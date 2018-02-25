# How to build illumos

!!! note ""
    Please also refer to the [illumos Developer's Guide](https://illumos.org/books/dev/intro.html).

!!! warning "Requires Review"
    This page references some old practices and needs to be reviewed.

## Introduction

This document will help prepare you to build the source code for illumos. It
assumes some familiarity with development on Unix-like systems.

You need an illumos-based operating system to build illumos. Cross-compilation
is not supported).

If you don't have one installed, the quickest way to get started is to download
and install either [OpenIndiana](https://openindiana.org) or
[OmniOS](https://www.omniosce.org/).

You may use a virtual machine – compilation performance may suffer, but it is
functional. Some other distributions support self-hosting, including
compilation of illumos-gate, as well.

!!! note ""
    All commands in this guide assume you run them as an unprivileged user.
    sudo will be prepended to commands which need additional privileges; on some
    systems pfexec can be used instead, if your user has the correct RBAC profiles.
    The generic commands below use a $USER variable to define the current
    (unprivileged) user account's name which will ultimately be used to compile the
    project. If you are not using a stock shell or have manipulated the $USER
    variable in your environment at a site, system, or user level, you are
    responsible for diagnosing and addressing any consequences.

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
please refer to [Building With Sun Studio](build-studio.md).

# Building illumos

## Preparing the source-code directory

You can use any location, but for the purposes of this guide, we will assume
that you have a directory `/code` owned by your user ID, which you are using to
obtain source and build.

For a less naive example, see the [Build datasets](build-datasets.md) page and
some more industrious details on [Managing multiple
workspaces](build-workspaces.md) and [Working on several bugs]() at once.

## Getting the source

You may use the Git source code management system to retrieve the illumos
source code. Make sure you have about 6 gigabytes of free space for the source
and binaries combined.

The repository is available from GitHub using the Git source code control
system.

The Git repository URI is: `git://github.com/illumos/illumos-gate.git`

Or, if the Git protocol is firewalled at your site: https://github.com/illumos/illumos-gate.git

The illumos-gate source can then be cloned using:

```
cd /code
git clone git://github.com/illumos/illumos-gate.git
```

## Getting closed binaries

There are still closed components in illumos that have not yet been replaced.
You must get the latest closed binaries from Sun/Oracle, since illumos
currently needs those in order to build:

```
cd /code/illumos-gate
wget -c \
  https://download.joyent.com/pub/build/illumos/on-closed-bins.i386.tar.bz2 \
  https://download.joyent.com/pub/build/illumos/on-closed-bins-nd.i386.tar.bz2
tar xjvpf on-closed-bins.i386.tar.bz2
tar xjvpf on-closed-bins-nd.i386.tar.bz2
```

!!! note ""
    OmniOS r151016 or later and OpenIndiana users have these tarballs installed in /opt/onbld/closed, and ON_CLOSED_BINS can be set to point to this directory directly.

!!! warning ""
    If you had a crypto tarball from an earlier build, do not use it here, as it is no longer required to build illumos. You should remove it from your tree if already present.

According to the gcc-4.4.4-il heads-up note, the kernel modules among the
closed binaries might need some fixup for proper compilation. According to
several developers, however, they've never needed to do this in practice. Just
in case you are trying to build some older branch of illumos which might
require this modification and inexplicably breaks without it, the steps are
outlined below in the troubleshooting section.

## Preparing the build environment

### General build configuration

The build is configured using a shell script with environment variables, a template for this file is included:

```
cp usr/src/tools/env/illumos.sh .
vi illumos.sh       # or your favourite editor instead of @vi@
```

The settings we are going to focus on for now are the following:

| &nbsp; | &nbsp; |
|--------|--------|
| NIGHTLY_OPTIONS | You may remove the "l" (lowercase L) option from the string, this will disable lint checking of the code to save some time during the build, but patches should be linted. |
| CODEMGR_WS | This should be the root of the directory with the code. If you followed the previous example, it will be `/code/illumos-gate`. |
| STAFFER | Change this to the name of the non-privileged user you use on the system |
| VERSION | Set this to illumos-gate or whatever version string you want for the build |

!!! note ""
    `ONNV_BUILDNUM` specifies the build number which is used in packaging. If you intend to upgrade a system whose build number is greater than the one in illumos-gate (currently 148), such as OmniOS you need to specify this to allow upgrades until issue #1118 is addressed. Run:
    ```
    pkg info osnet-incorporation | grep Branch:
    ```
    If you see, for example, "Branch: 0.151.1", you must choose a number greater than the part after the leading "0.". For example, add

```
export ONNV_BUILDNUM=152
```

to the `illumos.sh` script.

On OpenIndiana you'll likely see something like 'Branch: 2017.0.0.16790'. You
have to use PKGVERS_BRANCH to overwrite this value, you can't use ONNV_BUILDNUM
for this purpose. You should set PKGVERS_BRANCH in a form of YEAR.MAJOR.0.0 ,
where YEAR is the current year and MAJOR is more that the one used by
OpenIndiana. For example:  

```
export PKGVERS_BRANCH=2017.3.0.0
```

## Building with only GCC-4.4.4-il (i.e. without using Sun Studio at all)

!!! note ""
    If you are building with solely GCC 4.4.4 (i.e. you do NOT wish to use Sun Studio at all), you must append these lines to the end of illumos.sh:
    ```
    # The following are added to build without Sun Studio
    export CW_NO_SHADOW=1
    export ONLY_LINT_DEFS=-I${SPRO_ROOT}/sunstudio12.1/prod/include/lint
    export __GNUC=""
    #unset __SUNC
    ```

This should suffice for compilation of modern illumos-gate sources executed
on a modern distribution. Older branches (circa 2012) might need some more
setup which, along with explanation of the options, can be found below in the
troubleshooting section.

We understand that the required version of Sun Studio is no longer publicly
available and will accept contributions that were tested only with GCC.

## OmniOS Modifications

OmniOS r151014 or later has sample build files in `/opt/onbld/env/omnios-*` for
use with illumos-gate or illumos-omnios.  If you roll your own env files, read
on.

OmniOS requires that GCC-only be used.  OmniOS ALSO requires that a few other
variables are set:

### OmniOS mods

```
# Help OmniOS find lint
export SPRO_ROOT='/opt'
 
# OmniOS places GCC 4.4.4 differently.
export GCC_ROOT=/opt/gcc-4.4.4/
 
# These are required for building on OmniOS.
export PERL_VERSION=5.16.1
export PERL_PKGVERS=
export PERL_ARCH=i86pc-solaris-thread-multi-64int
 
# Pre-r151022 (i.e. older) versions of OmniOS building -gate
# need to set Python versions explicitly.
# Utter "/usr/bin/python --version" to confirm.
export PYTHON_VERSION="2.6"
export PYTHON_PKGVERS="-26"
 
# SET ONNV_BUILDNUM appropriately - to ONU r151014, set this to 151014.
export ONNV_BUILDNUM=151014
```

You must also make sure you disable IPP and SMB printing support on the default OmniOS installation by commenting out the following lines.

```
# export ENABLE_IPP_PRINTING=
# export ENABLE_SMB_PRINTING=
```
If you need to also compile IPP and SMB printing, you must provide the Apache, Apr/Apr-util for IPP or CUPS headers for SMB printing.

## OpenIndiana Modifications

To build illumos-gate on OpenIndiana , you'll have to customize illumos.sh in
the following way:

### OpenIndiana Hipster mods

```
# Set version which is greater than current OpenIndiana Hipster build numbers, ONNV_BUILDNUM is ignored if PKGVERS_BRANCH is set:
export PKGVERS_BRANCH=2017.3.0.0
 
# Set to current perl version
export PERL_VERSION="5.22"
export PERL_PKGVERS="-522"
 
# If you are building on the latest OpenIndiana (2017-03-07 and later)
export BLD_JAVA_8=
```

## Starting the build

You are now ready to start the illumos build.

Since this process may take up to several hours depending on your system
(reference build times are in a chart below), it may be wise to start the build
job in a VNC session, GNU Screen (screen), or tmux. The screen program can be
installed with the `pkg:/terminal/screen` package.

Run the following command to start the full build:

```
cd /code/illumos-gate
cp usr/src/tools/scripts/nightly.sh .
chmod +x nightly.sh
time ./nightly.sh illumos.sh
```

Note that the command does not give any progress output. You can instead follow
the log file at `log/nightly.log`, which is updated (slowly) during the build
process. In another terminal, run:

```
tail -f /code/illumos-gate/log/nightly.log
```

To only track the running build for warnings and errors you might instead run:

```
tail -F /code/illumos-gate/log/nightly.log | gegrep -A5 -B5 '(error|warning).*: '
```

After the build is complete, the nightly.log file and some other generated logs
are moved into a uniquely named subdirectory `log/log.$TIMESTAMP/` (i.e.
`/code/illumos-gate/log/log.2012-04-20.04\:17/`).

A dry overview of the build progress (hopefully small – about 2KB in size –
with no errors) is saved in `log/log.$TIMESTAMP/mail_msg` file intended for
mailing to the build administrator after the build completes (this automation
is out of the scope of the nightly.sh script). If you do receive any errors in
the `mail_msg` report file, you can grep the error lines in the larger
`nightly.log` file.

## Performing an incremental build

If you've made changes after completing a nightly build, you can perform an incremental build without discarding the already built files.

```
cd /code/illumos-gate
./nightly.sh -i illumos.sh
```

To make this the default, edit `illumos.sh` and add the character `i` to `NIGHTLY_OPTIONS`.

!!! note
    Before submitting a patch, we request that you perform a full, non-incremental build including the lint stage.

## Building specific components

[How To Build Components]()

## Installing built software

### Installing the nightly build on local machine with onu script

The build process will generate updated packages. Depending on the
NIGHTLY_OPTIONS variable in illumos.sh script, the packages will be written
either to $PWD/packages/i386/nightly (with debug, the typical default) or to
$PWD/packages/i386/nightly-nd (without debug). Therefore there are two possible
commands to install the software you you just built. You need choose the proper
onu command, typically the first one listed below.

Typical install: you can install with onu for debug builds (the default, with
'F' and 'D' characters in NIGHTLY_OPTIONS variable in illumos.sh):

```
$ sudo ./usr/src/tools/scripts/onu \
    -t nightly-`date +%Y-%m-%d` -d $PWD/packages/i386/nightly
```

!!! note
    For OmniOS, it is critical that the ONNV_BUILDNUM in the nightly environment file be set to the OmniOS release you wish to ONU.  Otherwise, ONU will fail.

The non-typical installs are detailed in the following pages:

* [Advanced - non-debug install]() describes different onu options for the different set of built packages.
* [Redistributing built packages]() and [Installing built illumos packages into BEs on a remote host and non-onu updates]() describe how to install illumos using the package depot server over the network, perhaps on a machine different from your build host. This recipe bypasses the onu script automation and manipulates your boot environments with beadm and pkg commands directly.

## Possible problems

In any case, if you have build errors or other "inconsistencies", it would be
wise to revise the mail_msg logfile that can contain short error descriptions,
and grep for those errors in the longer nightly.log file. If that doesn't help,
you should also recreate the build in a "clean lab" environment, which may be
set up as a local zone according to the Building in zones instructions and rule
out the local environment's influence (conflicting libraries and binaries,
perhaps from your own earlier builds, come to mind first).

## Localization bugs #167 and #168

illumos has entirely different localization infrastructure from Solaris, so
your existing system locales will not work.

The English locales for illumos are in pkg:/locale/en (NOT
pkg:/system/locale/en), and if you wish to use them, you'll need to install
that package after you reboot. Likewise, other locales are in
pkg:/locale/<language code> where <language code> is a two letter ISO 639-1
code, except for zh_cn/zh_hk/zh_mo/zh_sg/zh_tw.

If your locale is not installed, it will cause problems with software which
behaves badly if setlocale() fails. This includes, at least, time-slider and
svcs(1M). The pkg(5) commands print a warning, but function normally.

If this is a problem, you can  "export LANG=C LC_ALL=C" as a workaround, and
change the LANG setting in/etc/default/init to 'C' (and reboot) to make the
change permanent.

## Package repository (path /code/illumos-gate/packages/i386/nightly/repo.redist) is not created and onu script fails

This error has happened to me whenever I ran the default checkout and
full-build procedure outlined above (in VirtualBox VMs); I don't yet know why
(possibly due to a wrong setup of my SunStudio compiler stack, as was later
discovered).  However, rerunning with an incremental build has created the
package repository correctly (as well as full builds with proper SunStudio
setup):

```
./nightly.sh -i illumos.sh
```

Ensuring a build with only GCC-4.4.4-il for older branches of illumos
Current illumos-gate (as of March 2014) should compile cleanly with GCC with the simplified instructions above. However, some earlier versions of the gate needed more configuration steps to compile properly, and the settings below shouldn't break anything for the newer source code as well (wink)

If you are building with solely GCC 4.4.4 (i.e. you do NOT wish to use Sun Studio at all), you must append these lines to the end of illumos.sh:

```
# The following are added to build without Sun Studio
export CW_NO_SHADOW=1
export ONLY_LINT_DEFS=-I${SPRO_ROOT}/sunstudio12.1/prod/include/lint
# The following select the proper version of GCC
__GNUC=""; __GNUC4=""; export __GNUC __GNUC4
GCC_ROOT=/opt/gcc/4.4.4; export GCC_ROOT
CW_GCC_DIR=${GCC_ROOT}/bin; export CW_GCC_DIR
```

Explanation of these settings:

CW_NO_SHADOW - Set this to 1 to prevent the shadow compiler from running (for
instance, if you do not have Studio at all, in which case a regular build would
fail due to "cw: error: couldn't run /opt/SUNWspro/bin/cc (No such file or
directory)" and inability to run the shadow compilation and thus verify the
fitness of code for both supported compilers).  ONLY_LINT_DEFS - This is needed
so the lint is able to find the proper note.h include file.  If __GNUC is
defined, then a GCC would be the primary compiler. If __GNUC4 (or legacy
__GNUC3) is defined, then the particular version of the compiler is used.
Remember to unset __SUNC to properly use just one primary compiler (wink) and
use CW_NO_SHADOW=1 as described above to completely disable a secondary
(shadow) compiler.  The last two lines make sure the patched version of
GCC-4.4.4 is used (the default gcc version shipped with e.g. earlier
OpenIndiana, gcc-3.4.3, is not suitable for building illumos), as described
here.

