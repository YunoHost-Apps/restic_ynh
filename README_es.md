<!--
Este archivo README esta generado automaticamente<https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
No se debe editar a mano.
-->

# Restic para Yunohost

[![Nivel de integración](https://dash.yunohost.org/integration/restic.svg)](https://ci-apps.yunohost.org/ci/apps/restic/) ![Estado funcional](https://ci-apps.yunohost.org/ci/badges/restic.status.svg) ![Estado En Mantención](https://ci-apps.yunohost.org/ci/badges/restic.maintain.svg)

[![Instalar Restic con Yunhost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=restic)

*[Leer este README en otros idiomas.](./ALL_README.md)*

> *Este paquete le permite instalarRestic rapidamente y simplement en un servidor YunoHost.*  
> *Si no tiene YunoHost, visita [the guide](https://yunohost.org/install) para aprender como instalarla.*

## Descripción general

A [Restic](https://restic.net/) integration to backup your YunoHost server to an external location.

### Features

- backup data to remote storages (support for different types of storage: currently SFTP, S3 is planned)
- deduplication and compression of files, which makes it possible to keep many previous copies
- data encryption, which allows to store data at a third party

You can setup the Restic app several times on the same server so you can backup on several server or manage your frequency backup differently for specific part of your server.


**Versión actual:** 0.12.0~ynh9
## Documentaciones y recursos

- Sitio web oficial: <https://restic.net>
- Documentación administrador oficial: <https://restic.readthedocs.io/en/latest/>
- Repositorio del código fuente oficial de la aplicación : <https://github.com/restic/restic>
- Catálogo YunoHost: <https://apps.yunohost.org/app/restic>
- Reportar un error: <https://github.com/YunoHost-Apps/restic_ynh/issues>

## Información para desarrolladores

Por favor enviar sus correcciones a la [`branch testing`](https://github.com/YunoHost-Apps/restic_ynh/tree/testing

Para probar la rama `testing`, sigue asÍ:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
o
sudo yunohost app upgrade restic -u https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
```

**Mas informaciones sobre el empaquetado de aplicaciones:** <https://yunohost.org/packaging_apps>
