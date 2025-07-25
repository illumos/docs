# Leadership

## Core Team

The illumos core team has the ultimate say in what code is accepted for
integration, and their most important job is to ensure quality and stability
for all illumos users.  Core team members also take responsibility for the
provision of project infrastructure, including tools for code review, mailing
lists, and other forms of collaboration.

New core team members are appointed by the consensus of existing core team
members.

### Current Members

| Member            | IRC Handle | Organization           | Expertise |
| ----------------- | ---------- | ---------------------- | --------- |
| Dan McDonald      | danmcd     | Edgecast Cloud         | Networking, Security, etc. |
| Gordon Ross       | gwr        | RackTop Systems        | CIFS/SMB, VFS layer, ZFS ACLs, etc. |
| Hans Rosenfeld    | Woodstock  | unaffiliated           | Misc. |
| Joshua M. Clulow  | jclulow    | Oxide Computer Company | Misc. |
| Patrick Mooney    | pmooney    | Oxide Computer Company | Virtualization, etc. |
| Robert Mustacchi  | rmustacc   | Oxide Computer Company | Virtualization, SMF, PCI, MDB, DTrace, x86 platform, etc. |

### Emeritus Members

Some core team members have moved on to other things, and are no longer
actively working on illumos.  We thank them for their prior contributions!

| Member            | IRC Handle | Organization           | Expertise |
| ----------------- | ---------- | ---------------------- | --------- |
| Albert Lee        | trisk      | RackTop Systems        | Storage, drivers, userland. |
| Chris Siden       | csiden     | formerly Delphix       | ZFS |
| Matt Ahrens       | mahrens    | Delphix                | ZFS |
| Garrett D'Amore   | gdamore    | RackTop Systems        | Drivers, etc. |
| Rich Lowe         | richlowe   | unaffiliated           | Misc. |

## Life in the Core Team

Contributors send you patches, build results, test results, check results,
review results. If you're happy with all of this, you integrate the change on
their behalf.

You should have received a patch in `git format-patch` or similar format,
including a full set of metadata (`Reviewed by:` lines, authorship, etc.). If
you didn't, feel free to ask whoever submitted the patch to submit it in this
format.  You shouldn't have to go search the list archives for reviewers.

While the core team role is fundamentally one of gate-keeping, it is expected
that members are willing and able to help drive towards a positive result.  Use
your experience where you can to actively help contributors get to integration,
rather than simply denying changes that aren't well-formed.

### Things Core Team Members Focus On

* **Do you know the areas of the system affected well enough to even have an
  opinion?**  If not, determine whether another core team member is better
  placed to make a decision.  The codebase is large and our finite resources
  mean that we'll never have complete coverage; sometimes an absence of an
  obvious expert is a learning opportunity!

* **Is the commit well-formed?**  The `Author` field should include both a
  name and a well-formed e-mail address for the change contributor.  Ensure
  that any non-Latin characters in names are correctly rendered in UTF-8.
  The same should be true of any `Reviewed by:` or `Portions contributed by:`
  lines in the commit message.

* **Is the `git pbchk` output as clean as you want it to be?**  In general
  there should be no noise from any check, however some areas are not
  clean for the various style checks.  It will generally be quite obvious
  upon inspection when a file is not already free of issues.

* **Is the user's build clean?**
    * The contributor should be using the current primary and shadow
      compilers (i.e., GCC 10.4.0-il-2 and GCC 14.2.0-il-1, along with smatch).
      Check the `mail_msg` file for the compilers used during the build.
    * The build should be free of compiler warnings and other post-build
      checks, including smatch.

* **Did the submitter test their changes to your satisfaction?**
    * Can you think of anything else that should be tested? Ask for it!
    * Did the testing actually cover the area changed by the patch? Check!

* **Inspect the diff!** Check that nothing stands out that reviewers may have
  missed.

* If there are any open questions about possibly breaking the build, the core
  team member can always elect to run their own build once they have imported
  the patch.

### Integrating Changes

The following is a basic checklist for those pushing to the gate, whether they
are a member of the core team, or someone granted the right to push their own
approved changes.

* When importing a patch, record the approving core team member with an
  `Approved by:` line in the commit message after the existing
  `Reviewed by:` and `Portions contributed by:` lines.

* Make sure when you import the patch that the `Author:` field reflects
  the submitter of the change and not you, the committer.

* You can (and should) visually inspect outgoing commits prior to pushing
  (to ensure you have done all of the above) with something like:
  ```
  $ git show --pretty=fuller origin/master..
  commit 54a92aefa4a67c25d292cdc6f70533e6737db987
  Author:     Harry Nilsson <harry.nilsson@example.com>
  AuthorDate: Sat Jan 19 13:32:20 2019 +0200
  Commit:     Joshua M. Clulow <josh@sysmgr.org>
  CommitDate: Thu Apr 11 21:20:14 2019 +0700
  
      52034 put the lime in the coconut
      Portions contributed by: Fred Dagg <fdagg@farms.gov.nz>
      Reviewed by: Gérard de Pamplemousse <gdp@lacroix.com>
      Reviewed by: Don Quixote <don@windmills.org>
      Approved by: Joshua M. Clulow <josh@sysmgr.org>
  
  diff --git a/usr/src/uts/common/io/coconut/lime.c b/usr/src/uts/common/io/coconut/lime.c
  index adc83b19e79..54a92aefa4 100644
  --- a/usr/src/uts/common/io/coconut/lime.c
  +++ a/usr/src/uts/common/io/coconut/lime.c
  @@ -3134,7 +3134,7 @@ drink_them_both_up(void *state,
  ...
  ```

* If a push to the gate fails, you **MUST NOT** force push (i.e., `git push
  -f`).  There will _always_ be a reason for the error, which you must fix
  before proceeding.

* The remote for pushes is: `YOURUSER@code.illumos.org:illumos-gate.git`.  This
  will be mirrored automatically to GitHub.  Care must be taken to continue to
  push your Gerrit reviews to the right place (`refs/for/master`)
  and _not_ the live master branch (`refs/heads/master`).
