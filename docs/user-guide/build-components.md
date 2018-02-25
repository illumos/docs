!!! warning "Requires Review"
    This page references some old practices and needs to be reviewed.

# How to build components

## When it's appropriate

You can build just a component when you don't need the entire consolidation,
when you are building a self-contained utility, when you are getting started
with Illumos, or when you want to do a quick build.

This approach is only for independent programs like m4, date, cron, hostid,
man... etc.

## This example

I'm building the m4 command from the ONNV consolidation on a system running oi_148.

## Requirements
    
Setup of the compilation environment is detailed in [How To Build illumos](build.md).

### Mercurial (hg)

This should be installed in /usr from the IPS package pkg:/developer/versioning/mercurial.

### The compiler

The C compiler is the properly patched version of GCC 4.4.4

### Build tools

These reside in /opt/onbld and are installed from the IPS package pkg:/developer/build/onbld.

### The PATH

Mine is:

```
PATH=/usr/local/bin:/usr/bin:/opt/SUNWspro/bin:/usr/ccs/bin:\
/opt/onbld/bin:/opt/onbld/bin/i386:/opt/sfw/bin:/usr/sfw/bin:\
/usr/dt/bin:/usr/openwin/bin:/usr/sbin
export PATH
```

Just make sure all of the executables you need are available through the PATH.

### A symlink

I needed this symlink for the PATH to work correctly:

```
/opt/SUNWspro -> /opt/sunstudio12.1
```

## Preparation
    
!!! note ""
    Setup of the compilation environment, including preparation of the recommended directories in a ZFS layout, and checkout of the code, is detailed in How To Build illumos.
    The steps below outline an alternative (and somewhat incompatible) approach to this procedure. Still, if you only intend to build small pieces of the project, especially if you only have an unprivileged user account on the build host, these instructions should suffice and may be less complicated to follow.

### Set up the location

```
$ cd ~/Downloads
$ mkdir code
$ cd code
```

### Obtain the source

```
$ hg clone ssh://anonhg@hg.illumos.org/illumos-gate
```

### Set up the environment file

```
$ cd illumos-gate
$ cp -p usr/src/tools/env/illumos.sh .
$ cp -p illumos.sh illumos.sh-orig
$ vim illumos.sh
...

### Result of edition:
$ diff illumos.sh-orig illumos.sh
58c58
< export GATE='testws'
---
> export GATE='illumos-gate'
61c61
< export CODEMGR_WS="$HOME/ws/$GATE"
---
> export CODEMGR_WS="$HOME/Downloads/code/$GATE"
196c196
< #export ONBLD_TOOLS='/opt/onbld'
---
> export ONBLD_TOOLS='/opt/onbld'
217a218,225
> 
> # Lint locations
> i386_LINT=/opt/sunstudio12.1/bin/lint; export i386_LINT
> amd64_LINT=/opt/sunstudio12.1/bin/lint; export amd64_LINT
> sparc_LINT=/opt/sunstudio12.1/bin/lint; export sparc_LINT
> sparcv9_LINT=/opt/sunstudio12.1/bin/lint; export sparcv9_LINT
> 
> ####
```

As you can see, I modified some lines in the file to suit my build system, and
added a few so that the lint command from Sun Studio 12u1 could be found.

## Preparing the workspace for component build

A few tools have to be prepared before we can build a component. To build them,
you should run commands in a new shell which sets some environment variables:

```
ln -s usr/src/tools/scripts/bldenv.sh .
ksh93 bldenv.sh -d illumos.sh -c "cd usr/src && dmake setup"
```

## Procedure

### Location

Change directory to where the m4 Makefile (the build target of our example) resides:

```
$ cd ~/Downloads/code/illumos-gate/usr/src/cmd/sgs/m4
```

## Build

Clean out the object files by 'make clean'. It only deletes object files, and
not the generated executables. But the executables will be regenerated once all
the object files are rebuilt (and become newer than the executable target).

```
$ bldenv ~/Downloads/code/illumos-gate/illumos.sh 'make clean'
```

Do a dry-run by 'make -n'

```
$ bldenv ~/Downloads/code/illumos-gate/illumos.sh 'make -n'
```

Now actually build m4 binary by 'make'

```
$ bldenv ~/Downloads/code/illumos-gate/illumos.sh 'make'
```

Note that the argument list must be quoted if it contains more than one word.

### Check

Object file and i386/m4 executable file got generated.

```
$ find i386/
i386/
i386/Makefile
i386/.make.state
i386/m4objs
i386/m4objs/m4ext.o
i386/m4objs/m4y.o
i386/m4objs/m4macs.o
i386/m4objs/m4.o
i386/m4.xpg4
i386/m4objs.xpg4
i386/m4objs.xpg4/m4y_xpg4.o
i386/m4objs.xpg4/m4ext.o
i386/m4objs.xpg4/m4.o
i386/m4objs.xpg4/m4macs.o
i386/m4
$
```

Use "ldd" and "file" commands to profile the built m4 binary.

```
$ ldd i386/m4
        libc.so.1 =>     /lib/libc.so.1
        libm.so.2 =>     /lib/libm.so.2
$ file i386/m4
i386/m4:        ELF 32-bit LSB executable 80386 Version 1 [FPU],  \
dynamically linked, not stripped, \
no debugging information available
$
Run lint
$ bldenv ~/Downloads/code/illumos-gate/illumos.sh 'make lint'
```

### Alternatives

```
Garrett D'Amore suggests:
doing "make setup" in the top level, plus a "make install" in the
directory of interest, usually works if the utility is self contained.
```

```
Jens Elkner recommends:
I made the src tree once nightly to "initilize" required stuff. After
that I just source the script mentioned below when I start working,
change to the dir of interest and call 'make ...'. This usually works
even if nightly doesn't run through completely ...

http://iws.cs.uni-magdeburg.de/~elkner/osol/onbld.env2

Local copy backup in illumos Wiki: onbld.env2
```

```
Dan McDonald cites:
http://kebesays.blogspot.com/2011/03/for-illumos-newbies-on-developing-small.html

I haven't looked very closely at the Illumos build instructions, but
I'm going to do some things now that will help kernel module writers
(e.g. device drivers) get started without resorting to a full build
right off the bat.
```

## Some component build examples.

libc build on oi_148 dual CPU with 2G RAM VMware session (also note this example uses the recommended build directory layout):

```
$pwd
/code/illumos-gate/usr/src/lib/libc
 
$time bldenv /code/illumos-gate/illumos.sh 'make'
<snip>
ar: creating libc_pic.a
/usr/ccs/bin/mcs -d -n .SUNW_ctf libc_pic.a > /dev/null 2>&1
ar -ts libc_pic.a > /dev/null
/code/illumos-gate/usr/src/lib/libc/i386/etc
 
real    10m37.770s
user    7m58.969s
sys     5m54.108s
 
$
```
