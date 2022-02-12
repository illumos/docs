## Introduction

illumos provides a number of advanced features for downstream distributions and
users to utilize.

### OpenZFS

The illumos project is part of the community of operating system projects that
ships [OpenZFS](http://open-zfs.org/).

ZFS provides excellent data integrity, performance, flexibility and
ease-of-use you simply can't find in other file systems. ZFS combines
traditional concepts like volume management, and file systems with a pooled
storage that does for disks what virtual memory did for RAM.

ZFS was developed at Sun Microsystems in the early 2000s and released as open
source in 2005 as part of the OpenSolaris project. OpenZFS was announced in
2013. For a more detailed history, please see [OpenZFS
History](http://open-zfs.org/wiki/History).

ZFS allows you to:

* Group devices into a single storage pool with various redundancy characteristics
* Create tiered storage with log and cache devices
* Create read-only atomic file system snapshots
* Create writable clones of snapshots
* Send snapshots as a byte stream -- which you can redirect to a file, or send across the network!
* Dynamically modify dataset (file system) attributes
* Delegate dataset management to non-root users or groups

ZFS includes online checksumming of every block, on-demand scrubbing of disks,
and -- in redundant configurations -- self-healing of bad data with good.

ZFS has been ported to [Linux](http://zfsonlinux.org/),
[FreeBSD](https://www.freebsd.org/doc/handbook/zfs.html), [OS
X](https://openzfsonosx.org/) -- and a [Windows
port](https://github.com/openzfsonwindows/ZFSin) is in progress as of late
2017!

### Virtualization

illumos includes a number of virtualization technologies, including:

- Zones, a light weight operating system-level virtualization; analogous
  to "jails" or "containers" as provided by other systems
- Hardware virtualization

#### Native Zones

Native zones provide an isolated illumos environment to run your applications
in, like having a virtual machine without the hypervisor overhead.

#### LX (Linux Emulation)

LX-branded zones provide the Linux system call interface, allowing you to run
most Linux application binaries without recompiling them for illumos. This
facility is available in several illumos distributions, including SmartOS and
OmniOS.

#### KVM

KVM and QEMU were ported to illumos in 2011, and can be used on Intel CPUs
with VMX and EPT support.

#### bhyve

Joyent is in the process of porting the bhyve hypervisor from FreeBSD to
illumos.  The port is available in at least the SmartOS and OmniOS
distributions.

### Introspection and Debugging

#### DTrace

DTrace allows for system-wide tracing of a kernel for debugging applications and
the operating system, as well as gathering profiling data. DTrace along with MDB
allows you to leverage [CTF data](https://illumos.org/man/4/ctf) to inspect
userland and kernel structures.

#### Modular Debugger (MDB)

MDB, the illumos modular debugger, allows you to inspect running processes,
core files, kernel state, and kernel crash dumps.
[KMDB](https://illumos.org/man/1/kmdb) also allows controlling the execution of
a running kernel.

### Service Management Facility (SMF)

[SMF](https://illumos.org/man/5/smf) helps administrators manage services
running on the system. SMF can take care of tracking service dependencies,
supervising and restarting processes, disabling perpetually crashing
applications, and more.

### Firewall

illumos uses [ipfilter](https://illumos.org/man/5/ipfilter) for firewalling.
Using ipfilter you can create firewalls not just for the host system, but also
for zones and hardware virtualized systems.

### Virtual Networking

[dladm(8)](https://illumos.org/man/8/dladm) allows users to create Virtual
NICs, bridges, and in some distributions [overlay
networks](https://smartos.org/man/7/overlay).
