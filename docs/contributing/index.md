# Contributing to illumos

## Overview

This document describes our contribution process in some detail.  If you need
guidance or assistance, especially if you are new to the project, you can
always reach out to the [developer mailing list](../community/lists.md) or the
[IRC channel](../community/#irc-channels) for help.

Contributing to a large project with a long history like illumos can seem
daunting! To get started, you might consider watching [Ryan
Zezeski](https://zinascii.com/) going through fixing a bug in ZFS in this
"illumos Day" talk, which includes submitting a patch for integration into
`illumos-gate.git`:

* [video](https://www.youtube.com/watch?v=HXjIz-RzhK8)
* [slides](http://zinascii.com/pub/talks/fixing-bugs-in-illumos.pdf)

!!! note "RTI Process"
    The Request To Integrate (RTI) process is also documented in the [illumos
    Developer's Guide](https://illumos.org/books/dev/integrating.html).

## Finding An Area To Contribute To

If you're not sure what you want to work on, you can start by looking at our
[list of bite-size
bugs](https://www.illumos.org/projects/illumos-gate/issues?query_id=31) which
should be easy for newcomers to pick up.  You can also look at the entire list
of issues and see if any with status "New" fit your skill set.

If you are adding a new feature or addressing a problem not currently on our
[list of issues](https://www.illumos.org/projects/illumos-gate/issues), please
[create a new issue](https://www.illumos.org/projects/illumos-gate/issues/new)
describing it. You need to create an account in the bug tracker in order to be
able to file issues.

Before you start working on the code, it is advisable to first ask on either
the [developer mailing list](../community/lists.md) or the [IRC
channel](../community/#irc-channels) for advice on the particular area you're
interested in.  For larger bodies of work, it is worth writing an [illumos
Project Discussion (IPD)](https://github.com/illumos/ipd) document that
describes your plan and seek feedback from core team members and others.

## Writing The Code

Our guide to [building illumos](../developers/build.md) covers setting up a
build environment and getting the source.  To make sure you have a functional
build environment, it helps to try at least one build without modifying
anything.  This also helps you to familiarize yourself with the build system
and source tree layout.

An unparalleled resource for understanding the operating system is the book,
[Solaris Internals: Solaris 10 and OpenSolaris Kernel
Architecture](http://www.amazon.com/Solaris-Internals-OpenSolaris-Kernel-Architecture/dp/0131482092).

We have an [OpenGrok source browser and search engine](http://src.illumos.org/)
which is very useful for development.

Feel free to ask the [developer mailing list](../community/lists.md) or the
[IRC channel](../community/#irc-channels) for help.

We encourage you to "commit early, commit often" as you work, using your
personal clone of illumos-gate.git.

## Testing

The illumos gate is a core technology leveraged by several commercial vendors
that rely on it to be a stable, well-tested platform.  As such, changes to
illumos require qualified code review from community peers.  A reasonable
effort must also be made to test each change, to ensure that the change is
stable enough for others to rely upon.

The [core team member](../about/leadership#core-team) looking at your
integration request will discuss testing with you, and will ultimately decide
when your testing is sufficient.

The scope of required testing depends on the nature of the change and a
discussion with the core team member looking at your change, but in general the
core team adopts a "shrink to fit" mentality.  Below are some examples of a
reasonable level of testing based on the collective experience of the current
core team.  A core team member may ask for more testing depending on the
nature of the change.

### All changes

Make sure you test the results of the illumos-gate build with only your
changesets applied. To do this, you will need to [build the illumos
code](../developers/build.md). It is generally insufficient to test the build
results of a downstream fork that contains other non-trivial changes as there
may be implicit dependencies that break other consumers of the core illumos
gate.

If your code has been running in production as part of a downstream
distribution of illumos, or has already gone through other testing, please
include that information.  The core team will determine if any additional
testing is required for integration.

### Changing a single program

If your change affects only a single binary (e.g., `/usr/bin/ls`), it is likely
sufficient to copy the binary to a system running a distribution with a
reasonable similarity to vanilla illumos-gate and running your tests there.
These tests should cover enough functionality to demonstrate the correctness of
your changes, and could involve stress tests in addition to functional tests
depending on the nature of the change. This assumes that the binary has a
trivial set of library dependencies that are reasonably standard across
distros.

### Changing the implementation of a library

If your change affects the implementation of a library, but does not change any
externally visible interfaces, you should run tests against a reasonable subset
of programs that exercise the code in question.  As with a single binary, it is
likely sufficient to copy this library to a system running a distribution which
has identical interfaces to the vanilla illumos-gate.

Some core libraries (most notably `libc`) are challenging to replace on a live
system, so you will likely need to bootstrap a complete new image or boot
environment of your distribution in order to be able to test your changes.  How
to do this depends on your distribution; e.g., OpenIndiana or OmniOS can use
`onu` to update to new packages from a nightly build.

### Changing the implementation of a driver or adding a new driver

If your change affects a single driver, you may or may not be able to get away
with copying that driver to a system running an alternate distribution. On one
hand, many of the kernel interfaces (e.g., the DDI) are likely identical, but
if the core implementation of that distribution has diverged significantly from
illumos-gate, you may be asked to bootstrap a complete environment from your
vanilla illumos build.  Driver tests should demonstrate a reasonable amount of
functional and stress testing on appropriate hardware.

### Changing the core kernel or multiple interconnected binaries

If you are making a change to the core kernel (e.g., `unix` or `genunix`), or
have a series of changes across a number of libraries, commands, or kernel
components, they need to be tested as a cohesive whole.  You must bootstrap a
usable environment from your illumos-gate build that is sufficient to
demonstrate the correctness of your changes.

Exactly what "bootstrapping" means is dependent on the distribution, but the
goal is to run the entirety of the your illumos-gate build (not a combination
of downstream and upstream illumos-gate bits) in a testable environment. Not
all distros are capable of bootstrapping a vanilla illumos-gate build; check the
[distribution list](../about/distro.md) and ask on the [developer
list](../community/lists.md) if you are unsure of how to do this.

For example, on OpenIndiana or OmniOS, you can use `onu` to install the
packages produced by a nightly build.  On a SmartOS system, you can build
a wholly new "platform image" and boot a system using it.

The scope of testing here will likely be more substantial, and should focus on
stability of the system as well as the functionality of the changed
component(s).

As always, contact the core team member (or the core team mailing list if you
don't yet have someone in mind) if you have more questions about what
constitutes sufficient testing for a particular change.  You are welcome to ask
for help in creating a test plan well in advance of completing the work on you
change, so that the core team can help set expectations and provide feedback
throughout the process.

## Code Review

At least one person (other than you, of course) should review your changes.
These reviewers should have demonstrated expertise in the area in question or
are trusted as knowledgeable by the illumos community at large. If you work for
a commercial entity, it is best to include reviewers from outside your company,
but this is not required.

The [core team member](../about/leadership#core-team) looking at your
integration request will discuss the review you have received with you, and
will ultimately decide whether your change has undergone sufficient review.

If you don't know how to find adequate review, you may post the changes to the
developer mailing list to ask for feedback, or ask the core team if there is
anyone in particular they'd like to see review the code.

When seeking review, it is generally best to upload to some web-based review or
source hosting system, rather than attach a patch to your list e-mail.  The
illumos project provides a [Gerrit instance](https://code.illumos.org) which
you can use with your illumos bug tracker account credentials.  For more
information about using Gerrit, see [our documentation on Gerrit](./gerrit).
Remember to mention the issue ID in the email -- if one does not yet exist,
please [create one](https://www.illumos.org/projects/illumos-gate/issues/new)!

### Ensuring adequate review

It is up to you as a contributor to gather reasonable review to satisfy a
member of the core team that the code is correct and of high quality. Exactly
what this means will vary based on the nature and scope of the change, but here
are some guidelines that will give the core team confidence in your changes.

* There should be at least one code reviewer (focused on the implementation
  details) that is different from the core team member (focused on ensuring
  overall quality of contributions).
* For non-trivial changes to major technology areas (ZFS, DTrace, etc), at
  least one of the reviewers should be regarded as a subject matter expert by
  the community.
* Changes with significant impact should participate in a public review when
  appropriate, or otherwise ensure that alternate opinions are represented.
* When there are disagreements, every attempt should be made to adequately
  address reviewer's comments. In the event they cannot, it is acceptable to
  submit an RTI with known dissent. Such disagreements must be noted in the
  RTI submission with an explanation as to why the review comments were not
  addressed.

When in doubt, more review is generally better.  If anything is unclear, or
you're stuck on something, you can always ask the core team for guidance.

## Submitting A Patch

When you have adequate code review and test results for your proposed change,
you prepare a "request to integrate" (RTI).

First, in the issue(s) you created in the bug tracker, make sure you have:

* Any analysis that lead to the fix; e.g., if you used DTrace or MDB to
  determine what went wrong it'd be good to include scripts and/or output
  from your debugging session
* Your testing plan and results from your testing.  This could be simple
  for simple changes; e.g., "I ran the updated `ls` binary and this is
  the new output".  It could also be more detailed for a complicated bug.
  Providing the testing notes in the issue allows the core team to easily
  see what you did to test, and allows future engineers to better understand
  how to test _their_ changes in the same area of the system.

You should have a full clean build of the gate with your changes applied. This
currently means a successful build with GCC 10 as the primary compiler, and
GCC 14 and smatch as shadow compilers, with no warnings or errors in the
resulting `mail_msg`. Note that `mail_msg` includes a diff against the previous
build, so your patch's clean build should come directly after a clean build of
the previous commit.

If your commit does not yet include "Reviewed by:" indicating your reviewers,
this is when you should add those lines. We do not have a blank line between the
first line of a commit message in illumos, and the following "Reviewed by:"
lines. If you run `git format-patch` to get a patch to include, this will
result in an oddly-formatted "Subject:" line - that is expected and OK.

!!! note Assembling "Reviewed by:" lines
    If your review is not through Gerrit, you should have contact information
    for your reviewers that can be included when adding "Reviewed by:" lines. If
    your review is through Gerrit, you can use the Gerrit [/changes
    API](https://gerrit-review.googlesource.com/Documentation/rest-api-changes.html#get-change-detail)
    to get reviewer information and reduce the risk of a transcription error for
    your reviewers' names or e-mail addresses. This jq is an example of how you
    might want to assemble "Reviewed by:" lines:

    ```
    curl -s "https://code.illumos.org/changes/$YOUR_CHANGE_NUMBER?o=LABELS&o=DETAILED_ACCOUNTS" | \
        tail -n 1  | \
        jq -r '.labels."Code-Review".all[] |
          select(.value==1) |
          "Reviewed by: \(.name) <\(.email)>"'
    ```

If your change has been reviewed on Gerrit, you (or `git pbchk`) may have found
trivial changes such as whitespace nits, comment spelling, or copyright dates
since the last round of review. Please ensure any changes at this point are
also pushed to Gerrit. If your changes on Gerrit are the same as you would
include as a patch for integration, you can omit the patch from your RTI e-mail
entirely; the core team can fetch your change from Gerrit as well.

Your RTI e-mail should include:

* The link to the illumos issue(s) you're fixing, e.g.,
  https://illumos.org/issues/10052
* The changes that were reviewed; e.g., a link to your [Gerrit](./gerrit)
  review, or an attached patch otherwise.
* The full "change set description" (i.e., `git whatchanged -v origin/master..`)
  including:
    * Issue number(s) and description(s)
    * `Reviewed by: First Last <first.last@example.com>` lines
    * List of files affected
* Output of `git pbchk` (run under `bldenv` or have `/opt/onbld/bin` in `PATH`).
  This is optional if `git pbchk` prints nothing and exits with 0
* An attached clean `mail_msg` from a full nightly build (including shadow
  compilers, as noted above)
* Information about how the changes were tested (it's sufficient to
  mention that the testing notes appear in the bug tracker)

Here is an example change description:

```
123 Description of the issue in our tracker
Reviewed by: Jack <jack@eng.sun.com>
Reviewed by: Ohana Matsumae <ohana@kissui.ishikawa.jp>
```

Note this description does not include a "Change-ID:" line - it is the
description the commit should have when integrated, minus "Approved by:". Since
Gerrit identifies changes with the "Change-ID:" line, this will be a little
different from the description in the associated Gerrit link. This is okay! If
your RTI is approved, the core team member integrating your patch will remove
this line from the description when they add an "Approved by:" recording their
approval.

!!! note Amending descriptions
    You can use `git commit --amend` to edit the commit message.

A [core team member](../about/leadership#core-team) will need to judge whether
your code review and testing are adequate for the scope of changes you propose.
Note that the core team members's job as part of integration is not necessarily
to review your code again, only to judge whether review and testing was
adequate.

When you are ready, send an email to the [illumos core team (formerly
"advocates") mailing list](https://illumos.topicbox.com/groups/advocates).
Though you are welcome to subscribe to the list, it is not required; you can
just send mail to advocates@lists.illumos.org. If you're interested in what
past RTIs looked like, you can [browse past
messages](https://illumos.topicbox.com/groups/advocates).

A reasonably complete example issue is `10052 "dladm
show-ether" should pick one kstat snapshot and stick with
it`:

* [Bug #10052](https://www.illumos.org/issues/10052) in the bug tracker includes both analysis and testing notes
* The [RTI mailing list thread](https://illumos.topicbox.com/groups/advocates/T3b948e263f1d5364-Maa6757c734745876ace18745) shows the sort of interaction you can expect

!!! note
    Your email needs to be less than 2MB in size.  If your change is
    large, compress the patch or make it available over HTTP.  If your
    `mail_msg` is large, something is wrong.

You should soon get a reply with additional feedback if needed, or a "thank
you" for being part of the illumos developer community!

If the change is accepted, the core team will take care of actually committing
to master.  Regular contributors may get commit rights: they follow the same
system, but may push to master themselves after approval.

If your review was through Gerrit, one last step is to "Abandon" your change -
because the patch is intgrated through the RTI process, we don't use Gerrit to
merge. "integrated" is a good message to indicate to future readers that the
change was, in fact, integrated.
