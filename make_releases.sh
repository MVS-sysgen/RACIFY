#!/bin/bash


## JOBCARD
read -r -d '' JOBCARD << END
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,
//             PASSWORD=SYS1
//*
//* THIS JCL WAS GENERATED AUTOMATICALLY BY make_release.sh
//*
END

## AUPGM

printf "//AUPGM JOB (JOB),\n//             'INSTALL AUPGM',\n" > release/AUPGM.jcl
echo "$JOBCARD" >> release/AUPGM.jcl

cat >> release/AUPGM.jcl << END
//RACUPDT EXEC PGM=IEBGENER
//SYSUT1   DD  DATA,DLM=@@
END

cat AUPGM.hlasm >> release/AUPGM.jcl

cat >> release/AUPGM.jcl << END
@@
//SYSUT2   DD  DISP=(,PASS),UNIT=VIO,
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=*   
//ASMCL   EXEC ASMFCL,
//             PARM.ASM=(OBJ,NODECK),
//             PARM.LKED='LIST,MAP,RENT,REUS,REFR,AC=1',
//        MAC1='SYS1.AMODGEN',
//        MAC2='SYS2.MACLIB'
//ASM.SYSIN    DD DISP=(OLD,DELETE),DSN=*.RACUPDT.SYSUT2
//LKED.SYSLMOD DD DSN=SYS2.CMDLIB(AUPGM),DISP=SHR
//*
//* Add the RAKF permissions
//*
//EXEC     EXEC PGM=IKJEFT01,                  
//       REGION=8192K                                         
//TSOLIB   DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//RXLIB    DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//SYSEXEC  DD   DSN=SYS2.EXEC,DISP=SHR                         
//SYSPRINT DD   SYSOUT=*                                      
//SYSTSPRT DD   SYSOUT=*                                      
//SYSTSIN  DD   *
 RX RDEFINE 'FACILITY PGMAUTH UACC(NONE)'
 RX PERMIT 'PGMAUTH CLASS(FACILITY) ID(ADMIN) ACCESS(READ)'
//STDOUT   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDERR   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDIN    DD   DUMMY   
END

## BSPHRCMD

printf "//BSPHRCMD JOB (JOB),\n//             'INSTALL BSPHRCMD',\n" > release/BSPHRCMD.jcl
echo "$JOBCARD" >> release/BSPHRCMD.jcl

cat >> release/BSPHRCMD.jcl << END
//RACUPDT EXEC PGM=IEBGENER
//SYSUT1   DD  DATA,DLM=@@
END

cat BSPHRCMD.hlasm >> release/BSPHRCMD.jcl

cat >> release/BSPHRCMD.jcl << 'END'
@@
//SYSUT2   DD  DISP=(,PASS),UNIT=VIO,
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=* 
//ASM     EXEC PGM=IFOX00,PARM='DECK,NOOBJECT,TERM,NOXREF'
//********************************************************************
//* You might have to change the DSNAMES in the next 2 DD statements *
//********************************************************************
//SYSIN    DD  DISP=(OLD,DELETE),DSN=*.RACUPDT.SYSUT2
//SYSLIB   DD  DISP=SHR,DSN=SYS2.MACLIB,DCB=BLKSIZE=32720
//         DD  DISP=SHR,DSN=SYS1.MACLIB
//         DD  DISP=SHR,DSN=SYS1.AMACLIB
//         DD  DISP=SHR,DSN=SYS1.AMODGEN
//SYSUT1   DD  UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT2   DD  UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT3   DD  UNIT=VIO,SPACE=(CYL,(1,1))
//SYSTERM  DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//SYSPUNCH DD  DISP=(,PASS),UNIT=VIO,SPACE=(CYL,(1,1))
//LINK    EXEC PGM=IEWL,
//             COND=(0,NE),
//             PARM='LIST,LET,MAP,RENT,REUS,REFR,AC=1'
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  UNIT=VIO,SPACE=(TRK,(50,20))
//SYSLMOD  DD  DISP=SHR,DSN=SYS2.CMDLIB
//SYSLIN   DD  DISP=(OLD,DELETE),DSN=*.ASM.SYSPUNCH
//          DD *
 ALIAS BSPOSCMD
 NAME BSPHRCMD(R)
