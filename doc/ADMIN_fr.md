### Utilisation en ligne de commande

- Afficher la liste des applications à sauvegarder :
  `yunohost app setting restic apps`
- Modifier la liste des applications à sauvegarder :
  `yunohost app setting restic apps -v "nextcloud,wordpress"`
- Lancer une sauvegarde manuellement :
  `systemctl start restic`
- Lancer une vérification de la cohérence des sauvegardes :
  `systemctl start restic_check`
- Lancer une vérification complète des sauvegardes (cela lit toutes les données sauvegardées, ce qui peut prendre du temps) :
  `systemctl start restic_check_read_data`

### Comment vérifier si les sauvegardes ont réussi

Pour vérifier si vos sauvegardes automatiques Restic ont réussi, suivez ces étapes :

1. **Accès root** : Vous devez avoir un accès root au serveur. Si votre dépôt n'utilise pas SFTP, chargez les variables d'environnement de Restic en exécutant :
   ```bash
   source /var/www/restic/.env
   ```

2. **Récupérer l'URL du dépôt** : Pour obtenir l'URL du dépôt utilisé par Restic, exécutez :
   ```bash
   yunohost app setting restic repository
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
     cd /var/www/restic/
     ```
     Puis chargez les variables d'environnement :
     ```bash
     source .env
     ```

5. **Vérification d'une sauvegarde spécifique** : Définissez la variable `RESTIC_REPOSITORY` pour inclure le sous-dossier de l'application que vous souhaitez vérifier. Par exemple, pour Roundcube :
   ```bash
   RESTIC_REPOSITORY=$(yunohost app setting restic repository)/auto_roundcube
   ```

6. **Lister le contenu de la dernière sauvegarde** : Pour vérifier la dernière sauvegarde, listez son contenu avec :
   ```bash
   ./restic -r "$RESTIC_REPOSITORY" ls latest
   ```
   Si la sauvegarde a réussi, vous verrez une liste de fichiers et de dossiers.

### Comment restaurer depuis les sauvegardes Restic

Pour restaurer une sauvegarde avec Restic, commencez par accéder au dépôt comme décrit précédemment. Assurez-vous d'être connecté en tant que **root** et, si vous n'utilisez pas SFTP, chargez les variables d'environnement :
```bash
source /var/www/restic/.env
```

1. **Accéder au répertoire Restic** :
   ```bash
   cd /var/www/restic/
   ```

2. **Définir le dépôt cible** : Définissez la variable `RESTIC_REPOSITORY` pour pointer vers le sous-dossier de l'application que vous souhaitez restaurer. Par exemple, pour Roundcube :
   ```bash
   RESTIC_REPOSITORY=$(yunohost app setting restic repository)/auto_roundcube
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