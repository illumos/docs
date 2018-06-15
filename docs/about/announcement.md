# Project Announcement

## Introduction

On August 3, 2010, Garrett D'Amore announced the illumos project, "a community
effort of some core Solaris engineers to create a truly open source Solaris by
swapping closed source bits of OpenSolaris with open implementations."

In January, 2012, he reflected on [Experiences Starting an Open Source
Operating
System](http://smartos.org/2012/02/02/experiences-starting-an-open-source-operating-system/)
in a talk at SCALE 10x.

[Garrett's original slides](http://www.illumos.org/attachments/download/3/illumos.pdf)

## Transcript

```
OK, everybody. Thank you for joining us. My name is Garrett D'Amore. Hopefully
everyone is hearing this. We had some technology challenges such as, such as it
goes in our industry, and I apologise for the late start but here we are
anyway.

So Illumos. First off I do want to point out before we get started, that there
is a Q & A window in the Go2 webinar screen and Anil who is helping me out
here, is monitoring that. You can ask questions there and he will forward them
to me. We also have a backchannel on IRC if you go to irc.freenode.net and the
back channel is #illumos. I-L-L-U-M-O-S, and Anil's monitoring that as well,
and he'll let me know if there's pertinent questions I should address. I will
try to address those questions at the end, however.

[Slide 1, 1:06]

So, without further adieu, let's go ahead and continue. So, thanks for joining
us. I think that the topic there on the first page slide, hopefully everybody
sees it. By the way if you aren't able to see the slides now, we will be
posting them up, excuse me Anil have you already posted those? Ok, so Anil with
post them momentarily. So, hopefully you can get them, and they'll be on the
website at www.illumos.org. Just looking at that font on the slide, and realize
the "I" really doesn't stand out vary differently from the "L." I apologize for
that, it's I-L-L. And our topic is "Hope and Light Springs Anew."

So, the name... well first off I hope everyone understands that this
presentation is targeted towards the OpenSolaris audience so I didn't really go
into a lot of background there. It will become clear as we go on. If you are
here asking about Windows or something else you're probably in the wrong
conference call.

[Slide 2, 2:19]

So what's in a name? First "Illum" from Latin for "Light" and "OS" for
"Operating System." However even though I printed it out this way on the slide,
now we've been spelling it all one word with any unusual spellings, so
I-L-L-U-M-O-S, with only the "I" capitalized.

[Slide 3, 2:41]

So, actually what is this project about? Well the first thing is that the
project is designed here to solve a key problem, and that is that not all of
OpenSolaris is really open source. And there's a lot of other potential
concerns in the community, but this one is really kind of a core one, and from
solving this, I think a lot of other issues can be solved. So the critical
components of OpenSolaris. Well, first off I guess I should say that most of
the important parts of OpenSolaris are, for booting at least and for building a
foundation block for the OS/Net consolidation, out of that consolidation it's
nearly completely open source, except for a few pieces. One of the most
striking pieces is this part called "libc-i18n," which is a component you need
to build a working C library. It's a substantial percentage of libc is tied up
in that libc-i18n, in some cases because it's i18n code, in other cases because
of dependencies and well dependencies is probably the best way to put it.

The NFS lock manager, of course, there's the crypto framework, a number of
really important drivers. mpt I listed here is a pretty famous one its for a
pretty popular series of HBAs from LSI. But there's a lot of other drivers that
are closed source, and in fact even some key platform code, although that's for
the most port an issue for the SPARC port. Most of the critical platform code
for x86 is open, in fact I can't think of anything critical that's closed.
This list is by no means exhaustive, but it's a good start.

So the problem with the fact that not all of this source is open is that it
really does present some big challenges to anyone downstream or who depends on
OS/Net or consequently OpenSolaris and of course this involves Nexenta,
Belinux, Schillix these are all derivative distributions from the original
source from Oracle. And this problem is not new to the industry; some years ago
Apple had done the community a great favor by opening a bunch of their code in
the form of Darwin. However I think you can Google around for MacOS X and
Darwin and see the end result of that. And that is, the end result, I think,
that we would all like to avoid.

[Slide 4, 5:32]

So there's a lot of good stuff, with all the other issues going on with the
community that's built up around the code. First off there's technology in
the code, zfs, dtrace, crossbow, zones, I think everyone who's familiar with
OpenSolaris will recognize this stuff, and if you don't, Google will readily
fill you in with lots and lots of detail on all of these technologies, and this
is just a brief list of some of the big names. There's a lot of others beyond
this. And of course the community behind these technologies is made up of a
number of just incredible engineers, I've been fortunate to work with some of
the brightest people on the planet, I believe, on Solaris and SunOS code. And
we are also backed by an outstanding set of enthusiasts, and our eco-system
really is quite vibrant, particularly in light of some of the other challenges
it continues to be so vibrant. This I think says a lot. And of course the other
thing is that it's not all closed. In fact, the vast majority of the code is
indeed open. So the problem of, the problem faced to resolve this is actually
quite tractable.

[Slide 5, 7:06]

Technology issues, there it goes, alright. I apologise. OK. So around this
effort. I talked a little about the issue of the code. To elaborate a little
bit further, what we've done is taken OS/Net, this consolidation which really
makes up the kernel and a bunch of critical system utilities and made a child
of it, and this is really a source code management type term but what it means
is that it has an ancestry relationship with the upstream which in this case is
the code from Oracle, and we track the upstream very closely, and we also have
the goal of being 100% compatible with the code from Oracle. I say ABI
compatible, what that means is that the idea is that you can take an
application that is compiled and runs well on Solaris, and the same exact
application compiles and runs on Illumos, so that is an important point.

We also, the idea is no closed code. There's a fully open libc, I would want to
have a fully open kernel, and fully open drivers. As you'll see we are not all
the way there yet but we made really good progress, and continue to work on
this. The other idea is that this project then becomes a repository where we
can take changes from contributors that for a variety of reasons might be
unacceptable to Oracle, and I can detail all those later, maybe in Q & A or
maybe separately. There's a lot of potential possibilities here, and as long as
we don't really break the idea of ABI compatibility with Solaris and we don't
diverge needlessly from the upstream ON consolidation, there's a lot of room
for innovation.

[Slide 6, 9:19]

So the focus of Illumos is really ON right now, OS/Net, that's that core
consolidation that I talked about. But one of the ideas is that this also can
then ultimately build a community that can act as an umbrella for these other
projects, and other pieces, that become interesting, once you solve this
critical problem of that core foundation. X11, which is basically the graphical
windowing system. The desktop components. The C runtime. Some of the
distributions. And there is potentially a lot of ways which people can
innovate, and contribute. Which unfortunately, in the current community is
quite difficult to do. We hope that we can become a lot more of a facilitator
in that kind of development and collaboration.

[Slide 7, 10:16]

So, around this, we hope to build a community. And, I think we actually have
really started one pretty strongly, from the people who have already either
agreed to participate or are participating. And this community stands
independently from the OpenSolaris community. What that means is that we own
our own identity, and we can't be shut down, and we're not slaves to any
corporate master. And even though Nexenta is a major sponsor, and I'm very
grateful that Nexenta is. They're my employer, and they are funding my time on
this. But the identity and the project, is owned by the community. And that
means we're governed and run by the community. On that topic, I have a few
bullet points there about our resources being distributed, the fact that we're
going to basically run this as a Meritocracy, with a light hand on governance,
which is one of the areas we think we can improve upon from the previous
attempts.

[Slide 8, 11:28]

So there's a large number of people. I started the project, so I guess I'm the
de facto "leader". But you know, there's actually quite a - it was a dozen when
I wrote this, it's probably grown since then. This project started out with
just a few developers, that I wanted have real focus on just getting the code
done. Without engaging in a lot of conversation. Even with that small, focused
group, it's already still growing. And now, today, as of right this minute, we
hope to engage a much much broader audience. A we hope to invite, all of you -
actually we do invite all of you. So come join us. In this presentation you'll
see there's a website you can join, there's mailing lists you can join. A
number of the community leaders, a lot of whom you will be familiar with, if
you're already a part of this group. In fact, hang on just a minute. Some of
them are on this call. And actually we have a couple who have agreed to speak.
I'd like to tie in one. Anil's checking on it for me. Just a minute.

[12:48]

Simon, we're going to go ahead and un-mute your mic. Are you available to talk?
Ok, great. So Simon Phipps is one of the - he didn't start out as an existing
core member. But he's agreed to help us out, and as you'll see later, he's
agreed to take a role in this, and I'm hoping that Simon has some good things
to say.

*<Simon Phipps, SP>* Hi Garrett.

*<GDA>* Simon Phipps, maybe not the best introduction.

*<SP>* I'm very pleased that you're doing this, Garrett. You know I've seen a
project like this before, when we started OpenJDK there was some concern, that
Sun wasn't going to get around to opening all of the Java code, so some
community members got together and formed a project called "IcedTea", which was
downstream of OpenJDK, but to which people could innovate and could fix the
non-free parts of OpenJDK. It was the existence of that project, that made
OpenJDK a fully free project, and led to it having the existence beyond the
sponsorship that Sun put into it. I'm looking at Illumos at the moment, and I
think it's exactly the right step to take. It's good that it's downstream of
Oracle. If they choose to use it, it could do a great deal of good to their
Solaris products. If they choose not to use it, then it's a great place for the
community to assemble, and give a future to Solaris.

*<GDA>* Ok. Great. And thanks for your support. That was Simon Phipps. Simon
currently sits on the board for the Open Source Initiative. I think that's
correct, is that correct, Simon?

*<SP>* That's correct. I'm on the board of directors of OSI, the Open Source
Initiative. At the moment, while we still have one, I'm a member of the
OpenSolaris Governing Board, as well.

*<GDA>* Ok. And he also writes for Computer World UK. I'm sure you can find his
blog pretty easily. Thank you very much Simon. Let's go ahead and move along.
One of the points that's on there, before I switch to the next slide, is that I
believe that we actually do already have critical mass to drive this project
forward. That's one of the real challenges for a project like this. The
codebase, when you look at the size of OS/Net, is quite enormous, but the
number of people, and people who are actual do-ers rather than talk-ers, who
are involved and interested and engaged, already, is - I'm actually astounded,
and thrilled to have such a - frankly an illustrious group of contributors
involved. I have great hope. Moving forward.

[Slide 9, 15:50]

We have quite a few community partners. Of course, Nexenta is one of these, and
there's a number of these names that you will recognise, if you're familiar
with the OpenSolaris community. Google is great at filling each one of these
out. I'm not going to present all of them to you. But I'm really pleased that a
former colleague of mine at Oracle, is with us, and he has taken a position as
Vice President of Engineering at Joyent. Hopefully he's on the line. His name
is Brian Cantrill. He's one of the co-creators of DTrace as I understand it.
Can we un-mute his mic? We're having some technical issues here, hopefully
we'll get Brian in, in a few minutes. In the meantime, I'm going to go ahead
and move on.

[Slide 10, 16:52]

The 800 pound gorilla. This is the question that is probably on a lot of
people's minds. The 800 pound gorilla being that company that bought former
owner of the Intellectual Property behind most of OpenSolaris, Oracle. The
interactions here, it's really important that we understand what these
interactions are, and what they're intended to be. The first of these is that
Illumos is not a competitor to Solaris. Neither to OpenSolaris. In fact, I have
personally invited Oracle to participate as a peer, although they don't get to
own it, we would love to have their participation. To the extent that they are
allowed to, per whatever arrangements they have with Oracle, welcome the
individual employees of Oracle, to participate here as well. We'd love to have
a collaborative and cooperative relationship with Oracle. Just as with any of
our other corporate partners. From that slide I just had, you can see a few.
That slide, by the way, is by no means complete. I hope that it will not be the
end statement, either. But we're not going to depend on them. I'm being told
now that Brian is available, so I'm going to go ahead and switch back to Brian.

[18:12]

*<Bryan Cantrill, BC>* Hey Garrett. This is terrific news. A great development
for the OpenSolaris community. Looking back, historically, I think we at Sun (I
should say 'they' now I guess) - I think that Sun understood the importance of
the right to fork the operating system, but I think we've underestimated the
importance of the power to fork the operating system. As you know, as we all
know, we never quite made it to 100% of the source. And what that, effectively,
forbid - not explicitly, I mean we didn't do it by design - but because there
were these encumbrances that didn't allow us to open source elements of the
operating system, it effectively did not allow for a fork. A fork is a really
important check against an open source project. A fork is what allows people to
innovate. A fork is what allows people to not get hung up on governance models.
It allows them to express their independence from a project. Whilst people had
the right, strictly speaking, they didn't have the power, because it was not
all open source. Today is a really critical development. It is giving all of
us, in the community, the power to fork the system. Not that we want to
actually exercise that power in a way that is divisive, but we need to be able
to exercise that power in a way that is innovative. I think that is going to
allow many of us - now speaking as Joyent - many of us in the community who
depend on the innovations in this system for the value that we bring to our
customers, it is going to allow all of us to begin to differentiate ourselves
in the marketplace, it's going to allow all of us to be able to really innovate
to the operating system, and allows us all to collaborate. I think that,
speaking for Joyent, we have modifications to the system that we have not been
able to integrate for a variety of reasons. We believe with Illumos - with the
Illumos project - that we will be able to begin to integrate some of these
modifications. Many of them, of course, are small - bugfixes and so on. But
things that for a variety of reasons couldn't be taken further upstream. I,
personally, and we, Joyent, are thrilled. This is a tremendous, tremendous
development. Garrett, you and your team, are to be commended for some very
difficult technical work. To be clear, we are not completely out of the woods
yet. We boot. That's good. But we got work ahead of us. Collectively. As a
community. To get to a vibrant base, that will allow for innovation. I'm much
more confident now, than I have been at any time in the last five years, that
we're going to get there as a community. So, very exciting development, and I
think you see the number of people that are on Freenode. A lot of folks are
interested in this. I think for us as a community it's a real reboot. We owe
our debt of gratitude to Garrett and the Illumos project.

[21:44]

*<GDA>* Thank you very much, Brian. I'm very, very pleased that you and the
rest of the crew at Joyent are going to be able to join us, and collaborate to
expand upon the great work that is already part of SunOS base. With that, I'm
going to go ahead and switch back, because I want to keep moving ahead. On this
one slide, the 800 pound gorilla. So I think that this idea that Brian really
hit on, is that we have the power to fork. We are not a fork, but what we do is
we represent the ability of the community to do that. That's key.

[Slide 11, 22:30]

In fact, here's my top slide on that. What if the tap is turned off? What if,
the upstream, ceases to be cooperative, or just goes away. For a lot of
reasons, I don't think that's going to happen. Even if the community around
that code-base were to be abandoned, or shut down - or even change it's
character in a way that it might be hard to recognise it, the code-base, I
expect personally, for that to remain available. That code that is already
available, and for it to continue to be updated, on some level of frequency.
But in the event, that it were to go away, we believe that with the developers
we have, and especially, the growing ecosystem that already just on day one
here, seems to be exploding. I think we have critical mass to continue to
sustain it. As I said, I'm thrilled that Joyent, and there is a bunch of other
people, are a part of that. Of course, if this happens, then we - by definition
- become a fork. We are not a fork today, because of the way we track OS/Net.
In my mind, in a classical sense, a fork starts from the starting point, and
moves away, and becomes something else. So we're more like a project that -
we're going to continue to try to work closely with Oracle. As I think that
Brian talked about, really the idea is that Illumos is the insurance that the
entire community needs, against this sort of scenario of what happens if the
tap is turned off.

[Slide 12, 24:14]

What are some of the major goals of this project. I think we've already talked
about some of these. We want to be a self-hosting SunOS derivative. We're not
quite there yet, but we're getting there. We've made good strides. Fully open
source, of course. That's kind of, I think, a key thing. I already touched on
the 100% ABI compatibility with Solaris. So, for those who are listening in,
and aren't familiar with the acronym ABI, that's Application Binary
Interface, and really what it means, is that your existing applications work
without being recompiled. This next, fourth bullet point, I haven't touched on
it today, and it's really key. Probably it deserves a little bit of discussion.
That is, that we want the things that we put into Illumos to be usable by
Oracle. To be able to be taken back into the upstream code from Oracle. This is
part of the - we're not a fork today. Working and collaborate in a
collaborative relationship with Oracle. So there's a bunch of other
consequences that fall out of this. But the key thing is that the code that
integrates into Illumos really should be - it should be reasonable for somebody
to integrate that back into the Oracle code base. If whatever political or
business goals, that were preventing that, were removed. Of course, we don't
want to have any corporate dependencies on the Illumos project. I think I've
already talked about this. This last bullet point, the basis for other
distributions. For people not familiar with the way OpenSolaris distributions
are built today, there is typically this bottom piece, called ON. And there is
a bunch of other pieces, that are put together, and then these are all
constructed together, to create a full operating system. And there's a number
of distributions besides the one that Oracle creates, called OpenSolaris.
There's Schillix, there's Belenix, and of course, my favourite, Nexenta. This
is just a few of them. There's quite a few others. MilaX, EON, and we haven't
talked to all of the people producing these distributions, but at least the
ones that we have talked to are already engaged in looking at Illumos as their
future base line. So they're participating. I'm going to make a brief note
here, there is another individual who is a part of the Illumos developer
community, who's also working on a completely open, community driven, version
of the distribution, formerly known as Indiana. I'm not going to say anything
more about that, because that would be stealing his thunder. Hopefully, you'll
hear more from him in the coming days or weeks.

[Slide 13, 27:10]

A little bit here about how the project is organised. Basically, we're going to
have two groups, one group is this notion of administrative council, that
basically handles non-technical matters. So resource management. We do have
servers, we have mailing lists. There is probably matters of evangelism and
marketing and all these others things that happen. We wanted to separate the
technical from the non-technical. So the people focused on the code, and
getting things done, didn't have to be bothered by the day-to-day running of
the details. Likewise, the people running the day-to-day details don't have to
be all-star developers. Initially, I'm the chairman. It's a benevolent
dictatorship until we come up with some other form of rule that works. The idea
is to make this as much as possible, reasonable consensus driven, although
there will be a smaller group, that actually runs the administrative council. I
have already appointed a few members, that may change. Hopefully they will
select some additional members, to fill out their own ranks. The idea is a
meritocracy, the people who are actually helping to do things, rather than just
people who want to stand up and claim credit.

[Slide 14, 28:35]

The other half of this is the developer council. I had a little tie-in from a
joke here. A community member actually, had a nice tagline here, his name is
Matthew, you'll see him on IRC as lewellyn. His line was "if you have a
polarising issue, the first thing you have to work out if it's AC or DC".
Thanks to lewellyn for that little tid-bit. It's, again a benevolent
dictatorship, and I'm going to take the role as tech lead on the project. I'll
probably keep that lead, longer than I will the leadership in the other side,
because I really do view myself as a technical individual. Again, the initial
members will be appointed. The idea is that this really made up of the
developers who have the ability and - not just the ability - but the right to
commit, and a consensus driven meritocracy. My hope is that as tech lead, I
help define direction, but I only get involved in arbitration if no other
alternative, solution can be arrived at via consensus.

[29:55]

I'm seeing something on my UI here that says that we may be having network
trouble. Can somebody indicate on the IRC channel, am I coming across clearly?
Ok. Anil's giving the thumbs up. So I'm going to keep going. Maybe it's not too
bad.

[Slide 15, 30:10]

Rules for integration. This is getting down to the nuts and bolts of how we
expect to operate. As I think I already mentioned, again ON here is OS/Net.
That's that consolidation from the upstream. We have the same kind of
guidelines. You still gotta pass your cstyle, lint, you know, test your code,
have it reviewed, so forth. We do have some license restrictions, and really
these have a lot to do with this goal of making it easy for Oracle to take our
code and re-integrate it back into the upstream.
```

## Credits

* Brian Bienvenu (taemun)
* A. Hettinger (oninoshiko)
