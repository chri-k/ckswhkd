ckswhkd(1) "github.com/chri-k/ckswhkd" "General Commands Manual"

# NAME

ckswhkd - Hotkey daemon inspired by sxhkd

# SYNOPSIS

*ckswhkd* [_flags_]

# CONFIG FILE

The config file goes in *~/.config/ckswhkd/ckswhkdrc* with a fallback to */etc/ckswhkd/ckswhkdrc*.
More about the config file syntax in `ckswhkd(5)`

# OPTIONS

*-h*, *--help*
	Print help message and quit.

*-V*, *--version*
	Print version information.

*-c*, *--config* <CONFIG_FILE_PATH>
	Set a custom config file path.

*-C*, *--cooldown* <COOLDOWN_IN_MS>
	Set a custom repeat cooldown duration. Default is 250ms. Most wayland
	compositors handle this server side however, either way works.

*-d*, *--debug*
	Enable debug mode.

*-D, --device* <DEVICE_NAMES>
	Manually set the keyboard devices to use. Can occur multiple times.

*-I, --ignoredevice* <DEVICE_NAMES>
	Manually set the keyboard devices to ignore. Can occur multiple times.

# SIGNALS

	- Reload config file: `sudo pkill -HUP ckswhkd`
	- Pause Hotkey checking: `sudo pkill -USR1 ckswhkd`
	- Resume key checking: `sudo pkill -USR2 ckswhkd`

# AUTHORS

Created by Shinyzenith <aakashsensharma@gmail.com>, EdenQwQ <lsahlm1eden@gmail.com>, and Angelo Fallaria <ba.fallaria@gmail.com>.
This is a fork maintained (theoretically) by chri-k.

# SEE ALSO

	- *ckswhkd(5)*
	- *ckswhkd-keys(5)*
	- *ckswhks(1)*
