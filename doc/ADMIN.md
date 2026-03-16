### Command-line usage

- Display the apps list to backup: `yunohost app setting restic apps`
- Edit the apps list to backup: `yunohost app setting restic apps -v "nextcloud,wordpress"`
- Trigger a backup manually: `systemctl start restic`
- Trigger a backup consistency check: `systemctl start restic_check`
- Trigger a complete check of the backups (this reads all the backed up data, it can take some time): `systemctl start restic_check_read_data`

### How to verify if backups succeeded

To verify if your automatic Restic backups succeeded, follow these steps:

First, you need root access to the server. If your repository is not using SFTP, load the Restic environment variables by running:
```bash
source /var/www/restic/.env
```

To get the target repository URL used by Restic, run:
```bash
yunohost app setting restic repository
```
This will return something like:
```
s3:https://server:port/bucket_name
```

For each YunoHost application, Restic stores backups in a subdirectory of the repository. For example, Roundcube backups are stored in `/auto_roundcube`, and Nextcloud backups are stored in `/auto_nextcloud`.

If you're using SFTP, the SSH key is tied to the root user, so you must be logged in as root. For all other repository types (S3, B2, etc.), navigate to the Restic directory:
```bash
cd /var/www/restic/
```
Then load the environment variables:
```bash
source .env
```
Set the `RESTIC_REPOSITORY` variable to include the subdirectory for the app you want to check. For example, for Roundcube:
```bash
RESTIC_REPOSITORY=$(yunohost app setting restic repository)/auto_roundcube
```

To verify the latest backup, list its contents with:
```bash
./restic -r "$RESTIC_REPOSITORY" ls latest
```
If the backup succeeded, you'll see a list of files and directories. 

### How to restore from Restic backups

To restore a backup using Restic, start by accessing the repository as described in the previous guide. Ensure you're logged in as **root** and, if not using SFTP, load the environment variables:
```bash
source /var/www/restic/.env
```

Navigate to the Restic directory:
```bash
cd /var/www/restic/
```

Set the `RESTIC_REPOSITORY` variable to point to the subdirectory of the app you want to restore. For example, for Roundcube:
```bash
RESTIC_REPOSITORY=$(yunohost app setting restic repository)/auto_roundcube
```

Next, create a `.tar` archive of the files you want to restore. For example, to restore the latest snapshot:
```bash
./restic -r "$RESTIC_REPOSITORY" dump latest > roundcube_restore.tar
```
This command extracts the latest backup into a `.tar` file named `roundcube_restore.tar`.

Move the `.tar` archive to `/home/yunohost.backup/archives/` so YunoHost can detect it:
```bash
mv roundcube_restore.tar /home/yunohost.backup/archives/
```

Once the archive is in place, YunoHost will recognize it, and you can proceed with the restoration using the YunoHost admin interface or CLI tools.

### Common Errors

- **SFTP Server as Remote Repository:**
  When specifying the address for an SFTP remote repository, ensure you use the correct format:
  `sftp://backup_user@target_server.tld:ssh_port//your/folder/`
  *(Note the double slash after the port number.)*

- **Host Key Verification Failed (SFTP):**
  If you encounter the error `subprocess ssh: Host key verification failed.` when connecting to a remote repository via SFTP, it is often due to incorrect permissions on the SSH key. To fix this, run:
  `chmod 600 /root/.ssh/id___APP___ed25519`

- **Chroot Environment (SFTP):**
  If the remote system uses a "chroot" environment (e.g., another YunoHost server with the SSH configuration `ChrootDirectory %h`), the home directory path is not `/home/user` but rather `/user`.

- **Backblaze B2 as Remote Repository:**
  When using Backblaze B2, if you do not specify a subfolder, you must still append a `:` to the end of the address. This allows Restic to append the subfolder to the address (e.g., changing `b2:xxxxxxxxxxx:` to `b2:xxxxxxxxxxx:/auto_<app>`). This resolves the error "bucket name contains invalid characters."

- **Make your backup when the service is stopped:**
  Some YunoHost apps (like Synapse, Gitea, Seafile, Sogo, Monitorix and Xwiki) recommand to make your backup when the service is stopped. You can enable an option in Restic Config Panel to stop them automatically during the backup. If enabled, these apps won't be available for users during each backup.

- **YunoHost Backup Method:**
  Restic for YunoHost adds a [custom backup method](https://doc.yunohost.org/en/admin/backups/custom_backup_methods/) named `__APP___app`, which replaces the default "local" backup step with sending the backup to a remote server. This method is called for each saved content (configuration, data, media, and each application) as follows: `sudo yunohost backup create -n "auto_$application" --method __APP___app --apps "$application"`. To manually trigger a backup with Restic, we recommend using `systemctl start restic`. This command will automatically use the custom method, applying the configuration you set during installation or in the **Config Panel**. If you use the custom backup method directly, you must specify what you want to back up. The `-n` flag is undocumented but required to determine where your backup will be stored on the remote server.