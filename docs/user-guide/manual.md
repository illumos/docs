# Manual pages

You can browse (and link to) the illumos manual pages
[online](https://illumos.org/man/all).

## History

The manual pages integrated into illumos-gate are taken from the last source
drop provided by Sun at `http://dlc.sun.com/osol/man/downloads`. These sources
were outdated in several respects:

* They are missing descriptions of new features
* They may still describe some old features
* They have no updates for changes made by us (obviously)

Bugs can be filed under the ['manpages' category of the illumos-gate
project](http://www.illumos.org/projects/illumos-gate/issues?category_id=26&set_filter=1&status_id=o)
to rectify any omissions.

While the OpenSolaris build 134 manual pages claim to be under the CDDL in both
package license and headers, and newer pages may well claim to be under the
CDDL in their header comment, we have elected to treat them as tainted and work
from the last explicit source drop. Please do not source text from any
OpenSolaris page delivered to the system just because it superficially contains
a CDDL header. It is much, much better to be certain.

If you update software in a way that must be reflected in the manual, please
also update the manual in the same changeset.
