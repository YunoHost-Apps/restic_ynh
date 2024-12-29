<!--
Ohart ongi: README hau automatikoki sortu da <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>ri esker
EZ editatu eskuz.
-->

# Restic YunoHost-erako

[![Integrazio maila](https://dash.yunohost.org/integration/restic.svg)](https://ci-apps.yunohost.org/ci/apps/restic/) ![Funtzionamendu egoera](https://ci-apps.yunohost.org/ci/badges/restic.status.svg) ![Mantentze egoera](https://ci-apps.yunohost.org/ci/badges/restic.maintain.svg)

[![Instalatu Restic YunoHost-ekin](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=restic)

*[Irakurri README hau beste hizkuntzatan.](./ALL_README.md)*

> *Pakete honek Restic YunoHost zerbitzari batean azkar eta zailtasunik gabe instalatzea ahalbidetzen dizu.*  
> *YunoHost ez baduzu, kontsultatu [gida](https://yunohost.org/install) nola instalatu ikasteko.*

## Aurreikuspena

A [Restic](https://restic.net/) integration to backup your YunoHost server to an external location.

### Features

- backup data to remote storages (support for different types of storage: currently SFTP, S3 is planned)
- deduplication and compression of files, which makes it possible to keep many previous copies
- data encryption, which allows to store data at a third party

You can setup the Restic app several times on the same server so you can backup on several server or manage your frequency backup differently for specific part of your server.


**Paketatutako bertsioa:** 0.12.0~ynh9
## Dokumentazioa eta baliabideak

- Aplikazioaren webgune ofiziala: <https://restic.net>
- Administratzaileen dokumentazio ofiziala: <https://restic.readthedocs.io/en/latest/>
- Jatorrizko aplikazioaren kode-gordailua: <https://github.com/restic/restic>
- YunoHost Denda: <https://apps.yunohost.org/app/restic>
- Eman errore baten berri: <https://github.com/YunoHost-Apps/restic_ynh/issues>

## Garatzaileentzako informazioa

Bidali `pull request`a [`testing` abarrera](https://github.com/YunoHost-Apps/restic_ynh/tree/testing).

`testing` abarra probatzeko, ondorengoa egin:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
edo
sudo yunohost app upgrade restic -u https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
```

**Informazio gehiago aplikazioaren paketatzeari buruz:** <https://yunohost.org/packaging_apps>
