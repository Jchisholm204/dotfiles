# Global Mounts

Expects that the global mounting system has been setup:
- `/mnt/global/`
- `/mnt/global/home`

1. Move files to systemd
```sh
cp ./mounts/mnt-* /etc/systemd/system/
```

2. Restore file permissions
```sh
sudo restorecon /etc/systemd/system/mnt-*
```

3. Setup Systemd service (repeat for all mounts)
```sh
sudo systemctl start --now mnt-global.mount
```

4. Setup Mounts
```sh
ln -s /mnt/global/home/* $HOME/
```

