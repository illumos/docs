# Debugging broken systems

This page is intended to help users of operating systems derived from the
illumos gate to bring problems to the attention of the illumos gate developers.

!!! note ""
    All commands in this guide is presumed to be run as a non-privileged
    user. pfexec will be prepended to commands which need additional privileges. On
    some systems, the sudo command is used for this purpose.

## Help! My System Crashed or Locked Up!

You might be reading this because your system suddenly printed a panic message
on the console, saved a crash dump, and then rebooted (or the popular
alternative: suddenly locked up, showed some disk activity, and then rebooted).
Or perhaps your system stopped responding and never recovered. Calm down. We
want to know about this problem.

When illumos crashes (kernel panics), a crash dump is automatically saved
containing information from kernel memory. This can be copied to a file. A
developer can use use the crash dump to inspect the state of the system at the
time of the crash. You can also generate a crash dump manually to debug a hang.

If you are on a live session where no storage is available, you may have to
manually copy down crash or hang information. A serial console is preferred for
this.

### Gathering Information from a Crash Dump

If you are on an installed system and a crash occurs, a crash dump will
normally be saved. If you are on a live system, skip to the next section.
Assuming the crash does not recur immediately after the reboot, you can
retrieve information from the crash dump by following these instructions.

Log in as a user with access to pfexec or sudo (typically the user you created
at install)

Check your crash dump configuration:
```
pfexec dumpadm
```

This should print something like:

```
      Dump content: kernel pages
       Dump device: /dev/zvol/dsk/rpool/dump (dedicated)
Savecore directory: /var/crash/kirin
  Savecore enabled: no
   Save compressed: on
```

To extract the crash dump from the dump volume:

```
pfexec mkdir -p /var/crash/`hostname`
pfexec savecore
cd /var/crash/`hostname`
pfexec savecore -vf vmdump.0
```

With the crash dump extracted, you can now copy the kernel messages and stack
information from the crash to a file:

```
echo '::panicinfo\n::cpuinfo -v\n::threadlist -v 10\n::msgbuf\n*panic_thread::findstack -v\n::stacks' | mdb 0 > ~/crash.0
```

Save the crash.0 file in your home directory for reporting the crash. If
possible, keep the crash dump files on hand for future examination. If you have
available bandwidth and disk space, making this full crash dump accessible to
developers is invaluable. Note that due to the nature of the dump, it may
contain information you consider confidential. Use your judgement when making
it generally available.

### Notes

Configuring your crash dump.  The commands "dumpadm" and "coreadm" and be used
to list and alter the location and/or the actual contents of the resulting
crash dump.

#### Ensuring a successful crash dump

If you do not see a line like "100% done   .... dump succeeded" on the console
(if you have a console) or when you later try to analyze your crash dump via
"savecore -vd" or "savecore" you see a message like "savecore: bad magic number
0". You are probably are hitting illumos Bug #1110 and Bug #1369 (disable
multi-threaded dump). In this case in order to successfully force a crash dump
(if you do not see "dump succeeded")  you should modify your system to perform
a non-threaded crash dump by adding the following line to your /etc/system file
"set dump_plat_mincpu=0" and then performing a rconfiguration reboot.

#### Forcing a crash dump.

In order to force a crash dump form a working system that still has interactive capabilities you can do one of the following:

* as below "Gathering Information from a Running System".
* as below "Gathering Information from a Running System, using only NMI (x86)".
* issue the command "savecore -L" from the command line, this is not be the "best" method for debugging an issue.
* issue the command "reboot -d", this is not be the "best" method for debugging an issue.

## Gathering Information from a Running System

If you can reproduce the hang or crash, enabling the kernel debugger beforehand
is a way to get valuable information about it. The best option, if problem
occurs after the system has access to storage, is to use the debugger to save a
crash dump. Otherwise, you should record as much diagnostic information as
possible from the debugger.. A serial console or some form of lights-out
management (LOM) functionality is preferred for interacting with the debugger.

To use a serial console, you need an onboard or USB serial port, a null modem
cable, and another computer with a serial port, and to boot with the
appropriate -B console=ttya or similar option.

