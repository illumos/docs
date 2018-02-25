`webrev(1)` lets you create a comparison of files changed by development. Its
output can contain the same changeset in .patch, .ps, .pdf format along with
index.html file and other acompanying resources.

The tools lives in `/opt/onbld/bin` directory. Be sure to install packages from
How To Build illumos page. Also, be sure to have `/opt/onbld/bin` in your
`PATH`.  You can check it by running:

```
echo $PATH
```

You should see something along the lines of:

```
echo $PATH 
/opt/gcc/4.4.4/bin/:/usr/gnu/bin:/usr/bin:/usr/sbin:/sbin:/opt/onbld/bin
```

Your output may vary, the important part is `/opt/onbld/bin`

In the directory containing your build of illumos create a file listing your
changed files. For [issue 6168: strlcpy() does not return s1](), two files were
edited:

```
usr/src/man/man9f/string.9f
usr/src/man/man3c/string.3c
```

The file list (called by me file.list) consists of:

```
CODEMGR_WS=/code/illumos-gates-6168 
CODEMGR_PARENT=/code/illumos-gates 
 
usr/src/man/man9f/string.9f 
usr/src/man/man3c/string.3c
```
 
First two lines define top level paths to directory containing modified source
and top level directory containing original source.

Latter two are files, relative to the top-level directories defined above,
changed during development. In this case those are only two manpages, in case
of larger development it may be tens of files.

From within `CODEMGR_WS` call `webrev(1)`:

```
cd /code/illumos-gate-6168/
./webrev -o webrev6168 file.list
```

This should produce directory `webrev-6168` within your current working
directory.

You can then upload this directory to your chosen website and send link to
illumos developers for analysis.

The example tree of a generated webrev:

```
webrev-6168$ tree 
. 
├── ancnav.html 
├── ancnav.js 
├── file.list 
├── index.html 
├── raw_files 
│   ├── new 
│   │   └── usr 
│   │       └── src 
│   │           └── man 
│   │               ├── man3c 
│   │               │   ├── man.css 
│   │               │   ├── string.3c 
│   │               │   ├── string.3c.man.html 
│   │               │   ├── string.3c.man.raw 
│   │               │   └── string.3c.man.txt.html 
│   │               └── man9f 
│   │                   ├── man.css 
│   │                   ├── string.9f 
│   │                   ├── string.9f.man.html 
│   │                   ├── string.9f.man.raw 
│   │                   └── string.9f.man.txt.html 
│   └── old 
│       └── usr 
│           └── src 
│               └── man 
│                   ├── man3c 
│                   │   └── string.3c 
│                   └── man9f 
│                       └── string.9f 
├── TotalChangedLines 
├── usr 
│   └── src 
│       └── man 
│           ├── man3c 
│           │   ├── string.3c-.html 
│           │   ├── string.3c.cdiff.html 
│           │   ├── string.3c.frames.html 
│           │   ├── string.3c.html 
│           │   ├── string.3c.lhs.html 
│           │   ├── string.3c.man.cdiff.html 
│           │   ├── string.3c.man.frames.html 
│           │   ├── string.3c.man.lhs.html 
│           │   ├── string.3c.man.rhs.html 
│           │   ├── string.3c.man.sdiff.html 
│           │   ├── string.3c.man.udiff.html 
│           │   ├── string.3c.man.wdiff.html 
│           │   ├── string.3c.patch 
│           │   ├── string.3c.rhs.html 
│           │   ├── string.3c.sdiff.html 
│           │   ├── string.3c.udiff.html 
│           │   └── string.3c.wdiff.html 
│           └── man9f 
│               ├── string.9f-.html 
│               ├── string.9f.cdiff.html 
│               ├── string.9f.frames.html 
│               ├── string.9f.html 
│               ├── string.9f.lhs.html 
│               ├── string.9f.man.cdiff.html 
│               ├── string.9f.man.frames.html 
│               ├── string.9f.man.lhs.html 
│               ├── string.9f.man.rhs.html 
│               ├── string.9f.man.sdiff.html 
│               ├── string.9f.man.udiff.html 
│               ├── string.9f.man.wdiff.html 
│               ├── string.9f.patch 
│               ├── string.9f.rhs.html 
│               ├── string.9f.sdiff.html 
│               ├── string.9f.udiff.html 
│               └── string.9f.wdiff.html 
├── webrev-6168.patch 
├── webrev-6168.pdf 
└── webrev-6168.ps
```
