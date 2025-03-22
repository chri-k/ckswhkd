## systemd Instructions

To have systemd automatically start `ckswhkd` for you:

0. Make sure `ckswhkd` is suid, `NOPASSWD:`, or another equivalent
1. Copy `hotkeys.sh` into your preferred directory, modify as needed to set environment or replace `sudo`.
2. `chmod +x hotkeys.sh`
3. Copy `hotkeys.service` into your `$XDG_CONFIG_DIRS/systemd/user` directory
4. Using a text editor, uncomment line 7 of `hotkeys.service` and change the path accordingly
5. In a terminal: `systemctl --user enable hotkeys.service`