If you are trying to build with GCC 4.4.4 and your build fails because of some
invalid GCC warning options, try setting the variables GCC_ROOT and CW_GCC_DIR
as shown above and described here.

    
!!! warning ""
    While recently rebuilding a historical 2012 version of illumos-gate with GCC-4.4.4-only setup per instructions above, I've still got Sun Studio errors in my mail_msg file like:

```
< cw: error: couldn't run /opt/SUNWspro/bin/CC (No such file or directory) 
< cw: error: couldn't run /opt/SUNWspro/bin/cc (No such file or directory)
```

or more frightening:

```
< ln: cannot access /code/illumos-gate/proto/root_i386/usr/lib/isaexec
```

However, the files in proto/ and packages/ were created successfully. So... even error reports may need manual verification before panic and frantic fixes (wink)

### Command failed for target `packages.i386/developer-dtrace.dep'

4719 introduces a flag day for people who build illumos-gate. You will need a
Java Developers Kit (JDK) 7 or later. OpenIndiana 151a9 does NOT have this by
default.

Symptoms: Users still on JDK6 will see build errors in the packaging portions
like such:

```
==== package build errors (non-DEBUG) ====
 
dmake: Warning: Command failed for target `packages.i386/developer-dtrace.dep'
dmake: Warning: Command failed for target `packages.i386/service-network-dns-mdns.dep'
dmake: Warning: Target `install' not remade because of errors
Cause: These are due to javadoc changes between 6 and 7.  The dtrace and mdns packages generate javadoc, so their packaging manifests are updated to the 7 versions.
```

Cure: Builders must either set JAVA_ROOT to an installation location of JDK7,
or must have /usr/java populated with JDK7 (or pointing to an installation
location of JDK7). You can use whatever distribution of JDK7+ works for you
best (packages or tarballs, OpenJDK or Sun/Oracle JDK).


If you are on the latest OpenIndiana, you want to install runtime/java/openjdk8
and developer/java/openjdk8 packages. Then in your env file, set:

```
export BLD_JAVA_8=
```

# Build times

As a convenience, we will try to assemble some build times for various hardware
configurations here, so you can get an idea in advance of how long it will
take:

| Processor(s)               |  No. of cores  |  Memory | Time (HH:MM) |   Notes                       |
|----------------------------|----------------|---------|--------------|-------------------------------|
| 2 x Xeon X5570 2.93GHz     | 2 x 4          | 36 GB   | 00:19        | NIGHTLY_OPTIONS='-FnCDmprt'   |
| 4 x Opteron 6172 2.1 GHz   | 4 x 12         | 128 GB  | 00:21        | NIGHTLY_OPTIONS='-FnCDmprt'   |
| Xeon E3-1270 3.4 GHz       | 4              | 16 GB   | 00:23        | NIGHTLY_OPTIONS='-FnCDmprt' |
| Core i7-3770 3.4GHz        | 4              | 8 GB    | 00:28        | NIGHTLY_OPTIONS='-nCprt' (with SSD, the production build for Tribblix) |
| Xeon E3-1245V2 3.4 GHz     | 4              | 16 GB   | 00:31        | NIGHTLY_OPTIONS='-FnCDmprt' |
| Core i7-2600K 3.4 GHz      | 4              | 8 GB    | 00:35        | NIGHTLY_OPTIONS='-nClmprt' |
| 2 x Xeon E5620 2.4 GHz     | 2 x 4          | 48 GB   | 00:38        | None |
| 1 x Xeon E5607 2.27GHz     | 1 x 4          | 12 GB   | 00:46        | NIGHTLY_OPTIONS='-FnCDmprt' |
| Xeon E3-1245V2 3.4 GHz     | 4              | 16 GB   | 00:47        | NIGHTLY_OPTIONS='-FnCDlmprt' (with lint) |
| 2 x Xeon E5540 2.53 GHz    | 2 x 4          | 24 GB   | 00:50        | With lint |
| 2 x Xeon E5506 2.13 GHz    | 2 x 4          | 24 GB   | 00:50        | No dmake check |
| 1 x Xeon X5650 2.67 GHz    | 1 x 6          | 12 GB   | 00:51        | With lint, default NIGHTLY_OPTIONS |
| 2 x Xeon E5506 2.13 GHz    | 2 x 4          | 24 GB   | 01:03        | None |
| Core i7-960 3.2 GHz        | 4              | 9 GB    | 01:03        | With lint |
| 2 x Xeon E5506 2.13 GHz    | 2 x 4          | 16 GB   | 01:06        | VMware Workstation guest |
| Core i7-930 2.8 GHz        | 4              | 8 GB    | 01:07        | VMware ESXi guest |
| Xeon  E5-2676 v3 2.4GHz    | 2              | 16 GB   | 01:13        | NIGHTLY_OPTIONS='-nCprt' (Tribblix) on an AWS m4.xlarge EC2 instance |
| Core 2 Quad Q6600 2.4 GHz  | 4              | 2 GB    | 01:16        | None |
| 2 x Xeon E5310 1.6 GHz     | 2 x 4          | 32 GB   | 01:24        | None |
| 1 x Athlon II X2 240 2.8 GHz | 2            | 2 GB    | 01:27        | NIGHTLY_OPTIONS='-FnCDmprt', on a low end SSD |
| Core 2 Quad Q9300 2.5 GHz    | 4            | 7 GB    | 01:32        | None |
| 2 x Xeon E5420 @ 2.50GHz     | 2 x 4        | 4 GB    | 01:33        | Default NIGHTLY_OPTIONS; an incremental rebuild takes 13 min to walk all Makefiles |
| 2 x Opteron 2218HE 2.6 GHz   | 2 x 2        | 16 GB   | 01:42        | None |
| Core i5-540M 2.53 GHz        | 2            | 4 GB    | 01:54        | None |
| 2 x UltraSPARC-T2+ 1165 MHz  | 128 threads  | 32 GB   | 02:18        | NIGHTLY_OPTIONS='-nCprt' (the Tribblix SPARC build) |
| Core i3-370M 2.40 GHz        | 2            | 2 GB    | 02:30        | None |
| Core 2 Quad Q8200 2.33 GHz   | 4            | 5 GB    | 02:30        | Default NIGHTLY_OPTIONS. |
| Core 2 Duo T8300 2.3 GHz (T61)     | 2      | 2 GB    | 02:58        | VMware Workstation 2 CPUs |
| Core 2 Duo E6750 2.66 GHz          | 2      | 8 GB    | 02:59        | Sun Ultra 24 (with lint) |
| Core 2 Duo Celeron E3200 3.2 GHz   | 2      | 4 GB    | 03:28        | 2.4 GHz CPU over clocked to 3.2. Everything running on a low end SSD. With lint. |
| Core 2 Duo T5600 1.8 GHz           | 2      | 3.3 GB  | 04:26        | None |
| Opteron 146 2 GHz                  | 1      | 4 GB    | 07:28        | None |
| 4 x Dual-Core Opteron 8218 2.6 GHz | (8-vCPU VM)   | 16 GB (2GB VM) | 35:47 + 9:05 | VirtualBox 3.0.12 VM, with 8 vCPUs and 2GB vRAM; local vHDD; with lint and default NIGHTLY_OPTIONS='-FnCDlmprt' NOTE: Package repo did not get built at all with the first nightly run, only with the second, incremental nightly run (another 9 hours) |

### Notes

* "Bare Metal" just slightly faster than VMware guest. On the other hand, VirtualBox painfully slow.
* More cores faster but not linear increase.
* SSD use seems to provide nice speedup.
* As expected, lint checking results in longer build times.