For a local console, you need a monitor and keyboard. On x86, this must be a
PS/2 keyboard or a USB keyboard operating in USB legacy (PS/2 emulation) mode.

To enable verbose boot messages and the kernel debugger (kmdb) on x86:

* At the GRUB prompt, highlight the boot environment with the arrow keys and press 'e' to edit the commands.
* Highlight the splashimage line, if it exists, and press 'd' to delete.
* Highlight the kernel line and press 'e' to edit.
* Append -kvd -m verbose to the end of the line (and remove console=graphics if it appears after -B)
* Press 'Enter' when finished, and then press 'b' to boot.

To enable verbose boot messages and the kernel debugger (kmdb) on SPARC:

* Press 'Stop' ('L1'), then 'A' or send a BREAK on the serial line to interrupt the boot process, if necessary.
* At the ok prompt, type boot -kvd -m verbose and press 'Enter'.

On both platforms:

* Wait for the kmdb> prompt to appear, then type moddebug/W 80000000 and press 'Enter'.
* Type snooping/W 1 and press 'Enter'.
* Type :c and press 'Enter'.

If the system panics, copy down ::msgbuf, ::status and ::stack.

If the system hangs, copy down the last few lines regarding modules on screen,
and do one of:

* On a serial console, send a BREAK on the serial line using your serial communications program.
* On a local keyboard on SPARC, press 'Stop' ('L1'), then 'A'.
* On a local keyboard on x86, press 'Shift-Pause'; or 'Esc-B'; or 'F1', then 'A'.
* Generate an NMI if your system provides this capability (hardware button, service processor command).

When you are successful the system should drop you into a kmdb prompt.

* Use `$<systemdump` to save a crash dump. The system should automatically reboot when finished.
* Follow "Gathering Information About A Crash", above.
* If you cannot save a crash dump, and are on a serial console, enter ::msgbuf, ::panicinfo, ::cpuinfo -v and::threadlist -v 10 and record the output. (Or take photos if you're unlucky enough to be at a VGA console)..

More resources:

* http://blogs.sun.com/dmick/entry/diagnosing_kernel_hangs_panics_with
* http://wikis.sun.com/display/WDD/Enable+the+Deadman+Feature+to+Avoid+a+Hard+Hang

## Gathering Information from a Running System, Using only NMI (x86)

In order to force a crash dump form a system that seems hung or frozen e.g. no
longer has has interactive capabilities if your system supports NMI (hardware
button, service processor command) it might be a good practice to permanently
configure the following:

* Adding the line (as user root) `set pcplusmp:apic_panic_on_nmi = 1` to your /etc/system file allows a crash dump to be generated on the receipt by your system of an NMI (non-maskable interrupt). Once this line is added you will have to do a reconfiguration reboot.
* Note, If you also have the line `set pcplusmp:apic_kmdb_on_nmi=1` in your /etc/system file you will not generate a crash dump, but rather go into the kernel debugger as this later directive takes priority over the `pcplusmp:apic_panic_on_nmi` setting.

The above might be a a very good practice as it simplifies forcing a "crash
dump" (avoids the x86 requirement of  keyboard input e.g. press 'Shift-Pause';
or 'Esc-B'; or 'F1', then 'A'.).  However this simplification will a) not work
on all platforms and b) might even cause issues on a few system types and c)
works if your system loads/uses the pcplusmp module (not the apix module).
Because of these requirements despite the fact that many admins use this as a
default setting it is not the default configuration for fresh installs of the
OS.

More resources:

http://blogs.sun.com/dmick/entry/diagnosing_kernel_hangs_panics_with
http://wikis.sun.com/display/WDD/Enable+the+Deadman+Feature+to+Avoid+a+Hard+Hang
http://www.cuddletech.com/blog/pivot/entry.php?id=1044
http://kristof.willen.be/node/1100
http://docs.oracle.com/cd/E19963-01/html/817-2543/casestudy-13.html
http://shanit.blogspot.com/2009/03/solaris-10-crashdumps.html
