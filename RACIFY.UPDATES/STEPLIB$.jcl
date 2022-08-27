//HERC01   JOB (CBT),                                                   00000100
//             'Build STEPLIB',                                         00000200
//             CLASS=A,                                                 00000300
//             MSGCLASS=X,                                              00000400
//             MSGLEVEL=(1,1),                                          00000500
//             NOTIFY=HERC01                                            00000600
//********************************************************************  00000700
//*                                                                  *  00000800
//*  Name: SYS2.CNTL(STEPLIB$)                                       *  00000900
//*                                                                  *  00001000
//*  Type: Assembly of STEPLIB Module                                *  00001100
//*      Also needs STEPLIB entry in IKJEFTE2 (see ZUM0001)          *  00001200
//*                                                                  *  00001300
//*  Desc: TSO command for adding/replacing STEPLIBs                 *  00001400
//*                                                                  *  00001500
//********************************************************************  00001600
//RACUPDT EXEC PGM=IEBUPDTE                                             00001703
//SYSUT1   DD  DISP=SHR,DSN=SYS2.ASM                                    00001803
//SYSUT2   DD  DISP=(,PASS),UNIT=VIO,                                   00001903
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)   00002003
//SYSPRINT DD  SYSOUT=*                                                 00002103
//SYSIN    DD  DISP=SHR,DSN=SYS2.ASM(STEPLUPD)                          00002203
//ASM     EXEC PGM=IFOX00,PARM='DECK,NOOBJECT,TERM,NOXREF'              00002300
//********************************************************************  00002400
//* You might have to change the DSNAMES in the next 2 DD statements *  00002500
//********************************************************************  00002600
//SYSIN    DD  DISP=(OLD,DELETE),DSN=*.RACUPDT.SYSUT2                   00002704
//SYSLIB   DD  DISP=SHR,DSN=SYS2.MACLIB,DCB=BLKSIZE=32720               00002800
//         DD  DISP=SHR,DSN=SYS1.MACLIB                                 00002900
//         DD  DISP=SHR,DSN=SYS1.AMACLIB                                00003000
//         DD  DISP=SHR,DSN=SYS1.AMODGEN                                00003100
//SYSUT1   DD  UNIT=VIO,SPACE=(CYL,(1,1))                               00003200
//SYSUT2   DD  UNIT=VIO,SPACE=(CYL,(1,1))                               00003300
//SYSUT3   DD  UNIT=VIO,SPACE=(CYL,(1,1))                               00003400
//SYSPRINT DD  SYSOUT=*                                                 00003500
//SYSTERM  DD  SYSOUT=*                                                 00003600
//SYSPUNCH DD  DISP=(,PASS),UNIT=VIO,SPACE=(CYL,(1,1))                  00003700
//LINK    EXEC PGM=IEWL,COND=(0,NE),PARM='LIST,LET,MAP'                 00003800
//SYSPRINT DD  SYSOUT=*                                                 00003900
//SYSUT1   DD  UNIT=VIO,SPACE=(TRK,(50,20))                             00004000
//SYSLMOD  DD  DISP=SHR,DSN=SYS2.CMDLIB(STEPLIB) <<=== CHANGE           00004100
//SYSLIN   DD  DISP=(OLD,DELETE),DSN=*.ASM.SYSPUNCH                     00004200
