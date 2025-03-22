# AUR:

chri-k might make an AUR package of this fork.

# Building:

`ckswhkd` and `ckswhks` install to `/usr/local/bin/` by default. You can change this behaviour by editing the [Makefile](../Makefile) variable, `DESTDIR`, which acts as a prefix for all installed files. You can also specify it in the make command line, e.g. to install everything in `subdir`: `make DESTDIR="subdir" install`.

# Dependencies:

**Runtime:**

-   Uinput kernel module
-   Evdev kernel module

**Compile time:**

-   git
-   scdoc (If present, man-pages will be generated)
-   make
-   libudev (in Debian, the package name is `libudev-dev`)
-   rustup

# Compiling:

-   `git clone https://github.com/chri-k/ckswhkd ; cd ckswhkd`
-   `make setup`
-   `make clean`
-   `make`
-   `sudo make install`

# Running:

Refer to [Running section](https://github.com/chri-k/ckswhkd#running)
