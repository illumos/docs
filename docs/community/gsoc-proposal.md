# How to write an excellent GSoC proposal

We assume you've already found our Project Ideas, GSoC Application Template, and Google Summer of Code pages.

## Design 1st, Code 2nd

As part of your application, you should prepare a detailed design document
covering what you propose to do.  Be as detailed as you can about any
interfaces that will change as part of your work, i.e. reference any existing
interface document(s) in your design, and provide a new version (or diffs
against the existing document) to show how those interfaces will change.
Reference any standards or specifications that affect the design.  Consider
including in your proposal one or more test programs to exercise any affected
interfaces.

We care about well-designed interfaces, that allow changing implementations
with minimal or no impact consumers of an interface.

 
## Realistic Project Plan
 
With your reasonably complete design document in hand, break down the work in
to a list of modestly sized tasks.  Estimate the time required for each task.
If any are estimated to take more than a week, it's likely that you should
further divide those into smaller tasks.

Write a tentative schedule laying out all your tasks.  That schedule will (of course) change as you work on your tasks.

## Research first, ask questions later

If you don't understand what the project really is, particularly if there's
linked code or explicit references that you don't understand, you need to show
that you've tried to work this out for yourself rather than asking right off.
You are joining our community for mentorship, but our objective is to develop
your over the course of the summer into someone who can participate over the
long term as a peer. Nothing threatens that premise like asking a question that
a Google search could answer for you, particularly if it's how you introduce
yourself or if you do so persistently. Be especially sure to sure to search our
mail and IRC archives to see if we've had previous discussions about the idea
that interests you.

## Survey the project

### Assumptions are the hardest thing to refactor

A good time to ask questions is when you start getting clear ideas about how to
structure the project. Baking in mistaken assumptions can kill code, but
assumptions can also cause lost time well before that or show your project to
be untutored if they contradict a mentor's understanding. If you reckon you've
got a basic conceptual grasp of the project (you've followed explicit
references from the ideas page, you've checked how issues were framed if the
project was previously discussed on the developer mailing list), asking
questions is a good way to confirm and clarify that before you start building a
proposal around it.

### Don't be surprised if there is disagreement on fundamentals

The further you go in forming assumptions, the more important it is to expose
those assumptions to feedback from potential mentors. We encourage you to do
this via the developer mailing list and IRC channel. Assumptions may not be
agreed within the community, even between leading contributors to a particular
area. One of the most important skills to develop in an open-source project is
the ability to summarize and evaluate competing perspectives.

### Look at the whole on your first pass

If a project mentions a list of items, diving into the first item may not be
the best approach. Make a general survey to understand how the pieces do or do
not relate so that you understand what leverage resolving one item gets you for
others and what dependencies might exist between items.

### Spend time with existing code

Look for existing code that bears some relation to the project. For example: if
you're looking at a project to implement instrumentation tools with DTrace,
analyse different pieces to get a broader perspective: get a conceptual grasp
of what the tools you mean to reimplement do, see what's already in the DTrace
toolkit that instruments the same subsystems, and see what's implemented in
illumos-gate using kstats and C that overlaps so that you can get a grasp of
how DTrace differs in approach from traditional Unix instrumentation.

### Look for references

A number of people involved in our project write technical blogs, and there are
blogs dedicated to major subsystems, as well as related work in the continuing
commercial fork. The Solaris Internals book document a good deal of our
predecessor project. One book and one series by W. Richard Stevens, Advanced
Programming in the Unix Environment and TCP/IP Illustrated are considered
canonical texts on systems and fundamental networking programming. Tannenbaum's
Modern Operating Systems offers a comparative approach. Online docs for our
predecessor projects can be found here:http://www.filibeto.org/~aduritz/. An
online source for OS development can be found here:http://www.osdever.net/.

## Assertions are only for debugging

### Demonstration is best

This is a practical project. A lot of references to your academic record will
be hard for us to verify, thus making it hard to evaluate parts of your
application. Contributing fixes to bite-sized bugs, working through demo code
for a first step on your project (preferably allowing time for feedback after
sharing it with the community), and referencing contributions to other open
source projects all go a long way to demonstrating that you can do the work.

### Analysis is good, too

Code's always best, but showing that you can find and grok relevant code and
put it into a clear conceptual context is still better than resorting to
rhetoric.

## Show a long-term perspective

### Focus your enthusiasm

illumos and GSoC both want to support students with a long-term commitment to
open-source development. If you have no prior experience with open source
development, you're at something of a disadvantage. Do not try to overcome this
with non-specific expressions of enthusiasm.

### The race you're running has already begun

You are offering to make a serious commitment of time and energy to our
project, and completing a project successfully, meaning that we are able to
commit it before the summer is over, is a serious challenge. Particularly if
you don't have a record of open-source contribution generally and to our
project in particular, you should expect to put in much of your free time
between reading this and the deadline researching and preparing your
application and supporting materials (bite-sized contributions, demo code
directly relevant to the project).

### We're long-term people looking for long-term people

Many of the people working on this project have made career decisions to stick
with it and have been doing this for quite a long time, many for a living. We
come from a wide variety of backgrounds. We've had a lot of experience in the
workplace, as well as in the open-source world. We have a decent eye for
measuring capability, interest, and fortitude. Focus on the work as concretely
as possibly, and you are most like to exhibit those things. Let them speak for
themselves and leave other things out or in the background.
