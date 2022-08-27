//AUPGM$   JOB  (SETUP),                                                00000100
//             'Make AUPGM Command',                                    00000200
//             CLASS=A,                                                 00000300
//             MSGCLASS=X,                                              00000400
//             REGION=4M,                                               00000500
//             NOTIFY=HERC01,                                           00000600
//             MSGLEVEL=(1,1)                                           00000700
//********************************************************************* 00000800
//*                                                                     00000900
//* NAME: SYS2.CNTL(AUPGM$)                                             00001000
//*                                                                     00001100
//* DESC: Assemble and link AUPGM command processor                     00001200
//*                                                                     00001300
//********************************************************************* 00001400
//RACUPDT EXEC PGM=IEBUPDTE                                             00001500
//SYSUT1   DD  DISP=SHR,DSN=SYS2.ASM                                    00001600
//SYSUT2   DD  DISP=(,PASS),UNIT=VIO,                                   00001700
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)   00001800
//SYSPRINT DD  SYSOUT=*                                                 00001900
//SYSIN    DD  DISP=SHR,DSN=SYS2.ASM(AUPGMUPD)                          00002000
//ASMCL   EXEC ASMFCL,                                                  00002100
//             PARM.ASM=(OBJ,NODECK),                                   00002200
//             PARM.LKED='LIST,MAP,RENT,REUS,REFR,AC=1',                00002300
//        MAC1='SYS1.AMODGEN',                                          00002400
//        MAC2='SYS2.MACLIB'                                            00002500
//ASM.SYSIN    DD DISP=(OLD,DELETE),DSN=*.RACUPDT.SYSUT2                00002600
//LKED.SYSLMOD DD DSN=SYS2.CMDLIB(AUPGM),DISP=SHR                       00002700
//                                                                      00002800
