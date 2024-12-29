<!--
Nota bene : ce README est automatiquement généré par <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Il NE doit PAS être modifié à la main.
-->

# Restic pour YunoHost

[![Niveau d’intégration](https://dash.yunohost.org/integration/restic.svg)](https://ci-apps.yunohost.org/ci/apps/restic/) ![Statut du fonctionnement](https://ci-apps.yunohost.org/ci/badges/restic.status.svg) ![Statut de maintenance](https://ci-apps.yunohost.org/ci/badges/restic.maintain.svg)

[![Installer Restic avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=restic)

*[Lire le README dans d'autres langues.](./ALL_README.md)*

> *Ce package vous permet d’installer Restic rapidement et simplement sur un serveur YunoHost.*  
> *Si vous n’avez pas YunoHost, consultez [ce guide](https://yunohost.org/install) pour savoir comment l’installer et en profiter.*

## Vue d’ensemble

A [Restic](https://restic.net/) integration to backup your YunoHost server to an external location.

### Features

- backup data to remote storages (support for different types of storage: currently SFTP, S3 is planned)
- deduplication and compression of files, which makes it possible to keep many previous copies
- data encryption, which allows to store data at a third party

You can setup the Restic app several times on the same server so you can backup on several server or manage your frequency backup differently for specific part of your server.


**Version incluse :** 0.12.0~ynh9
## Documentations et ressources

- Site officiel de l’app : <https://restic.net>
- Documentation officielle de l’admin : <https://restic.readthedocs.io/en/latest/>
- Dépôt de code officiel de l’app : <https://github.com/restic/restic>
- YunoHost Store : <https://apps.yunohost.org/app/restic>
- Signaler un bug : <https://github.com/YunoHost-Apps/restic_ynh/issues>

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche `testing`](https://github.com/YunoHost-Apps/restic_ynh/tree/testing).

Pour essayer la branche `testing`, procédez comme suit :

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
ou
sudo yunohost app upgrade restic -u https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
```

**Plus d’infos sur le packaging d’applications :** <https://yunohost.org/packaging_apps>
