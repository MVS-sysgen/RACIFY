RACification of MVS 3.8 Utilities and TSO Command Processors
============================================================

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

---------+----------+-----------------------------------------------------------
         | Profile  |
Utility  | checked  | Action taken if access isn't granted
=========+==========+===========================================================
AUPGM    | PGMAUTH  | "IKJ56500I COMMAND AUPGM NOT FOUND" and exit
---------+----------+-----------------------------------------------------------
BSPHRCMD | DIAG8CMD | "BSPHC03W - No commands in PARM or SYSIN" and exit RC=12
---------+----------+-----------------------------------------------------------
DSSDUMP  | DSSAUTH  | "** DSSDUMP must run authorized ***" and abend U0047
---------+----------+-----------------------------------------------------------
SHOWSS   | SHOWAUTH | "IKJ56500I COMMAND SHOWSS NOT FOUND" and exit
---------+----------+-----------------------------------------------------------
STEPLIB  | STEPAUTH | ignore APF operand
---------+----------+-----------------------------------------------------------

All updates are completely transparent when there is no RAC system
installed or when it isn't active, i.e. in this case the utilities
behave as the would without the respective update.

April 2012, Juergen Winkelmann, winkelmann@id.ethz.ch
