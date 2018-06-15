# So You Want to Develop on illumos

Written by [Bryan Cantrill]()

!!! info "Terminology"
    | Term          | Definition                                                          |
    | --------------|---------------------------------------------------------------------|
    | FCS           | First Customer Ship                                                 |
    | gate          | Source code repository                                              |
    | gatekeeper    | Release Engineer responsible for ensuring the gate is working       |
    | putback       | Committing code to the gate                                          |
    | jurassic      | Server in the Sun Microsystems engineering dept.                    |

## Introduction

So you're new to open source, and/or you're new to illumos. Maybe you have lots
of experience developing mission-critical software, maybe you have none. But if
you haven't already figured it out, we take quality very seriously around here.
Developing illumos is very hard, and it's very important. This is good news,
not bad news -- solving easy problems is boring and solving irrelevant problems
is, well, irrelevant. But you should be prepared for the fact that you will
need to push yourself to deliver the highest quality software.

If you haven't already discovered it, illumos -- like any large software
system -- has a complete range of software quality within its many subsystems.

## Immaculate

Some illumos subsystems are beautiful works of engineering -- they are squeaky
clean, well-designed and well-crafted. These subsystems are a joy to work in
but (and here's the catch) by virtue of being well-designed and
well-implemented, they generally don't need a whole lot of work. So you'll get
to use them, appreciate them, and be inspired by them -- but you probably won't
spend much time modifying them. (And because many of these subsystems have been
implemented by engineers who are now part of the active illumos community, many
of the changes will be done by the original implementor(s) anyway.)

## Fetid

Other illumos subsystems are cobbled-together piles of junk -- reeking garbage
barges that have been around longer than anyone remembers, floating from one
release to the next. These subsystems have few-to-no comments (or what comments
they have are clearly wrong), are poorly designed, needlessly complex, badly
implemented and virtually undebuggable. There are often parts that work by
accident, and unused or little-used parts that simply never worked at all. They
manage to survive for one or more of the following reasons:

* They work just well enough to not justify the cost of rewriting them
* The problem they solve isn't important enough to justify the cost of rewriting them
* The problem they solve is so nasty that the cost of a rewrite is enormous -- or at least it dwarfs the cost of ongoing maintenance

If you find yourself having to do work in one of these subsystems, you must
exercise extreme caution: you will need to write as many test cases as you can
think of to beat the snot out of your modification, and you will need to
perform extensive self-review. You can try asking for assistance, but you may
quickly discover that no one is available who understands that particular
subsystem. Your code reviewers may not  be able to help much either -- maybe
you'll find one or two people who have had the same misfortune that you find
yourself experiencing, but it's more likely that you will have to explain most
aspects of the subsystem to your reviewers. You may discover as you work in the
subsystem that maintaining it is simply untenable -- it may be time to consider
rewriting the subsystem from scratch. (After all, most of the subsystems that
are in the first category replaced subsystems that were in the second.) One
should not come to this decision too quickly: rewriting a subsystem from
scratch is enormously difficult and time-consuming. Still, don't rule it out a
priori.

Even if you decide not to rewrite such a subsystem, you should improve it while
you're there in ways that don't introduce excessive risk. For example, if
something took you a while to figure out, don't hesitate to add a block comment
to explain your discoveries. And if it was a pain in the ass to debug, you
should add the debugging support that you found lacking. This will make it
slightly easier on the next engineer -- and it will make it easier on you when
you need to debug your own modifications.

## Grimy

Most illumos subsystems, however, don't actually fall neatly into either of
these categories -- they are somewhere in the middle. That is, they have parts
that are well thought out, or design elements that are sound, but they are also
littered with implicit intradependencies within the subsystem or implicit
interdependencies with other subsystems. They may have debugging support, but
perhaps it is incomplete or out of date. Perhaps the subsystem effectively met
its original design goals, but it has been extended to solve a new problem in a
way that has left it brittle or overly complex. Many of these subsystems have
been fixed to the point that they work reliably -- but they are delicate and
they must be modified with care.

## Due Diligence

The majority of work that you will do on existing code will be to subsystems in
this last category. You must be very cautious when making changes to these
subsystems. Sometimes these subsystems have local experts, but many changes
will go beyond their expertise. (After all, part of the problem with these
subsystems is that they often weren't designed to accommodate the kind of
change you might want to make.) You must extensively test your change to the
subsystem. Run your change on your desktop, your laptop, your home machine and
every kind of machine you can grab a tip line to. But you can't just be content
with booting a machine with your change -- you must beat the hell out of it.
Sometimes there is a stress test available that you may run, but this _is not a
substitute for writing your own tests_. You should find any standards tests that
might apply to the subsystem and run them. (If you don't know which standards
tests might apply to your change, consult the gatekeepers or the C-team.) You
should review your own changes extensively. Are you obeying all of the locking
rules? What are the locking rules, anyway? Are you building new dependencies
into the subsystem? (This can only be answered with extensive, laborious
cscope'ing -- you cannot rely on code reviewers to pick up subtle new
dependencies.) Review your changes again. Then, print your changes out, take
them to a place where you can concentrate, and review them yet again. And when
you review your own code, review it not as someone who believes that the code
is right, but as someone who is certain that the code is wrong. As you perform
your self-review, look for novel angles from which to test your code. Then test
and test and test.

It can all be summed up by asking yourself one question: have you reviewed and
tested your change every way that you know how? _You should not even *contemplate*
a putback until your answer to this is an unequivocal YES_.. Remember: you are
always empowered as an engineer to take more time to test your work. You can --
always take time to do the Right Thing. This is important to avoid the [Quality
Death Spiral](qds.md). You must do your part by delivering *FCS quality all the
time*.

Does this mean that you should contemplate ritual suicide if you introduce a
serious bug? Of course not -- everyone who has made enough modifications to
delicate, critical subsystems has introduced a change that has induced
expensive downtime somewhere. We know that this will be so because writing
system software is just so damned tricky and hard. Indeed, it is because of
this truism that you _must demand of yourself_ that you not integrate a change
until you are out of ideas of how to test it. Because you will one day
introduce a bug of such subtlety that it will seem that no one could have
caught it.

And what do you do when that awful, black day arrives? Here's a quick coping
manual from those of us who have been there:

* Don't pretend it didn't happen -- you screwed up, but your mother still loves you (unless, of course, her home directory is on jurassic)
* Don't minimize the problem, shrug it off or otherwise make light of it -- this is serious business, and we take it seriously
* If someone spent time debugging your bug, thank them
* If someone was inconvenienced by your bug, apologize to them
* Take responsibility for your bug -- don't bother to blame other subsystems, the inherent complexity of illumos, your code reviewers, etc.

But most importantly, you must ask yourself: _what could I have done
differently_? If you honestly don't know, ask a community member to help you.
We've all been there, and we want to make sure that you are able to learn from
it. Once you have an answer, take solace in it; no matter how bad you feel for
having introduced a problem, you can know that the experience has improved you
as an engineer -- and that's the most anyone can ask for.
