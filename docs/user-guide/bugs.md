# Bug Trackers

| Project | Description |
|---------|-------------|
| [illumos-gate](https://www.illumos.org/projects/illumos-gate/issues)   | Core. Kernel, userland, drivers, etc.   |
| [OpenIndiana](https://www.illumos.org/projects/openindiana)     | Distribution-specific                   |
| [SmartOS Bugview](https://smartos.org/bugview/)                         | Distribution-specific, read-only JIRA mirror                   |
| [SmartOS GitHub](https://github.com/TritonDataCenter/smartos-live/issues/)                         | Distribution-specific, public issues |
| [OmniOS](https://github.com/omniosorg/omnios-build/issues)      | Distribution-specific                   |
| [SmartOS pkgsrc](https://github.com/TritonDataCenter/pkgsrc/issues)        | Cross-platform packages                 |

# How to report problems

Before creating new issues in the bug tracker, please perform a search to
determine if the problem is already known, or resolved in a newer version of
the software.

You can [report a new
issue](https://www.illumos.org/projects/illumos-gate/issues/new) using our
issue tracker.

A good issue report includes:

* Steps for reproducing the problem, in as much detail as possible.
* Information about your system software and hardware.
* For crashes, the contents of the crash information file from the above
  section.

Please paste any error messages, or the output of `::msgbuf` from `mdb -k`,
directly in the bug description.

# Examples of bug fixing

[Ryan Zezeski](https://zinascii.com/) goes through fixing a bug in ZFS in this "illumos Day" talk.
([video](https://www.youtube.com/watch?v=HXjIz-RzhK8), [slides](http://zinascii.com/pub/talks/fixing-bugs-in-illumos.pdf))