//*
//* Add the RAKF permissions
//*
//EXEC     EXEC PGM=IKJEFT01,                  
//       REGION=8192K                                         
//TSOLIB   DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//RXLIB    DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//SYSEXEC  DD   DSN=SYS2.EXEC,DISP=SHR                         
//SYSPRINT DD   SYSOUT=*                                      
//SYSTSPRT DD   SYSOUT=*                                      
//SYSTSIN  DD   *
 RX RDEFINE 'FACILITY DIAG8CMD UACC(NONE)'
 RX PERMIT 'DIAG8CMD CLASS(FACILITY) ID(ADMIN) ACCESS(READ)'
//STDOUT   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDERR   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDIN    DD   DUMMY   
END

# DSSDUMP

printf "//DSSDUMP JOB (JOB),\n//             'INSTALL DSSDUMP',\n" > release/DSSDUMP.jcl
echo "$JOBCARD" >> release/DSSDUMP.jcl

cat >> release/DSSDUMP.jcl << END
//RACUPDT EXEC PGM=IEBGENER
//SYSUT1   DD  DATA,DLM=@@
END

cat DSSDUMP.hlasm >> release/DSSDUMP.jcl

cat >> release/DSSDUMP.jcl << 'END'
@@
//SYSUT2   DD  DISP=(,PASS),UNIT=VIO,
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=* 
//ASM     EXEC PGM=IFOX00,PARM='DECK,NOOBJECT,TERM,NOXREF'
//********************************************************************
//* You might have to change the DSNAMES in the next 2 DD statements *
//********************************************************************
//SYSIN    DD  DISP=(OLD,DELETE),DSN=*.RACUPDT.SYSUT2
//SYSLIB   DD  DISP=SHR,DSN=SYS1.MACLIB
//         DD  DISP=SHR,DSN=SYS1.HASPSRC
//         DD  DISP=SHR,DSN=SYS2.PVTMACS
//         DD  DISP=SHR,DSN=SYS2.ESPMAC
//         DD  DISP=SHR,DSN=SYS2.COLEMAC
//         DD  DISP=SHR,DSN=SYS1.AMACLIB
//         DD  DISP=SHR,DSN=SYS1.AMODGEN
//SYSUT1   DD  UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT2   DD  UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT3   DD  UNIT=VIO,SPACE=(CYL,(1,1))
//SYSTERM  DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//SYSPUNCH DD  DISP=(,PASS),UNIT=VIO,SPACE=(CYL,(1,1))
//LINK    EXEC PGM=IEWL,
//             COND=(0,NE),
//             PARM='LIST,LET,MAP,RENT,REUS,REFR,AC=1'
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  UNIT=VIO,SPACE=(TRK,(50,20))
//SYSLMOD  DD  DISP=SHR,DSN=SYS2.CMDLIB
//SYSLIN   DD  DISP=(OLD,DELETE),DSN=*.ASM.SYSPUNCH
//          DD *
 NAME DSSDUMP(R)
//*
//* Add the RAKF permissions
//*
//EXEC     EXEC PGM=IKJEFT01,                  
//       REGION=8192K                                         
//TSOLIB   DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//RXLIB    DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//SYSEXEC  DD   DSN=SYS2.EXEC,DISP=SHR                         
//SYSPRINT DD   SYSOUT=*                                      
//SYSTSPRT DD   SYSOUT=*                                      
//SYSTSIN  DD   *
 RX RDEFINE 'FACILITY DSSAUTH UACC(NONE)'
 RX PERMIT 'DSSAUTH CLASS(FACILITY) ID(ADMIN) ACCESS(READ)'
//STDOUT   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDERR   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDIN    DD   DUMMY   
END

## SHOWSS

printf "//SHOWSS JOB (JOB),\n//             'INSTALL SHOWSS',\n" > release/SHOWSS.jcl
echo "$JOBCARD" >> release/SHOWSS.jcl

cat >> release/SHOWSS.jcl << END
//RACUPDT EXEC PGM=IEBGENER
//SYSUT1   DD  DATA,DLM=@@
END

cat SHOWSS.hlasm >> release/SHOWSS.jcl

