//C7BSS   JOB (M096,0616,99,9999),'SYSTEMS*BRIAN',NOTIFY=HERC01,        00000101
//       MSGCLASS=X                                                     00000201
//ASMFCL PROC  CLASS='*',      -   SYSOUT CLASS                         00000301
//             MEM=,                                                    00000400
//*            DSN='SYS2.ASM',                                          00000503
//*            LOAD='SYS1.APFLIB',                                      00000600
//             LOAD='SYS2.CMDLIB',                                      00000701
//             WORK1=SYSDA,        DASD OUTPUT TYPE                     00000800
//             WORK2=SYSDA,        DASD WORK TYPE                       00000900
//             PRI=1,              PRIMARY ALLOCATION                   00001000
//             SEC=1,              SECONDARY ALLOCATION                 00001100
//             ALLOC=TRK           ALLOC INCREMENT                      00001200
//ASM      EXEC  PGM=IFOX00,REGION=500K,COND=EVEN,                      00001300
//         PARM='LOAD,NODECK,XREF'                                      00001400
//SYSPRINT DD  SYSOUT=&CLASS                                            00001500
//SYSLIB   DD  DSN=SYS1.MACLIB,DISP=SHR                                 00001600
//         DD  DSN=SYS1.AMODGEN,DISP=SHR                                00001700
//SYSUT1   DD  SPACE=(CYL,(10,10)),UNIT=&WORK2                          00001800
//SYSUT2   DD  SPACE=(CYL,(10,10)),UNIT=&WORK2                          00001900
//SYSUT3   DD  SPACE=(CYL,(10,10)),UNIT=&WORK2                          00002000
//SYSGO    DD  DSN=&&INDXOBJ,DISP=(NEW,PASS),                           00002100
//             UNIT=&WORK1.,FREE=CLOSE,                                 00002200
//             SPACE=(&ALLOC.,(&PRI.,&SEC.),RLSE)                       00002300
//SYSIN    DD  DISP=(OLD,DELETE),DSN=&&SHOWSS                           00002403
//LKED     EXEC  PGM=IEWL,REGION=256K,COND=(4,LT,ASM),                  00002500
//         PARM='LIST,MAP,LET,AC=1,RENT,REUS,REFR'                      00002600
//SYSPRINT DD  SYSOUT=&CLASS                                            00002700
//SYSUT1   DD  SPACE=(CYL,(10,10)),UNIT=&WORK2                          00002800
//SYSLIB   DD  DSN=SYS2.LINKLIB,DISP=SHR                                00002901
//SYSLMOD  DD  DSN=&LOAD.(&MEM),DISP=SHR                                00003000
//SYSLIN   DD  DSN=&&INDXOBJ,DISP=(OLD,PASS)                            00003100
//         DD  DDNAME=SYSIN                                             00003200
//       PEND                                                           00003300
//RACUPDT EXEC PGM=IEBUPDTE                                             00003402
//SYSUT1   DD  DISP=SHR,DSN=SYS2.ASM                                    00003502
//SYSUT2   DD  DISP=(,PASS),UNIT=VIO,DSN=&&SHOWSS,                      00003603
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)   00003702
//SYSPRINT DD  SYSOUT=*                                                 00003802
//SYSIN    DD  DISP=SHR,DSN=SYS2.ASM(SHSSUPD)                           00003902
//ASMFCL      EXEC ASMFCL,MEM=SHOWSS                                    00004000
//LKED.SYSIN  DD   *                                                    00004100
  NAME SHOWSS(R)                                                        00004200
/*                                                                      00004300
