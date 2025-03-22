ckswhkd(5) "github.com/chri-k/ckswhkd" "File Formats Manual"

# NAME

ckswhkd	- Hotkey daemon inspired by sxhkd

# CONFIG FILE

- A global config can be defined in *~/.config/ckswhkd/ckswhkdrc*, with a
fallback to  */etc/ckswhkd/ckswhkdrc*. ckswhkd attempts to look in your *$XDG_CONFIG_HOME*, failing which it defaults to *~/.config*.
- A local config overrides the global one. Local configs should be placed in the root of the project.
- The config file can also be specified with the *-c* flag.

# ENVIRONMENT

- The environment variables are sourced using the ckswhks(1) binary, running in the background.
- The environment variables are then supplemented to the command that is to be run, thus emulating the
environment variables in the default shell.
- The commands are executed via *SHELL -c 'command'*, hence the environment is sourced from the default shell.
- If the user wants to use a different set of environment variables, they can set the environment variables
in the default shell or export the environment variables within a logged in instance of their shell before
running the ckswhks binary.

# SYNTAX

The syntax of the configuration file is similar to sxhkd.

Each line of the configuration file is interpreted as so:
	- If it is empty or starts with #, it is ignored.
	- If it starts with a space, it is read as a command.
	- Otherwise, it is read as a hotkey.

For valid keys and modifiers, check *ckswhkd-keys(5)*

# DISCLAIMER

The configuration file parser is deficient. it will not report all syntax errors correctly. some
invalid configuration files will be parsed succesfully, but will have unintended effects.

# EXAMPLE

```
# Import another configuration file.
# NOTE: the path provided must be absolute and not relative such as `~`.
include /home/YourUserName/.config/ckswhkd/ckswhkdrc

ignore alt + print # globally ignore a key binding

# bind super+shift+enter to run kitty:
super + shift + enter
	kitty

# key names are case-insensitive
super + ReTuRn
	alacritty

super + shift + f
	pcmanfm

super + w
	firefox

# shorthand for defining multiple bindings of the same form at once
super + {_,shift + }{h,j,k,l}
	bspc node -{f,s} {west,south,north,east}

# more complicated example
super + ctrl + alt + {Left\
,Down\
,Up\
,Right}
  n=10; \
  { d1=left;   d2=right;  dx=-$n; dy=0;   \
  , d1=bottom; d2=top;    dx=0;   dy=$n;  \
  , d1=top;    d2=bottom; dx=0;   dy=-$n; \
  , d1=right;  d2=left;   dx=$n;  dy=0;   \
  } \
  bspc node --resize $d1 $dx $dy || bspc node --resize $d2 $dx $dy

# commas look weird when used like this
super + {\,, .}
  bspc node -f {next.local,prev.local}

# any represents at least one of the valid modifiers
any + print
	scrot -s

# prefix with @ to run on key release instead of key press.
@super + shift + f
	pcmanfm

# prefix with ~ to pass through the keys to other applications
~super + f
	pcmanfm

# a mode can be defined to temporarily change the key bindings.
mode music

{n, p, space, r, z, y}
	mpc {next, prev, toggle, repeat, random, single}

q
	@escape
# @escape is an internal command which exits the current mode and returns to the previous one.

endmode

# to enter the music mode defined above, use the @enter internal command
super + m
	@enter music

# it is possible to combine internal and shell commands with `&&`.
super + shift + m
	@enter music && echo "music" > ~/.config/waybar/ckswhkd-mode

# `&&` whih is not followed or preceded by an internal command is not tretaed specially, and is
# simply included as part of the shell command.

# modes may be defined with additional flags following the mode name
# swallow: don't pass through unbound keys (WARNING: make sure to define a way to exit the mode.)
# oneoff: automatically exit the mode after any of the defined keybinds is triggered.
mode option_demo swallow oneoff
a
	echo 0
b
	@escape # escaping in a 'oneoff' mode pops two modes out of the mode stack.
endmode

# there is another internal command which can be used instead of @enter
# @await is similar to @enter, however any commands following @await are executed only
# after the mode is exited (for any reason).
alt + 3
	dunstify "entering mode test" && @await test && dunstify "exited mode test"
mode test oneoff
t
	dunstify "doing something in mode test"
endmode

# anything after @await will be executed immediately after an @escape, after which
# execution continues to whatever is after the @escape.
# combinations of @await and @escape may be used to create extremely complicated behaviour.

# note however that shell commands are executed asyncrhonously, which means that even though they are sent in order, their execution will likely overlap.

```
# AUTHORS

Created by Shinyzenith <aakashsensharma@gmail.com>, EdenQwQ <lsahlm1eden@gmail.com>, and Angelo Fallaria <ba.fallaria@gmail.com>.
This is a fork maintained (theoretically) by chri-k.

# SEE ALSO

	- *ckswhkd(1)*
	- *ckswhkd-keys(5)*
	- *ckswhks(1)*
