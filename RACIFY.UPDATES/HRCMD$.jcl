//HRCMD    JOB (TK4SETUP),
//             'Build BSPHRCMD',
//             CLASS=A,
//             MSGCLASS=X,
//             NOTIFY=VOLKER,
//             MSGLEVEL=(0,0)
//********************************************************************
//*                                                                  *
//*  Name: SYS2.CNTL(HRCMD$)                                         *
//*                                                                  *
//*  Type: Assembly of BSPHRCMD Module                               *
//*                                                                  *
//*  Desc: Run Hercules Command from PARM or SYSIN                   *
//*                                                                  *
//********************************************************************
//RACUPDT EXEC PGM=IEBUPDTE
//SYSUT1   DD  DISP=SHR,DSN=SYS2.ASM
//SYSUT2   DD  DISP=(,PASS),UNIT=VIO,
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120)
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  DISP=SHR,DSN=SYS2.ASM(BSPHRUPD)
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
//SYSLMOD  DD  DISP=SHR,DSN=SYS2.LINKLIB(BSPHRCMD) <<=== CHANGE¦
//SYSLIN   DD  DISP=(OLD,DELETE),DSN=*.ASM.SYSPUNCH
//DBRESET EXEC DBRESET
