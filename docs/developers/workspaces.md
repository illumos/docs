!!! warning "Requires Review"
    This page references some old practices and needs to be reviewed.

!!! note
    https://wiki.illumos.org/display/illumos/Managing+multiple+workspaces+for+illumos+with+Git

# Managing Multiple Workspaces

By [Bayard G. Bell]()

## Make a symlink to the dedicated package repository (Optional)

If you used a separate ZFS dataset for packages, as detailed in [Build
datasets](build-datasets.md) and checked out the workspace with one of the
methods in How To Build illumos, now is the time to symlink to it. If you
don't, a directory named packages will be created under the workspace directory
in due course during the build, within the build dataset; if that happens – you
may just move the files into the dedicated dataset after the successful build
and make the symlink then:

```
sudo ln -s ../../packages /export/home/illumos-dev/code/illumos-gate
```

## Golden repository – one of many

If you want to [Work on several bugs at once](multibug.md), you may want
to maintain a "golden image" of the source code repository in a dedicated
dataset and zfs clone that for your actual works. In this case you'd run:

```
sudo zfs create rpool/export/home/illumos-dev/code/illumos-clone
sudo chown -R $USER /export/home/illumos-dev
 
cd /code
hg clone ssh://anonhg@hg.illumos.org/illumos-gate illumos-clone
 
### This symlink is optional - if you store packages in a separate dataset
sudo ln -s ../../packages /export/home/illumos-dev/code/illumos-clone
 
TS="`/bin/date '+%Y%m%d-%H%M%S'`"
zfs snapshot rpool/export/home/illumos-dev/code/illumos-clone@"$TS"
zfs clone rpool/export/home/illumos-dev/code/illumos-clone@"$TS" \
          rpool/export/home/illumos-dev/code/illumos-gate
```

!!! note ""
    In the multiple-workspace pattern you'd likely name the clone according to the bugID you're working on in it, like "illumos-bug1234"

Now you'll have to modify the clone's pointer to parent repository (so it's
local, not Internet as was true for the golden image). Edit the clone's
`/code/illumos-gate/.hg/hgrc` file and replace the default path with the local
pathname to the local master repository, like this:

```
[paths]
default = /code/illumos-clone
```

## Diagram

For those people who understand pictures better, here is an illustration of
illumos-gate development with multiple repositories and hints to the
contribution process:

![diagram](../images/build-workspaces-diagram.png)
