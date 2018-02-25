### Inspecting An Application Crash

Check your core file configuration:

```
# coreadm
```

This should print something like:

```
     global core file pattern: 
     global core file content: default
       init core file pattern: core
       init core file content: default
            global core dumps: disabled
       per-process core dumps: enabled
      global setid core dumps: disabled
 per-process setid core dumps: disabled
     global core dump logging: disabled
```

If the global core file pattern is empty and per-process core dumps are
enabled, an application crash will save a core file named core in the working
directory.  To print the stack information from the crash:

```
pstack core
```

# Creating an Issue Report

You can [report a new
issue](https://www.illumos.org/projects/illumos-gate/issues/new) using our
issue tracker.

A good issue report includes:

* Steps for reproducing the problem, in as much detail as possible.
* Information about your system software and hardware.
* For crashes, the contents of the crash information file from the above section.

Please paste any error messages, or the output of ::msgbuf from mdb directly in the bug description.
