Si vous utilisez **SFTP**, vous devez autoriser la clé publique suivante sur le serveur de destination :

`__PUBLIC_KEY__`

Pour ce faire, exécutez ces commandes sur le serveur cible :

```bash
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
chmod u=rw,go= ~/.ssh/authorized_keys
echo "__PUBLIC_KEY__" >> ~/.ssh/authorized_keys
```

Assurez-vous également que le chemin existe et est accessible en écriture par votre utilisateur.

**Optionnel** : Pour améliorer la sécurité, limitez l'accès de l'utilisateur à SFTP uniquement et restreignez-le à son répertoire personnel sur le serveur cible. Sur Debian/Ubuntu, cela se fait avec la commande suivante :

```bash
cat << EOF >> /etc/ssh/sshd_config
Match User __SSH_USER__
   ChrootDirectory %h
   ForceCommand internal-sftp
   AllowTcpForwarding no
   X11Forwarding no
EOF
systemctl restart ssh
```

---

Si vous utilisez un autre fournisseur de sauvegarde, ajoutez vos variables d'environnement dans le **Panneau de configuration de l'application**.

---

Une fois la clé SSH autorisée ou les variables d'environnement ajoutées, vous pouvez tester la connexion en utilisant l'action **« Tester la connexion »** dans le Panneau de configuration de l'application.