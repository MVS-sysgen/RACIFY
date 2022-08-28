# RACification of MVS 3.8 Utilities and TSO Command Processors

Contained in this repo are 'RACified' MVS 3.8J program. They were
obtained from https://groups.io/g/turnkey-mvs/filessearch?p=name%2C%2Cracify.*%2C20%2C1%2C0%2C0&q=racify

The XMI file from that location has been extracted and stored in `RACIFY.UPDATES`. 

The programs from the table below have been updated. To generated the 
needed JCL to install these programs run the script `make_releases.sh`.

## Install with MVP

All 5 programs have been added MVP https://github.com/MVS-sysgen/MVP you
can install them with `RX MVP INSTALL <program>` for example to install
SHOWSS: `RX MVP INSTALL SHOWSS`

## Manual Install

The install JCL will also create the RAKF rules required to use these
programs. The JCL relies on the RAKF Command Library available here:
https://github.com/MVS-sysgen/RAKFCL

If you're on MVS/CE you must install MACLIBS and RAKFCL with:
`RX MVP INSTALL MACLIB` and `RX MVP INSTALL RAKFCL`

### DSSDUMP

I'm currently unable to build DSSDUMP from source.

# Original Readme

Many utilities and TSO command processors available for MVS 3.8j
can severly compromise system integrity when they are used by people
not being aware of the potential consequences or, even worse, with
malicious intentions. This isn't a problem on todays many "single user"
MVS 3.8j systems, on which the system programmer is the only user. But
on systems that are connected to the internet and allow public access
or even on "private" systems with very few (but more than one) users
problems can arise quickly.

MVS 3.8j systems having a resource access control system installed and
active (for example RAKF, an easy to use RACF(tm) like system) can use
this system to effectively limit access to critical utilities by
either protecting the libraries they reside in or by explicitely
asking the security system for authorization from within each utility.
The second method provides better granularity while still allowing to
conveniently execute from linklist and thus should be preferred over
the "hide away" method.

This library RACifies a few utilities and TSO command processors by
adding checks for READ access authority to dedicated profiles in the
FACILITY class:
        
| Utility  | Profile Checked | Action taken if access isn't granted                     |
|----------|-----------------|----------------------------------------------------------| 
| AUPGM    | PGMAUTH         | "IKJ56500I COMMAND AUPGM NOT FOUND" and exit             |
| BSPHRCMD | DIAG8CMD        | "BSPHC03W - No commands in PARM or SYSIN" and exit RC=12 |
| DSSDUMP  | DSSAUTH         | "** DSSDUMP must run authorized ***" and abend U0047     |
| SHOWSS   | SHOWAUTH        | "IKJ56500I COMMAND SHOWSS NOT FOUND" and exit            |
| STEPLIB  | STEPAUTH        | ignore APF operand                                       |

All updates are completely transparent when there is no RAC system
installed or when it isn't active, i.e. in this case the utilities
behave as the would without the respective update.

April 2012, Juergen Winkelmann, winkelmann@id.ethz.ch
