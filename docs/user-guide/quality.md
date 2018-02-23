# The Quality Death Spiral

Jeff Bonwick was the gatekeeper for Solaris 2.5. He gave a talk on Solaris to the Sun Systems Group in September, 1994. It included a section on the Quality Death Spiral -- a timeless phenomenon that remains our omnipresent fear:

```
if it's broken, rip it out

    - FCS* quality all the time
    - put it back today, 20 of your (current) friends
        will be running it tomorrow
    - gate breakage grinds other development to a halt
    - the product, not any one project, is what matters
    - mistakes will happen; negligence cannot

FCS* quality all the time -- why is this so important?

    - only way to avoid the quality death spiral:

        - people hear the gate is broken
        - decide not to risk a bringover
        - fewer people run the latest stuff
        - less real-life testing
        - new bugs not found
        - quality drops further

    - morale tracks quality

    - downward spiral hard to break

    - recovery time can be very long
```

* FCS == First Customer Ship

Sourced from http://hub.opensolaris.org/bin/view/Community+Group+on/qual_death_spiral.
