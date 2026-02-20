### Test

You can manually trigger backups using: `systemctl start __APP__.service`

And then make sure to verify the backup contents using: `restic -r __REPOSITORY__/auto_conf snapshots`

(Replace `auto_conf` with `auto_<app>` if you did not choose to backup configuration but only applications)

### Misc helpful commands

- Display the apps list to backup: `yunohost app setting restic apps`
- Edit the apps list to backup: `yunohost app setting restic apps -v "nextcloud,wordpress"`
- Launch a backup manually: `systemctl start restic`
- Launch a backup consistency check: `systemctl start restic_check.service`

#### Launch a complete backup check

If you want to make a complete check of the backups - keep in mind that this reads all the backed up data, it can take some time depending on your target server upload speed (more on this topic in [the Restic documentation](https://restic.readthedocs.io/en/latest/045_working_with_repos.html#checking-integrity-and-consistency)):

```
systemctl start restic_check_read_data.service
```

#### How to verify if backups succeeded

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

If you’re using SFTP, the SSH key is tied to the root user, so you must be logged in as root. For all other repository types (S3, B2, etc.), navigate to the Restic directory:
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
If the backup succeeded, you’ll see a list of files and directories. 

#### How to restore from Restic backups

To restore a backup using Restic, start by accessing the repository as described in the previous guide. Ensure you’re logged in as **root** and, if not using SFTP, load the environment variables:
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