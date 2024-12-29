<!--
NOTA: Este README foi creado automáticamente por <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
NON debe editarse manualmente.
-->

# Restic para YunoHost

[![Nivel de integración](https://dash.yunohost.org/integration/restic.svg)](https://ci-apps.yunohost.org/ci/apps/restic/) ![Estado de funcionamento](https://ci-apps.yunohost.org/ci/badges/restic.status.svg) ![Estado de mantemento](https://ci-apps.yunohost.org/ci/badges/restic.maintain.svg)

[![Instalar Restic con YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=restic)

*[Le este README en outros idiomas.](./ALL_README.md)*

> *Este paquete permíteche instalar Restic de xeito rápido e doado nun servidor YunoHost.*  
> *Se non usas YunoHost, le a [documentación](https://yunohost.org/install) para saber como instalalo.*

## Vista xeral

A [Restic](https://restic.net/) integration to backup your YunoHost server to an external location.

### Features

- backup data to remote storages (support for different types of storage: currently SFTP, S3 is planned)
- deduplication and compression of files, which makes it possible to keep many previous copies
- data encryption, which allows to store data at a third party

You can setup the Restic app several times on the same server so you can backup on several server or manage your frequency backup differently for specific part of your server.


**Versión proporcionada:** 0.12.0~ynh9
## Documentación e recursos

- Web oficial da app: <https://restic.net>
- Documentación oficial para admin: <https://restic.readthedocs.io/en/latest/>
- Repositorio de orixe do código: <https://github.com/restic/restic>
- Tenda YunoHost: <https://apps.yunohost.org/app/restic>
- Informar dun problema: <https://github.com/YunoHost-Apps/restic_ynh/issues>

## Info de desenvolvemento

Envía a túa colaboración á [rama `testing`](https://github.com/YunoHost-Apps/restic_ynh/tree/testing).

Para probar a rama `testing`, procede deste xeito:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
ou
sudo yunohost app upgrade restic -u https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
```

**Máis info sobre o empaquetado da app:** <https://yunohost.org/packaging_apps>
