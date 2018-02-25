# Creating Build Datasets

By [Bayard G. Bell]()

## Introduction

The main guide assumes that your illumos-gate workspace resides in a directory
named /code (likely located in your rpool) and owned by your build user.

However, this is not very practical regarding further OS updates, compression,
snapshots and rollbacks and a myriad other features that a dedicated ZFS
dataset might give you. So it is recommended to create one instead and also
link it as /code (at least for the consistency of this guide and some others
that link to it):

```
sudo zfs create rpool/export/home/illumos-dev
sudo zfs create rpool/export/home/illumos-dev/code
sudo ln -s ./export/home/illumos-dev/code /
sudo chown -R $USER /export/home/illumos-dev
```

!!! note ""
    This example still uses the rpool ZFS pool, available by default on any current OpenSolaris system. If your system has other pools, perhaps larger and more performant, you might want to use them instead.

As an example of why you might want a separate ZFS dataset, consider checking
out the source into a dataset and keeping it pristine, while you do your
wildest experiments and compilation in its clone dataset. The snapshot and
subsequent clone require no space initially, and can be easily demolished when
the wild experiments lead into a dead-end, while you retain the checked-out
source code repository and don't have to download it again. Alternately, this
can be used to work on several bugs in parallel and keeping the diffs separated
for further webrev (see [Comparing arbitrary sources with
webrev(1)](comp-webrev.md)) and submission upstream (see [How To
Contribute](../contributing/index.md)).

Now that you have a separate dataset, you can optimize it for space and/or
access speed by setting some ZFS attributes, for example:

```
sudo zfs set compression=lzjb rpool/export/home/illumos-dev
sudo zfs set atime=off rpool/export/home/illumos-dev
sudo zfs set sync=disabled rpool/export/home/illumos-dev
```

compression decreases used disk space and may increase IO speed (by reducing
mechanical IOPS) at cost of some CPU time (especially during writes) atime
disables directory entry updates when reading files; this decreases pool writes
and increases available IOPS. If your build host is a VM backed by ZFS storage
with automatic snapshots, or if you use an iSCSI volume imported from a storage
host as your building zfs pool, this can also save lots of space on the backend
storage.  sync allows to bypass the ZIL for this dataset. It is believed to
somewhat increase write speeds at the cost of potential loss of consistency in
case of untimely reboots or kernel panics.

Since this is a ZFS dataset, you can later zfs snapshot it (i.e. after
successful builds) to make a zfs clone and/or to zfs rollback to some
known-good state. In fact, you can (optionally) delegate the administrative
rights for that to your build-user:

```
sudo zfs allow -l -d -u $USER \
  create,destroy,snapshot,rollback,clone,promote,rename,mount,send,receive \
  rpool/export/home/illumos-dev
```

!!! note ""
    The `-l -d` options set this permission locally on the named dataset and on its descendants, including those created in the future.

Finally, one of your large space consumers would be the package repository
containing the built installable binaries. You can seperate that into a
standalone dataset for the same ZFS benefits of independent data lifecycle,
replication or storage optimization, for example:

```
sudo zfs create -o atime=off -o compression=gzip-9 \
  rpool/export/home/illumos-dev/packages
sudo chown -R $USER /export/home/illumos-dev
```
 
!!! note ""
    Make the symlink AFTER checking out the source:

```
sudo ln -s ../../packages /export/home/illumos-dev/code/illumos-gate
```

!!! note ""
    This last step (symlinking) should be done after getting the source (checkout requires an empty target).

It is arguable whether a separate dataset for packages is at all needed (and it
is relatively small compared the the build workspace directory). Well, I for
one like putting stuff into different boxes.

Administrative rationales however include:

* When working on many bugs, people can have several "code" workspaces maintained as ZFS-clones of one golden code repo, as summarized in [Working on several bugs at once]().
* However they can want to share the package repository between such projects, and maintain one package depot once configured.
* Snapshooting the package repo before and after a build to check for differences, or to do a zfs send to another machine.
* rsync may be better though (since the rebuild would likely wipe the repo and create it anew, even if made up of mostly the same contents – `zfs diff` would be huge, but rsync data diff would only include changes).
* NFS/CIFS-sharing of the package repo may be easier to set up if it is a separate dataset.

It can be located separately from workspace – another pool, different hardware (i.e. ramdisk/SSD for compile workspace, HDD for package repo).
