# Building illumos with Sun Studio

!!! warning "Here Be Dragons"
    Building illumos with Sun Studio is not recommended.

    If you *do* wish to build with Sun Studio, you need specifically patched
    versions of both Studio 12 (used to compile) and 12.1 (used for lint) to get
    consistent results. These are no longer distributed by Oracle and can not be
    legally found in the open Internet. If you do not have access to these
    versions, skip this section and use GCC.

## Introduction

illumos-gate does not build correctly with Sun Studio versions released after
12.0. Reportedly using a newer version of the compiler will produce a system
containing grave, data-corrupting bugs.  Patched compilers were previously
available from Sun Microsystems, however not licensed for redistribution. After
a recent Oracle site reorganization, the necessary compilers are no longer
available.

## Requirements

If you have the patched versions of both Sun Studio 12 and 12.1, they should be
installed in `/opt/SUNWspro` (Studio 12), and `/opt/SUNWspro/sunstudio12.1`
(Studio 12.1), respectively. Pay attention, the Studio 12.1 location is
different from how it was in OpenSolaris, i.e. it's not `/opt/sunstudio12.1`.

The meta-procedure for cleaning up optionally prepackaged Sun Studio
installations and installing the ones you require for building illumos
(assuming your stashed Sun Studio 12 distribution archives are now pre-copied
to /tmp) is as follows:

```
sudo pkg uninstall \
    pkg:/developer/sunstudio12u1* \
    pkg:/metapackages/build-essential
 
sudo mkdir -p /opt/SUNWspro
cd /opt/SUNWspro
sudo tar xjf /tmp/sunstudio12-patched-ii-2009Sep-sol-x86.tar.bz2
sudo tar xzf /tmp/sunstudio12u1-patched-ii-2010Feb-sol-x86.tar.gz
```

The first archive contains the product component sub-directories directly at
the top-level, and the second has similar sub-directories under the top-level
sunstudio12.1 as its children. Thus you receive the structure outlined above.

You can check if you have the correct versions installed as follows. All of the
following tests must succeed and return these specific product/patch versions:

```
$ /opt/SUNWspro/bin/cc -V
cc: Sun C 5.9 SunOS_i386 Patch 124868-10 2009/04/30
usage: cc ...
 
$ /opt/SUNWspro/sunstudio12.1/bin/cc -V
cc: Sun C 5.10 SunOS_i386 Patch 142363-03 2009/12/03
usage: cc ...
 
$ /opt/SUNWspro/sunstudio12.1/bin/lint -V
lint: Sun C 5.10 SunOS_i386 Patch 142363-03 2009/12/03
usage: lint ...
```

You must then adjust your `nightly(1)` environment file (i.e. by adding a line in `illumos.sh`) to specify that Studio should be used as the default compiler, by adding:

```
export __SUNC="";
```
