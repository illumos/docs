# what *is* illumos?

To quote the [illumos Developer's Guide](http://illumos.org/books/dev/):

!!! note ""
    illumos is a consolidation of software that forms the core of an Operating
    System. It includes the kernel, device drivers, core system libraries, and
    utilities. It is the home of many technologies including ZFS, DTrace, Zones,
    ctf, FMA, and more. We pride ourselves on having a stable, highly
    observable, and technologically different system. In addition, illumos
    traces it roots back through Sun Microsystems to the original releases of
    UNIX and BSD.

illumos itself does not offer an OS distribution -- it is the core from which
[distributions](distro.md) can be created. In this sense, illumos is similar to
a BSD source tree, or Linux's kernel.org.

Please see the [history page](history.md) for more information about the
origins of illumos.

### Licensing

illumos is licensed under the [CDDL](https://en.wikipedia.org/wiki/Common_Development_and_Distribution_License).

### Community Values

* Empathy as a core engineering tenet
* Code quality and correctness

### Technology Features

The following are shared development tenets and features for distributions utilizing illumos:

* Stability
* SMP support for many CPUs
* Security multi-user facilities like Roles and Privileges
* Multi-tenancy with Zones
* Unparalleled system introspection with [DTrace](http://dtrace.org/guide/)
* A single pipeline for system issues with the Fault Management Architecture (FMA)
* Network virtualization with Crossbow
* Hardware virtualization with KVM
* [Excellent online documentation](https://www.illumos.org/man/)
* [Source code for the entire system](https://github.com/illumos/illumos-gate)

For more in-depth descriptions, please see the [features page](features.md).

### Uses for illumos

While it can be and is used in any nearly situation where a UNIX-type server is
needed, illumos excels at storage applications, large multi-tenant systems, and
other cloud-centric uses. 

Have a look at [who is using illumos](who.md) to see what illumos technologies
are being used for!

### Supported hardware platforms

illumos currently supports: 

 * i86pc (x86, x86_64) architectures
 * AMD64 (except KVM support)
  
There are also several SPARC distributions of illumos; if you are interested in
running illumos on SPARC, please refer directly to those distributions' docs.

To determine if a specific piece of hardware will work with illumos, please
refer to the [Hardware Compatability List](https://www.illumos.org/hcl/).

For pre-defined builds of server-grade hardware, you may also refer to
[Joyent Engineering Manufactory
database](http://eng.joyent.com/manufacturing/bom.html).    

### illumos Development Model

Please refer to the [illumos Developer's Guide](http://illumos.org/books/dev/)
and the [development section](../developers/index.md).

### Contributing to illumos

Please see the [contribution](../contributing/index.md) if you'd like to
participate in the project.

### Third Party Software

illumos does not itself ship third party software, or contain software like webservers and so forth. 

Distributions include their own package management.
