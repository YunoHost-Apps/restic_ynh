If you're using SFTP, you should now allow the following public key on the target server : 

`__PUBLIC_KEY__`

Do so by running those commands on the target server :

```
mkdir ~/.ssh -p
touch ~/.ssh/authorized_keys
chmod u=rw,go= ~/.ssh/authorized_keys
echo "__PUBLIC_KEY__" >> ~/.ssh/authorized_keys
```

Also make sure that path exists and is writable by your user.

Optional: to improve security, make sure the user can only connect through SFTP and can only access its home directory on the target server.
On Debian/Ubuntu, this is done using the following command snippet:

```
cat << EOF>> /etc/ssh/sshd_config
Match User __SSH_USER__
   ChrootDirectory %h
   ForceCommand internal-sftp
   AllowTcpForwarding no
   X11Forwarding no
EOF
systemctl restart ssh
```
