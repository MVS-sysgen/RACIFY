//DSSDMUP$ JOB  (SETUP),                                                00000100
//             'Update DSSDUMP',                                        00000200
//             CLASS=A,                                                 00000300
//             MSGCLASS=X,                                              00000400
//             REGION=4M,                                               00000500
//             NOTIFY=HERC01,                                           00000600
//             MSGLEVEL=(1,1)                                           00000700
//********************************************************************* 00000800
//*                                                                     00000900
//* NAME: SYS2.DSSSRC(DSSDMUP$)                                         00001001
//*                                                                     00001100
//* DESC: Add RAC authorization to DSSDUMP source                       00001200
//*                                                                     00001300
//********************************************************************* 00001400
//RACUPDT EXEC PGM=IEBUPDTE                                             00001500
//SYSUT1   DD  DISP=SHR,DSN=SYS2.DSSSRC                                 00001601
//SYSUT2   DD  DISP=(,CATLG),UNIT=SYSDA,DSN=updated.source,             00001700
//             SPACE=(TRK,(10,1),RLSE),                                 00001800
//             DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)                     00001900
//SYSPRINT DD  SYSOUT=*                                                 00002000
//SYSIN    DD  DISP=SHR,DSN=SYS2.DSSSRC(DSSDMUPD)                       00002101
//                                                                      00002200
