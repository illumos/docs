# The Quality Death Spiral

!!! info "Terminology"
    | Term | Definition                          |
    | -----|-------------------------------------|
    | FCS  | First Customer Ship                 |
    | gate | Source code repository              |
    | Put [it] back | Committing code to the gate |

## Introduction

[Jeff Bonwick](https://en.wikipedia.org/wiki/Jeff_Bonwick) was the gatekeeper
for Solaris 2.5. He gave a talk on Solaris to the Sun Systems Group in
September, 1994. It included a section on the Quality Death Spiral -- a
timeless phenomenon that remains our omnipresent fear:

The following is paraphrasing Jeff's talk.

## If it's broken, rip it out!

* FCS quality all the time
* Put it back today, 20 of your (current) friends will be running it tomorrow
* Gate breakage grinds other development to a halt
* The product, not any one project, is what matters
* Mistakes will happen; negligence cannot

## FCS quality all the time

Why is this so important?

Only way to avoid the quality death spiral:

* People hear the gate is broken
* Decide not to risk a bringover
* Fewer people run the latest stuff
* Less real-life testing
* New bugs not found
* Quality drops further

* Morale tracks quality
* Downward spiral hard to break
* Recovery time can be very long

Originally sourced from [http://hub.opensolaris.org/bin/view/Community+Group+on/qual_death_spiral](https://web.archive.org/web/20110104044942/http://hub.opensolaris.org/bin/view/Community+Group+on/qual_death_spiral).
