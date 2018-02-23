# what *is* illumos?

To quote the [illumos Developer's Guide](http://illumos.org/books/dev/):

!!! note ""
    illumos is a consolidation of software that forms the core of an Operating
    System. It includes the kernel, device drivers, core system libraries, and
    utilities. It is the home of many technologies include ZFS, DTrace, Zones,
    ctf, FMA, and more. We pride ourselves on having a stable, highly
    observable, and technologically different system. In addition, illumos
    traces it roots back through Sun Microsystems to the original releases of
    UNIX and BSD.

illumos itself does not offer an OS distribution -- it is the core from which
distributions can be created. This is quite similar to how the BSD projects are
organized, though different components are available (or not.)

Please see the [history page](history.md) for more information about the
(surprisingly convoluted!) origins of illumos.

### Licensing

illumos is licensed under the CDDL.

### Community Values

* Empathy as a core engineering tenant
* Code quality and correctness

### Technology Features

The following are shared tenants and features for distributions utilizing illumos:

* Stability
* SMP support for many CPUs
* Security multi-user facilities like Roles and Privileges
* Multi-_tenancy_ with Zones
* Unparalleled system introspection with [DTrace](http://dtrace.org/guide/)
* A single pipeline for system issues with the Fault Management Architecture (FMA)
* Network virtualization with Crossbow
* Hardware virtualization with KVM
* [Excellent online documentation](https://www.illumos.org/man/)
* [Source code for the entire system](https://github.com/illumos/illumos-gate)

### Supported platforms

illumos currently supports i86pc (x86, x86_64) architectures. However, it does
cleanly compile on SPARC and there are several SPARC distributions of illumos.

illumos also works fine on AMD64, though KVM is awaiting merges to work properly.

To determine if a specific piece of hardware will work with illumos, please
refer to the [Hardware Compatability List](https://www.illumos.org/hcl/).

For pre-defined builds of server-grade hardware, you might also refer to
[Joyent Engineering Manufactory
database](http://eng.joyent.com/manufacturing/bom.html).

### Uses for illumos

illumos can be used in any number of situations.

### illumos Development Model

Please refer to the [illumos Developer's Guide]() which describes how illumos
is built.

### Contributing to illumos

 * http://wiki.illumos.org/display/illumos/How+To+Contribute
 * http://zinascii.com/pub/talks/fixing-bugs-in-illumos.pdf

### Third Party Software

illumos does not itself ship third party software, or contain software like webservers and so forth. (An exception would be OpenSSH shipping in the core.)
