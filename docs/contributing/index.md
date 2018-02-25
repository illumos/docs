!!! warning "Requires Review"
    This page contains incomplete content and needs to be reviewed.

# Contributing to illumos

!!! note "RTI Process"
    The Request To Integrate process is also documented in the [illumos
    Developer's Guide](https://illumos.org/books/dev/integrating.html).

## Finding An Area To Contribute To

If you're not sure what you want to work on, you can start by looking at our
[list of bite-site bugs](https://www.illumos.org/issues?query_id=15) which
should be easy for newcomers to pick up. You can also look at the entire list
of issues and see if any with status "New" fit your skill set.

If you're looking for a longer-term project, we have a [list of ideas for new
projects](https://wiki.illumos.org/display/illumos/Project+Ideas) for different
levels skill and expertise. Alternatively you may look through the [mailing
lists](../community/lists.md) for suggestions for improvements.

If you are adding a new feature or addressing a problem not currently on our
[list of issues](https://www.illumos.org/projects/illumos-gate/issues), please
[create a new issue](https://www.illumos.org/projects/illumos-gate/issues/new)
describing it. You need to be signed in to use the issue tracker.

Before you start working on the code, it is advisable to first ask on either
the [developer mailing list](../community/lists.md) or the [IRC
channel](../community/#irc-channels) for advice on the particular area you're
interested in.

## Writing The Code

Our guide to building illumos covers setting up a build environment and getting
the source. You should try a build once or twice to get accustomed to the build
system and source tree layout.

An unparalleled resource for understanding the operating system is the the
book, [Solaris Internals: Solaris 10 and OpenSolaris Kernel
Architecture](http://www.amazon.com/Solaris-Internals-OpenSolaris-Kernel-Architecture/dp/0131482092)
and its companion wiki,
[solarisinternals.com](http://www.solarisinternals.com/).

We have an [OpenGrok source browser and search engine](http://src.illumos.org/)
which is very useful for development.

Feel free to ask the [developer mailing list](../community/lists.md) or the [IRC
channel](../community/#irc-channels) for help.

We encourage you to "commit early, commit often" as you work, using your
personal clone of illumos-gate.

## Testing

The illumos gate is a core technology leveraged by several commercial vendors
that rely on it to be a stable, well-tested platform. As such, integration into
the core illumos-gate requires both code review by relevant parties and
reasonable testing to ensure that the changes are stable enough for others to
rely upon.

Your [RTI advocate](../about/leadership#advocates) is the ultimate arbiter of
whether your testing is sufficient.

The scope of required testing depends on the nature of the change and a
discussion with your advocate, but in general advocates adopt a "shrink to fit"
mentality. Here are some examples of reasonable testing based on the collective
experience of the current RTI advocates. Your advocate may always ask for more
testing depending on the nature of the change.

### All changes

Make sure you test the results of the illumos-gate build with only your
changesets applied. To do this, you will need to [build the illumos
code](../user-guide/build.md). It is generally insufficient to test the build
results of a downstream fork that contains other non-trivial changes as there
may be implicit dependencies that break other consumers of the core illumos
gate.

If your code has been running in production in another distro or has gone
through other testing downstream, please include that information, though by
itself may be insufficient to constitute sufficient testing.

### Changing a single program

If your change affects only a single binary, it is likely sufficient to copy
this binary to a downstream distro of reasonable similarity and running your
tests there. These tests should cover enough functionality to demonstrate the
correctness of your changes, and could involve stress tests in addition to
functional tests depending on the nature of the change. This assumes that the
binary has a trivial set of library dependencies that are reasonably standard
across distros.

### Changing the implementation of a library

If your change affects the implementation of a library without changing
external interfaces, you should run tests against a reasonable subset of
programs that exercise the code in question. As with a single binary, it is
likely sufficient to copy this library to a distro which has identical
interfaces, though for some core libraries (most notably libc), you will
probably need to bootstrap a complete distro given the challenges with swapping
such libraries on a running system, though this depends on the distro in
question.

### Changing the implementation of a driver or adding a new driver

If your change affects a single driver, you may or may not be able to get away
with copying over that driver to an alternate distro. On one hand, the kernel
interfaces are likely identical, but if the core implementation of that distro
has diverged significantly from illumos-gate, you may be asked to bootstrap a
complete environment from your illumos build. Driver tests should demonstrate a
reasonable amount of functional and stress testing on appropriate hardware.

### Changing the core kernel or multiple interconnected binaries

If you are making a change to the core kernel, or have a series of changes
across a number of libraries, commands, or kernel components that need to be
tested as a cohesive whole, you should bootstrap a usable environment from your
illumos-gate build that is sufficient to demonstrate the correctness of your
changes. Exactly what "bootstrapping" means is dependent on the distro, but the
goal is to run the entirety of the your illumos-gate build (not a combination
of downstream and upstream illumos-gate bits) in a testable environment. Not
all distros are capable of bootstrapping a bare illumos-gate build - check the
[distribution list](../about/distro.md) and ask on the [developer
list](../community/lists.md) if you are unsure how to do this. Running `onu` on
OpenIndiana or building an illumos-live distribution are two such ways to
demonstrate this testing that have been used in the past, but they are not the
only ones.

The scope of testing here will likely be more substantial, and should focus on
stability of the system as well as the functionality of the changed
component(s).

As always, contact your advocate (or the advocates list if you don't yet have
someone in mind) if you have more questions about what constitutes sufficient
testing for a particular change.

## Code Review

At least one person (other than you, of course) should review your changes.
These reviewers should have demonstrated expertise in the area in question or
are trusted as knowledgeable by the illumos community at large. If you work for
a commercial entity, it is best to include reviewers from outside your company,
but this is not required.

Your [RTI advocate](../about/leadership#advocates) is the ultimate arbiter of
whether your review is sufficient.

If you don't know how to find adequate review, you may post the changes to the
developer mailing list to ask for feedback, or ask the RTI advocates if there
is anyone in particular they'd like to see review the code.

For larger changes, please link to a resource on the web, instead of attaching
a patch file. You may use a webrev (see below), a private hgweb or gitweb or
online services like Bitbucket, Github, or Gitorious to share your changes.
Remember to mention the issue ID in the email - if one does not yet exist,
please create one!

### Generate a key pair

If you don't already have an SSH public key in your account in the [bug
tracker](https://bugs.illumos.org), generate a key pair like this on your
machine (usually as the building/development user account):

```
$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/USER/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/USER/.ssh/id_rsa.
Your public key has been saved in /home/USER/.ssh/id_rsa.pub.
$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3...
```

Then paste your public key into the box on your account settings page and save
the changes.  Wait for a while for the change to propagate to the webrev
server.  

Note if you leave your passphrase blank you will be able to both publish and
delete your webrev's as per the latest instructions on the main page at
http://cr.illumos.org/ (this both creates and uploads your webrev - see
"Creating and Uploaded in one step" ) however if you use a passphrase you will
not be able to delete your webrev's as only publish will ask you for your
passphrase.

### Creating a webrev

The [webrev(1)](http://illumos.org/man/webrev) tool is an easy way to show
other people changes you have made.  It presents changes (including commit
messages) in multiple formats viewable from a web browser. If you have
installed an illumos build, you can run webrev like this:

```
/opt/onbld/bin/webrev -O -o illumos-123-webrev
```

Else, from your workspace if you have built the tools:

```
ksh93 bldenv.sh illumos.sh -c 'webrev -O -o illumos-123-webrev'
```

Or to use webrev provided by installed ON build tools on a non-illumos system:

```
/opt/onbld/bin/webrev -I usr/src/tools/scripts/its.reg -O -o illumos-123-webrev'
```

Note: The reason for the `-I` option is to provide links to our issue tracker. If you see

```
*** failed to import extension hgext.cdm from .../usr/src/tools/proto/root_i386-nd/opt/onbld/lib/python2.6/onbld/hgext/cdm.py: cannot import name WorkList, 
```

try running `webrev` from the workspace instead.

Upload the directory somewhere people can access it from the web, such as a
personal web site.  You may also use the free webrev hosting provided by the
illumos project as described in the next section.

### Creating and uploading a webrev in one step

To publish a webrev, you'll first need to make sure your SSH key is up-to-date
in the illumos [bug tracker](https://bugs.illumos.org).  Refer to Generate a
key pair above for more information. Please note that it takes a couple of
minutes for your added (or updated) key to get copied to the webrev server.

Once you have a key uploaded, you can use `webrev(1)` to generate and upload
your webrev, all at once, thus:

```
webrev -t rsync://webrev@cr.illumos.org:$SOME_NAME -U
```

You can delete a previously uploaded webrev thus:

```
webrev -t rsync://webrev@cr.illumos.org:$SOME_NAME -D
```

Note that `$SOME_NAME` (in the examples above) is an arbitrary string that will
form part of the URL to your webrev. This is not your user name but rather a
descriptive name of the issue and/or fix. Note, also, that you should always
use `webrev@` in the rsync URL, not your bug tracker username.

Once uploaded, your webrev will be in your directory here:
http://cr.illumos.org/~webrev for example assuming your login name is `jondoe`
and your `$SOME_NAME` is 1023 the final webrev will be located as `$SOME_NAME`
e.g. `1023` under your directory http://cr.illumos.org/~webrev/jondoe/ or with a
complete path of http://cr.illumos.org/~webrev/jondoe/1023.

### Review Board

For reviews you could also use the illumos' Review Board instance at
http://illumos.org/rb. You should be able to log in with your existing illumos
bug tracker username and password.

### Ensuring adequate review

It is up to you as a contributor to gather reasonable review to satisfy your
RTI advocate that the code is correct and of high quality. Exactly what this
means will vary based on the nature and scope of the change, but here are some
guidelines that will give the advocates confidence in your changes. As always,
trust your avocate and apply "shrink to fit".

* There should be at least one code reviewer (focused on the implementation details) that is different from the advocate (focused on ensuring overall quality of contributions).
* For non-trivial changes to major technology areas (ZFS, DTrace, etc), at least one of the reviewers should be regarded as a subject matter expert by the community.
* Changes with significant impact should participate in a public review when appropriate, or otherwise ensure that alternate opinions are represented.
* When there are disagreements, every attempt should be made to adequately address reviewer's comments. In the event they cannot, it is acceptable to submit an RTI with known dissent. Such disagreements must be noted in the RTI submission with an explanation as to why the review comments were not addressed.

When in doubt, more review is generally better, and you can always ask the advocates for guidance.

## Submitting A Patch

When you have adequate code review and test results for your proposed change,
you prepare a "request to integrate" (RTI).  Your RTI should include:

* The link to the illumos issue you're fixing, i.e. https://illumos.org/issues/1
* The issue synopsis (see the sample change description below)
* A link to the changes that were reviewed (preferably a webrev, code review page, or web repository view).
* The full "change set description", (i.e. "hg outgoing" or "git whatchanged -v origin/master..") including:
 *  issue number(s) and description(s)
 * Reviewed by: XXX lines
 * list of files affected
 * Here is an example change description:

```
123 Description of the issue in our tracker
Reviewed by: Jack <jack@eng.sun.com>
Reviewed by: Ohana Matsumae <ohana@kissui.ishikawa.jp>
```

!!! note Amending descriptions
    You can use `git commit --amend` to fix the change description.

* Output of `git pbchk` (you'll need the "cadmium" extension for git)
* Attach the `mail_msg` file from a full nightly build (including `lint`), which should be free of warnings.
* Supply information about how the changes were tested.
* Attach the actual changes, either from `git format-patch`. (the webrev is not sufficient. Attach an actual patch)

An [Advocate](../about/leadership#advocates) will need to judge whether your
code review and testing are adequate for the scope of changes you propose.
Note that the advocate's job is not necessarily to review your code, only to
judge whether review and testing was adequate.

When you are ready, send an email to the [illumos
Advocates](../about/leadership#advocates).

You don't need to subscribe to this list, just send an email to
advocates@lists.illumos.org. If you're interested in what past RTIs looked
like, you can [browse past
messages](https://illumos.topicbox.com/groups/advocates).

Your email needs to be less than 2MB in size.  If your change is large,
compress the patch or make it available over HTTP.  If your `mail_msg` is
large, something is wrong.

You should soon get a reply with additional feedback if needed, or a "thank
you" for being part of the illumos developer community!

## Credits
