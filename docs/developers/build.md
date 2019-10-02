# Building illumos

## Introduction

This document will help prepare you to build the source code for illumos. It
assumes some familiarity with development on Unix-like systems.

!!! note ""
    For more detail and background information, please also refer to the
    [illumos Developer's Guide](https://illumos.org/books/dev/intro.html).

You need an illumos-based operating system to build illumos. Cross-compilation
is not supported.

If you don't have one installed, the quickest way to get started is to download
either [OpenIndiana](https://openindiana.org) or
[OmniOS](https://www.omniosce.org/).  Both distributions can be installed in a
VM (e.g., VMware Fusion on macOS) or on a physical machine, and can be used to
build illumos.

All commands in this guide assume you run them as an unprivileged user.  `sudo`
will be prepended to commands which need additional (i.e., `root`) privileges.
On some systems `pfexec` can be used in place of `sudo`, provided your user has
the correct [RBAC profiles](https://illumos.org/man/1/profiles).

## Make sure your system is up-to-date

On a freshly installed system, it is a good idea to make sure you have the
latest version of all operating system components.  On both OmniOS and
OpenIndiana, you can update your system by running:

```
sudo pkg update
```

Once the update is complete, you may need to reboot your machine to begin using
the new kernel.

## Installing required packages

Once you have an up-to-date illumos system installed and running, you will need
to install the basic development tools needed to build illumos.  The operating
system is currently built with a
[patched version of GCC 7](https://github.com/illumos/gcc/). Distributions may
have their own particular versions of GCC 7 which work, however.

In addition, GCC 4.4.4 is used as a "shadow" compiler to test that builds
with GCC 4 still work.

The list of packages to install depends on which distribution you have
chosen:

### OpenIndiana

On OpenIndiana, the `build-essential` package includes the GCC compiler
and other tools required to build illumos.  In addition, for now, we
should install the newer GCC 7 compiler and the Python 3.5 runtime for a
complete build.

```
sudo pkg install build-essential \
    runtime/python-35 \
    developer/gcc-7
```

The GCC versions to use can be found in `/usr/gcc/7` and `/opt/gcc/4.4.4`.

### OmniOS

On OmniOS, the `illumos-tools` package includes everything you'll need to build
illumos.  Make sure you're running at least OmniOS version r151028 or higher.

```
sudo pkg install pkg:/developer/illumos-tools
```

The GCC versions to use can be found in `/opt/gcc-7` and `/opt/gcc-4.4.4`.

## Preparing your workspace

You can build the software in any directory, but for the purposes of this guide
we will assume that you have a directory `/code` on your system.  This
directory should be owned by the unprivileged user you will use to build
illumos.

## Getting the source

You may use the Git source code management system to retrieve the illumos
source code.  Git is installed with the other build tools in a previous
section.  Make sure you have about 6 gigabytes of free space for the source
and binaries combined.

The repository is available from GitHub using the Git source code control
system.  The Git repository URI is:
`https//github.com/illumos/illumos-gate.git`

To check out the source:

```
cd /code
git clone https://github.com/illumos/illumos-gate.git
```

From here on we'll refer to this clone of the repository, i.e.,
`/code/illumos-gate`, as your "workspace".

## Getting the closed binaries

There are a small handful of illumos components for which source code is not
available.  Over time, we have replaced most of the closed source components
from the Sun era with new open source versions.  This work is ongoing.

### OpenIndiana & OmniOS

OmniOS (r151016 or later) and OpenIndiana users have the closed binary files
installed in `/opt/onbld/closed`.  The `ON_CLOSED_BINS` environment variable
can be set to refer to this directory without copying it into your workspace.

### Other Distributions

For systems where the closed binaries are not shipped as part of the
development tools packages, you can download the closed binary tar files into
your local illumos-gate workspace yourself:

```
cd /code/illumos-gate
wget -c \
  https://download.joyent.com/pub/build/illumos/on-closed-bins.i386.tar.bz2 \
  https://download.joyent.com/pub/build/illumos/on-closed-bins-nd.i386.tar.bz2
tar xjvpf on-closed-bins.i386.tar.bz2
tar xjvpf on-closed-bins-nd.i386.tar.bz2
```

## Configuring the build

The build is configured using an "environment file", a shell script that works
like your `.bashrc` or `.profile`.  This script sets various environment
variables that control the build.  Some of the variables to set depend on which
distribution of illumos you're using.

An environment file template is included in `illumos-gate.git` and can thus be
found in your workspace.  Make a copy so that we can edit it for use on your
particular build machine.

```
cd /code/illumos-gate
cp usr/src/tools/env/illumos.sh .
vi illumos.sh                          # use your favourite text editor!
```

The current version of the template is mostly complete, and written such that
it tries to guess sensible defaults for most things.  For example,

- `git describe` is used to set `VERSION` based on the branch and commit
  to build
- `git` is also used to set `CODEMGR_WS` to the workspace directory; i.e.,
  `/code/illumos-gate` in this document.

### OpenIndiana

On OpenIndiana systems, you'll need to add a few more variables to your
environment file to get a complete build with packages you can install.  Add
the following to the bottom of your copy of `illumos.sh`:

```
#
# Set a package version number which is greater than the current OpenIndiana
# build number.  Note that ONNV_BUILDNUM is ignored if PKGVERS_BRANCH is set:
#
export PKGVERS_BRANCH=9999.99.0.0

#
# Set to current version of Perl shipped with OpenIndiana:
#
export PERL_VERSION="5.22"
export PERL_PKGVERS="-522"
export BUILDPERL64="#"

#
# If you are building on the latest OpenIndiana (2017-03-07 and later), use
# OpenJDK 8:
#
export BLD_JAVA_8=

#
# IPS packages published at 2019-08-08 and later ship only Python 3.5 modules,
# so you have to use this Python version to build illumos tools
# if your pkg:/package/pkg version is 0.5.11-2019.0.0.5521 or later.
#
export BUILDPY2TOOLS="#"
 
#
# Use the copy of the closed binaries that comes with the "build-essential"
# package:
#
export ON_CLOSED_BINS="/opt/onbld/closed"
```

Note in particular that `PKGVERS_BRANCH` must be a higher number than the one
currently in use on your OpenIndiana system, so that `pkg` and `onu` will
prefer your locally built packages to those from the base distribution.  You
can find out the current branch version with `pkg info`:

```
$ pkg info osnet-incorporation | grep Branch:
        Branch: 2018.0.0.18230
```

### OmniOS

On OmniOS systems, you have the option of using a complete environment file
provided in the developer tool packages.  Those files reside in
`/opt/onbld/env/omnios-*`; one for vanilla `illumos-gate.git`, and one for the
OmniOS-specific downstream fork, `illumos-omnios.git`.

Currently, you may need to set the compiler versions by hand, however.

If instead you wish to start with the stock environment file template, you'll
need to add the following at the end of your copy of `illumos.sh`:

```
# Set to the current perl version (this is correct for OmniOS r151028)
export PERL_VERSION=5.28
export PERL_ARCH=i86pc-solaris-thread-multi-64int
export PERL_PKGVERS=
 
# Set to current python3 version (this is correct for OmniOS r151028)
export PYTHON3=/usr/bin/python3.5
export TOOLS_PYTHON=$PYTHON3

export SPRO_ROOT=/opt/sunstudio12.1
export SPRO_VROOT="$SPRO_ROOT"
export ONLY_LINT_DEFS="-I${SPRO_ROOT}/sunstudio12.1/prod/include/lint"
export ON_CLOSED_BINS=/opt/onbld/closed

export __GNUC=
export GNUC_ROOT=/opt/gcc-7/
export PRIMARY_CC=gcc7,/opt/gcc-7/bin/gcc,gnu
export PRIMARY_CCC=gcc7,/opt/gcc-7/bin/g++,gnu
export SHADOW_CCS=gcc4,/opt/gcc-4.4.4/bin/gcc,gnu
export SHADOW_CCCS=gcc4,/opt/gcc-4.4.4/bin/g++,gnu

SMATCHBIN=$CODEMGR_WS/usr/src/tools/proto/root_$MACH-nd/opt/onbld/bin/$MACH/smatch
export SHADOW_CCS="$SHADOW_CCS smatch,$SMATCHBIN,smatch"

# This will set ONNV_BUILDNUM to match the release on which you are building, allowing ONU.
export ONNV_BUILDNUM=`grep '^VERSION=r' /etc/os-release | cut -c10-`
export PKGVERS_BRANCH=$ONNV_BUILDNUM.0
```

You must also make sure you disable the (optional) IPP and SMB printing support
by commenting out the following lines in the stock template:

```
# export ENABLE_IPP_PRINTING=
# export ENABLE_SMB_PRINTING=
```

If you do need the optional IPP and SMB printing support, you must install and
provide Apache, APR, and APR-util, as well as IPP or CUPS headers for SMB
printing.

## Starting the build

You are now ready to start the illumos build.

The build itself may take anywhere from twenty minutes to a few hours,
depending on the performance of your system.  It is generally good advice to
run the build under a session manager like `screen` or `tmux` so that you can
detach and reattach without interrupting the build.

Run the following command to start the full build:

```
cd /code/illumos-gate
time ksh93 usr/src/tools/scripts/nightly.sh illumos.sh
```

The build creates a _lot_ of output, so rather than emit it directly to the
terminal it is saved in a log file: `log/nightly.log` in your workspace.

You can follow the log file with `tail` as the build progresses; e.g.,

```
tail -F /code/illumos-gate/log/nightly.log
```

If you only want to see warning or error messages from the build, you might
try:

```
tail -F /code/illumos-gate/log/nightly.log | grep -5 '(error|warning).*: '
```

Once the build is complete, the log files (including `nightly.log`) are moved
to a unique directory including the datestamp; e.g.,
`log/log.2019-02-08.17:50`.  A `latest` symlink is also created, so
`log/latest/nightly.log` always refers to the most recently completed build
log.

A summary of the build is saved in the `log/latest/mail_msg` file.  If you see
any errors in this file, you can find the full context by searching for the
same message in the full `nightly.log`.

The `mail_msg` file should be included when submitting a patch to demonstrate a
successful build with no errors or warnings.

## Performing an incremental build

Once you have completed a full `nightly` build, you can perform an incremental
build without discarding files that are already built.  This allows you to make
some changes to the code and rebuild only the files to which you have made
changes.

The `-i` flag to `nightly.sh` performs an incremental build:

```
cd /code/illumos-gate
time ksh93 usr/src/tools/scripts/nightly.sh -i illumos.sh
```

!!! note
    Before submitting a patch, you must perform a full (i.e., not incremental)
    build.

## Installing your build

The build process generates packages that you can install on your system with
the developer system update tool, [onu](https://illumos.org/man/1ONBLD/onu).
Depending on the `NIGHTLY_OPTIONS` you chose earlier, you will have packages in
one of two locations within your workspace:

- `packages/i386/nightly` for a DEBUG build
- `packages/i386/nightly-nd` for a non-DEBUG build

Once you locate your packages, you can install them with `onu`; e.g., for a
DEBUG build:

```
sudo /code/illumos-gate/usr/src/tools/proto/root_i386-nd/opt/onbld/bin/onu \
    -t "$(date -u +nightly-%Y%m%d-%H%MZ)" \
    -d "/code/illumos-gate/packages/i386/nightly"
```

This creates a build environment with a name that includes the date and time in
UTC; e.g., `nightly-20190415-0333Z`.  If your installation was successful, you
can `reboot` to try the new bits!  You can use
[beadm(1M)](https://illumos.org/man/1M/beadm) to list or modify the boot
environments on your machine.

!!! note
    For OpenIndiana and OmniOS it is critical that `PKGVERS_BRANCH` is set
    correctly in your `nightly.sh` environment file, or `onu` will likely
    fail to correctly install packages.  See above on [configuring your
    environment file](#configuring-the-build)

## In case of emergency

The illumos project contains a _lot_ of software with a long history.  The
build system is quite complicated, and not always extremely robust in the face
of unexpected changes on the build machine.

If you're experiencing a problem with the build that you cannot immediately
explain, here are a few things to try:

### Up-to-date build system

Make sure you're running the latest version of your illumos distribution, [as
described above](#make-sure-your-system-is-up-to-date).  If you're hitting a
bug in the build tools it might well have been fixed already.

Even if this doesn't fix your problem, it's easiest for members of the
community to help you out when you're running recent software.

### Missed Flag Day

As people work on the system it is occasionally necessary to make a change that
will impact other developers.  We try to communicate those changes in "flag
day" e-mail messages to the [developer mailing list](../community/lists.md).  A
list of these announcements also appears [here on the site](flagdays.md).

### Reach out for help

If you're still having trouble, remember that you're not alone!  Other members
of the community may be hitting the same problem, or they may just know how to
help.

Members of the community are usually available [in IRC](../community/index.md)
or [on the mailing lists](../community/lists.md).  When asking for help, it's a
good idea to have ready the contents of your `mail_msg` file, or any other
build error output you see on your machine.
