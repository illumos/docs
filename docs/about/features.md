## Introduction

illumos provides a number of advanced features for downstream distributions and
users to utilize.

### Filesystems

#### OpenZFS

We are the canonical upstream for the [OpenZFS Project](http://open-zfs.org/).

ZFS provides excellent data integrity, performance, flexilibility and
ease-of-use you simply can't find in other filesystems. ZFS combines
traditional concepts like volume management and filesystems with a pooled
storage that does for disks what virtual memory did for RAM.

ZFS was developed at Sun Microsystems in the early 2000s and released as open
source in 2005 as part of the OpenSolaris project. OpenZFS was announced in
2013. For a more detailed history, please see [OpenZFS
History](http://open-zfs.org/wiki/History).

ZFS allows you to:

* Group devices into a single storage pool with various redundancy characteristics
* Create tiered storage with log and cache devices
* Create read-only atomic filesystem snapshots
* Create writable clones of snapshots
* Send snapshots as a bytestream -- which you can redirect to a file, or send across the network!
* Dynamically modify dataset (filesystem) attributes
* Delegate dataset management to non-root users or groups

ZFS includes online checksumming of every block, on-demand scrubbing of disks,
and -- in redundant configurations -- self-healing of bad data with good.

ZFS has been ported to [Linux](http://zfsonlinux.org/),
[FreeBSD](https://www.freebsd.org/doc/handbook/zfs.html), [OS
X](https://openzfsonosx.org/) -- and a [Windows
port](https://github.com/openzfsonwindows/ZFSin) is in progress as of late
2017!

#### Others

illumos provides a number of [other filesystems](http://illumos.org/man/7fs/all), including:

* [Loopback](http://illumos.org/man/7fs/lofs)
* [Temporary](http://illumos.org/man/7fs/tmpfs)
* [UFS](http://illumos.org/man/7fs/ufs)
* [HSFS](http://illumos.org/man/7fs/hsfs)
* [NFS](https://illumos.org/man/1M/nfsd)
* [FAT](http://illumos.org/man/7fs/pcfs)
* [CIFS](http://illumos.org/man/7fs/smbfs)
* [UDFS](http://illumos.org/man/7fs/udfs)

### Virtualization

illumos offers a number of virtualization options, including lightweight
"operating system zones", Linux emulated zones, and KVM.

!!! tip "Terminology"
    In illumos, the global context is referred to as the _global zone_, or
    _GZ_.

    Other zone "brands" are _non-global zones_, _NGZ_, or simply _zones_.

#### Native OS

#### LX (Linux Emulation)

#### KVM

#### bhyve (Under development!)

Joyent is in the process of porting FreeBSD's bhyve to illumos. It should be
available for testing soon!

### Introspection and Debugging

#### DTrace

#### mdb

### Fault Management

### Service Management

### Firewall

### Virtual Networking

### Security