cat >> release/SHOWSS.jcl << END
@@
//SYSUT2   DD  DISP=(,PASS),UNIT=VIO,
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=*   
//ASMCL   EXEC ASMFCL,
//             PARM.ASM=(OBJ,NODECK),
//             PARM.LKED='LIST,MAP,RENT,REUS,REFR,AC=1',
//        MAC1='SYS1.AMODGEN',
//        MAC2='SYS2.MACLIB'
//ASM.SYSIN    DD DISP=(OLD,DELETE),DSN=*.RACUPDT.SYSUT2
//LKED.SYSLMOD DD DSN=SYS2.CMDLIB(SHOWSS),DISP=SHR
//*
//* Add the RAKF permissions
//*
//EXEC     EXEC PGM=IKJEFT01,                  
//       REGION=8192K                                         
//TSOLIB   DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//RXLIB    DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//SYSEXEC  DD   DSN=SYS2.EXEC,DISP=SHR                         
//SYSPRINT DD   SYSOUT=*                                      
//SYSTSPRT DD   SYSOUT=*                                      
//SYSTSIN  DD   *
 RX RDEFINE 'FACILITY SHOWAUTH UACC(NONE)'
 RX PERMIT 'SHOWAUTH CLASS(FACILITY) ID(ADMIN) ACCESS(READ)'
//STDOUT   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDERR   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDIN    DD   DUMMY   
END


## STEPLIB

printf "//STEPLIB JOB (JOB),\n//             'INSTALL STEPLIB',\n" > release/STEPLIB.jcl
echo "$JOBCARD" >> release/STEPLIB.jcl

cat >> release/STEPLIB.jcl << END
//RACUPDT EXEC PGM=IEBGENER
//SYSUT1   DD  DATA,DLM=@@
END

cat STEPLIB.hlasm >> release/STEPLIB.jcl

cat >> release/STEPLIB.jcl << 'END'
@@
//SYSUT2   DD  DISP=(,PASS),UNIT=VIO,
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=* 
//ASM     EXEC PGM=IFOX00,PARM='DECK,NOOBJECT,TERM,NOXREF'
//********************************************************************
//* You might have to change the DSNAMES in the next 2 DD statements *
//********************************************************************
//SYSIN    DD  DISP=(OLD,DELETE),DSN=*.RACUPDT.SYSUT2
//SYSLIB   DD  DISP=SHR,DSN=SYS2.MACLIB,DCB=BLKSIZE=32720
//         DD  DISP=SHR,DSN=SYS1.MACLIB
//         DD  DISP=SHR,DSN=SYS1.AMACLIB
//         DD  DISP=SHR,DSN=SYS1.AMODGEN
//SYSUT1   DD  UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT2   DD  UNIT=VIO,SPACE=(CYL,(1,1))
//SYSUT3   DD  UNIT=VIO,SPACE=(CYL,(1,1))
//SYSTERM  DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//SYSPUNCH DD  DISP=(,PASS),UNIT=VIO,SPACE=(CYL,(1,1))
//LINK    EXEC PGM=IEWL,
//             COND=(0,NE),
//             PARM='LIST,LET,MAP,RENT,REUS,REFR,AC=1'
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  UNIT=VIO,SPACE=(TRK,(50,20))
//SYSLMOD  DD  DISP=SHR,DSN=SYS2.CMDLIB
//SYSLIN   DD  DISP=(OLD,DELETE),DSN=*.ASM.SYSPUNCH
//          DD *
 NAME STEPLIB(R)
//*
//* Add the RAKF permissions
//*
//EXEC     EXEC PGM=IKJEFT01,                  
//       REGION=8192K                                         
//TSOLIB   DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//RXLIB    DD   DSN=BREXX.CURRENT.RXLIB,DISP=SHR                             
//SYSEXEC  DD   DSN=SYS2.EXEC,DISP=SHR                         
//SYSPRINT DD   SYSOUT=*                                      
//SYSTSPRT DD   SYSOUT=*                                      
//SYSTSIN  DD   *
 RX RDEFINE 'FACILITY STEPAUTH UACC(NONE)'
 RX PERMIT 'STEPAUTH CLASS(FACILITY) ID(ADMIN) ACCESS(READ)'
//STDOUT   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDERR   DD   SYSOUT=*,DCB=(RECFM=FB,LRECL=140,BLKSIZE=5600)
//STDIN    DD   DUMMY                                         
END
