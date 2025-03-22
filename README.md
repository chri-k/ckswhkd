## Disclaimer

this is chri-k's fork of [waycrate/swhkd](https://github.com/waycrate/swhkd).
it intended for chri-k's own use. it is expected to diverge from upstream, and is renamed to make this more
explicit. it is only tested on Arch.

ckswhkd will be maintained so long as chri-k continues using it.

at fork time the original swhkd appears to be abandoned and is not effectively functional on Arch.

## CKSWHKD

`ckswhkd` is a hotkey daemon for Wayland, inspired by `sxhkd`.

`ckswhkd` works by directly intercepting device events, and is thus is protocol-independent, and will even work in a TTY.

the original `swhkd` claims to be a drop-in replacement for `sxhkd`, however that is not true.

## Installation and Building

[Installation and building instructions can be found here.](./INSTALL.md)

do not expect chri-k to fix issues that are not reproducible on Arch.

## Running

the main daemon `ckswhkd` must be running as root. a separate process `ckswhks` is used to obtain the actual user's environment.
to start `ckswhkd`:

```bash
ckswhks && sudo ckswhkd
```

or alternatively, make `ckswhkd` a setuid binary:

```bash
sudo chown root:root ckswhkd
sudo chmod u+s ckswhkd
```

then to start,
```bash
ckswhks && ckswhkd
```

## Runtime signals

A running `ckswhkd` can be controlled through signals:

- `sudo pkill -USR1 ckswhkd` — Pause key checking
- `sudo pkill -USR2 ckswhkd` — Resume key checking
- `sudo pkill -HUP ckswhkd` — Reload config file

## Configuration

the configuration of `ckswhkd` is similar to `sxhkd`
More information about the sxhkd syntax can be found in `ckswhkd(5)`

The default configuration file is in `~/.config/ckswhkd/ckswhkdrc` with a fallback to `etc/ckswhkd/ckswhkdrc`.

If you use Vim, you can get the original `swhkd` config syntax highlighting with the
[swhkd-vim](https://github.com/waycrate/swhkd-vim) plugin. Install it in
vim-plug with `Plug 'waycrate/swhkd-vim'`. chri-k will eventually fork that too to account for syntax changes.

All supported key and modifier names are listed in `man 5 ckswhkd-keys`.

## Environment Variables

The environment variables are now sourced using the `ckswhks` binary, running in the background which are then supplemented
to the command that is to be run, thus emulating the environment variables in the default shell.

The commands are executed via `SHELL -c 'command'`, hence the environment is sourced from the default shell.
If the user wants to use a different set of environment variables, they can set the environment variables
in the default shell or export the environment variables within a logged in instance of their shell before
running the `ckswhks` binary.

## Autostart

### To autostart `ckswhkd` you can do one of two things

1. Add the commands from the ["Running"
   section](https://github.com/chri-k/ckswhkd#running) to your window managers
   configuration file.
2. Enable the [service
   file](https://github.com/chri-k/ckswhkd/tree/main/contrib/init) for your
   respective init system. Currently, only a systemd service file exists.

## Security

We use a server-client model to keep you safe. The daemon (`ckswhkd` — privileged
process) is responsible for listening to key events and running shell commands.
The server (`ckswhks` — non-privileged process) is responsible for keeping a track of the
environment variables and sending them to the daemon. The daemon
uses these environment variables while running the shell commands.
The daemon only runs shell commands that have been parsed from the config file and there is no way to
run arbitrary shell commands (so long as the config file does not allow arbitrary shell commands to be run). The server is responsible for only sending the environment variables to the daemon and nothing else.
This separation of responsibilities ensures security.