## Quick Links

* [Security Information](../security/index.md)
* [Manual pages](http://illumos.org/man)
* [Mailing lists](../community/lists.md)
* [Bug reporting](../user-guide/bugs.md)

## What is the objective of the illumos project?

illumos is a fully open community project to develop a reliable and scalable
operating system. It began as a fork of the former
[OpenSolaris](https://en.wikipedia.org/wiki/OpenSolaris) operating system.

Our goal is to foster open development of technologies for the 21st century
while building on a twenty-year heritage, but free from the oversight of a
single corporate entity and the resulting challenges thereof.

While our code base has a long history and many engineering traditions attached
to it, our development processes are being reinvented in an attempt to remove
barriers while maintaining consistently high code quality.

## How do I download the software?

The source code developed by the project is a fork of the Sun/Oracle code base
referred to as "OS/Net" or "ON" (short for Operating System/Networking). It is
the home of the technologies that previously defined OpenSolaris and Solaris,
such as the kernel, network stack, filesystems, and device drivers, and all of
the basic userland libraries and applications.

The illumos code base forms the foundation of [distributions](distro.md).
To use the operating system, just download and install one of the
distributions.

To download the source code, follow the section on Git or Mercurial in [How To
Build illumos](../developers/index.md). You can also [browse and search the
illumos code online](https://github.com/illumos/illumos-gate).

## Is illumos free software (open source)?

The bulk of the illumos source code is available under the Common Development
and Distribution License (CDDL), an OSI-approved free software license based on
the Mozilla Public License (MPL).

There are some components with other licenses including BSD and MIT. We also
include some software with the GNU General Public License (GPL) or the
Lesser/Library General Public License (LGPL).

There still remain some binary-only, closed source components that we inherited
from Oracle which we are working to replace. Unlike OpenSolaris, we do not
require a closed source compiler.

## Is illumos a community project?

Yes!

Multiple community groups and interests (including people like you!) are
stakeholders in the project, and anyone and everyone is welcome to
[contribute](../contributing/index.md).

illumos was initiated by then-employees of Nexenta in collaboration with former
OpenSolaris community members and volunteers. While companies including
Nexenta, Joyent, and Delphix sponsor some of the work in illumos, the project
is independent of their business decisions. illumos exists as a common base for
multiple commercial and community distributions.

## How do I start contributing?

illumos thrives on the efforts of its contributors. Have a look at the guide on
[How To Contribute](../contributing/index.md) if you want to submit code.

If you want to help in other ways then have a look at the [Mailing
Lists](../community/lists.md).

Most of the developers can be found on [IRC](../community/index.md#irc-channels)
and you're invited to drop in and say "hi!"

## How do I build illumos?

See [How To Build illumos](../developers/index.md).

## How do I build a distribution based on illumos?

OpenSolaris was historically difficult to build as a distribution because it
was assembled by many separate teams at Sun. The illumos community
distributions are working to make this easier.

Some distributions have
[documented](https://www.omniosce.org/dev/build_instructions.html) their build
processes.

## Is illumos compatible with Solaris/OpenSolaris?

illumos is very likely to be compatible with Solaris/OpenSolaris binaries and
drivers before Oracle closed the gate in 2010. After that, all bets are off.
Solaris 10 update 11, and Solaris 11, and beyond, may contain incompatible
changes.

## What changes does illumos maintain?

* Open internationalization libraries and data files.
* Open replacements for closed binaries.
* Code that Oracle may choose to no longer maintain.
* Community enhancements to critical technologies like DTrace and ZFS.
* New open technologies.
* Patches/bug-fixes we have independently developed, including security fixes.
* Changes to ease community development.
* ...and more!

## Do you track Oracle changes?

We originally intended to closely follow upstream changes, but became a fork by
necessity because Oracle's software is no longer open source. We now represent
the open future of the code base after Sun.

## Will you work on sending illumos changes upstream?

We would like Oracle to use changes from illumos, as long as they are willing
to abide by the open source license for our code. Where we use code from other
free software projects, we also respect their licenses and keep the source
open.

## Why did you announce the project after it was set up and much of the code written?

This decision was made for multiple reasons. The signal to noise ratio in the
OpenSolaris community had grown low, and announcing the project would have
distracted the developers from actual code and contribution. Most vocal members
talked about opening the code rather than writing it. illumos chose the
opposite. Before the formal announcement, we reached out to developers in the
community and solicited their help and participation.

## And the name illumos?

We started off with the codename "FreeON", and later realized it is used by an
existing project. We finally settled on illumos, after many hours of
suggestions and counter-suggestions. illumos (pronounced i-llu-MOS and written
in lowercase) ties in with Sun and light. It's the closest to ON we could get!
