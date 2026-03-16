### Utilisation en ligne de commande

- Afficher la liste des applications à sauvegarder :
  `yunohost app setting __APP__ apps`
- Modifier la liste des applications à sauvegarder :
  `yunohost app setting __APP__ apps -v "nextcloud,wordpress"`
- Lancer une sauvegarde manuellement :
  `systemctl start __APP__`
- Lancer une vérification de la cohérence des sauvegardes :
  `systemctl start __APP___check`
- Lancer une vérification complète des sauvegardes (cela lit toutes les données sauvegardées, ce qui peut prendre du temps) :
  `systemctl start __APP___check_read_data`

### Comment vérifier si les sauvegardes ont réussi

Pour vérifier si vos sauvegardes automatiques Restic ont réussi, suivez ces étapes :

1. **Accès root** : Vous devez avoir un accès root au serveur. Si votre dépôt n'utilise pas SFTP, chargez les variables d'environnement de Restic en exécutant :
   ```bash
   source /var/www/__APP__/.env
   ```

2. **Récupérer l'URL du dépôt** : Pour obtenir l'URL du dépôt utilisé par Restic, exécutez :
   ```bash
   yunohost app setting __APP__ repository
   ```
   Cela retournera quelque chose comme :
   ```
   s3:https://serveur:port/nom_du_bucket
   ```

3. **Structure des sauvegardes** : Pour chaque application YunoHost, Restic stocke les sauvegardes dans un sous-dossier du dépôt. Par exemple, les sauvegardes de Roundcube sont stockées dans `/auto_roundcube`, et celles de Nextcloud dans `/auto_nextcloud`.

4. **Accès au dépôt** :
   - Si vous utilisez **SFTP**, la clé SSH est liée à l'utilisateur root, vous devez donc être connecté en tant que root.
   - Pour tous les autres types de dépôts (S3, B2, etc.), accédez au répertoire Restic :
     ```bash
     cd /var/www/__APP__/
     ```
     Puis chargez les variables d'environnement :
     ```bash
     source .env
     ```

5. **Vérification d'une sauvegarde spécifique** : Définissez la variable `RESTIC_REPOSITORY` pour inclure le sous-dossier de l'application que vous souhaitez vérifier. Par exemple, pour Roundcube :
   ```bash
   RESTIC_REPOSITORY=$(yunohost app setting __APP__ repository)/auto_roundcube
   ```

6. **Lister le contenu de la dernière sauvegarde** : Pour vérifier la dernière sauvegarde, listez son contenu avec :
   ```bash
   ./restic -r "$RESTIC_REPOSITORY" ls latest
   ```
   Si la sauvegarde a réussi, vous verrez une liste de fichiers et de dossiers.

### Comment restaurer depuis les sauvegardes Restic

Pour restaurer une sauvegarde avec Restic, commencez par accéder au dépôt comme décrit précédemment. Assurez-vous d'être connecté en tant que **root** et, si vous n'utilisez pas SFTP, chargez les variables d'environnement :
```bash
source /var/www/__APP__/.env
```

1. **Accéder au répertoire Restic** :
   ```bash
   cd /var/www/__APP__/
   ```

2. **Définir le dépôt cible** : Définissez la variable `RESTIC_REPOSITORY` pour pointer vers le sous-dossier de l'application que vous souhaitez restaurer. Par exemple, pour Roundcube :
   ```bash
   RESTIC_REPOSITORY=$(yunohost app setting __APP__ repository)/auto_roundcube
   ```

3. **Créer une archive `.tar`** : Créez une archive `.tar` des fichiers que vous souhaitez restaurer. Par exemple, pour restaurer le dernier snapshot :
   ```bash
   ./restic -r "$RESTIC_REPOSITORY" dump latest > roundcube_restore.tar
   ```
   Cette commande extrait la dernière sauvegarde dans un fichier `.tar` nommé `roundcube_restore.tar`.

4. **Déplacer l'archive** : Déplacez l'archive `.tar` vers `/home/yunohost.backup/archives/` pour que YunoHost puisse la détecter :
   ```bash
   mv roundcube_restore.tar /home/yunohost.backup/archives/
   ```

5. **Restauration** : Une fois l'archive en place, YunoHost la reconnaîtra, et vous pourrez procéder à la restauration via l'interface d'administration ou les outils en ligne de commande de YunoHost.

### Erreurs fréquentes

- **Utilisation d’un serveur SFTP comme dépôt distant :**
  Pour spécifier l’adresse d’un dépôt distant SFTP, utilisez ce format exact :
  `sftp://utilisateur_backup@serveur_cible.tld:port_ssh//votre/dossier/`
  *(Attention aux doubles barres obliques après le port.)*

- **Échec de vérification de la clé hôte (SFTP) :**
  Si l’erreur `subprocess ssh: Host key verification failed.` apparaît lors de la connexion à un dépôt SFTP, cela est souvent dû à des permissions incorrectes sur la clé SSH. Pour corriger le problème, exécutez :
  `chmod 600 /root/.ssh/id___APP___ed25519`

- **Environnement "chroot" (SFTP) :**
  Si le système distant utilise un environnement "chroot" (par exemple, un autre serveur YunoHost avec la configuration SSH `ChrootDirectory %h`), le chemin du dossier racine n’est pas `/home/utilisateur`, mais simplement `/utilisateur`.

- **Utilisation de Backblaze B2 comme dépôt distant :**
  Avec Backblaze B2, si vous ne précisez pas de sous-dossier, ajoutez tout de même un `:` à la fin de l’adresse. Cela permet à Restic d’ajouter automatiquement le sous-dossier (par exemple, transformer `b2:xxxxxxxxxxx:` en `b2:xxxxxxxxxxx:/auto_<app>`). Cette étape évite l’erreur *"bucket name contains invalid characters"*.

- **Make your backup when the service is stopped:**
  Plusieurs applications YunoHost (comme Synapse, Gitea, Seafile, Sogo, Monitorix et Xwiki) recommandent d'effectuer les sauvegardes lorsque le service est à l'arrêt. Vous pouvez activer une option dans le Config Panel de Restic pour les arrêter automatiquement pendant la sauvegarde. Si ce paramètre est activé, ces applications seront indisponibles aux utilisateurs pendant chaque sauvegarde.

- **YunoHost Backup Method:**
  L'application YunoHost Restic ajoute une [méthode de sauvegarde personnalisée](https://doc.yunohost.org/fr/admin/backups/custom_backup_methods/) nommée `__APP___app` qui permet d'ajouter l'étape d'envoi de la sauvegarde sur un serveur distant à la place de la sauvegarde en "local". Cette méthode est appelée pour chaque contenu sauvegardé (configuration, données, multimédia et chaque application) de la manière suivante : `sudo yunohost backup create -n "auto_$application" --method __APP___app --apps "$application"`. Pour lancer une sauvegarde manuellement avec Restic nous vous recommandons d'utiliser `systemctl start __APP__` qui utilisera cette méthode par elle-même en appliquant la configuration que vous avez demandée lors de l'installation ou dans le Config Panel. Si vous utilisez la méthode de sauvegarde personnalisée vous-même, vous devez préciser ce que vous souhaitez sauvegarder. L'attribut `-n` n'est pas documenté mais est bien nécessaire pour déterminer ou sera stockée votre sauvegarde sur le serveur distant.