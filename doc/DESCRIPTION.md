A [Restic](https://restic.net/) integration to backup your YunoHost server to an external location.

### Features

- backup data to remote storages (support for different types of storage: currently SFTP, S3 is planned)
- deduplication and compression of files, which makes it possible to keep many previous copies
- data encryption, which allows to store data at a third party

You can setup the Restic app several times on the same server so you can backup on several server or manage your frequency backup differently for specific part of your server.
