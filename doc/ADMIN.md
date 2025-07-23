### Test

You can manually trigger backups using: `systemctl start __APP__.service`

And then make sure to verify the backup contents using: `restic -r __REPOSITORY__/auto_conf snapshots`

(Replace `auto_conf` with `auto_<app>` if you did not choose to backup configuration but only applications)

### Misc helpful commands

- Display the apps list to backup: `yunohost app setting restic apps`
- Edit the apps list to backup: `yunohost app setting restic apps -v "nextcloud,wordpress"`
- Launch a backup manually: `systemctl start restic`
- Launch a backup consistency check: `systemctl start restic_check.service`

##### Launch a complete backup check


If you want to make a complete check of the backups - keep in mind that this reads all the backed up data, it can take some time depending on your target server upload speed (more on this topic in [the Restic documentation](https://restic.readthedocs.io/en/latest/045_working_with_repos.html#checking-integrity-and-consistency)):

```
systemctl start restic_check_read_data.service
```
