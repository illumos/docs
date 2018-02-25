# Leadership

There are two levels of leadership in the illumos project: Members of the Dev
Council, and Request To Integrate (RTI) Advocates.

Advocates are the gatekeepers to the illumos core: they have the ultimate say
in what code is accepted, and their primary job is to ensure quality and
stability for all illumos users.

Advocates are appointed by the illumos Developer Council, a technical steering
committee drawn from well-known developers of Solaris, whose role is to make
high-level architecture decisions.

# Developer Council

| Member          | Organization |
| --------------- | ------------ |
| Bryan Cantrill  | Joyent |
| Garrett D’Amore | unaffiliated |
| Adam Leventhal  | Delphix |
| Rich Lowe       |  unaffiliated |
| Gordon Ross     | Nexenta |

# Advocates

| Member            | Handle     | Organization | Expertise |
| ----------------- | ---------- | ------------ | --------- |
| Garrett D'Amore   | gdamore    | unaffiliated | Drivers, etc. |
| Albert Lee        | trisk      | SoftNAS      | Storage, drivers, userland. |
| Rich Lowe         | richlowe   | unaffiliated | Misc. |
| Dan McDonald      | danmcd     | Joyent       | Cryptography, Networking |
| Robert Mustacchi  | rmustacc   | Joyent       | Virtualization, SMF, PCI, MDB, DTrace, x86 platform, etc. |
| Gordon Ross       | gwr        | Nexenta      | CIFS/SMB, VFS layer, ZFS ACLs, etc. |
| Chris Siden       | csiden     | Delphix      | ZFS |
| Matt Ahrens       | mahrens    | Delphix      | ZFS |
| Hans Rosenfeld    | Woodstock  | Joyent       | Misc. |
| Joshua M. Clulow  | LeftWing   | Joyent       | Misc. |

## Life as an Advocate

Contributors send you patches, build results, test results, check results,
review results. If you're happy with all of this, you integrate the change on
their behalf.

You should have received a diff in hg export or similar format, including a
full set of metadata (Reviewed by: lines, authorship, etc.). If you didn't,
feel free to ask whoever submitted the patch to submit it in this format, you
shouldn't have to go search the list archives for reviewers.

### Using your judgement

The whole reason we have RTI advocates or, if you're not steeped in Sun-ish
history, follow a "pull" model, is that it provides us with a step in the
process where in theory experienced people can exercise their (in theory)
better judgement, and everyone can benefit from less breakage. This is 95% of
the work involved.

### Things Advocates Focus On

* Do you know the areas of the system affected well enough to even have an opinion?
* If not, you should probably leave this for someone else who might (note that we don't have perfect coverage, so you can't just punt on everything).
* Is the commit well-formed?
* The author line should include both a name and a well formed email address, and should match the actual author. The format here is very important for SCM export. Don't just assume it's fine!
* Is the pbchk output as clean as you want it to be?
* In general, there should be no noise from any check, however some areas are not clean for the various style checks, you should check this is actually the case (in general, areas that are innately dirty are very dirty, and stand out).
* Is the users build clean?
* They'll be giving you a mail_msg file, it will ideally be absolutely free of any noise. In practice, there are times when there will be noise for other reasons, not related to their integration. You should check! One thing to double check is that lint was actually run. It's surprisingly easy to glance at an incremental build, and not notice that the source was never linted.
* Did the submitter test their changes to your satisfaction?
  * Can you think of anything else that should be tested? Ask for it!
  * Did the testing actually test the area changed by the patch? Check!
* Read the diff. Check that nothing stands out that reviewers may have missed
* Feel free to run a build yourself, if you're paranoid, but don't feel compelled to.
