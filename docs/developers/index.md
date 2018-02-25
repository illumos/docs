# How to build illumos

!!! note ""
    Please also refer to the [illumos Developer's Guide](https://illumos.org/books/dev/intro.html).

!!! warning "Requires Review"
    This page references some old practices and needs to be reviewed.

## Introduction

This document will help prepare you to build the source code for illumos. It
assumes some familiarity with development on Unix-like systems.

!!! tip "My First illumos Build"
    If you are just dipping your toes into illumos, you should consider reading
    [Ryan Zezeski's post on his own first
    build](https://zinascii.com/2014/my-first-illumos-build.html)!

You need an illumos-based operating system to build illumos. Cross-compilation
is not supported.

If you don't have one installed, the quickest way to get started is to download
and install either [OpenIndiana](https://openindiana.org) or
[OmniOS](https://www.omniosce.org/) and install them in a VM or on metal.

!!! tip ""
    All commands in this guide assume you run them as an unprivileged user.
    sudo will be prepended to commands which need additional privileges; on some
    systems pfexec can be used instead, if your user has the correct RBAC profiles.
    The generic commands below use a $USER variable to define the current
    (unprivileged) user account's name which will ultimately be used to compile the
    project. If you are not using a stock shell or have manipulated the $USER
    variable in your environment at a site, system, or user level, you are
    responsible for diagnosing and addressing any consequences.

## Hardware Support

You'll generally have good luck with common x86 components, but it's always a
good idea to refer to the [Hardware Combatibility
List](https://www.illumos.org/hcl/) or Joyent's [Manufactory
database](http://eng.joyent.com/manufacturing/bom.html).

## Installing required packages

You will need to install the basic development environment to build illumos.

### OpenIndiana

```
sudo pkg install build-essential
```

### OmniOS

```
sudo pkg install pkg:/developer/illumos-tools
```

## Compilers

The source code was traditionally built using Sun's closed-source compiler
suite, which was named Sun Studio at the time of the illumos fork.  We now
build illumos with GCC, but you will still need some tools from Sun Studio and
those are available as packages in the legacy OpenSolaris repository.

### GCC

The primary version of GCC necessary for development and integration 4.4.4
(4.4.4-il-4) should have been installed on your system when you installed the
prerequisites above.

!!! warning "OpenIndiana Hipster 20161030"
    OpenIndiana Hipster 20161030 ships with gcc-4.4.4-il-3, so make sure to update that package to -il-4 before building.
    Building with 4.4.4-il-3 leads to build failures with warnings as below in the mail_msg and nightly.log:
    ```
    ../../i86pc/os/trap.c:2188: error: unknown conversion type character '-' in format [-Wformat]
    ../../i86pc/os/trap.c:2188: error: too many arguments for format [-Wformat-extra-args]
    ```

Note that the compiler for building `illumos-gate` installs into
`/opt/gcc/4.4.4` on OpenIndiana, and `/opt/gcc-4.4.4` on OmniOS and is not
available in the default PATH for building application programs.

You can add (OI example) `PATH="/opt/gcc/4.4.4/bin:$PATH"; export PATH` to your
profile to reference this compiler, or install one of the other GCC builds,
destined as the current default compiler for application programs (versions
ranging from 3.4.3 to 4.6.x, see `pkg info -r '*gcc*'` for details du-jour).

Unfortunately, Sun Studio `lint` is currently required even for GCC-only builds.
We currently deliver Lint libraries built using the closed Sun Studio version
of lint. OmniOS includes this in its `sunstudio12.1` package.  On OpenIndiana
it's delivered as part of `developer/sunstudio12u1/cc`, which you shouldn't
install explicitly if you've already installed `build-essential`.

### Sun Studio

Building with Sun Studio is generally unsupported. If you have need of it,
please refer to [Building With Sun Studio](studio.md).

## Next Steps

Once you've got the prerequisites installed, you're ready to start [building
illumos](build-illumos.md).
