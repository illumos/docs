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
