A [Restic](https://restic.net/) integration to backup your YunoHost server to an external location.

### Features
- **Multiple storage backends**: Supports all Restic storage types (SFTP, S3, Backblaze B2, Azure, etc.). **SFTP is recommended** for simplicity.
- **Deduplication and compression**: Saves space by removing duplicates and compressing data.
- **Encryption**: Data is encrypted before being sent to the storage backend.
- **Flexibility**: Install multiple instances to backup to different locations or set custom frequencies.

### Configuration
- **SFTP**: Configure directly during installation.
- **Other backends**: Set the required environment variables in the **App Panel** after installation.
