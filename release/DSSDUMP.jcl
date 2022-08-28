//DSSDUMP JOB (JOB),
//             'INSTALL DSSDUMP',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,
//             PASSWORD=SYS1
//*
//* THIS JCL WAS GENERATED AUTOMATICALLY BY make_release.sh
//*
//RACUPDT EXEC PGM=IEBGENER
//SYSUT1   DD  DATA,DLM=@@
DSSDUMP  TITLE 'D S S D U M P  ***  DATA SET DUMP IN ADRDSSU FORMAT'    00010000
         PUNCH '   SETCODE AC(1) '                                      00020000
         PUNCH ' ORDER DSSDUMP(P) '   ***** MAKE DUMPS EASIER *****     00030000
         SPACE 1                                                        00040000
         COPY  OPTIONGB                                                 00050000
         SPACE 1                                                        00060000
         SYSPARM LIST=YES    SET LOCAL OPTIONS                          00070000
         SPACE 1                                                        00080000
*********************************************************************** 00090000
*                                                                     * 00100000
*    DSSDUMP - QUICK AND DIRTY SUBSTITUTE FOR MVS 3.8J USERS          * 00110000
*                                                                     * 00120000
*    PROGRAM IS AUTHORIZED, AND REENTRANT (but not all subroutines)   * 00130000
*    REQUIRED DD CARDS:                                               * 00140000
*      SYSPRINT - PROCESSING LOG                                      * 00150000
*      SYSIN    - REQUESTS:                                           * 00160000
*             Note that all reserved words may be abbreviated to the  * 00170000
*             first three characters (e.g., OPT for OPTIONS)          * 00180000
*        OPTIONS {ENQ,NOENQ,TEST,DEBUG,NODEBUG}   <anwhere in SYSIN>  * 00190000
*                {ALLDATA,EXPORT,LIST,SHOW}       <anwhere in SYSIN>  * 00200000
*             ENQ       issues an exclusive ENQ TEST for each data    * 00210000
*                       set. Dump continues if DS not available,      * 00220000
*                       and issues RC=4. Applies from prior DUMP on.  * 00230000
*             NOENQ     (default). Dumps DS as is.                    * 00240000
*             ALLDATA | ALLEXCP   Causes all tracks, including unused * 00250000
*                       ones, to be written out. May be needed to     * 00260000
*                       recover from invalid, non-zero LSTAR.         * 00270000
*                       This option also preserves LABEL=SUL data.    * 00280000
*             EXPORT    modifies the output DSCB1 by removing any     * 00290000
*                       expiration date and password flags.           * 00300000
*             TEST      bypasses all TAPE output. Note that file has  * 00310000
*                       been opened already, and will be empty.       * 00320000
*             DEBUG     -not implemented-                             * 00330000
*             NODEBUG   -not implemented-                             * 00340000
*             LIST | SHOW   - display current OPTION settings.        * 00350000
*        INCLUDE mask | DUMP mask - one or more dump requests per run * 00360000
*             mask      specifies a data set name (unquoted). If it   * 00370000
*                       contains an asterisk, question mark, or       * 00380000
*                       percent sign, it is treated as a mask.        * 00390000
*                       A name ending in a period is treated as a     * 00400000
*                       mask followed by an implied **                * 00410000
*                       In MVS (VSAM catalog), the first index level  * 00420000
*                       may not contain a mask character. Also note   * 00430000
*                       that VSAM catalog processing does not support * 00440000
*                       detection or processing of alias entries.     * 00450000
*                       Note that a percent sign is treated as a      * 00460000
*                       positional mask (one to one correspondence    * 00470000
*                       of characters/mask to dsname).                * 00480000
*                       Any number of DUMP cards may be used in a run * 00490000
*                       but only about 700 data sets will fit in the  * 00500000
*                       name table (assembly option)                  * 00510000
*        DUMP mask VOLUME(serial)   Processes matching data sets on   * 00520000
*                       that volume serial only. If this results in   * 00530000
*                       duplicate data set names, a .D#nnnnnn is      * 00540000
*                       appended to duplicates on higher volume       * 00550000
*                       serials (i.e., the cataloged entry may be the * 00560000
*                       one that gets renamed). Masking bytes are     * 00570000
*                       valid in any position in the mask.            * 00580000
*        EXCLUDE mask        (optional) follows relevant DUMP card    * 00590000
*             mask      as above. Excludes matching data sets chosen  * 00600000
*                       by the previous DUMP/INCLUDE/SELECT card.     * 00610000
*        PREFIX name    causes all data set names to be prefixed by   * 00620000
*                       the specified text string. It is not required * 00630000
*                       to be an index level (e.g., SYS9.), but if    * 00640000
*                       not, generated names may be syntactically     * 00650000
*                       invalid. Result names are truncated to 44     * 00660000
*                       characters, and a trailing period is blanked. * 00670000
*                       Only one PREFIX card may be used per run,     * 00680000
*                       and it is mutually exclusive of RENAME and    * 00690000
*                       STRIP options.                                * 00700000
*        STRIP name     The specified string is removed from any DSN  * 00710000
*                       where it is found. Multiple STRIP and RENAME  * 00720000
*                       requests are supported (up to 16; ASM option) * 00730000
*        RENAME oldname newname   The specified string is replaced in * 00740000
*                       any DSN found and replaced by prefix newname. * 00750000
*                       Up to 16 RENAME and STRIP requests are legal. * 00760000
*                       All strings in PREFIX/RENAME/STRIP are        * 00770000
*                       limited to 23 characters (assembly option).   * 00780000
*                                                                     * 00790000
*      TAPE     - UNIT,DSN,VOLSER - dump tape(s) - in DSS format,     * 00800000
*                            uncompressed; TEST assumed if missing.   * 00810000
*        RECFM=U, BLKSIZE=65520 is the default for tape output.       * 00820000
*        RECFM=U  7892<block size<65520 is supported.                 * 00830000
*        RECFM=V  is supported, with blocks 7900<block size<32760     * 00840000
*                                                                     * 00850000
*        For DASD output, the range is 7892<data size<32760, with     * 00860000
*        the default being either the track size (if >=7892) or the   * 00870000
*        half-track size for modulo devices.                          * 00880000
*                                                                     * 00890000
*      PARM=EXPORT is the only supported PARM OPTION at present.      * 00900000
*                                                                     * 00910000
*                                                                     * 00920000
*    DSSDUMP MAY BE INVOKED AUTHORIZED FROM ANOTHER AUTHORIZED        * 00930000
*    PROGRAM, USING A PARM, AND A DD NAME LIST OVERRIDE:              * 00940000
*                                                                     * 00950000
*    LA   R1,PARMDD          COMBINED LIST                            * 00960000
*    LINK/ATTACH/SYNCH/L =V,BALR  etc. to invoke                      * 00970000
*                                                                     * 00980000
*    PARMDD  DC  A(PARMFLD),X'80',AL3(DDNMLST)                        * 00990000
*    PARMFLD DC  AL2(L'TEXT),C'parm text'                             * 01000000
*    DDNMLST DC  AL2(L'DDN),CL8'SYSIN',CL8'SYSPRINT',CL8'TAPE'        * 01010000
*        unwanted override positions may be blank or zero             * 01020000
*                                                                     * 01030000
*********************************************************************** 01040000
*                                                                     * 01050000
*   The mapping in the DSSBLOCK DSECT adapted from material supplied  * 01060000
*   by Charlie, the DSSREST author, at OS_390@hotmail.com             * 01070000
*                                                                     * 01080000
*********************************************************************** 01090000
*                                                                     * 01100000
*        COPYRIGHT 2009  EXPERT SYSTEM PROGRAMMING                    * 01110000
*                        176 OLD STAGE COACH ROAD                     * 01120000
*                        BRADFORD, VT 05033-8844                      * 01130000
*                        gerhard@valley.net                           * 01140000
*                    ALL RIGHTS RESERVED                              * 01150000
*                                                                     * 01160000
*   Not-for-profit use permitted, and distribution rights granted to  * 01170000
*   Hercules and CBT projects.                                        * 01180000
*********************************************************************** 01190000
*                                                               JW12114 01191000
*  Updated 23APR12 - Authorization through RAC added.           JW12114 01192000
*    On systems with resource access control active DSSDUMP     JW12114 01193000
*    executes only if the caller has read access to profile     JW12114 01194000
*    DSSAUTH in the FACILITY class.                             JW12114 01195000
*                                                               JW12114 01196000
*************************************************************** JW12114 01197000
         PRINT &PRTSOR                                                  01200000
DSSDUMP  PGMHEAD ZERO31,BASE=(R11,R12),PARM=R9,BNDRY=PAGE,AM=24,RM=24   01210000
         L     R10,=A(DSSDUMPD)   GET SUBROUTINES AND STATIC DATA       01220000
         USING DSSDUMPD,R10  DECLARE SUBROUTINE AREA                    01230000
         MVC   DYNIOWK(DYNIOLEN),PATIOWK    INIT I/O WORK AREAS GP09194 01240000
         TM    0(R9),X'80'   NORMAL OS PARM ?                   GP09194 01250000
         BNZ   SKIPORID      YES; NO DD NAME LIST               GP09194 01260000
         L     R14,0(,R1)    LOAD PARM POINTER                  GP09247 01270000
         CLI   2(R14),0      POSSIBLE TSO CP PARM ?             GP09247 01280000
         BE    SKIPORID      YES; NO DD NAME LIST               GP09247 01290000
         L     R1,4(,R9)     GET DD NAME LIST                   GP09194 01300000
         LA    R1,0(,R1)     CLEAN                              GP09194 01310000
         LTR   R1,R1         TEST                               GP09194 01320000
         BZ    SKIPORID      NULL LIST                          GP09194 01330000
         LH    R15,0(,R1)    GET PURPORTED LENGTH               GP09194 01340000
         LTR   R15,R15       NULL OR INVALID ?                  GP09194 01350000
         BM    BADPARM       INVALID                            GP09194 01360000
         BZ    SKIPORID      NULL LIST                          GP09194 01370000
         CH    R15,=H'24'    ROOM FOR THREE NAMES?              GP09194 01380000
         BL    TWOORID       NO                                 GP09194 01390000
         CLI   18(R1),C' '   ANYTHING THERE ?                   GP09194 01400000
         BNH   TWOORID       NO; IGNORE                         GP09194 01410000
         MVC   SYSDDNM,18(R1)   MOVE TAPE DD OVERRIDE           GP09194 01420000
TWOORID  CH    R15,=H'16'    ROOM FOR TWO NAMES?                GP09194 01430000
         BL    ONEORID       NO                                 GP09194 01440000
         CLC   10(8,R1),ZEROES  ANYTHING THERE ?                GP09194 01450000
         BE    ONEORID       NO; IGNORE                         GP09194 01460000
         CLC   10(8,R1),BLANKS  ANYTHING THERE ?                GP09194 01470000
         BE    ONEORID       NO; IGNORE                         GP09194 01480000
         MVC   SYSPRINT(8),10(R1)   MOVE SYSPRINT DD OVERRIDE   GP09194 01490000
ONEORID  CH    R15,=H'8'     ROOM FOR ONE NAME ?                GP09194 01500000
         BL    SKIPORID      NO                                 GP09194 01510000
         CLC   10(8,R1),ZEROES  ANYTHING THERE ?                GP09194 01520000
         BE    SKIPORID      NO; IGNORE                         GP09194 01530000
         CLC   10(8,R1),BLANKS  ANYTHING THERE ?                GP09194 01540000
         BE    SKIPORID      NO; IGNORE                         GP09194 01550000
         MVC   SYSIN(8),2(R1)   MOVE SYSIN DD OVERRIDE          GP09194 01560000
         B     SKIPORID      RESUME NORMAL CODE                 GP09194 01570000
BADPARM  WTO   'DSSDUMP: INVALID PARM OR DD NAME LIST'          GP09194 01580000
         ABEND 1234,DUMP                                        GP09194 01590000
         SPACE 1                                                        01600000
SKIPORID PARMLOAD R8         LOOK AT PARM FIELD                 GP09247 01610000
         LTR   R9,R9         ANY TEXT?                          GP09247 01620000
         BNP   DONEPARM      USE IT                             GP09197 01630000
SKIPPRLP CLI   0(R8),C' '    CP SPACER ?                        GP09247 01640000
         BNE   SKIPPRCM      NO                                 GP09197 01650000
         LA    R8,1(,R8)     SKIP ONE SPACER                    GP09197 01660000
         BCT   R9,SKIPPRLP   TRY AGAIN                          GP09247 01670000
SKIPPRCM CH    R9,=H'6'      PARM=EXPORT ?                      GP09197 01680000
         BL    FAILPARM      NO; IGNORE                         GP09197 01690000
         OI    OPTFLAGS,FGEXP     (PRE)SET FOR EXPORT           GP09197 01700000
         CLC   =C'EXPORT',0(R8)  REALLY EXPECTED PARM?          GP09197 01710000
         BE    DONEPARM      USE IT                             GP09197 01720000
FAILPARM WTO   'DSSDUMP: INVALID PARM IGNORED'                  GP09197 01730000
         SPACE 1                                                        01740000
DONEPARM LA    R8,RECREC     USE RECORD AREA IN MACRO EXPANSION         01750000
         USING CELLSECT,R8   DECLARE IT                                 01760000
         SERVINIT ,          INITIALIZE SUPPORT SERVICES                01770000
         SERVLOAD @INPREAD,@PARSER,@PRINTER              DYNAMIC        01780000
         SERVLOAD SUBCAT,SUBCOMP,SUBTREE,SUBVERB,SUBVTVAL,LFETCH=LINK   01790000
         MVC   #SUBCAT,@SUBCAT    COPY                                  01800000
         MVC   #SUBCOMP,@SUBCOMP  COPY                                  01810000
         PRTOPEN SYSPRINT,OPT=(ABEND,WTO)   MUST HAVE                   01820000
         PRTL  '#  Version 0.97       DSS Format Data Set Dump',TITLE=1 01830000
*DEFER*  BANDAID INIT        *****DEBUG*****                            01840000
*DEFER*  BANDAID SPIE        *****DEBUG*****                            01850000
*---------------------------------------------------------------------* 01860000
*   WE NEED TO RUN AUTHORIZED FOR @VOLREAD'S DEB USE                  * 01870000
*---------------------------------------------------------------------* 01880000
         TESTAUTH FCTN=1     ARE WE AUTHORIZED ?                        01890000
         BXLE  R15,R15,CHECKRAC YES; check user authorization   JW12114 01900000
ABEND    PRTL  '*** DSSDUMP must run authorized ***'            JW12114 01906000
         PRTCLOSE ,                                                     01920000
         ABEND 047,DUMP                                                 01930000
         SPACE 1                                                        01940000
*---------------------------------------------------------------------* 01950000
*   @VOLREAD USES A //VOLMOUNT DD DUMMY.  IF USER DIDN'T SUPPLY,      * 01960000
*     WE BUILD ONE HERE, BUT NEVER UNALLOCATE IT.                     * 01970000
*---------------------------------------------------------------------* 01980000
HAVEAUTH SERVCALL TIODD,DCVOLMNT  DID USER SUPPLY A VOLMOUNT DD ?       01990000
         LTR   R0,R0         ANY ADDRESS RETURNED ?                     02000000
         BNZ   HAVEVMNT                                                 02010000
         MVC   BUFTAPE(PATALLEN),PATALLOC   COPY ALLOCATION REQUEST     02020000
         LA    R1,BUFTAPE    POINT TO IT                                02030000
         ST    R1,DB                                                    02040000
         OI    DB,X'80'                                                 02050000
         LA    R1,DB         PASS PRB                                   02060000
         DYNALLOC ,          ALLOCATE IT                                02070000
*   NOTE THAT I NEVER UNALLOCATE - TOO BAD                              02080000
         LTR   R15,R15                                                  02090000
         BZ    HAVEVMNT      SUCCESSFUL                                 02100000
         ST    R15,DB                                                   02110000
         PRTL  '*** No VOLMOUNT DD DUMMY found ***',NL,CC=NO            02120000
 PRTDATA '*** Dynamic Allocation failed: R15=',(DB,I,PADR),' Reason=',(*02130000
               BUFTAPE+4,2,HEX,PADR),' Info=',(BUFTAPE+6,2,HEX)         02140000
         SPACE 1                                                        02150000
*---------------------------------------------------------------------* 02160000
*   WE NEED TO KEEP THE FILE INFORMATION IN ORDER BY VOLUME SERIAL    * 02170000
*     AND DSNAME (PROCESSING ALL FILES PER VOLUME IS FASTER)          * 02180000
*   RATHER THAN SORTING STUFF, WE USE TREE ALGORITHM, BASED ON ONE    * 02190000
*   IN DONALD KNUTH'S ART OF COMPUTER PROGRAMMING, VOLUME 3.          * 02200000
*---------------------------------------------------------------------* 02210000
HAVEVMNT MVC   ROOTBALL(RECSIZE),ROOTPATT   INIT TREE STUMP             02220000
         SUBCALL INITREE     BUILD THE DUMP REQUEST TREE                02230000
         LTR   R15,R15       GOOD ?                                     02240000
         BZ    HAVETREE      OK                                         02250000
         PRTDATA '*** Fatal error - SUBTREE routine failed ***'         02260000
         B     PGMEXIT8      NO; QUIT                                   02270000
         SPACE 2                                                        02280000
*---------------------------------------------------------------------* 02290000
*   INITIALIZE THE @VOLREAD ROUTINE. WE DO THIS NOW TO AVOID          * 02300000
*     STORAGE FRAGMENTATION PROBLEMS LATER.                           * 02310000
*---------------------------------------------------------------------* 02320000
HAVETREE VOLREAD LOAD        LOAD THE VOLUME READ ROUTINE               02330000
         SPACE 1                                                        02340000
*---------------------------------------------------------------------* 02350000
*   OUTPUT GOES TO DDNAME TAPE. IF MISSING, WE RUN IN TEST MODE ONLY. * 02360000
*   1) SET DEFAULT BUFFER OF 65520 {<=32760 FOR DASD & RECFM=V(B)}    * 02370000
*   2) GET THE TIOT ENTRY AND CHECK THE UNIT TYPE                     * 02380000
*   3) GET THE JFCB - FAIL INVALID RECFM; ACCEPT BLKSIZE= OVERRIDE    * 02390000
*   4) USE EXCP FOR TAPE, AND BSAM FOR DASD                           * 02400000
*   5) BUILD APPROPRIATE CONTROL BLOCKS                               * 02410000
*   6) FOR BSAM OPEN, ALLOW JFCB/DSCB MERGE BLKSIZE OVERRIDE.         * 02420000
*   7) SET BLKSIZE DEPENDENT VALUES                                   * 02430000
*   N.B. ADRDSSU REQUIRES 7892 AS A MINIMUM SIZE                      * 02440000
MINBLOCK EQU   7892          SO WE SET IT HERE                  GP09207 02450000
*---------------------------------------------------------------------* 02460000
         LA    R3,BUFTAPE    GET TAPE OUTPUT BUFFER                     02470000
         ST    R3,@BUF       SAVE BUFFER START                          02480000
         ST    R3,@BUFCUR    SAVE AVAILABLE ADDRESS                     02490000
         L     R4,=A(65520)  GET MAXIMUM BUFFER SIZE                    02500000
         ST    R4,#BUFMAX    PROVISIONALLY SAVE MAXIMUM BUFFER SIZE     02510000
         LA    R0,BUFTAPE(R4)     PHYSICAL MEMORY LIMIT                 02520000
         ST    R0,@MEMEND    SAVE FOR DSN TABLE                         02530000
         SERVCALL TIODD,SYSDDNM   FIND TAPE DD                  GP09194 02540000
         LTR   R2,R0         FOUND IT ?                                 02550000
         BZ    TAPEDDNO      NO                                         02560000
         USING TIOENTRY,R2   DECLARE IT                         GP09207 02570000
         SERVCALL RJFCB,SYSDDNM   LOOK FOR JFCB                 GP09194 02580000
         BXH   R15,R15,TAPEDDNO                                         02590000
         USING INFMJFCB,R1                                      GP09207 02600000
         SR    R14,R14                                                  02610000
         ICM   R14,3,JFCLRECL     CHECK LRECL                   GP09207 02620000
         ICM   R15,3,JFCBLKSI     CHECK BLOCK SIZE              GP09207 02630000
         MVC   DUMPDSN,JFCBDSNM   SAVE FOR VALIDITY CHECK       GP09317 02640000
         MVC   DUMPVOL,JFCBVOLS     (CAN'T DUMP OPEN DS)        GP09317 02650000
         CLI   JFCRECFM,0         UNSPECIFIED? -> U             GP09207 02660000
         BE    TAPERFUU                                                 02670000
         CLI   JFCRECFM,X'C0'     RECFM=U ?                     GP09207 02680000
         BE    TAPERFUU                                                 02690000
         TM    JFCRECFM,255-(DCBRECV+DCBRECBR+DCBRECSB) V(B)(S) GP09207 02700000
         BZ    TAPERFVV      NO                                         02710000
         DROP  R1                                               GP09207 02720000
 PRTDATA '*** Output DD',(SYSDDNM,DEB,PAD),'RECFM= not supported ***'   02730000
         B     PGMEXIT8                                                 02740000
TAPERFVV MINH  R4,=H'32760'  SET RECFM=V DATA MAXIMUM                   02750000
         OI    OPTFLAGS,FGVAR     SET VARIABLE MODE                     02760000
         LTR   R14,R14       ANY RECORD LENGTH?                         02770000
         BZ    TAPERVNL      NO                                         02780000
         LA    R14,4(,R14)   ALLOWANCE FOR RDW                          02790000
TAPERVNL LTR   R15,R15       ANY BLOCK SIZE ?                           02800000
         BZ    TAPELROK      NO; USE DEFAULT                            02810000
         LTR   R14,R14       ANY RECORD LENGTH?                         02820000
         BZ    TAPELROK      NO                                         02830000
         MIN   R15,(R14)     USE SMALLER VALUE                          02840000
         B     TAPELROK                                                 02850000
TAPERFUU LTR   R14,R14       ANY LRECL ?                                02860000
         BZ    TAPELROK                                                 02870000
         CR    R14,R15       SAME AS BLOCK SIZE?                        02880000
         BE    TAPELROK                                                 02890000
 PRTDATA '*** Output DD',(SYSDDNM,DEB,PAD),'LRECL ignored ***'          02900000
TAPELROK LTR   R15,R15       ANY BLOCK SIZE ?                           02910000
         BZ    TAPEDFLT                                                 02920000
         MIN   R4,(R15)      USE SMALLER VALUE                          02930000
TAPEDFLT ICM   R6,7,TIOEFSRT      GET UCB                       GP09207 02940000
         BZ    TAPEDDNO      NONE                                       02950000
         DROP  R2            DONE WITH TIOT                     GP09207 02960000
         USING UCBOB,R6      HAVE UCB                           GP09207 02970000
         CLI   UCBTBYT3,UCB3TAPE                                GP09207 02980000
         BE    TAPEDDEX      REALLY TAPE                                02990000
         MINH  R4,=H'32760'  SET DASD MAXIMUM                           03000000
         CLI   UCBTBYT3,UCB3DACC  DASD ?                        GP09207 03010000
         BNE   TAPENU        ELSE DEVICE TYPE UNSUPPORTED               03020000
         IC    R15,UCBTBYT4  GET DEVICE TYPE                    GP09207 03030000
         N     R15,=X'0000000F'             MASK WHAT I KNOW            03040000
         BZ    TAPENU        ?                                          03050000
         SLL   R15,1         CONVERT TO HALFWORD OFFSET                 03060000
         LH    R1,DASDSIZE-2(R15)           GET PREFERRED VALUE         03070000
         CH    R1,=AL2(MINBLOCK)  TOO SMALL FOR MINIMUM?        GP09207 03080000
         BL    DASD2WEE      YES; REGRETS                       GP09207 03090000
         MIN   (R4),(R1)     USE SMALLER OF DEFAUT OR JFCB      GP09201 03100000
         MVC   TAPEDCB(TAPELEN),PATTAPE   INIT TAPE DCB                 03110000
         MVC   DCBDDNAM-IHADCB+TAPEDCB(8),SYSDDNM  UPDATE DDN   GP09194 03120000
 PRTDATA '   === Using BSAM mode for output DD',(SYSDDNM,DEB,PAD),'===' 03130000
         B     TAPEDDCM      YES; PROCEES                               03140000
         SPACE 1                                                        03150000
DASD2WEE PRTDATA '*** Output DD',(SYSDDNM,DEB,PAD),'not supported due t*03160000
               o small track size ***'                          GP09207 03170000
         B     PGMEXIT8                                         GP09207 03180000
         SPACE 1                                                        03190000
DASDSIZE DC    H'3625,20483,4892,27998,6144,14136,14660,7294' 2311-2314 03200000
         DC    H'13030,8368,19069,17600,13030,23476,27998' 3330-3390    03210000
         SPACE 1                                                        03220000
TAPENU PRTDATA '*** Output DD',(SYSDDNM,DEB,PAD),'neither TAPE nor DASD*03230000
                - TEST mode forced ***'                                 03240000
         OI    OPTFLAGS,FGTEST    SET TEST MODE                         03250000
         B     TAPEDDCM                                                 03260000
         DROP  R6                                               GP09207 03270000
TAPEDDEX MVC   TAPEDCB(TAPEXLEN),PATEXCP   INIT FOR EXCP MODE           03280000
         MVC   DCBDDNAM-IHADCB+TAPEDCB(8),SYSDDNM  UPDATE DDN   GP09194 03290000
         XC    DUMPVOL,DUMPVOL    INVALIDATE DUMP DSN CHECK     GP09317 03300000
         LA    R2,TAPEIOB    FOR EASIER SETTINGS                        03310000
         USING IOBSTDRD,R2                                              03320000
         MVI   IOBFLAG1,IOBDATCH+IOBCMDCH   COMMAND CHAINING IN USE     03330000
         MVI   IOBFLAG2,IOBRRT2                                         03340000
         LA    R1,TAPEECB                                               03350000
         ST    R1,IOBECBPT                                              03360000
         LA    R1,TAPECCW                                               03370000
         ST    R1,IOBSTART   CCW ADDRESS                                03380000
         ST    R1,IOBRESTR   CCW ADDRESS                                03390000
         LA    R1,TAPEDCB                                               03400000
         ST    R1,IOBDCBPT   DCB                                        03410000
         LA    R0,1          SET BLOCK COUNT INCREMENT                  03420000
         STH   R0,IOBINCAM                                              03430000
         DROP  R2                                                       03440000
         MVC   TAPECCW+1(3),@BUF+1  WRITE FROM BUFFER                   03450000
         TM    OPTFLAGS,FGTEST    SET TEST MODE                         03460000
         BNZ   TAPEDDCM                                                 03470000
 PRTDATA '   === Using EXCP mode for output DD',(SYSDDNM,DEB,PAD),'===' 03480000
         B     TAPEDDCM                                                 03490000
TAPEDDNO PRTDATA '*** Output DD',(SYSDDNM,DEB,PAD),'not found - running*03500000
                in TEST mode ***'                                       03510000
         OI    OPTFLAGS,FGTEST    SET TEST MODE                         03520000
TAPEDDCM ST    R4,#BUFMAX    SAVE MAXIMUM BUFFER SIZE                   03530000
         CH    R4,=AL2(MINBLOCK)   IS ADRDSSU MINIMUM?          GP09207 03540000
         BNL   TAPEGBLK      YES                                        03550000
 PRTDATA '*** Output block size',(#BUFMAX,I,PAD),'too small ***'        03560000
         B     PGMEXIT8                                                 03570000
TAPEGBLK TM    OPTFLAGS,FGTEST    SET TEST MODE                         03580000
         BNZ   TAPESETZ      DONE WITH TAPE; BUILD SIZES                03590000
         MVI   OCLIST,X'8F'  OPEN OUTPUT                                03600000
         LA    R2,TAPEDCB    POINT TO DCB                               03610000
         OPEN  ((R2),OUTPUT),MF=(E,OCLIST)  OPEN TAPE                   03620000
         TM    DCBOFLGS-IHADCB(R2),DCBOFOPN                             03630000
         BNZ   TAPEIMRG      CHECK FOR OPEN EXIT UPDATE                 03640000
     PRTL  '*** Output DD won''t open - running in TEST mode ***',CC=NO 03650000
         OI    OPTFLAGS,FGTEST    SET TEST MODE                         03660000
         B     TAPESETZ                                                 03670000
TAPEIMRG TM    DCBMACR1-IHADCB+TAPEDCB,DCBMRECP  EXCP MODE?             03680000
         BNZ   TAPESETZ      USING EXCP                                 03690000
         TM    DCBRECFM-IHADCB+TAPEDCB,X'80'     RECFM=U ?              03700000
         BNZ   TAPESETZ                                                 03710000
         OI    OPTFLAGS,FGVAR     RECFM=V                               03720000
         SPACE 1                                                        03730000
TAPESETZ L     R4,#BUFMAX    GET MERGED SIZE                            03740000
         TM    OPTFLAGS,FGVAR     USING RECFM=V?                        03750000
         BZ    TAPESETX      NO                                 GP09201 03760000
         SH    R4,=H'8'      ALLOW FOR BDW AND RDW                      03770000
TAPESETX L     R3,@BUF                                                  03780000
         AR    R3,R4         GET END ADDRESS                            03790000
         ST    R3,@BUFEND    AND SAVE IT                                03800000
         LR    R15,R4        COPY BUFMAX                                03810000
         SH    R15,=AL2(DTPSIZE)  CONTROL BLOCK OVERHEAD                03820000
         ST    R15,#DATMAX   MAX DATA PER BLOCK                         03830000
    PRTDATA '   === Data block size adjusted to',(#BUFMAX,I,PAD),'==='  03840000
         SPACE 2                                                        03850000
*---------------------------------------------------------------------* 03860000
*   READ A RECORD FROM SYSIN. ABEND 2540 IF NOT SUPPLIED.             * 03870000
*   READ CARDS UNTIL A DUMP TYPE IS FOUND (DUMP/INCLUDE/SELECT)       * 03880000
*     IF SO, PUT THE CURRENT CARD BACK ON THE STACK, AND PROCESS      * 03890000
*     PREVIOUS REQUEST.                                               * 03900000
*   ECHO CARD AS APPROPRIATE                                          * 03910000
*---------------------------------------------------------------------* 03920000
         INPOPEN SYSIN,OPT=(ABEND,FOLD)     UPPER-CASE INPUT            03930000
         SPACE 2                                                        03940000
CARDNEXT INPGET ,            CONTROL CARD LOOP                          03950000
         BXH   R15,R15,CARDEOD   TREAT ERROR AS EOF                     03960000
         LR    R7,R0         COPY INPUT LENGTH                          03970000
         LR    R6,R1         COPY INPUT ADDRESS                         03980000
         LR    R3,R7         PRESERVE CARD LENGTH                       03990000
         MINH  R3,=H'72'     IGNORE SEQUENCE NUMBERS                    04000000
         MVI   PAR$RQFG,PAR$PARK+PAR$COUQ+PAR$COUP                      04010000
         PARSE (R6),(R3),OPT=KEYWORD                                    04020000
         LTR   R15,R15                                                  04030000
         BNZ   PARSFAIL                                                 04040000
         TM    PROFLAGS,PFGDUMP   DUMP PENDING ?                        04050000
         BZ    CARDPRNT           NO; OK TO PRINT                       04060000
         ICM   R3,15,PAR@TABL                                           04070000
         BZ    CARDPRNT      ALL BLANK                                  04080000
         USING PRSDSECT,R3   DECLARE RESULT LIST                        04090000
         LA    R0,PRS$TEXT   VERB TO BE LOCATED                         04100000
         LA    R1,WAITBXLE   DEFER PRINT ?                              04110000
         SUBCALL SUBVERB                                                04120000
         LTR   R15,R15       DID IT WORK ?                              04130000
         BNZ   CARDNPRT      YES; SKIP PRINT                            04140000
CARDPRNT PRTDATA (' --> ''',NL),(0(R6),(R7)),''''                       04150000
CARDNPRT ICM   R3,15,PAR@TABL                                           04160000
         BZ    CARDNEXT      ALL BLANK                                  04170000
         CLI   PRS$TEXT,C'*'  COMMENT CARD ?                            04180000
         BE    CARDNEXT      YES; JUST GET ANOTHER                      04190000
         LA    R0,PRS$TEXT   VERB TO BE LOCATED                         04200000
         LA    R1,VERBBXLE   VERB TABLE                                 04210000
         SUBCALL SUBVERB                                                04220000
         LTR   R15,R15       DID IT WORK ?                              04230000
         BNZR  R1            YES; INVOKE MATCHING ADDRESS               04240000
         SPACE 1                                                        04250000
PARSBCD  PRTL  ' *** UNRECOGNIZED CONTROL CARD ***'                     04260000
         OICC  4,4,RESULT=RETCODE                                       04270000
         B     CARDNEXT      GET ANOTHER CARD                           04280000
         SPACE 1                                                        04290000
PARSFAIL OICC  12                                                       04300000
         PRTL  '0*** Unexpected PARSER failure ***'                     04310000
         PRTCLOSE ,          WRITE MESSAGE BEFORE DUMP                  04320000
         ABEND 666,DUMP                                                 04330000
         SPACE 1                                                        04340000
VERBBXLE PARKEYBX VERBTAB    DEFINE PARM VALUES                         04350000
         SPACE 1                                                        04360000
WAITBXLE PARKEYBX WAITTAB    DEFINE PARM VALUES                         04370000
WAITTAB  PARKEYAD 'INCLUDE ',SETDUMP   SPECIFY DS MASK                  04380000
WAITTAB2 PARKEYAD 'SELECT  ',SETDUMP   SPECIFY DS MASK                  04390000
         PARKEYAD 'DUMP    ',SETDUMP   BEGIN DS SELECTION               04400000
WAITTABN PARKEYAD 'COPY    ',SETDUMP   BEGIN DS SELECTION               04410000
         SPACE 1                                                        04420000
SETALLTK OI    OPTFLAGS,FGADAT   DUMP ALL ALLOCATED TRACKS              04430000
    PRTL  ' ***** All allocated tracks will be dumped *****',MODE=DEBUG 04440000
         B     CARDNEXT      NEXT CARD                                  04450000
         SPACE 1                                                        04460000
SETBUGON OI    OPTFLAGS,FGBUG  SET DEBUG MODE ON                        04470000
         PRTL  ' ***** Debug mode now on *****',MODE=DEBUG              04480000
         B     CARDNEXT      NEXT CARD                                  04490000
         SPACE 1                                                        04500000
SETBUGOF NI    OPTFLAGS,255-FGBUG  SET DEBUG MODE OFF                   04510000
         PRTL  ' ***** Debug mode now off *****',MODE=DEBUG             04520000
         B     CARDNEXT      NEXT CARD                                  04530000
         SPACE 1                                                        04540000
SETTSTON OI    OPTFLAGS,FGTEST   SET TAPE OUTPUT INHIBITED              04550000
         PRTL  ' ***** Output inhibited *****',MODE=DEBUG               04560000
         B     CARDNEXT      NEXT CARD                                  04570000
         SPACE 1                                                        04580000
*---------------------------------------------------------------------* 04590000
*   SAVE RENAME/PREFIX DATA.                                          * 04600000
*     PREFIX index.          ALL DATA SET NAMES PREFIXED WITH .index  * 04610000
*     RENAME oldpfx. newpfx.   OLD PREFIX REPLACED BY NEW ONE.        * 04620000
*   NOTE THAT RENAME MAY NOT BE USED WHEN PREFIX IS SPECIFIED         * 04630000
*   IF newpfx. IS OMITTED, oldpfx. IS STRIPPED AND NOT REPLACED       * 04640000
*   A MAXIMUM OF MAXPFX RENAME CARDS MAY BE USED IN ONE RUN           * 04650000
*---------------------------------------------------------------------* 04660000
         SPACE 1                                                        04670000
SETPFX   ICM   R3,15,PRSLINK      GET SECOND OPERAND            GP09197 04680000
         BZ    OPMISS                                           GP09197 04690000
         L     R0,PRS#TEXT        GET LENGTH                    GP09197 04700000
         CL    R0,=A(L'PFXNEW)    VALID ?                       GP09197 04710000
         BH    OP2LONG            NO                            GP09197 04720000
         OC    PRS$TEXT,BLANKS    UPPER-CASE                    GP09197 04730000
         SPACE 1                                                GP09197 04740000
         XC    PFXOLDL(PFXLEN),PFXOLDL   CLEAR RENAME STUFF     GP09197 04750000
         STC   R0,PFXNEWL         SAVE TEXT LENGTH              GP09197 04760000
         MVC   PFXNEW,PRS$TEXT    SAVE PREFIX TO BE DELETED     GP09197 04770000
         OI    PROFLAGS,PFPREF    SHOW PREFIX FOUND             GP09197 04780000
         ICM   R15,15,NUMPFX      OTHER PREFIX REQUESTS?        GP09197 04790000
         BZ    SETPFXCT           NO; SET ONE                   GP09197 04800000
         PRTV  MSGEXPFX           SHOW ERROR                    GP09197 04810000
         OICC  4             MINOR ERROR                        GP09197 04820000
SETPFXCT LA    R0,1                                             GP09197 04830000
         ST    R0,NUMPFX     FORCE ONE AND ONLY                 GP09197 04840000
         B     CARDNEXT                                         GP09197 04850000
MSGEXPFX VCON  ' *** RENAME/REPLACE IGNORED; NOT VALID WITH PREFIX ***' 04860000
         SPACE 1                                                        04870000
SETREN   ICM   R3,15,PRSLINK      GET SECOND OPERAND            GP09197 04880000
         BZ    OPMISS                                           GP09197 04890000
         TM    PROFLAGS,PFPREF    WAS THERE A PREFIX REQUEST?   GP09197 04900000
         BZ    SETRENEW           NO; ADD THIS ONE              GP09197 04910000
         PRTV  MSGEXPFX           SHOW ERROR                    GP09197 04920000
         OICC  4             MINOR ERROR                        GP09197 04930000
         B     CARDNEXT                                         GP09197 04940000
         SPACE 1                                                        04950000
SETRENEW L     R4,NUMPFX     GET PRIOR RENAME COUNT             GP09197 04960000
         CH    R4,=AL2(MAXPFX)  ROOM FOR MORE ?                 GP09197 04970000
         BL    SETRENAD      YES; GET ADDRESS                   GP09197 04980000
         PRTL  ' *** TOO MANY RENAME REQUESTS - IGNORED'        GP09197 04990000
         OICC  8                                                GP09197 05000000
         B     CARDNEXT                                         GP09197 05010000
         SPACE 1                                                        05020000
SETRENAD LA    R4,1(,R4)     SET NEW COUNT                      GP09197 05030000
         ST    R4,NUMPFX     UPDATE                             GP09197 05040000
         MH    R4,=AL2(PFXLEN)    TIMES ENTRY SIZE              GP09197 05050000
         LA    R4,PFXOLDL-PFXLEN(R4)   POINT TO NEW ENTRY       GP09197 05060000
         L     R0,PRS#TEXT        GET LENGTH                    GP09197 05070000
         CL    R0,=A(L'PFXOLD)    VALID ?                       GP09197 05080000
         BH    OP2LONG            NO                            GP09197 05090000
         OC    PRS$TEXT,BLANKS    UPPER-CASE                    GP09197 05100000
         SPACE 1                                                GP09197 05110000
*TEST*   XC    PFXOLDL(PFXLEN),PFXOLDL   CLEAR RENAME STUFF     GP09197 05120000
         STC   R0,PFXOLDL         SAVE TEXT LENGTH              GP09197 05130000
         MVC   PFXOLD,PRS$TEXT    SAVE PREFIX TO BE DELETED     GP09197 05140000
         ICM   R3,15,PRSLINK      GET THIRD OPERAND             GP09197 05150000
         BZ    CARDNEXT                                         GP09197 05160000
         L     R0,PRS#TEXT        GET LENGTH                    GP09197 05170000
         CL    R0,=A(L'PFXNEW)    VALID ?                       GP09197 05180000
         BH    OP2LONG            NO                            GP09197 05190000
         OC    PRS$TEXT,BLANKS    UPPER-CASE                    GP09197 05200000
         SPACE 1                                                GP09197 05210000
         STC   R0,PFXNEWL         SAVE TEXT LENGTH              GP09197 05220000
         MVC   PFXNEW,PRS$TEXT    SAVE PREFIX TO BE PREPENDED   GP09197 05230000
         B     CARDNEXT                                         GP09197 05240000
         SPACE 1                                                        05250000
*---------------------------------------------------------------------* 05260000
*   ACCEPT EXCLUSION MASKS FOR THE PREVIOUS DUMP REQUEST              * 05270000
*       EXCLUDE name|mask                                             * 05280000
*     MASKS END WITH A PERIOD, OR CONTAIN *, ?, OR %                  * 05290000
*     NONE OF THE ABOVE DEFINES A SIMPLE DATA SET NAME                * 05300000
*                                                                     * 05310000
*   THE ALLOWED NUMBER OF EXCLUDES IS DEFINED BY EXCMASKS REPEAT CNT  * 05320000
*---------------------------------------------------------------------* 05330000
         SPACE 1                                                        05340000
GETXMASK TM    PROFLAGS,PFGDUMP   FOLLOWS A DUMP CARD ?                 05350000
         BNZ   GETXMAS2           YEAH                                  05360000
 PRTL '*** Exclusion mask valid after a DUMP/SELect only ***',NL,CC=NO  05370000
         OICC  4                  MINOR ERROR?                          05380000
         B     CARDNEXT                                                 05390000
GETXMAS2 ICM   R3,15,PRSLINK      GET SECOND OPERAND                    05400000
         BZ    OPMISS                                                   05410000
         L     R0,PRS#TEXT        GET LENGTH                            05420000
         CL    R0,=A(L'COMPMASK)  VALID ?                               05430000
         BH    OP2LONG            NO                                    05440000
         ST    R0,DB              SAVE TEXT LENGTH                      05450000
         OC    PRS$TEXT,BLANKS    UPPER-CASE                            05460000
         SPACE 1                                                        05470000
         INC   EXC#MASK,WORK=R15                                        05480000
         CH    R15,=AL2((EXC#MASK-EXCMASKS)/L'EXCMASKS)                 05490000
         BNH   GETXMAS3           YES; CONTINUE                         05500000
         PRTL  '*** Too many EXClude statements ***',NL,CC=NO           05510000
         OICC  4                  TOO BAD                               05520000
         B     CARDNEXT                                                 05530000
         SPACE 1                                                        05540000
GETXMAS3 BCTR  R15,0              RELATIVE TO ZERO                      05550000
         M     R14,=A(L'EXCMASKS)  (RE-USE LITERAL)                     05560000
         LA    R4,EXCMASKS(R15)   FIND CURRENT ENTRY                    05570000
         MVC   0(L'COMPMASK,R4),PRS$TEXT    USE IT                      05580000
         LR    R1,R4         POINT TO MASK NAME                         05590000
         BAL   R9,WHATMASK   ANALYZE WHAT WE ARE LOOKING AT             05600000
         CH    R15,=H'4'                                                05610000
         BNL   GETXSHOM      MASK                                       05620000
         PRTDATA '       Excluding data set',(0(R4),L'COMPMASK,PADL)    05630000
         B     CARDNEXT                                                 05640000
         SPACE 1                                                        05650000
GETXSHOM PRTDATA '       Excluding by mask:',(0(R4),L'COMPMASK,PADL)    05660000
         B     CARDNEXT                                                 05670000
         SPACE 1                                                        05680000
GETXMBAD PRTDATA '*** Mask',(0(R4),44,DEB,PAD),'invalid ***'            05690000
         B     PGMEXIT8                                                 05700000
         SPACE 1                                                        05710000
*---------------------------------------------------------------------* 05720000
*   SET ONE OR MORE OPTIONS BITS, ACCORDING TO SELF-DEFINING KEYWORDS * 05730000
*   ON OPTION CARDS.                                                  * 05740000
*---------------------------------------------------------------------* 05750000
         SPACE 1                                                        05760000
SETOPT   ICM   R3,15,PRSLINK      GET SECOND OPERAND            GP09197 05770000
         BZ    OPMISS                                           GP09197 05780000
SETOFLAG OC    PRS$TEXT,BLANKS    UPPER CASE                    GP09197 05790000
         PARFGSET OPTSETP,ERR=SETOBAD,DONE=SETONEXT             GP09197 05800000
SETONEXT ICM   R3,15,PRSLINK      ANY MORE ?                    GP09197 05810000
         BZ    SETOSHOW           NO; READ ANOTHER CARD         GP09197 05820000
         CLI   PRS$TEXT,C'*'      COMMENTS?                     GP09197 05830000
         BNE   SETOFLAG           NO; CHECK IT                  GP09197 05840000
SETOSHOW PRTLIST MSGOPTS                                        GP09197 05850000
         B     CARDNEXT           READ NEXT CARD                GP09197 05860000
         SPACE 1                                                        05870000
SETOBAD  PRTDATA '*** UNRECOGNIZED OPTION',(PRS$TEXT,DEB,PAD),'***'     05880000
         OICC  8                                                GP09197 05890000
         B     CARDNEXT                                         GP09197 05900000
         SPACE 1                                                        05910000
MSGOPTS  FDPRT '      Options now on are : ',NL                 GP09197 05920000
         FDTM   OPTFLAGS,255-FGPSPO-FGWRITE,BZ=MSGOPTS0         GP09197 05930000
         FDFLAG OPTFLAGS,TABLE=OPTSHO,SPACE=1,LEN=80            GP09197 05940000
         FD    *END                                             GP09197 05950000
MSGOPTS0 FDPRT 'all off'                                        GP09197 05960000
         FD    *END                                             GP09197 05970000
         SPACE 1                                                        05980000
OPTSHO   FLGTAB FGENQ,'ENQUEUE',MLEN=1                          GP09197 05990000
         FLGTAB FGVAR,'RECFM=V'                                 GP09197 06000000
         FLGTAB FGADAT,'ALLDATA'                                GP09197 06010000
         FLGTAB FGEXP,'EXPORT'                                  GP09197 06020000
         FLGTAB FGTEST,'TEST-MODE'                              GP09197 06030000
         FLGTAB FGBUG,'DEBUG-MODE'                              GP09197 06040000
         FLGTAB *END                                            GP09197 06050000
         SPACE 1                                                        06060000
         PARKEYBX OPTSET     BXLE                               GP09197 06070000
OPTSET   PARKEYFG 'ENQUEUE',OPTFLAGS,0,FGENQ     ENQTEST        GP09197 06080000
OPTSET2  PARKEYFG 'NOENQUE',OPTFLAGS,FGENQ,0     SKIPENQ        GP09197 06090000
         PARKEYFG 'SKIPENQ',OPTFLAGS,FGENQ,0     SKIPENQ        GP09197 06100000
         PARKEYFG 'ALLDATA',OPTFLAGS,0,FGADAT    WRITE ALL      GP09197 06110000
         PARKEYFG 'ALLEXCP',OPTFLAGS,0,FGADAT    WRITE ALL      GP09197 06120000
         PARKEYFG 'TEST',OPTFLAGS,0,FGTEST       NO WRITE       GP09197 06130000
         PARKEYFG 'EXPORT',OPTFLAGS,0,FGEXP      RESET PROTECT  GP09197 06140000
         PARKEYFG 'LIST',OPTFLAGS,0,0            SHOW SETTINGS  GP09212 06150000
         PARKEYFG 'SHOW',OPTFLAGS,0,0            SHOW SETTINGS  GP09212 06160000
OPTSETN  PARKEYFG 'DEBUG',OPTFLAGS,0,FGBUG       TEST MODE      GP09197 06170000
         SPACE 2                                                        06180000
*********************************************************************** 06190000
*                                                                     * 06200000
*   Examine contents of COPY/DUMP CARD.                               * 06210000
*     COPY level.            Uses catalog lookup to find candidates.  * 06220000
*     COPY mask VOLUME(serial)   Uses VTOC entries                    * 06230000
*     COPY VOLUME(serial) mask   Uses VTOC entries                    * 06240000
*                                                                     * 06250000
*********************************************************************** 06260000
SETDUMP  TM    PROFLAGS,PFGDUMP   DUMP REQUEST PENDING ?                06270000
         BZ    SETDUMP1           NO; EXAMINE THIS ONE                  06280000
         INPKEEP ,                PUT THE INPUT CARD BACK               06290000
         B     ACTDUMP                                                  06300000
SETDUMP1 ICM   R3,15,PRSLINK      GET SECOND OPERAND                    06310000
         BZ    OPMISS                                                   06320000
         XC    DB,DB              CLEAR LENGTHS                         06330000
         MVC   CELLKEY,BLANKS     CLEAR VOL/DSN|MASK                    06340000
SETDUMPC L     R0,PRS#TEXT        GET LENGTH                            06350000
         CLC   =C'VOL',PRSKEYWD   IS IT VOL() OR VOL= ?                 06360000
         BE    SETDUMPV           YES; DIFFERENT PROCESSING             06370000
         CLC   =C'SER',PRSKEYWD   IS IT SER() OR SER= ?                 06380000
         BE    SETDUMPV           YES; DIFFERENT PROCESSING             06390000
         CLI   PRS$TEXT,C'*'      COMMENT OR MASK ?             GP09207 06400000
         BNE   SETDUMPM           NO                            GP09207 06410000
         CH    R0,=H'1'           COMMENTS FIELD ?              GP09207 06420000
         BE    SETDUMPX           YES; SEE WHAT WE HAVE         GP09207 06430000
SETDUMPM ICM   R14,15,DB          DONE DSN|MASK BEFORE?         GP09207 06440000
         BNZ   OP2MANY            YES; FAIL                             06450000
         CL    R0,=A(L'CELLDSN)   VALID ?                               06460000
         BH    OP2LONG            NO                                    06470000
         ST    R0,DB              SAVE TEXT LENGTH                      06480000
         OC    CELLDSN,PRS$TEXT   COPY TEXT                             06490000
         TRT   CELLDSN,TRTDSNM    DSN, POSSIBLE MASK?                   06500000
         CLM   R2,1,=X'4'         FULL 44, OR BLANK STOP?               06510000
         BNH   SETDUMPN           ACCEPT IT                             06520000
OPCHAR   PRTDATA '***',(PRS$TEXT,PAD,DEB),'contains illegal characters *06530000
               ***'                                                     06540000
         OICC  8                                                        06550000
         B     ACTRESET           QUIT THIS ONE                         06560000
         SPACE 1                                                        06570000
SETDUMPN ICM   R3,15,PRSLINK      ANY MORE ?                            06580000
         BNZ   SETDUMPC           YES; EXAMINE                          06590000
SETDUMPX OI    PROFLAGS,PFGDUMP+PFGONCE   SHOW DUMP REQUESTED           06600000
         B     CARDNEXT                                                 06610000
         SPACE 1                                                        06620000
SETDUMPV ICM   R14,15,DB+4        DID WE GET A VOLUME SERIAL?   GP09207 06630000
         BNZ   OP2MANY            YES; DUPLICATE                        06640000
         LTR   R0,R0              TEST LENGTH                   GP09207 06650000
         BZ    OPMISS             NEED A SERIAL                         06660000
         CL    R0,=A(L'CELLVOL)   VALID ?                               06670000
         BH    OP2LONG            NO                                    06680000
         ST    R0,DB+4            SAVE TEXT LENGTH                      06690000
         OC    CELLVOL,PRS$TEXT                                         06700000
         SERVCALL UCBVS,CELLVOL   VALID SERIAL ?                        06710000
         BXH   R15,R15,VOLNTMNT   NO                                    06720000
         LR    R15,R0                                                   06730000
         CLI   UCBTBYT3-UCBOB(R15),UCB3DACC  DASD ?                     06740000
         BE    SETDUMPN      LOOK FOR ANOTHER OPERAND                   06750000
         PRTDATA '***',(CELLVOL,PAD),'is not DASD ***'                  06760000
         OICC  8                                                        06770000
         B     ACTRESET                                                 06780000
VOLNTMNT PRTDATA '***',(CELLVOL,PAD),'is not available ***'             06790000
         OICC  8                                                        06800000
         B     ACTRESET                                                 06810000
         SPACE 1                                                        06820000
ACTDUMP  CLI   CELLVOL,C' '       DID WE GET A VOLUME SERIAL?           06830000
         BH    SEARCHVL           YES; RUN VTOC                         06840000
         CLI   CELLDSN,C' '       DID WE GET A MASK OR DSN              06850000
         BNE   SEARCHCT           YES; SEARCH CATALOG                   06860000
OPMISS   PRTL  '*** DSname/Mask operand required; VOL(serial) optional *06870000
               ***',CC=NO                                               06880000
         OICC  8                                                        06890000
         B     ACTRESET                                                 06900000
         SPACE 1                                                        06910000
OP2MANY  PRTL  '*** Too many operands ***',CC=NO                        06920000
         OICC  4                                                        06930000
         B     ACTRESET                                                 06940000
         SPACE 1                                                        06950000
OP2LONG  PRTDATA '*** Operand',(PRS$TEXT,PAD,DEB),'too long ***'        06960000
         OICC  8                                                GP09197 06970000
         B     ACTRESET                                                 06980000
         DROP  R3                                                       06990000
         EJECT ,                                                        07000000
*********************************************************************** 07010000
*                                                                     * 07020000
*   PROCESS DATA SET SELECTION FOR 'DUMP level '                      * 07030000
*     Use IGGCSI00 OR SuperLocate to get non-VSAM data sets,          * 07040000
*     screen for DSORG, etc. and compare to mask.                     * 07050000
*                                                                     * 07060000
*********************************************************************** 07070000
SEARCHCT MVC   COMPMASK,CELLDSN   COPY TO PERMANENT SPACE               07080000
         LA    R1,COMPMASK                                              07090000
         BAL   R9,WHATMASK   EXAMINE IT                                 07100000
         CH    R15,=H'4'     IS IT NAME OR MASK?                        07110000
CATMASK  CATCALL INIT,COMPMASK,MODE=(@,BALR)                            07120000
         BXH   R15,R15,CATNOLOC  FAILED                                 07130000
         PRTDATA '   === Processing catalog',(CSPRCAT,PAD,DEB)          07140000
         B     CATNEXT2                                                 07150000
         SPACE 1                                                        07160000
CATNOLOC PRTDATA '*** Catalog lookup failed',(CELLDSN,DEB,PAD),'***'    07170000
         OICC  8                                                        07180000
         B     ACTRESET                                                 07190000
         SPACE 1                                                        07200000
*---------------------------------------------------------------------* 07210000
*  GET NEXT CATALOG ENTRY                                             * 07220000
*---------------------------------------------------------------------* 07230000
CATNEXT  CATCALL LOOP,MODE=(@,BALR)   GET NEXT ENTRY                    07240000
         BXH   R15,R15,CATDONE   DONE WITH THIS MASK                    07250000
CATNEXT2 CLI   CSPRTYP,C'A'  NON-VSAM ENTRY?                            07260000
         BNE   CATNEXT       NO; SKIP TO NEXT ENTRY                     07270000
         MVC   CMPREQ,=C'DSN'    'NORMAL' MASKING                       07280000
         TM    COMPMASK+L'COMPMASK,X'10'    POSITIONAL ?                07290000
         BZ    *+10                                                     07300000
         MVC   CMPREQ,=C'POS'    POSITIONAL MASKING                     07310000
         SUBCALL SUBCOMP,(CMPREQ,CSPRDSN,COMPMASK,CMP@STOR),VL,        *07320000
               MF=(E,CALLPARM)                                          07330000
         BXH   R15,R15,CATNEXT  SKIP IF NO MATCH                        07340000
         SPACE 1                                                        07350000
         ICM   R2,15,EXC#MASK     ANY EXCLUSION MASKS ?                 07360000
         BNP   CATXDONE           NO; ACCEPT                            07370000
         LA    R3,EXCMASKS        POINT TO FIRST                        07380000
CATXLOOP L     R15,CSP@SCMP  GET COMPARE ROUTINE ADDRESS                07390000
         TM    L'COMPMASK(R3),X'80'    MASK PROCESING ?                 07400000
         BNZ   CATXMASK      YES                                        07410000
         CLC   CSPRDSN,0(R3)      DSN MATCHES EXCLUDE ?                 07420000
         BNE   CATXBUMP      NO; TRY AGAIN                              07430000
         B     CATNEXT       REJECT THIS ONE                            07440000
CATXMASK MVC   CMPREQ,=C'DSN'    'NORMAL' MASKING                       07450000
         TM    L'COMPMASK(R3),X'10'    POSITIONAL ?                     07460000
         BZ    *+10                                                     07470000
         MVC   CMPREQ,=C'POS'    POSITIONAL MASKING                     07480000
         SUBCALL SUBCOMP,(CMPREQ,CSPRDSN,0(R3),CMP@STOR),VL,           *07490000
               MF=(E,CALLPARM)                                          07500000
         BXLE  R15,R15,CATNEXT    SKIP IF MATCH ON EXCLUDE              07510000
CATXBUMP LA    R3,L'EXCMASKS(,R3)                                       07520000
         BCT   R2,CATXLOOP        TRY NEXT                              07530000
         SPACE 1                                                        07540000
CATXDONE SLR   R2,R2                                                    07550000
         ICM   R2,1,CSP#VOL LOAD VOLUME COUNT                           07560000
         BNP   CAT0VOL                                                  07570000
         BCT   R2,CAT2VOL    DON'T DO MULTI-VOLUME (YET?)               07580000
*LATER*  LA    R6,CSPRVOL    POINT TO FIRST VOLUME SERIAL               07590000
*LATER*  LA    R5,CSPRDTY    AND MATCHING DEVICE TYPE                   07600000
         MVC   CELLVOL,CSPRVOL    MOVE VOLUME                           07610000
         MVC   CELLDSN,CSPRDSN    AND SERIAL                            07620000
         SERVICE DSDS1,CELLVOL    GET DSCB 1                            07630000
         BXH   R15,R15,CATNEXT                                          07640000
         LR    R3,R1         COPY DSCB ADDRESS                          07650000
         USING DS1FMTID,R3   DECLARE RETURN                             07660000
         CLI   DS1FMTID,C'1'   REALLY A FORMAT 1 ?                      07670000
         BNE   CATNEXT       IF NOT, SKIP                               07680000
         BAL   R9,TESTDS     EXAMINE                                    07690000
         B     CATNEXT       AND TRY NEXT                               07700000
         SPACE 1                                                        07710000
CAT2VOL  PRTDATA '*** Multi-volume DS',(CSPRDSN,PAD,DEB),'skipped ***'  07720000
CATSKIP  INC   NUMSKIP       COUNT SKIPPED DATA SETS                    07730000
         B     CATNEXT       TRY NEXT ENTRY                             07740000
         SPACE 1                                                        07750000
CAT0VOL PRTDATA '*** No VOLSER information for',(CSPRDSN,PAD,DEB),'***' 07760000
         B     CATNEXT       SKIP THIS                                  07770000
         SPACE 1                                                        07780000
CATDONE  CATCALL CLOSE,CSPMASK,MODE=(@,BALR)  FREE IT UP                07790000
         PRTL  '   === End of requested catalog search ===',NL,CC=NO    07800000
         B     ACTRESET                                                 07810000
         EJECT ,                                                        07820000
*********************************************************************** 07830000
*                                                                     * 07840000
*   PROCESS DATA SET SELECTION FOR 'DUMP mask VOLUME(xyz)'            * 07850000
*     Read the VTOC, screen DSORG, etc., and compare mask.            * 07860000
*                                                                     * 07870000
*********************************************************************** 07880000
SEARCHVL VOLREAD OPEN,CELLVOL   INITIALIZE VOLUME PROCESSING            07890000
         MVC   VOLVOL,CELLVOL   REMEMBER WHAT'S OPEN                    07900000
         BXH   R15,R15,SKIPVOL    IGNORE IF BAD                         07910000
         MVC   COMPMASK,CELLDSN   PROPAGATE MASK                        07920000
         CLI   COMPMASK,C' '      ANY MASK ?                    GP09194 07930000
         BH    DSCBTMSK           YES; TEST IT                  GP09194 07940000
         MVC   COMPMASK(2),=C'**'   MAKE UNIVERSAL MATCH        GP09194 07950000
DSCBTMSK LA    R1,COMPMASK                                              07960000
         BAL   R9,WHATMASK   EXAMINE MASK                               07970000
DSCBFMT4 VOLREAD DSCB        READ THE FORMAT 4                          07980000
         BXH   R15,R15,SKIPVOL   ERROR                                  07990000
         B     DSCBNEX4      JOIN NORMAL PROCESSING              82137  08000000
         SPACE 1                                                        08010000
SKIPVOL  PRTDATA '*** Error reading VTOC',(VOLVOL,PAD),'***'            08020000
         OICC  8                                                        08030000
         B     ACTRESET                                                 08040000
         SPACE 1                                                        08050000
DSCBNEXT VOLREAD DSCB        GET ANOTHER DSCB                           08060000
         CH    R15,=H'4'     DID WE GET ONE ?                           08070000
         BE    DSCBNDVL      NO; END OF VOLUME                          08080000
         BH    SKIPVOL       NO; I/O ERROR                              08090000
DSCBNEX4 LR    R3,R0         COPY DSCB ADDRESS                          08100000
         USING DS1DSNAM,R3   DECLARE RETURN                             08110000
         MVC   CELLDSN,DS1DSNAM   PROPAGATE DS NAME                     08120000
         LA    R3,DS1FMTID   FOR TESTDS COMMON MAPPING                  08130000
         USING DS1FMTID,R3                                              08140000
         CLI   DS1FMTID,C'1'   REALLY A FORMAT 1 ?                      08150000
         BNE   DSCBNEXT      IF NOT, SKIP                               08160000
*   SUBMIT TO COMPARE TESTS                                             08170000
         MVC   CMPREQ,=C'DSN'    'NORMAL' MASKING                       08180000
         TM    COMPMASK+L'COMPMASK,X'10'    POSITIONAL ?                08190000
         BZ    *+10                                                     08200000
         MVC   CMPREQ,=C'POS'    POSITIONAL MASKING                     08210000
         SUBCALL SUBCOMP,(CMPREQ,CELLDSN,COMPMASK,CMP@STOR),VL,        *08220000
               MF=(E,COMPPARM)                                          08230000
         CH    R15,=H'4'                                                08240000
         BNL   DSCBNEXT      SKIP IT                                    08250000
         SPACE 1                                                        08260000
         ICM   R2,15,EXC#MASK     ANY EXCLUSION MASKS ?                 08270000
         BNP   DSCXDONE           NO; ACCEPT                            08280000
         LA    R4,EXCMASKS        POINT TO FIRST                        08290000
DSCXLOOP L     R15,CSP@SCMP  GET COMPARE ROUTINE ADDRESS                08300000
         TM    L'COMPMASK(R4),X'80'    MASK PROCESING ?                 08310000
         BNZ   DSCXMASK      YES                                        08320000
         CLC   CELLDSN,0(R4)      DSN MATCHES EXCLUDE ?         GP10163 08330000
         BNE   DSCXBUMP      NO; TRY AGAIN                              08340000
         B     DSCBNEXT      REJECT THIS ONE                            08350000
DSCXMASK MVC   CMPREQ,=C'DSN'    'NORMAL' MASKING                       08360000
         TM    L'COMPMASK(R4),X'10'    POSITIONAL ?                     08370000
         BZ    *+10                                                     08380000
         MVC   CMPREQ,=C'POS'    POSITIONAL MASKING                     08390000
         SUBCALL SUBCOMP,(CMPREQ,CELLDSN,0(R4),CMP@STOR),VL,           *08400000
               MF=(E,CALLPARM)                                          08410000
         BXLE  R15,R15,DSCBNEXT   SKIP IF MATCH ON EXCLUDE              08420000
DSCXBUMP LA    R4,L'EXCMASKS(,R4)                                       08430000
         BCT   R2,DSCXLOOP        TRY NEXT                              08440000
         SPACE 1                                                        08450000
DSCXDONE BAL   R9,TESTDS     EXAMINE                                    08460000
         B     DSCBNEXT      AND TRY NEXT                               08470000
         SPACE 1                                                        08480000
DSCBNDVL PRTL  '   === End of requested volume search ===',NL,CC=NO     08490000
ACTRESET XC    EXC#MASK,EXC#MASK  RESET EXCLUSION MASKS                 08500000
         ZI    PROFLAGS,PFGDUMP   NO LONGER DUMP MODE                   08510000
         B     CARDNEXT      AND TRY NEXT                               08520000
         SPACE 1                                                        08530000
*********************************************************************** 08540000
**  End of input on SYSIN - see what to do                           ** 08550000
*********************************************************************** 08560000
CARDEOD  TM    PROFLAGS,PFGDUMP   DUMP REQUEST PENDING ?                08570000
         BNZ   ACTDUMP            COLLECT DS INFORMATION                08580000
         SPACE 1                                                        08590000
CARDEODX PRTL  '   === End file on SYSIN ===',NL,CC=NO                  08600000
         L     R15,=A(DSSDUMP2)   GO TO DUMP PHASE                      08610000
         L     R0,RETCODE    LOOK AT ERRORS SO FAR                      08620000
         CH    R0,=H'4'      ANY ERRORS?                                08630000
         BNHR  R15           NO; CONTINUE                               08640000
         PRTL  '0*** Dump not attempted due to errors ***',CC=ASA       08650000
         B     PGMEXIT1      AND QUIT                                   08660000
         SPACE 2                                                        08670000
*********************************************************************** 08680000
**  TESTDS - CHECK DSCB1 TO SEE WHETHER THIS IS A FILE TYPE WE       ** 08690000
**    SUPPORT. 1) DSORG = PS, PO, DA                                 ** 08700000
**             2) LSTAR > 0                                          ** 08710000
*********************************************************************** 08720000
         USING DS1FMTID,R3                                              08730000
TESTDS   TM    DS1DSORG,DS1DSGPS+DS1DSGDA+DS1DSGPO  xSAM/BDAM ?         08740000
         BNM   TESTSKIP      NO; SKIP                                   08750000
         CLI   DS1DSORG+1,0  VSAM, ETC. ?                       GP09186 08760000
         BNE   TESTSKIP      YES; SKIP                          GP09186 08770000
         CLC   CELLDSN,DUMPDSN    ACTIVE DUMP DS ?              GP09317 08780000
         BNE   TESTNSLF      NO                                 GP09317 08790000
         CLC   CELLVOL,DUMPVOL    SAME SERIAL ?                 GP09317 08800000
         BNE   TESTNSLF      NO                                         08810000
         PRTDATA '*** Data set',(CELLDSN,PAD,DEB),' bypassed - is activ*08820000
               e DSSDUMP output ***'                            GP09317 08830000
         MVICC 4                                                GP09317 08840000
         B     TESTSKNO                                         GP09317 08850000
TESTNSLF CLI   DS1NOEPV,0    ANY DATA ?                         GP09193 08860000
         BE    TESTSKEM      NO; NOTHING TO DUMP                GP09193 08870000
         ICM   R0,7,DS1LSTAR  EVER USED ?                               08880000
         BZ    TESTSKIP      SKIP EMPTY AND PDS/E, HFS, ETC.            08890000
         SPACE 1                                                        08900000
         TM    OPTFLAGS,FGENQ     ENQUEUE TEST REQUESTED        GP09212 08910000
         BZ    TESTNENQ           NO                            GP09212 08920000
         LOCBYTE CELLDSN          GET DSN LENGTH                GP09212 08930000
         SR    R15,R14            LENGTH OF DSN                 GP09212 08940000
         LR    R6,R15             USE BETTER REGISTER           GP09212 08950000
         MVC   ENQLIST(PATENQL),PATENQ      REFRESH             GP09212 08960000
         ENQ   (,CELLDSN,,(R6),),RET=TEST,MF=(E,ENQLIST)        GP09212 08970000
         BXH   R15,R15,TESTNBAD                                 GP09212 08980000
         ENQ   (QJAM,CELLDSN,,(R6),),RET=TEST,MF=(E,ENQLIST)    GP09212 08990000
         BXLE  R15,R15,TESTNENQ   PASSED                        GP09212 09000000
TESTNBAD PRTDATA '*** Data set',(CELLDSN,PAD,DEB),' bypassed - ENQ test*09010000
                unsuccessful ***'                               GP09212 09020000
         MVICC 4                                                GP09212 09030000
         B     TESTSKNO                                         GP09212 09040000
         SPACE 1                                                        09050000
TESTNENQ MVI   CELLFLAG,CFPICK    FLAG DS AS SELECTED                   09060000
         MVC   CELLALI,CELLDSN    SET ALIAS SAME AS TRUE NAME           09070000
         ICM   R6,15,NUMPFX  DOING PREFIXING ?                  GP09197 09080000
         BZ    TESTUPD       NO, LEAVE DSN ALONE                GP09197 09090000
         LA    R5,PFXOLDL    POINT TO RENAME/PREFIX LIST        GP09197 09100000
TESTPFX  MVI   LOCFMT1,C' '  PREPARE A WORK AREA                GP09197 09110000
         MVC   LOCFMT1+1(43+44),LOCFMT1    MORE THAN ENOUGH     GP09197 09120000
         MVC   LOCFMT1(L'PFXNEW),PFXNEW-PFXOLDL(R5) NEW PREFIX  GP09197 09130000
         SR    R14,R14                                          GP09197 09140000
         SR    R1,R1                                            GP09197 09150000
         IC    R1,PFXNEWL-PFXOLDL(,R5)                          GP09197 09160000
         LA    R1,LOCFMT1(R1)   TO ADDRESS                      GP09197 09170000
         IC    R14,PFXOLDL-PFXOLDL(R5)                          GP09197 09180000
         LA    R15,CELLALI(R14)  SET SOURCE ADDRESS             GP09197 09190000
         LTR   R14,R14       ANY COMPARE ?                      GP09197 09200000
         BNP   TESTNOLD      NO                                 GP09197 09210000
         BCTR  R14,0         EX LENGTH                          GP09197 09220000
         EX    R14,EXCLCPFX  MATCHING PREFIX ?                  GP09197 09230000
         BNE   TESTBUMP      NO; TRY ANOTHER                    GP09197 09240000
         LA    R14,1(,R14)   FIX UP                             GP09317 09250000
TESTNOLD LA    R0,44-1       GET LENGTH - 1 TO MOVE             GP09197 09260000
         SR    R0,R14        GET EX LENGTH                      GP09197 09270000
         BM    TESTNNEW                                         GP09197 09280000
         LR    R14,R0        SWAP                               GP09197 09290000
         EX    R14,EXMVCPFX  MOVE                               GP09197 09300000
TESTNNEW MVC   CELLALI,LOCFMT1    MOVE NEW NAME                 GP09197 09310000
         CLI   CELLALI+L'CELLALI-1,C'.'   TRAILING INDEX POINT? GP09197 09320000
         BNE   TESTUPD       NO                                 GP09197 09330000
         MVI   CELLALI+L'CELLALI-1,C' '   YES; FIX IT           GP09197 09340000
         B     TESTUPD            AND USE IT                    GP09197 09350000
EXCLCPFX CLC   CELLALI(0),PFXOLD-PFXOLDL(R5)   MATCHING PREFIX? GP09197 09360000
EXMVCPFX MVC   0(0,R1),0(R15)   MOVE TRAILER                    GP09197 09370000
         SPACE 1                                                        09380000
TESTBUMP LA    R5,PFXLEN(,R5)                                           09390000
         BCT   R6,TESTPFX    CHECK FOR PREFIX MATCH             GP09197 09400000
TESTUPD  LOCBYTE CELLALI     GET NAME LENGTH                    GP09197 09410000
         SR    R15,R14       GET LENGTH                         GP09197 09420000
         STC   R15,CELLALIL  AND SAVE FOR PASS 2                GP09197 09430000
         SUBCALL SUBTREE,('UPD',ROOTBALL,RECREC),VL,MF=(E,CALLPARM)     09440000
         CH    R15,=H'8'     ACCEPTABLE RESULT ?                        09450000
         BL    TESTGOOD                                                 09460000
         PRTL  '0*** List update failed ***',CC=ASA                     09470000
         B     PGMEXIT8                                                 09480000
         SPACE 1                                                        09490000
TESTSKEM DS    0H            NO EXTENTS                         GP09193 09500000
 PRTDATA ' ? ',CELLVOL,(CELLDSN,PAD),'skipped (no extents).        DSOR*09510000
               G=',(DS1DSORG,2,HEX,PAD),'LSTAR=',(DS1LSTAR,3,HEX)       09520000
         B     TESTSKNO                                                 09530000
         SPACE 1                                                        09540000
TESTSKIP DS    0H            BAD DSORG OR LSTAR                 GP09193 09550000
 PRTDATA ' ? ',CELLVOL,(CELLDSN,PAD),'skipped (unsupported/empty). DSOR*09560000
               G=',(DS1DSORG,2,HEX,PAD),'LSTAR=',(DS1LSTAR,3,HEX)       09570000
TESTSKNO INC   NUMSKIP       COUNT DATA SETS SKIPPED                    09580000
         BR    R9            RETURN TO CALLER                           09590000
         SPACE 1                                                        09600000
TESTGOOD BXH   R15,R15,TESTADDD                                         09610000
 PRTDATA '   ',CELLVOL,(CELLDSN,PAD),'already queued'                   09620000
         BR    R9            RETURN TO CALLER                           09630000
         SPACE 1                                                        09640000
TESTADDD INC   NUMPICK                                                  09650000
         SERVCALL DSFMT,DS1DSORG  MAKE ATTRIBUTES PRINTABLE             09660000
         LR    R3,R1         SAVE RETURN                                09670000
   PRTDATA '   ',CELLVOL,(CELLDSN,PAD),'queued:    ',(0(R3),3,PAD),(3(R*09680000
               3),6,PAD),(22(R3),5,PAD),(17(R3),5)                      09690000
         BR    R9            RETURN TO CALLER                           09700000
         DROP  R3                                                       09710000
         SPACE 1                                                        09720000
         LTORG ,                                                        09730000
         SPACE 1                                                        09740000
VERBTAB  PARKEYAD 'EXCLUDE ',GETXMASK  SPECIFY DS MASK                  09750000
VERBTAB2 PARKEYAD 'INCLUDE ',SETDUMP   SPECIFY DS MASK                  09760000
         PARKEYAD 'SELECT  ',SETDUMP   SPECIFY DS MASK                  09770000
         PARKEYAD 'DUMP    ',SETDUMP   BEGIN DS SELECTION               09780000
         PARKEYAD 'COPY    ',SETDUMP   BEGIN DS SELECTION               09790000
         PARKEYAD 'RENAME  ',SETREN    SET PFX RENAME           GP09197 09800000
         PARKEYAD 'REPLACE ',SETREN    SET PFX RENAME           GP09197 09810000
         PARKEYAD 'STRIP   ',SETREN    DELETE LEADING DSN CHARS GP09197 09820000
         PARKEYAD 'PREFIX  ',SETPFX    SET PREFIX (NO RENAME)   GP09197 09830000
         PARKEYAD 'OPTIONS ',SETOPT    SET OPTION BITS ON/OFF           09840000
         PARKEYAD 'ALLDATA ',SETALLTK  DUMP ALL TRACKS                  09850000
         PARKEYAD 'ALLEXCP ',SETALLTK  DUMP ALL TRACKS                  09860000
         PARKEYAD 'NODEBUG ',SETBUGOF                                   09870000
         PARKEYAD 'TEST    ',SETTSTON                                   09880000
VERBTABN PARKEYAD 'DEBUG   ',SETBUGON                                   09890000
BASE2    EQU   4096                                             JW12114 09890400
CHECKRAC LA    R12,INCRBASE(,R12) increment 2nd base            JW12114 09890800
INCRBASE EQU   CHECKRAC-BASE2 offset to original 2nd base       JW12114 09891200
         USING CHECKRAC,R12   establish addressability          JW12114 09891600
         L     R15,CVTPTR     get CVT address                   JW12114 09892000
         ICM   R15,B'1111',CVTSAF(R15) SAFV defined?            JW12114 09892400
         BZ    GOAHEAD        no RAC, go execute                JW12114 09892800
         USING SAFV,R15       addressability of SAFV            JW12114 09893200
         CLC   SAFVIDEN(4),SAFVID SAFV initialized?             JW12114 09893600
         BNE   GOAHEAD        no RAC, go execute                JW12114 09894000
         DROP  R15            SAFV no longer needed             JW12114 09894400
         RACHECK ENTITY=DSSAUTH,CLASS='FACILITY',ATTR=READ      JW12114 09894800
         LTR   R15,R15        RAC authorization granted?        JW12114 09895200
         BZ    GOAHEAD        yes, go execute                   JW12114 09895600
         S     R12,BASE2INC   no, restore 2nd base ..           JW12114 09896000
         B     ABEND           .. and abend                     JW12114 09896400
GOAHEAD  S     R12,BASE2INC   restore 2nd base                  JW12114 09896800
         B     HAVEAUTH       WHOOPPEE                          JW12114 09897200
BASE2INC DC    A(INCRBASE)    offset to original 2nd base       JW12114 09897600
DSSAUTH  DC    CL39'DSSAUTH'  facility name to authorize        JW12114 09898000
SAFVID   DC    CL4'SAFV'      SAFV eye catcher                  JW12114 09898400
         TITLE 'D S S D U M P  ***  MAKE DUMP TAPE'                     09900000
DSSDUMP2 CSECT ,             SUBROUTINE AND DATA AREA                   09910000
         LA    R11,0(,R15)   COPY NEW BASE                              09920000
         LA    R12,2048(,R11)                                           09930000
         LA    R12,2048(,R12)                                           09940000
         USING DSSDUMP2,R11,R12                                         09950000
         PRTL  ' ',NL,CC=NO       PRETTIFY OUTPUT                       09960000
         SPACE 1                                                        09970000
*---------------------------------------------------------------------* 09980000
*   Note that the catalog name isn't available for VOL() lookup,      * 09990000
*   and I didn't keep it from the catalog retrieval.                  * 10000000
*   So we use the master catalog name for laughs.                     * 10010000
*---------------------------------------------------------------------* 10020000
         PUSH  USING                                                    10030000
         L     R5,CVTPTR                                                10040000
         NUSE  CVT,R5                                                   10050000
         ICM   R5,15,CVTCBSP    -> AMCBS                                10060000
         BZ    NONECAX       HUH?                                       10070000
         USING AMCBS,R5                                                 10080000
         LA    R5,CBSCAXCN-(CAXCHN-IGGCAXWA)                            10090000
         USING IGGCAXWA,R5                                              10100000
CAXNEXT  ICM   R5,15,CAXCHN                                             10110000
         BZ    NONECAX                                                  10120000
         TM    CAXFLGS,CAXMCT     MASTER CATALOG ?                      10130000
         BZ    CAXNEXT            NO; IGNORE                            10140000
         MVC   CSPRCAT,CAXCNAM    REMEMBER IT                           10150000
         LOCBYTE CSPRCAT                                        GP09192 10160000
         SR    R15,R14       NON-BLANK LENGTH                   GP09192 10170000
         STC   R15,CSPRTYP   SAVE IN STOLEN FIELD               GP09192 10180000
         POP   USING                                                    10190000
         SPACE 1                                                        10200000
*---------------------------------------------------------------------* 10210000
*   Check for at least one queued entry. Quit if none.                * 10220000
*   Else build tape header record.                                    * 10230000
*---------------------------------------------------------------------* 10240000
NONECAX  SUBCALL LISTREE     INITIALIZE SEQUENTIAL READING              10250000
         LTR   R15,R15       ANY PROBLEM ?                              10260000
         BZ    DSNLINIT                                                 10270000
         PRTDATA '*** No data sets to dump ***'                         10280000
         B     PGMEXIT8                                                 10290000
         SPACE 1                                                        10300000
DSNLINIT L     R8,REC@REC    UPDATE THE CELL ADDRESS                    10310000
         L     R2,@BUF       POINT TO START OF BUFFER                   10320000
         BAL   R9,BUILDHED   BUILD A HEADER RECORD                      10330000
         USING DSSBLOCK,R2   DECLARE IT                                 10340000
         XC    DTHTIMD(DTHSIZE),DTHTIMD  CLEAR UNUSED                   10350000
         MVI   DTPRCID1,DTPTHDR   IDENTIFY HEADER                       10360000
         TIME  DEC                                                      10370000
         ST    R1,DTHTIMD    SET DAY                                    10380000
         ST    R0,DTHTIMD+4  AND TIME                                   10390000
         MVI   DTHIND2,DTHGVI     NON-VSAM ONLY                         10400000
         LA    R1,DTHSIZE    SIZE OF HEADER - HEADER                    10410000
         STCM  R1,3,DTHLEN                                              10420000
         LA    R1,DTPSIZE(,R1)                                          10430000
         STCM  R1,3,DTPSEGLN      SEGMENT SIZE                          10440000
         MVI   DTHVERNO,X'1F'                                           10450000
         MVI   DTHLVLNO,X'50'                                           10460000
         L     R0,#BUFMAX    MAXIMUM BLOCK                              10470000
         STCM  R0,3,DTHBLKSZ                                            10480000
         L     R0,NUMPICK                                               10490000
         STCM  R0,3,DTHNDS   NUMBER OF DATA SETS                        10500000
         LA    R2,DTHSIZE+DTPSIZE(,R2)                                  10510000
         ST    R2,@BUFCUR    SET SIZE USED                              10520000
         BAL   R9,TAPEOUT    WRITE A BLOCK                              10530000
         SPACE 1                                                        10540000
*---------------------------------------------------------------------* 10550000
*   Now run through the queued data sets just to build the data set   * 10560000
*   name block. Check for duplicate names (on separate volumes) and   * 10570000
*   assign them a fake name.                                          * 10580000
*   The table is built in the output buffer, even though larger than  * 10590000
*   the block size, and is then written as multiple blocks.           * 10600000
*---------------------------------------------------------------------* 10610000
         SPACE 1                                                        10620000
         L     R2,@BUF                                                  10630000
         BAL   R9,BUILDHED   BUILD COMMON HEADER                        10640000
         MVI   DTPRCID1,DTPDSNL   DS NAME LIST                          10650000
         LA    R2,DSSHEDND   POINT TO START OF LIST                     10660000
         ST    R2,@MEMCUR    SAVE FOR REFERENCE                         10670000
         B     DSNLCOMM                                                 10680000
         SPACE 1                                                        10690000
DSNLNEXT SUBCALL NEXTREE     GET NEXT ENTRY                             10700000
         BXH   R15,R15,DSNLTEND   DONE                                  10710000
         L     R8,REC@REC    UPDATE THE CELL ADDRESS                    10720000
         SPACE 1                                                        10730000
         SR    R15,R15                                          GP09197 10740000
         IC    R15,CELLALIL  GET LENGTH BACK                    GP09197 10750000
         L     R2,@BUF                                                  10760000
         SR    R14,R14       CLEAR FOR IC                               10770000
DSNLDLUP CLM   R15,1,DTLLEN  SAME LENGTH ?                              10780000
         BNE   DSNLDBMP      NO; IGNORE                                 10790000
         LR    R14,R15                                                  10800000
         BCTR  R14,0         EXECUTE LENGTH FOR COMPARE                 10810000
         EX    R14,EXCLCDSN  IS IT A DUPLICATE ?                        10820000
         BE    DSNLDDUP      YES; RENAME                                10830000
DSNLDBMP IC    R14,DTLLEN         GET ENTRY LENGTH                      10840000
         LA    R2,DTLSIZE(R14,R2)   NEXT ENTRY                          10850000
         C     R2,@MEMCUR    IS THAT IT ?                               10860000
         BL    DSNLDLUP      NO; CHECK AGAIN                            10870000
         B     DSNLCOM2      RE-USE R15                                 10880000
EXCLCDSN CLC   CELLALI(0),DTLDSN  DUPE CHECK                            10890000
         SPACE 1                                                        10900000
DSNLDDUP MINH  R15,=AL2(L'CELLALI-9) IF TOO LONG, TRUNCATE              10910000
         LA    R1,CELLALI-1(R15)                                        10920000
         CLI   0(R1),C'.'    HIT ON A PERIOD ?                          10930000
         BNE   *+4+2                                                    10940000
         BCTR  R1,0          REUSE IT                                   10950000
         MVC   1(9,R1),=C'.D#nnnnnn'   MAKE FAKE NAME                   10960000
         INC   NUMDUPE,WORK=R0                                          10970000
         CVD   R0,DB                                                    10980000
         OI    DB+7,X'0F'    FORCE SIGN                                 10990000
         MVC   DB2(8),=X'F021202020202020'                              11000000
         ED    DB2(8),DB+4                                              11010000
         MVC   4(6,R1),DB2+2   MAKE UNIQUE (?) NAME                     11020000
         SPACE 1                                                        11030000
DSNLCOMM SR    R15,R15                                          GP09197 11040000
         IC    R15,CELLALIL  LENGTH TO FIRST BLANK              GP09197 11050000
DSNLCOM2 L     R2,@MEMCUR    GET CURRENT USE                            11060000
         USING DTLLEN,R2     SKIP PAST HEADER                           11070000
         LA    R3,DTLSIZE(R15,R2)  SIZE AFTER MOVE                      11080000
         C     R3,@MEMEND    WILL IT FIT                                11090000
         BL    DSNLMOVE      YES (NOTE IT TAKES ONE MORE)               11100000
      PRTL '*** Data set name table overflow - split job? ***',NL,CC=NO 11110000
         PRTDATA '    at data set',(NUMPICK,I,PAD)                      11120000
         B     PGMEXIT8                                                 11130000
         SPACE 1                                                        11140000
DSNLMOVE STC   R15,DTLLEN    SET DSN LENGTH                             11150000
         MVC   DTLCAT,CSPRCAT  CATALOG NAME (IRRELEVANT?)               11160000
         EX    R15,EXMVCDSN  MOVE NAME + ONE CRUD BYTE                  11170000
         ST    R3,@MEMCUR    UPDATE BUFFER                              11180000
         B     DSNLNEXT      PROCESS NEXT DATA SET                      11190000
EXMVCDSN MVC   DTLDSN(0),CELLALI       MOVE NAME                        11200000
         SPACE 1                                                        11210000
DSNLTEND L     R3,@MEMCUR    POINT TO END OF BUFFER                     11220000
         MVI   0(R3),X'0'    END FLAG - NO DSN                          11230000
         LA    R3,1(,R3)     ADJUST LENGTH                              11240000
         ST    R3,@MEMCUR                                               11250000
         ST    R3,@BUFCUR    FOR SINGLE BLOCK                           11260000
         L     R2,@BUF       BUFFER START                               11270000
         USING DSSBLOCK,R2        HEADER                                11280000
         C     R3,@BUFEND         SINGLE BLOCK ?                        11290000
         BNH   DSNL1BLK           YES; WRITE DSN TABLE AS SINGLE BLOCK  11300000
         SPACE 1                                                        11310000
*---------------------------------------------------------------------* 11320000
*    The Data Set Name Table is larger than the block size, but less  * 11330000
*    than 65KB. Break it into block-sized chunks.                     * 11340000
*    To make life more interesting, a simple break was too easy for   * 11350000
*    IBM - each chunk must end with a DSN length field, artificially  * 11360000
*    set to zero. And we need to examine data to get segment count!   * 11370000
*---------------------------------------------------------------------* 11380000
         LA    R15,DTLLEN    GET FIRST DATUM                            11390000
         SR    R1,R1         CLEAR IC REGISTER                          11400000
         LA    R5,1          AT LEAST ONE SEGMENT                       11410000
         LA    R4,1          ALLOW FOR ZERO END BYTE                    11420000
DSNLSLUP LR    R14,R15       CURRENT DSN ENTRY                          11430000
         ICM   R1,1,0(R14)   DSN LENGTH                                 11440000
         BZ    DSNLSDON      DONE                                       11450000
         LA    R15,DTLSIZE(R1,R14)  NEXT ENTRY                          11460000
         LA    R4,DTLSIZE(R1,R4)    PURPORTED DATA SIZE IN BLOCK        11470000
         C     R4,#DATMAX    WILL IT FIT ?                              11480000
         BL    DSNLSLUP      YES; TRY AGAIN                             11490000
         LA    R4,1+DTLSIZE(R1)     SIZE IN NEXT BLOCK                  11500000
         LA    R5,1(,R5)     NEW SEGMENT COUNT                          11510000
         B     DSNLSLUP        TRY NEXT                                 11520000
DSNLSDON STC   R5,DTPNOSEG   SAVE SEGMENT COUNT                         11530000
         LR    R5,R3         COPY END ADDRESS                           11540000
         SR    R5,R2         LESS START                                 11550000
         SH    R5,=AL2(DTPSIZE)   LESS HEADER                           11560000
         LA    R4,DTLLEN          POINT TO START OF DATA                11570000
DSNLBLKN L     R7,#DATMAX         SIZE WE'RE WRITING                    11580000
         AR    R7,R2              LAST BYTE+1                           11590000
         LR    R15,R4             POINT TO DATA START                   11600000
         SR    R1,R1              CLEAR FOR IC                          11610000
DSNLHLUP LR    R14,R15            COPY TO WORKING REGISTER              11620000
         ICM   R1,1,0(14)         GET NEXT DSN LENGTH                   11630000
         BZ    DSNLHDON              BUT SHOULD NOT HAPPEN?             11640000
         LA    R15,DTLSIZE(R1,R14)   NEXT LENGTH BYTE                   11650000
         CR    R15,R7             AT END OF CHUNK?                      11660000
         BNH   DSNLHLUP           AND AGAIN                             11670000
DSNLHDON ICM   R6,8,0(R14)        SAVE OLD LENGTH                       11680000
         MVI   0(R14),0           SET END FLAG                          11690000
         LR    R7,R14             END ADDRESS                           11700000
         SR    R7,R4              GET DATA LENGTH USED                  11710000
         BNP   COPYINIT      SHOULD NOT HAPPEN?                         11720000
         LA    R7,1(,R7)         CURRENT BYTE OF ZERO (NOT DATA)        11730000
         LA    R3,DTPSIZE(,R7)    PLUS HEADER                           11740000
         STCM  R3,3,DTPSEGLN      SET LENGTH INTO RECORD                11750000
         MVC   DB3,DTPNOSEG  SAVE                                       11760000
         BAL   R9,TAPEOUTR   WRITE ONE BLOCK                            11770000
         CR    R5,R7         FINISHED ?                                 11780000
         BNH   COPYINIT      YES                                        11790000
         BCTR  R7,0          ACCOUNT FOR EXTRA LENGTH FIELD             11800000
         SR    R5,R7         ACCOUNT FOR PORTION WRITTEN                11810000
         AR    R4,R7         NEXT BUFFER START                          11820000
         STCM  R6,8,0(R4)    RESTORE DSN LENGTH                         11830000
         LR    R2,R4         GET DATA START                             11840000
         SH    R2,=AL2(DTPSIZE)  ROOM FOR NEXT HEADER                   11850000
         BAL   R9,BUILDHED   BUILD BASICS                               11860000
         MVC   DTPNOSEG(8),DB3   RESTORE                                11870000
         SR    R15,R15                                                  11880000
         IC    R15,DTPSEGNO  PREVIOUS                                   11890000
         LA    R15,1(,R15)                                              11900000
         STC   R15,DTPSEGNO  NEXT SEGMENT                               11910000
         B     DSNLBLKN      WRITE THIS SEGMENT                         11920000
         SPACE 1                                                        11930000
DSNL1BLK SR    R3,R2              LENGTH                                11940000
         STCM  R3,3,DTPSEGLN      SET LENGTH INTO RECORD                11950000
         BAL   R9,TAPEOUT                                               11960000
         SPACE 1                                                        11970000
*---------------------------------------------------------------------* 11980000
*   Copy Data Set information - fake as SMS.                          * 11990000
*---------------------------------------------------------------------* 12000000
         SPACE 1                                                        12010000
COPYINIT SUBCALL LISTREE     INITIALIZE SEQUENTIAL READ BACK            12020000
         LTR   R15,R15       ANY PROBLEM ?                              12030000
         BNZ   COPYIBAD                                                 12040000
         L     R8,REC@REC         GET RECORD ADDRESS                    12050000
         CLC   CELLVOL,VOLVOL     NEW SERIAL ?                          12060000
         BE    COPYTYPE           NO; JUST GET DEVICE TYPE              12070000
         B     COPYFILE           YES; SWITCH PACKS                     12080000
COPYIBAD PRTDATA '*** Program error in SUBTREE ***'                     12090000
         PRTCLOSE ,          WRITE MESSAGE BEFORE DUMP                  12100000
         ABEND 1001,DUMP                                                12110000
         SPACE 1                                                        12120000
COPYNEXT SUBCALL NEXTREE     GET NEXT ENTRY                             12130000
         BXH   R15,R15,COPYTEND   DONE                                  12140000
         L     R8,REC@REC         GET RECORD ADDRESS                    12150000
COPYFILE CLC   CELLVOL,VOLVOL     NEW SERIAL ?                          12160000
         BE    COPYSAME           NO                                    12170000
         VOLREAD OPEN,CELLVOL                                           12180000
         BXH   R15,R15,COPYBADV                                         12190000
         MVC   VOLVOL,CELLVOL                                           12200000
COPYTYPE MVC   GENERIC,BLANKS                                           12210000
         SERVCALL UCBVS,VOLVOL    GET UCB BACK                          12220000
         LTR   R1,R0              TEST                                  12230000
         BZ    COPYSAME           WILL FAIL ?                           12240000
         LR    R2,R1         SAVE OVER SUBROUTINE CALL          GP09210 12250000
         SUBCALL SUBVTVAL    GET TRACK SIZE, ETC FOR UCB IN R1  GP09210 12260000
         LTR   R15,R15       SUCCESSFUL ?                       GP09210 12270000
         BZ    COPYN4VL      NO; SKIP                           GP09210 12280000
         STM   R15,R0,DB     TEMP STASH                         GP09210 12290000
         MVI   LOCFMT1,X'04'                                    GP09210 12300000
         MVC   LOCFMT1+1(L'LOCFMT1-1),LOCFMT1                   GP09210 12310000
         VOLREAD DSCB        READ THE FORMAT 4                  GP09210 12320000
         BXH   R15,R15,COPYN4VL   ERROR                         GP09210 12330000
         LR    R1,R0              COPY ADDRESS                  GP09210 12340000
         LA    R6,44(,R1)         SKIP NAME                     GP09210 12350000
         USING DS4IDFMT,R6                                      GP09210 12360000
         CLI   DS4IDFMT,C'4'      REALLY?                       GP09210 12370000
         BNE   COPYN4VL           NO; SKIP                      GP09210 12380000
         LM    R15,R0,DB          RESTORE TRK.CAP, DSCB, DE     GP09210 12390000
         CLM   R15,3,DS4DEVTK     MATCHING TRACK CAPACITY?      GP09210 12400000
         BNE   COPY4IFF           NO; MAY NOT WORK              GP09210 12410000
         CLM   R0,3,DS4DEVDT      TEST DSCB,DE COUNT            GP09210 12420000
         BE    COPYN4VL           GOOD                          GP09210 12430000
COPY4IFF PRTDATA '***',(VOLVOL,PAD),'device constants do not match IBM'*12440000
               's; like device restore with ADRDSSU questionable ***'   12450000
         PRTDATA 'VTOC track size',(DS4DEVTK,IA,PAD),' DSCBs/tk',(DS4DE*12460000
               VDT,IA,PAD),' DirBlk/tk',(DS4DEVDB,IA,PAD)       GP09210 12470000
         PRTDATA 'DVCT track size',(DB+2,2,IA,PAD),' DSCBs/tk',(DB+6,1,*12480000
               IA,PAD),' DirBlk/tk',(DB+7,1,IA,PAD)             GP09210 12490000
         OICC  4                  SET WARNING                   GP09210 12500000
         DROP  R6                                               GP09210 12510000
COPYN4VL SERVCALL UCBGN,(R2)      GET GENERIC                   GP09210 12520000
         LM    R14,R15,0(R1)      LOAD RESULT                           12530000
         LA    R0,7               SHOW SOME RESTRAINT                   12540000
COPYSGLP CLM   R15,1,BLANKS       TRAILING BLANK ?                      12550000
         BNE   COPYSGEN                                                 12560000
         SRDL  R14,8                                                    12570000
         ICM   R14,8,BLANKS       LEFT FILL                             12580000
         BCT   R0,COPYSGLP                                              12590000
COPYSGEN STM   R14,R15,GENERIC    COPY RESULT OR BLANK                  12600000
         SPACE 1                                                        12610000
*---------------------------------------------------------------------* 12620000
*   Finally we can actually write a data set:                         * 12630000
*   1) Get the format 1 DSCB, and a format 3 if present               * 12640000
*   2) Write the data set header record                               * 12650000
*   3) Write the volume header                                        * 12660000
*   4) Write the track data  (up to LSTAR+1 tracks; all if ALLDATA)   * 12670000
*---------------------------------------------------------------------* 12680000
COPYSAME XC    DSN#TRAK(NUMPCYL-DSN#TRAK),DSN#TRAK  RESET COUNTERS      12690000
         ZI    OPTFLAGS,FGPSPO    RESET DSORG FLAG                      12700000
         ZI    PROFLAGS,PFSOME    RESET NOT ALLDATA FLAG        GP09202 12710000
         MVC   DSN#TMAX,=X'7FFFFFFF'    DUMP ALL TRACKS                 12720000
         L     R2,@BUF                                                  12730000
         BAL   R9,BUILDHED        BUILD HEADER                          12740000
         XC    DTDLEN(DTDSIZE),DTDLEN  CLEAR UNUSED                     12750000
         MVI   DTPRCID1,DTPDSHDR  DATA SET HEADER                       12760000
         LA    R3,DTPSIZE+DTDSIZE  SEGMENT SIZE                         12770000
         STCM  R3,3,DTPSEGLN      SET                                   12780000
         AR    R3,R2                                                    12790000
         ST    R3,@BUFCUR                                               12800000
         MVC   DTDLEN,CELLALIL    GET DATA SET NAME LENGTH      GP09197 12810000
         MVC   DTDCATLN,CSPRTYP   COPY CATALOG NAME LENGTH      GP09192 12820000
         MVI   DTDNVOL,1          ONLY VOLUME SUPPORTED AT PRESENT      12830000
         MVI   DTDIND,DTDSMS           FAKE SMS AND RACF        GP09193 12840000
*DOC*    XC    DTDPSWD,DTDPSWD    NO PASSWORD                   GP09193 12850000
         MVC   DTDDSN-L'CSPRCAT(L'CSPRCAT),CSPRCAT                      12860000
         MVC   DTDDSN,CELLALI                                           12870000
         MVI   DTDVCTD,1          VOLUME COUNT                          12880000
*DOC*    MVI   DTDVCTD+1,0        VSAM COMPONENT COUNT                  12890000
         VOLREAD SEARCH,CELLDSN     GET FORMAT 1 DSCB                   12900000
         BXH   R15,R15,COPYBAD1   NONE ?                                12910000
         LR    R6,R0                                                    12920000
         USING IECSDSL1,R6                                              12930000
         MVC   LOCFMT1(DS1END-IECSDSL1),IECSDSL1   SAVE FOR LATER       12940000
         LA    R6,LOCFMT1         USE PERMANENT COPY                    12950000
         MVC   DS1DSNAM,CELLALI   FAKE USING ALIAS NAME                 12960000
         MVC   DTDDSORG,DS1DSORG                                        12970000
         MVC   DTDOPTCD,DS1OPTCD                                        12980000
         LA    R1,DS1CREDT        POINT TO DATE                 GP09194 12990000
         BAL   R9,FIXDATE         FIX IT UP                     GP09194 13000000
         LA    R1,DS1EXPDT        POINT TO DATE                 GP09194 13010000
         BAL   R9,FIXDATE         FIX IT UP                     GP09194 13020000
         LA    R1,DS1REFD         POINT TO DATE                 GP09194 13030000
         BAL   R9,FIXDATE         FIX IT UP                     GP09194 13040000
         TM    OPTFLAGS,FGEXP     EXPORTING THIS ?              GP09197 13050000
         BZ    COPYNSET           NO                            GP09197 13060000
         NI    DS1DSIND,255-(DS1IND40+DS1IND10+DS1IND04)        GP09197 13070000
         XC    DS1EXPDT,DS1EXPDT  KILL EXPIRATION               GP09197 13080000
         NI    DS1DSORG,255-DS1DSGU   RESET UNMOVEABLE          GP09197 13090000
COPYNSET TM    OPTFLAGS,FGADAT    ALLDATA/ALLEXCP ?                     13100000
         BNZ   COPYALLT      YES; COPY ALL ALLOCATED TRACKS             13110000
         TM    DS1DSORG,DS1DSGPS+DS1DSGPO   SEQUENTIAL OR PARTITIONED?  13120000
         BNM   COPYALLT      NEITHER - COPY ALL                         13130000
         TM    DS1DSORG+1,0  VSAM, ETC.?                        GP09186 13140000
         BNE   COPYALLT      FUNNY - COPY ALL                   GP09186 13150000
         OI    OPTFLAGS,FGPSPO    INDICATE LSTAR VALID                  13160000
         SR    R1,R1                                                    13170000
         ICM   R1,3,DS1LSTAR                                            13180000
         LA    R1,1(,R1)     NUMBER TO BE DONE                          13190000
         ST    R1,DSN#TMAX   SAVE                                       13200000
         OI    DTDIND2,DTDNTALL   SHOW SKIPPING UNUSED TRACKS           13210000
         OI    PROFLAGS,PFSOME    SHOW SKIPPING TRACKS          GP09202 13220000
COPYALLT BAL   R9,TAPEOUT         WRITE THE DATA SET HEADER             13230000
         SPACE 1                                                        13240000
*---------------------------------------------------------------------* 13250000
*   Write volume information. Create fake VVRS; fake indexed VTOC     * 13260000
*---------------------------------------------------------------------* 13270000
COPYVTOC L     R2,@BUF                                                  13280000
         BAL   R9,BUILDHED        BUILD HEADER                          13290000
         MVI   DTPRCID1,DTPVOLD   VOLUME HEADER                         13300000
         XC    DTMVOL(256),DTMVOL  CLEAR UNUSED ITEMS           GP09193 13310000
         XC    DTMVOL+256(256),DTMVOL+256  CLEAR MORE           GP09193 13320000
         MVC   DTMVSERL,CELLVOL   SERIAL                                13330000
         SERVCALL UCBDK,CELLVOL   GET UCB                               13340000
         LTR   R1,R0         DID WE FIND IT ?                           13350000
         BZ    COPYNUCB        BUT HOW/                                 13360000
         MVC   DTMDEVTY,UCBTBYT1-UCBOB(R1)                              13370000
         SR    R14,R14                                                  13380000
         IC    R14,UCBTBYT4-UCBOB(R1)  GET DEVICE TYPE                  13390000
         N     R14,=A(DVCTYPMK)    REMOVE EXTRANEOUS BITS               13400000
         L     R15,CVTPTR    GET CVT                                    13410000
         L     R15,CVTZDTAB-CVTMAP(,R15)                                13420000
         IC    R14,DVCTIOFF-DVCTI(R14,R15)   GET DEVICE OFFSET          13430000
         AR    R14,R15       GET DEVICE ENTRY                           13440000
         MVC   DTMTRKCP+2(2),DVCTRKLN-DVCT(R14)  RAW TRACK SIZE         13450000
         MVC   DTMLOGCY(L'DTMLOGCY+L'DTMTRKCY),DVCCYL-DVCT(R14)         13460000
         MVC   NUMPCYL+2(2),DVCCYL+2-DVCT(R14)                          13470000
COPYNUCB MVI   DTM#DSCB,1    FOR NOW                                    13480000
         MVI   DTM#VVRS,1         FAKE VVRS                     GP09193 13490000
         MVI   DTMFLAGS,DTMCVAF   INDEXED VTOC                  GP09193 13500000
         MVC   DTMDSCB(DS1END-IECSDSL1),LOCFMT1                         13510000
         XC    LOCFMT3,LOCFMT3    CLEAR PROPOSED FMT3 INPUT             13520000
         OC    DS1PTRDS,DS1PTRDS  IS THERE A FORMAT 3?                  13530000
         BZ    COPY3NOT                                                 13540000
         VOLREAD DSC3 DS1PTRDS    GET FMT3 FOR PREVIOUS FMT 1           13550000
         LR    R1,R0                                                    13560000
         BXH   R15,R15,COPY3NOT   OOPS?                                 13570000
         LR    R1,R0                                                    13580000
         CLI   DS3FMTID-IECSDSL3(R1),C'3'                               13590000
         BNE   COPY3NOT                                                 13600000
         MVC   LOCFMT3(DS3END-IECSDSL3),0(R1)    SAVE FOR LATER         13610000
COPY3NOT SR    R3,R3                                                    13620000
         IC    R3,DS1NOEPV   GET EXTENTS                        GP09193 13630000
         TM    OPTFLAGS,FGADAT    ALLDATA/ALLEXCP ?             GP09314 13640000
         BZ    COPYNSUL      NO                                 GP09314 13650000
         CLI   DS1EXT1,X'40' LABEL TRACK PRESENT?               GP09314 13660000
         BNE   COPYNSUL      NO                                 GP09314 13670000
         LA    R3,1(,R3)     SET PHYSICAL EXTENTS               GP09314 13680000
COPYNSUL STC   R3,DTM#EXT    AND UPDATE                         GP09314 13690000
         LR    R5,R3         EXTENTS ON THIS VOLUME             GP09238 13700000
         MH    R3,=AL2(DS1EXT2-DS1EXT1)     EXTENT DATA         GP09193 13710000
         LA    R3,DTPSIZE+DTMSIZE-(DS1EXT2-DS1EXT1)(,R3)        GP09193 13720000
         SR    R15,R15                                          GP09193 13730000
         IC    R15,CSPRTYP        LENGTH OF CATALOG NAME        GP09193 13740000
         AR    R3,R15                                           GP09193 13750000
         IC    R15,CELLALIL       LENGTH OF DATA SET NAME       GP09197 13760000
         AR    R3,R15                                           GP09193 13770000
         STCM  R3,3,DTPSEGLN                                            13780000
         AR    R3,R2                                                    13790000
         ST    R3,@BUFCUR                                               13800000
*   MAKE ALL (16) EXTENTS CONTIGUOUS FOR EASIER USE                     13810000
         MVC   DS1EXT1+3*10(4*10),DS3EXTNT-IECSDSL3+LOCFMT3     GP09193 13820000
         MVC   DS1EXT1+7*10(9*10),DS3ADEXT-IECSDSL3+LOCFMT3     GP09193 13830000
         LR    R15,R5                                           GP09193 13840000
         MH    R15,=AL2(DS1EXT2-DS1EXT1)                                13850000
         BCTR  R15,0         TOTAL EXTENT SIZE -1                       13860000
         LA    R4,DS1EXT1    POINT TO FIRST EXTENT IN LIST      GP09193 13870000
         CLI   DS1EXT1,X'40'      LABEL TRACK ?                         13880000
         BNE   COPYNLBL      NO                                         13890000
         TM    OPTFLAGS,FGADAT    ALLDATA/ALLEXCP ?             GP09314 13900000
         BNZ   COPYNLBL      YES; COPY LABEL TRACK ALSO         GP09314 13910000
         LA    R4,DS1EXT2    SKIP LABEL TRACK                           13920000
COPYNLBL MVC   CURCCHH,2(R4)   COPY STARTING CC HH                      13930000
EXMVCEXT MVC   DTMEXTS(0),0(R4)   COPY EXTENTS                  GP09193 13940000
         STM   R4,R5,CUREXT       SAVE FOR COPY                 GP09238 13950000
         TM    PROFLAGS,PFSOME    PARTIAL DUMP ?                GP09202 13960000
         BZ    COPYXALL           NO; DUMP ALL                  GP09202 13970000
*---------------------------------------------------------------------* 13980000
*   WE ARE DUMPING ONLY SOME OF THE TRACKS IN THE DATA SET.           * 13990000
*   WE NEED TO MOVE ALL EXTENTS NECESSARY TO SATISFY LSTAR(+1), AND   * 14000000
*   CLIP THE LAST EXTENT TO MATCH THE LSTAR TRACK                     * 14010000
*---------------------------------------------------------------------* 14020000
         LR    R9,R2         TEMP RE-ASSIGNEMNT                 GP09202 14030000
         DROP  R2            GONE, BUT NOT FORGOTTEN            GP09202 14040000
         USING DSSBLOCK,R9                                      GP09202 14050000
         ICM   R6,3,DS1LSTAR   GET LSTAR BACK                   GP09202 14060000
         DROP  R6                                               GP09202 14070000
         N     R6,=X'0000FFFF'    KILL SIGN EXTENSION           GP09202 14080000
         LA    R6,1(,R6)     NUMBER OF USED TRACKS              GP09202 14090000
         LA    R3,DTMEXTS    FIRST EXTENT DESTINATION           GP09202 14100000
         L     R2,NUMPCYL    TRACKS PER CYLINDER                GP09202 14110000
         MVI   DTM#EXT,0     RESET EXTENT COUNT                 GP09202 14120000
         SPACE 1                                                        14130000
COPYXSLP LR    R1,R4         CURRENT EXTENT ADDRESS             GP09202 14140000
         LA    R0,1          ONE AT A TIME                      GP09202 14150000
         L     R15,=V(SUBXTSUM)    EXTENT SIZER                 GP09202 14160000
         BALR  R14,R15       GET EXTENT SIZE                    GP09202 14170000
         LTR   R15,R15       ANY ?                              GP09202 14180000
         BNP   COPYXSUP      SKIP BAD EXTENT                    GP09202 14190000
         SR    R14,R14                                          GP09202 14200000
         IC    R14,DTM#EXT   GET CURRENT COUNT                  GP09202 14210000
         LA    R14,1(,R14)   BUMP                               GP09202 14220000
         STC   R14,DTM#EXT   STASH BACK                         GP09202 14230000
         MVC   0(10,R3),0(R4)   COPY EXTENT                     GP09202 14240000
         CR    R15,R6        SATISFIED LSTAR YET ?              GP09202 14250000
         BH    COPYXSTK      YES; NEED TO ADJUST END CCHH       GP09202 14260000
         BE    COPYXSTX      YES, EXACTLY                       GP09202 14270000
         SR    R6,R15        NEW RESIDUAL                       GP09202 14280000
         LA    R3,10(,R3)    NEXT OUTPUT                        GP09202 14290000
COPYXSUP LA    R4,10(,R4)    NEXT INPUT                         GP09202 14300000
         BCT   R5,COPYXSLP   TRY NEXT                           GP09202 14310000
         B     COPYXSTY      ?  SHOULD GET HERE                 GP09202 14320000
COPYXSTK SR    R15,R15       COPY RESIDUAL LSTAR COUNT          GP09202 14330000
         SR    R14,R14                                          GP09202 14340000
         ICM   R15,3,2(R3)   START CC                           GP09202 14350000
         MR    R14,R2        CONVERT TO TRACKS                  GP09202 14360000
         ICM   R14,3,4(R3)   GET TRACKS                         GP09202 14370000
         AR    R15,R14       ADD RESIDUAL TRACKS                GP09202 14380000
         AR    R15,R6        ADD LSTAR TRACKS                   GP09202 14390000
         BCTR  R15,0         ALLOW FOR LSTAR BUMP               GP09202 14400000
         SR    R14,R14       CLEAR FOR DIVIDE                   GP09202 14410000
         DR    R14,R2        GET TRACKS / CYLINDERS OF END      GP09202 14420000
         STCM  R15,3,6(R3)   STASH END CYLINDER                 GP09202 14430000
         STCM  R14,3,8(R3)     AND END TRACK                    GP09202 14440000
COPYXSTX LA    R3,10(,R3)    SET FOR VVRS ADDRESS               GP09202 14450000
COPYXSTY LR    R2,R9         RESTORE                            GP09202 14460000
         SR    R14,R14                                          GP09202 14470000
         IC    R14,DTM#EXT   GET CURRENT COUNT                  GP09202 14480000
         ST    R14,CUREXT+4  SAVE EXTENT COUNT                  GP09238 14490000
         DROP  R9                                               GP09202 14500000
         USING DSSBLOCK,R2                                      GP09202 14510000
         B     COPYXCOM      AND BUILD IT                               14520000
         SPACE 1                                                        14530000
*---------------------------------------------------------------------* 14540000
*   ALLDATA/ALLEXCP MODE, OR NOT A PS/PO DATA SET - USE ALL EXTENTS   * 14550000
*---------------------------------------------------------------------* 14560000
COPYXALL EX    R15,EXMVCEXT    COPY EXTENTS                     GP09193 14570000
         LA    R3,DTMEXTS+1(R15)  VVRS LOCATION                 GP09193 14580000
*PRTDATA '>>> Extent',(0(R4),2,HEX,PAD),(2(R4),4,HEX),(6(R4),4,HEX,PAD) 14590000
         PUSH  USING                                            GP09193 14600000
         USING DTMVVRS,R3    DECLARE FAKE VVRS RECORD           GP09193 14610000
COPYXCOM SR    R15,R15       DATA SET LENGTH                    GP09193 14620000
         SR    R14,R14       CATALOG LENGTH                     GP09193 14630000
         IC    R15,CELLALIL  GET LENGTH OF DSN                  GP09193 14640000
         LA    R15,1(,R15)     FINAGLE ??                       GP09193 14650000
         IC    R14,CSPRTYP   GET LENGTH OF CDSN                 GP09193 14660000
         LA    R0,12(R14,R15)   LENGTH OF NAME SEGMENT          GP09193 14670000
         STCM  R0,3,DTMVL2   SET LENGTH OF N SEGMENT            GP09193 14680000
         LA    R0,L'DTMREST+14(R14,R15)  LENGTHS + OHD          GP09193 14690000
         STCM  R0,3,DTMVL1   SET TOTAL LENGTH OF RECORD         GP09193 14700000
         MVC   DTMVT1,=XL6'D50000000000'                        GP09193 14710000
         STC   R15,DTMVDSL   DSN LENGTH                         GP09193 14720000
         BCTR  R15,0           FINAGLE ??                       GP09193 14730000
EXMVCCDS MVC   DTMVDSN(0),CELLALI   MOVE DSN                    GP09247 14740000
         EX    R15,EXMVCCDS  MOVE DSN (+1 GARBAGE)              GP09193 14750000
         LA    R15,DTMVDSN(R15)  POINT PAST DSN                 GP09193 14760000
         XC    0(2,R15),0(R15)   MAKE SURE IT'S CLEAR           GP09193 14770000
         STC   R14,2(,R15)       SET CATALOG DSN LENGTH         GP09193 14780000
         EX    R14,EXMVCCAT      MOVE CATALOG NAME              GP09193 14790000
         LA    R15,3(R14,R15)    PAST CATALOG NAME              GP09193 14800000
         MVI   0(R15),0          CLEAR                          GP09193 14810000
         MVC   1(L'VVRSREST,R15),VVRSREST  MOVE REST            GP09193 14820000
         POP   USING                                            GP09193 14830000
         BAL   R9,TAPEOUT         WRITE THE DATA SET HEADER             14840000
         B     COPYTGET                                         GP09193 14850000
         SPACE 1                                                        14860000
EXMVCCAT MVC   3(0,R15),CSPRCAT  MOVE CATALOG NAME              GP09193 14870000
         SPACE 1                                                        14880000
*---------------------------------------------------------------------* 14890000
*   Loop through extents and write track images.                      * 14900000
*---------------------------------------------------------------------* 14910000
         SPACE 1                                                        14920000
COPYTGET LM    R4,R5,CUREXT  GET CURRENT EXTENT AND COUNT       GP09247 14930000
COPYTRAK STM   R4,R5,CUREXT  SAVE CURRENT EXTENT AND COUNT LEFT GP09247 14940000
         CLI   0(R4),0       NULL EXTENT?                               14950000
         BE    COPYDONE      YES; DONE WITH THIS DATA SET               14960000
COPYTTWO L     R2,@BUFCUR    GET CURRENT SLOT                           14970000
         L     R0,@BUFEND                                               14980000
         SR    R0,R2         ROOM LEFT IN CURRENT BUFFER                14990000
         CH    R0,=H'40'     ARBITRARY MINIMUM                          15000000
         BNL   COPYSOME                                                 15010000
         BAL   R9,TAPEOUT    WRITE OUT THE CURRENT BUFFER               15020000
         L     R2,@BUFCUR    LOAD NEW BUFFER START                      15030000
COPYSOME BAL   R9,BUILDHED   MAKE TRACK HEADER                          15040000
         XC    DTTTRK(DTTSIZE),DTTTRK   CLEAR UNUSED                    15050000
         MVI   DTPRCID1,DTPDATA   TRACK RECORD                          15060000
         MVC   DTTCCHH,CURCCHH    COPY ADDRESS                          15070000
         VOLREAD TRACK,CURCCHH    READ NEXT TRACK                       15080000
         LR    R6,R1                                                    15090000
         USING MAPVOLRD,R6                                              15100000
         BXLE  R15,R15,COPYTROK   HAVE IT                               15110000
         OI    DTTTRKID,DTTIOER   SET FOR ERROR                         15120000
         OICC  4,8           SET BAD TRACK                              15130000
         PRTDATA '*** Track',(CURCCHH,HEX,PAD),'failed ***'             15140000
COPYTROK SR    R5,R5         SIZE FOR I/O ERROR                         15150000
         TM    DTTTRKID,DTTIOER   TEST FOR ERROR                        15160000
         BNZ   *+8           YES; NO DATA                               15170000
         A     R5,TRKCURSZ                                              15180000
         LA    R4,DB         ANY VALID ADDRESS (FOR I/O ERROR)          15190000
         LA    R1,8(,R5)     ALLOW FOR R0 DATA                          15200000
         STH   R1,DTTTRKLN   DATA LENGTH                                15210000
         LA    R1,DTPSIZE+DTTSIZE(,R5)      FULL TRACK SIZE             15220000
         STH   R1,DTPSEGLN   STASH FOR FIT                              15230000
         INC   DSN#TRAK      COUNT TRACKS WRITTEN                       15240000
         TM    DTTTRKID,DTTIOER   TEST FOR ERROR                        15250000
         BNZ   COPYNOST      YES; NO DATA                               15260000
         L     R4,TRK@DATA   FIRST COUNT FIELD                          15270000
         L     R14,TRK#BLOK  RECORDS ON TRACK                           15280000
         A     R14,DSN#REC   COUNT                                      15290000
         ST    R14,DSN#REC   BLOCKS WRITTEN                             15300000
         TM    OPTFLAGS,FGPSPO    SEQUENTIAL ?                          15310000
         BNZ   COPYNOST      YES; DON'T NEED R0                         15320000
         MVC   DTTR0DAT,TRKR0DAT   R0 DATA                              15330000
COPYNOST LA    R14,DTTCOUNT  TRACK START                                15340000
         L     R15,@BUFEND   END OF BUFFER                              15350000
         SR    R15,R14       SIZE LEFT IN BUFFER                        15360000
         CR    R5,R15        DOES TRACK FIT ?                           15370000
         BNH   COPYMOVE                                                 15380000
         L     R0,@BUFEND                                               15390000
         SR    R0,R2         HEADER+DATA LENGTH                         15400000
         STH   R0,DTPSEGLN   SET PARTIAL SIZE                           15410000
         LR    R1,R5         RESIDUAL SIZE                              15420000
         SR    R1,R15        LESS CURRENT BUFFER                        15430000
         SR    R0,R0                                                    15440000
         D     R0,#DATMAX    DATA SIZE OF ONE BUFFER                    15450000
         LTR   R0,R0         ANY REMAINDER                              15460000
         BZ    *+8           NO                                         15470000
         LA    R1,1(,R1)     PARTIAL                                    15480000
         LA    R1,1(,R1)     PLUS CURRENT = NUMBER OF SEGMENTS          15490000
         STC   R1,DTPNOSEG   FIRST SEGMENT OF #                         15500000
COPYSPLT MVC   DB3,DTPNOSEG  SAVE IT                                    15510000
         MVCL  R14,R4        COPY PARTIAL TRACK DATA                    15520000
         ST    R14,@BUFCUR   UPDATE FOR NEXT TIME                       15530000
         LTR   R5,R5         ANYTHING LEFT ?                            15540000
         BNP   COPYBUMP      NO; DO NEXT TRACK                          15550000
         BAL   R9,TAPEOUT    WRITE FIRST/NEXT BUFFER                    15560000
         L     R2,@BUFCUR    NEXT AVAILABLE ADDRESS                     15570000
         BAL   R9,BUILDHED   MAKE NEW HEADER                            15580000
         MVC   DTPNOSEG(8),DB3   SET OLD HEADER INFO                    15590000
         SR    R1,R1                                                    15600000
         IC    R1,DTPSEGNO   PREVIOUS SEGMENT                           15610000
         LA    R1,1(,R1)     INCREASE                                   15620000
         STC   R1,DTPSEGNO   AND WRITE BACK                             15630000
         LA    R14,DSSHEDND  DATA START                                 15640000
         L     R15,#DATMAX   SIZE IN THIS BUFFER                        15650000
         LR    R1,R15                                                   15660000
         MIN   R1,(R5)       MAX MOVEABLE                               15670000
         LR    R15,R1        COPY                                       15680000
         LA    R1,DTPSIZE(R1)  SIZE OF THIS PORTION                     15690000
         STH   R1,DTPSEGLN   SET SIZE                                   15700000
         B     COPYSPLT      WRITE NEXT SEGMENT                         15710000
COPYMOVE LR    R15,R5        NOT MORE THAN WHAT'S AVAILABLE             15720000
         MVCL  R14,R4        COPY TRACK DATA                            15730000
         ST    R14,@BUFCUR   FOR NEXT TIME                              15740000
         SPACE 1                                                        15750000
COPYBUMP BAL   R9,TAPEOUT         WRITE BLOCK, IF USED          GP09210 15760000
         LM    R4,R5,CUREXT  GET CURRENT EXTENT ADDRESS / COUNT         15770000
         CLI   0(R4),X'40'   LABEL TRACK ?                              15780000
         BE    COPYBLAB      YES; IGNORE IT                             15790000
         INC   DSN#DATA,WORK=R0   COUNT DATA TRACKS                     15800000
         C     R0,DSN#TMAX   PAST END?                                  15810000
         BNL   COPYDONE      DONE WITH LOGICAL DATA                     15820000
COPYBLAB SR    R14,R14                                                  15830000
         SR    R15,R15                                                  15840000
         ICM   R15,3,CURCCHH+2    CURRENT HEAD ADDRESS                  15850000
         LA    R15,1(,R15)   UP                                         15860000
         STH   R15,CURCCHH+2      SET IT BACK                           15870000
         CLC   CURCCHH,6(R4)      IN CURRENT EXTENT ?                   15880000
         BH    COPYBUMR             NO; GET NEXT EXTENT                 15890000
         C     R15,NUMPCYL        IN CURRENT CYLINDER ?                 15900000
         BL    COPYTRAK             YES; GET IT                 GP09238 15910000
         STH   R14,CURCCHH+2      ELSE SET TO ZERO                      15920000
         ICM   R14,3,CURCCHH      GET CYLINDER                          15930000
         LA    R14,1(,R14)        BUMP IT                               15940000
         STH   R14,CURCCHH        STASH BACK                            15950000
         CLC   CURCCHH,6(R4)      IN CURRENT EXTENT ?                   15960000
         BNH   COPYTRAK             YES; GET THIS TRACK         GP09238 15970000
COPYBUMR LA    R4,10(,R4)         NEXT EXTENT                           15980000
         MVC   CURCCHH,2(R4)      SET NEXT ADDRESS                      15990000
*PRTDATA '>>> Extent',(0(R4),2,HEX,PAD),(2(R4),4,HEX),(6(R4),4,HEX,PAD) 16000000
         SH    R5,=H'1'           IS THERE ONE ?                        16010000
         BP    COPYTRAK           YES; DO IT                    GP09238 16020000
COPYDONE BAL   R9,TAPEOUT         WRITE BLOCK, IF USED                  16030000
         SPACE 1                                                        16040000
         PRTLIST FDDSDONE                                               16050000
         INC   NUMCOPY                                                  16060000
         LA    R5,2          TRAILER WRITTEN TWICE                      16070000
COPYTRAL L     R2,@BUF       GET BUFFER START                           16080000
         BAL   R9,BUILDHED   BUILD A HEADER RECORD                      16090000
         LA    R4,DTRSIZE+DTPSIZE  SIZE OF HEADER + TRAILER             16100000
         STCM  R4,3,DTPSEGLN UPDATE LENGTH                              16110000
         AR    R4,R2         BUFFER USED                                16120000
         ST    R4,@BUFCUR    SET IT                                     16130000
         MVI   DTPRCID1,DTPDTRLR  IDENTIFY TRAILER                      16140000
         XC    DTRDLR,DTRDLR      CLEAR DATA                            16150000
         BAL   R9,TAPEOUT    WRITE FINAL RECORD                         16160000
         BCT   R5,COPYTRAL                                              16170000
         B     COPYNEXT           TRY ANOTHER                           16180000
         SPACE 1                                                        16190000
FDDSDONE FDPRT '     ',NL                                               16200000
         FDPRT GENERIC,PAD                                              16210000
         FDPRT CELLVOL                                                  16220000
         FDPRT CELLDSN,PAD                                              16230000
         FDPRT 'dumped'                                                 16240000
         FDPRT DSN#TRAK,I,PAD,RADJ,LEN=10                               16250000
         FDPRT 'Tracks,'                                                16260000
         FDPRT DSN#REC,I,PAD,RADJ,LEN=10                                16270000
         FDPRT 'Blocks'                                                 16280000
         FDCLC CELLDSN,CELLALI,BE=FDDSDONX                              16290000
         FDPRT 'as',NL,RADJ,LEN=14                              GP09197 16300000
         FDPRT CELLALI,PAD                                              16310000
FDDSDONX FDPRT *END                                                     16320000
         DROP  R6                                                       16330000
         SPACE 1                                                        16340000
COPYTEND B     PGMEXIT                                                  16350000
         SPACE 1                                                        16360000
COPYBAD1 PRTDATA '*** FMT1 read on',(CELLVOL,PAD),'failed'              16370000
         B     COPYBADC                                                 16380000
         SPACE 1                                                        16390000
COPYBADV PRTDATA '*** VTOC read for',(CELLVOL,PAD),'failed'             16400000
COPYBADC PRTDATA '    ',(CELLDSN,PAD),'not dumped'                      16410000
         INC   NUMFAIL                                                  16420000
         B     COPYNEXT                                                 16430000
         SPACE 1                                                        16440000
*---------------------------------------------------------------------* 16450000
*   BUILD A SEGMENT HEADER AT (R2)                                    * 16460000
*     NOTE THAT HEADER TYPE AND SEGMENT LENGTH WILL BE COMPLETED      * 16470000
*     BY THE CALLER                                                   * 16480000
*---------------------------------------------------------------------* 16490000
BUILDHED INC   OUT#SEQ,WORK=R0    INCREASE SEGMENT COUNT                16500000
         ST    R0,DTPSEQNO   SET SEGMENT                                16510000
         MVI   DTPNOSEG,1    SEGMENTS/RECORD                            16520000
         MVI   DTPSEGNO,1    SEGMENT IN RECORD                          16530000
         LA    R0,DTPSIZE    PROVISIONAL SIZE                           16540000
         STC   R0,DTPPFXLN   PREFIX LENGTH                              16550000
         STCM  R0,3,DTPSEGLN   SEGMENT LENGTH                           16560000
         MVI   DTPDMPID,DTPLOGCL  LOGICAL DUMP                          16570000
         MVI   DTPRCID1,DTPDATA   SET MOST FREQUENT                     16580000
         MVI   DTPRCFL1,0    NO DISPLACEMENT                            16590000
         XC    DTPRESVD,DTPRESVD  RESERVED WORD                         16600000
         BR    R9                                                       16610000
         SPACE 1                                                        16620000
*---------------------------------------------------------------------* 16630000
*   FIX DATES APPEARING TO BE PRIOR TO 1964                           * 16640000
*---------------------------------------------------------------------* 16650000
FIXDATE  ICM   R14,7,0(R1)   IS THE DATE ALL ZERO ?             GP09194 16660000
         BZR   R9            YES; LEAVE IT ALONE                GP09194 16670000
         SRL   R14,16        ISOLATE YEAR                       GP09194 16680000
         CH    R14,=H'64'    IS IT 1964 OR LATER ?              GP09194 16690000
         BNLR  R9            YES; KEEP IT                       GP09194 16700000
         LA    R14,100(,R14)    CHANGE 1900 -> 2000             GP09194 16710000
         STC   R14,0(,R1)    UPDATE IT                          GP09194 16720000
         BR    R9            RETURN TO CALLER                   GP09194 16730000
         SPACE 1                                                        16740000
*---------------------------------------------------------------------* 16750000
*   TAPE OUTPUT ROUTINE                                               * 16760000
*   FOR BSAM USE PLAIN WRITE WITH NO FRILLS                           * 16770000
*                                                                     * 16780000
*   FOR EXCP, USE WRITE/NOP CCW. NOTE THAT I CAN'T GET UNIT EXCEPTION * 16790000
*   WHEN END OF TAPE MARKER IS PASSED. INSTEAD THE TAPE SWITCH IS     * 16800000
*   TRIGGERED BY AN EQUIPMENT CHECK (DDR IS INHIBITED).               * 16810000
*---------------------------------------------------------------------* 16820000
TAPEOUT  L     R2,@BUF                                                  16830000
         L     R3,@BUFCUR                                               16840000
         SR    R3,R2                                                    16850000
TAPEOUTR STM   R2,R3,SUBSAVE                                            16860000
         LTR   R3,R3         VALID LENGTH ?                     GP09207 16870000
         BNP   TAPEOUTY      PROGRAM ERROR                              16880000
         TM    OPTFLAGS,FGVAR     RECFM=V OR U ?                        16890000
         BZ    TAPEOUTL      U                                          16900000
         SH    R2,=H'8'      BACK UP TO BDW                             16910000
         MVC   HOLDBDW,0(R2)     PRESERVE OLD DATA, IF ANY      GP09207 16920000
         LA    R15,4(,R3)    LENGTH FOR RDW                             16930000
         LA    R14,4(,R15)   LENGTH FOR BDW                             16940000
         LR    R3,R14        NEW WRITE LENGTH                           16950000
         SLDL  R14,16        ALIGN                                      16960000
         STM   R14,R15,0(R2)  BUILD BDW/RDW                             16970000
TAPEOUTL TM    OPTFLAGS,FGTEST    RUNNING IN TEST MODE ?                16980000
         BNZ   TAPEOUTX      YES; BYPASS I/O                            16990000
         TM    DCBMACRF-IHADCB+TAPEDCB,DCBMRECP  EXCP MODE?             17000000
         BNZ   XDAPST        USING EXCP                                 17010000
         WRITE TAPEDECB,SF,TAPEDCB,(R2),(R3),MF=E   WRITE A BIG BLOCK   17020000
         CHECK TAPEDECB          WAIT FOR COMPLETION                    17030000
         B     TAPEOUTX                                                 17040000
         SPACE 1                                                        17050000
XDAPST   STH   R3,TAPECCW+6                                             17060000
         STCM  R2,7,TAPECCW+1     WRITE FROM TEXT                       17070000
         ZI    DCBIFLGS-IHADCB+TAPEDCB,DCBIFEC   ENABLE ERP             17080000
         OI    DCBIFLGS-IHADCB+TAPEDCB,X'40'     SUPPRESS DDR           17090000
         STCM  R3,12,IOBSENS0-IOBSTDRD+TAPEIOB   CLEAR SENSE            17100000
         OI    DCBOFLGS-IHADCB+TAPEDCB,DCBOFLWR  SHOW WRITE DONE        17110000
         XC    TAPEECB,TAPEECB                                          17120000
         EXCP  TAPEIOB                                                  17130000
         WAIT  ECB=TAPEECB                                              17140000
         TM    TAPEECB,X'7F'      GOOD COMPLETION?                      17150000
         BNO   TAPEN7F            NO                                    17160000
         B     TAPEOUTX                                                 17170000
         SPACE 1                                                        17180000
TAPEN7F  TM    IOBUSTAT-IOBSTDRD+TAPEIOB,IOBUSB7  END OF TAPE MARKER?   17190000
         BNZ   TAPEEND       YES; SWITCH TAPES                          17200000
         CLC   =X'1020',IOBSENS0-IOBSTDRD+TAPEIOB  EXCEEDED AWS/HET ?   17210000
         BNE   TAPEB001                                                 17220000
         INC   DCBBLKCT-IHADCB+TAPEDCB,INC=-1    FIX BLOCK COUNT        17230000
         EOV   TAPEDCB       TRY TO RECOVER                             17240000
 PRTDATA '--- New tape at block',(OUT#BLOK,I,PAD),'***'                 17250000
         B     XDAPST                                                   17260000
         SPACE 1                                                        17270000
TAPEB001 LA    R9,TAPEIOB    GET IOB FOR QUICK REFERENCE                17280000
         PRTLIST FDTAPIOB    PRINT INFO                                 17290000
         PRTCLOSE                                                       17300000
         ABEND 001,DUMP                                                 17310000
         SPACE 1                                                        17320000
         USING IOBSTDRD,R9   DECLARE IT                                 17330000
FDTAPIOB FDOPT NL,CC=C'0'                                               17340000
         FDPRT '*** TAPE WRITE ERROR; ECB='                             17350000
         FDPRT TAPEECB,HEX,PADR                                         17360000
         FDPRT '***'                                                    17370000
         FDFD  IOBFLAG1,OPTL=NL                                         17380000
         FDFD  IOBFLAG2                                                 17390000
         FDFD  IOBSENS0                                                 17400000
         FDFD  IOBSENS1                                                 17410000
         FDFD  IOBCSW                                                   17420000
         FDFD  IOBSTART                                                 17430000
         FDFD  IOBINCAM                                                 17440000
         FDFD  IOBERRCT                                                 17450000
         FDPRT *END                                                     17460000
         DROP  R9                                                       17470000
         SPACE 1                                                        17480000
TAPEEND  INC   DCBBLKCT-IHADCB+TAPEDCB   UPDATE BLOCKCOUNT              17490000
         OI    DCBOFLGS-IHADCB+TAPEDCB,DCBOFLWR  SHOW WRITE DONE        17500000
         EOV   TAPEDCB            GET ANOTHER TAPE                      17510000
         B     TAPEOUTX      CONTINUE ON NEW TAPE                       17520000
         SPACE 1                                                        17530000
TAPEOUTX TM    OPTFLAGS,FGVAR     RECFM=V OR U ?                GP09207 17540000
         BZ    TAPEOUT2      U                                  GP09207 17550000
         MVC   0(8,R2),HOLDBDW    RESTORE OLD DATA              GP09207 17560000
TAPEOUT2 LM    R2,R3,SUBSAVE                                            17570000
         INC   OUT#BLOK      INCREMENT BLOCK COUNT                      17580000
         STMAX R3,OUT#MAX    SAVE LARGEST BLOCK SIZE                    17590000
         A64F  OUT#BYTE,(R3)   COUNT OUTPUT BYTES                       17600000
TAPEOUTY L     R2,@BUF                                                  17610000
         ST    R2,@BUFCUR    RESET BUFFER USE                           17620000
         BR    R9                                                       17630000
         SPACE 1                                                        17640000
         LTORG ,                                                        17650000
         TITLE 'D S S D U M P  ***  SUBROUTINES AND DATA'               17660000
DSSDUMPD CSECT ,             SUBROUTINE AND DATA AREA                   17670000
         DROP  R11,R12       USING R10 FOR THIS                         17680000
PGMEXIT8 PRTL  '0*** Unable to continue due to errors',CC=ASA           17690000
         OICC  8                                                        17700000
         SPACE 1                                                        17710000
PGMEXIT  ICM   R0,15,NUMCOPY   CHECK DATA SETS COPIED                   17720000
         BZ    PGMEXWRN      THAT'S NOT GOOD ?                          17730000
         S     R0,NUMPICK     COMPARE TO COUNT SELECTED                 17740000
         BZ    PGMEXIT1      OK                                         17750000
PGMEXWRN LA    R0,4                                                     17760000
         STMAX R0,RETCODE    SET WARNING CODE                           17770000
PGMEXIT1 TM    TAPEDCB+DCBOFLGS-IHADCB,DCBOFOPN                         17780000
         BZ    PGMEXIT2      TAPE OPEN ?                                17790000
         TM    OPTFLAGS,FGWRITE   OUTSTANDING WRITE ?                   17800000
         BZ    PGMEXCLS                                                 17810000
         CHECK TAPEDCB       CHECK LAST BLOCK                           17820000
         ZI    OPTFLAGS,FGWRITE   OUTSTANDING WRITE                     17830000
PGMEXCLS CLOSE MF=(E,OCLIST)    YES; CLOSE IT                           17840000
         L     R15,OUT#MAX        IN CASE CAN'T DIVIDE                  17850000
         ICM   R0,15,OUT#BLOK     GET BLOCK COUNT                       17860000
         BZ    PGMEXWAT           USE MAX AS AVERAGES                   17870000
         LM    R14,R15,OUT#BYTE   GET OUTPUT BYTE COUNT                 17880000
         DR    R14,R0             GET AVERAGE BLOCK SIZE                17890000
PGMEXWAT ST    R15,OUT#AVG          AND SAVE IT                         17900000
         PRTROOM 6                                                      17910000
         PRTLIST FDSTAT      PRINT TAPE STATISTICS                      17920000
PGMEXIT2 PRTROOM 6                                                      17930000
         PRTLIST FDFINAL                                                17940000
         BAL   R14,ENDTREE   TERMINATE TREE IF NOT DONE EARLIER         17950000
         SUBCALL SUBCOMP,('END',,,CMP@STOR),VL,MF=(E,COMPPARM)          17960000
         PRTCLOSE DEV=255    LFETCH=LINK DOESN'T CLOSE                  17970000
         SERVTERM ,          CLOSE AND FREE EVERYTHING                  17980000
         PGMEXIT COPYRET=(RETCODE,8)   RETURN R15 & R0                  17990000
         SPACE 1                                                        18000000
INITREE  SUBCALL SUBTREE,('INI',ROOTBALL),VL,MF=(E,CALLPARM)            18010000
         ORG   *-2           OVERLAY BALR                               18020000
         BR    R15           RETURN TO CALLER                           18030000
         SPACE 1                                                        18040000
ENDTREE  SUBCALL SUBTREE,('END',ROOTBALL),VL,MF=(E,CALLPARM)            18050000
         ORG   *-2           OVERLAY BALR                               18060000
         BR    R15           RETURN TO CALLER                           18070000
         SPACE 1                                                        18080000
LISTREE  SUBCALL SUBTREE,('LIST',ROOTBALL),VL,MF=(E,CALLPARM)           18090000
         ORG   *-2           OVERLAY BALR                               18100000
         BR    R15           RETURN TO CALLER                           18110000
         SPACE 1                                                        18120000
NEXTREE  SUBCALL SUBTREE,('NEXT',ROOTBALL),VL,MF=(E,CALLPARM)           18130000
         ORG   *-2           OVERLAY BALR                               18140000
         BR    R15           RETURN TO CALLER                           18150000
         SPACE 2                                                        18160000
*********************************************************************** 18170000
**  WHATMASK - LOOK AT WHATEVER USER IS PASSING OFF AS A MASK, AND   ** 18180000
**    CLASSIFY IT AS NAME, MASK, or POSITIONAL MASK                  ** 18190000
**                rc  0      4          8                            ** 18200000
**              flag  00    80         90                            ** 18210000
*********************************************************************** 18220000
WHATMASK STM   R1,R5,SUBSAVE SAVE A LITTLE                              18230000
         LR    R5,R1         PRESERVE MASK ADDRESS                      18240000
         MVI   L'COMPMASK(R5),X'00'    SET FOR NAME                     18250000
         SUBCALL SUBCOMP,('AST',0(R5),0(R5),CMP@STOR),VL,              *18260000
               MF=(E,CALLPARM)                                          18270000
*DEFER*  CH    R15,=H'8'     IS MASK VALID ?                            18280000
*DEFER*  BNL   WHATMBAD                                                 18290000
         SR    R15,R15       SET RETURN CODE                            18300000
         TRT   0(L'COMPMASK,R5),TRTMASK   ANY MASK CHARACTERS?          18310000
         BZ    WHATMEXT      NO; RETURN NAME                            18320000
         MVI   L'COMPMASK(R5),X'80'    SHOW MASK                        18330000
         SR    R2,R2         CLEAR FOR TRT IC                           18340000
         TRT   0(L'COMPMASK,R5),TRTMASKP  ANY POSITIONALS ?             18350000
         LA    R15,4(,R2)    SET MASK=4, POSITIONAL=8                   18360000
         BZ    WHATMEXT      NO                                         18370000
         OI    L'COMPMASK(R5),X'10'    SHOW POSITIONAL                  18380000
WHATMEXT LM    R1,R5,SUBSAVE                                            18390000
         BR    R9            RETURN TO CALLER                           18400000
         SPACE 1                                                        18410000
*---------------------------------------------------------------------* 18420000
*   PHASE I DATA                                                      * 18430000
*---------------------------------------------------------------------* 18440000
         DS    0D            FORCE ALIGNMENT                    GP09207 18450000
PATTAPE  DCB   DDNAME=TAPE,MACRF=W,DSORG=PS,EXLST=TAPEXLST  WAS RECFM=U 18460000
         WRITE PATDECB,SF,TAPEDCB-TAPEDCB,2-2,3-3,MF=L   WRITE A BLOCK  18470000
PATTAPEL EQU   *-PATTAPE                                                18480000
TAPEXLST DC    0A(0),X'85',AL3(TAPEMERG)                                18490000
         DS    0D            ALIGN CCW(S)                               18500000
PATEXCP  DCB   DDNAME=TAPE,MACRF=E,DSORG=PS,REPOS=Y                     18510000
PATCCW   CCW   1,2-2,X'40',3-3                                          18520000
         CCW   3,2-2,X'20',1                                            18530000
PATXLEN  EQU   *-PATEXCP     PATTERN TO MOVE                            18540000
         SPACE 1                                                        18550000
PATALLOC DS    0F            ALLOCATION REQUEST BLOCK                   18560000
         DC    AL1(PATTUPTR-PATALLOC)   RB LENGTH                       18570000
         DC    AL1(S99VRBAL)   ALLOCATE                                 18580000
         DC    AL1(0,0)      (NO) FLAGS                                 18590000
         DC    AL4(0)        ERROR/INFO CODE RETURN                     18600000
         DC    AL4(PATTUPTR) TEXT UNIT POINTER LIST ADDRESS             18610000
         DC    AL4(0)        RB EXTENSION                               18620000
         DC    4AL1(0)       MORE FLAGS                                 18630000
PATALLEN EQU   *-PATALLOC    LENGTH TO MOVE                             18640000
PATTUPTR DC    A(TUPDDN)     SPECIFY DDN                                18650000
         DC    AL1(X'80'),AL3(TUPDUM) AND REQUEST DUMMY DD              18660000
TUPDDN   DC    AL2(DALDDNAM,1,8)    DDN 1 ENTRY, LEN 8                  18670000
DCVOLMNT DC    CL8'VOLMOUNT'                                            18680000
TUPDUM   DC    AL2(DALDUMMY)                                            18690000
         SPACE 1                                                        18700000
TRTMASK  DC    256AL1(0)     ALLOW ALL CHARACTERS                       18710000
         TRENT TRTMASK,4,C'*',C'?',  NORMAL WILD CARD                   18720000
         TRENT ,8,C'%'        POSITIONAL WILD CARD                      18730000
         SPACE 1                                                        18740000
TRTMASKP DC    256AL1(0)     ALLOW ALL CHARACTERS                       18750000
         TRENT TRTMASKP,4,C'%'   POSITIONAL WILD CARD ?                 18760000
         SPACE 1                                                        18770000
TRTDSNM  DC    256AL1(8)     FAIL ALL                                   18780000
         TRENT TRTDSNM,0,(C'A',9),(C'J',9),(C'S',8),  ALPHA             18790000
         TRENT ,0,(C'0',10),C'@',C'#',C'$', -MERIC + INTEGER            18800000
         TRENT ,0,C'?',C'*',C'.',C'%',        INDEX + MASKING           18810000
         TRENT ,4,C' '       SCAN STOPPER                               18820000
         SPACE 1                                                        18830000
PATIOWK  DS    0F            START OF WORK PATTERN              GP09194 18840000
PATPRINT PRTWORK SYSPRINT,SYSOUT,TITLE=3                        GP09194 18850000
PATIN    INPWORK SYSIN,EODAD=CARDEOD,EDIT=128                   GP09194 18860000
PATDDNM  DC    CL8'TAPE'                                        GP09194 18870000
PATIOLEN EQU   *-PATIOWK     LENGTH TO MOVE                     GP09194 18880000
VVRSREST DC    X'0054220000000000000000000048240002000000000000000008E2*18890000
               E3C1D5C4C1D9C400000008E2E3C1D5C4C1D9C4'          GP09193 18900000
         SPACE 1                                                        18910000
QMAJ     DC    CL8'SYSDSN '                                     GP09212 18920000
QJAM     DC    CL8'SPFEDIT'                                     GP09212 18930000
PATENQ   ENQ   (QMAJ,1-1,E,44,SYSTEM),RET=TEST,MF=L             GP09212 18940000
PATENQL  EQU   *-PATENQ                                         GP09212 18950000
         SPACE 1                                                        18960000
FDFINAL  FDOPT NL,CC=C'0'    DOUBLE SPACE                               18970000
         FDPRT 'Completion code',NL                                     18980000
         FDPRT RETCODE,I,PAD                                            18990000
         FDPRT NUMPICK,I,RADJ,NL,LEN=12                                 19000000
         FDPRT 'Data Sets selected',PAD                                 19010000
         FDPRT NUMSKIP,I,RADJ,NL,LEN=12                                 19020000
         FDPRT 'Data Sets skipped',PAD                                  19030000
         FDPRT NUMFAIL,I,RADJ,NL,LEN=12                                 19040000
         FDPRT 'Data Sets failed',PAD                                   19050000
         FDPRT NUMCOPY,I,RADJ,NL,LEN=12                                 19060000
         FDPRT 'Data Sets copied',PAD                                   19070000
         FDCLC NUMDUPE,ZEROES,BE=FDFINALX                               19080000
         FDPRT NUMDUPE,I,RADJ,NL,LEN=12                                 19090000
         FDPRT 'Data Sets renamed',PAD                                  19100000
FDFINALX FDPRT *END                                                     19110000
         SPACE 1                                                        19120000
FDSTAT   FDOPT NL,CC=C'0'    DOUBLE-SPACE                               19130000
         FDPRT OUT#BLOK,I,RADJ,NL,LEN=12                                19140000
         FDPRT 'Blocks written',PAD                                     19150000
         FDPRT OUT#SEQ,I,RADJ,NL,LEN=12                                 19160000
         FDPRT 'Segments written',PAD                                   19170000
         FDPRT OUT#MAX,I,RADJ,NL,LEN=12                                 19180000
         FDPRT 'Maximum block size',PAD                                 19190000
         FDPRT OUT#AVG,I,RADJ,NL,LEN=12                                 19200000
         FDPRT 'Average block size',PAD                                 19210000
         FDPRT *END                                                     19220000
         SPACE 1                                                        19230000
*---------------------------------------------------------------------* 19240000
*   BSAM DCB OPEN EXIT                                                * 19250000
*   USE BLKSIZE FROM JFCB OR DSCB, BUT NO LESS THAN MINBLOCK          * 19260000
*   AND NO MORE THAN TRACK SIZE (OR HALF-TRACK FOR MODULO DEVICES)    * 19270000
*---------------------------------------------------------------------* 19280000
         PUSH  USING                                                    19290000
         DROP  ,                                                        19300000
         USING TAPEMERG,R15                                             19310000
         USING IHADCB,R1                                                19320000
TAPEMERG L     R3,#BUFMAX-TAPEDCB(,R1)    CURRENT BUFMAX        GP09207 19330000
         SR    R2,R2                                                    19340000
         ICM   R2,3,DCBBLKSI   GET JFCB OR DSCB SIZE                    19350000
         BNZ   *+6                                                      19360000
         LR    R2,R3         USE DEFAULT                                19370000
         MIN   R2,(R3)       USE SMALLER VALUE                          19380000
         MAXH  R2,=AL2(MINBLOCK)   BUT AT LEAST 1K              GP09207 19390000
         LR    R3,R2         ALSO UPDATE BUFMAX                         19400000
         TM    DCBRECFM,X'C0'     RECFM=U?                              19410000
         BO    TAPEMERX      YES; JUST SET BLOCK SIZE                   19420000
         BM    TAPEMERV      F OR V (F WILL FAIL)                       19430000
         OI    DCBRECFM,X'C0'     SET =U                                19440000
         B     TAPEMERX          AND EXIT                               19450000
TAPEMERV SH    R3,=H'4'      LESS FOUR FOR RDW                          19460000
         STH   R3,DCBLRECL                                              19470000
         SH    R3,=H'4'      LESS FOUR FOR BDW                          19480000
TAPEMERX STH   R2,DCBBLKSI                                              19490000
         ST    R3,#BUFMAX-TAPEDCB(,R1)    UPDATE BUFMAX         GP09207 19500000
         BR    R14           RETURN TO OPEN                             19510000
         POP   USING                                                    19520000
         SPACE 1                                                        19530000
         LTORG ,                                                        19540000
         TITLE 'D S S D U M P  ***  DYNAMIC DATA AND MAPPINGS'          19550000
CELLSECT DSECT ,             TREE DEFINITION                            19560000
CELLVOL  DS    CL6           VOLUME SERIAL                              19570000
CELLDSN  DS    CL44          DATA SET NAME                              19580000
CELLKEY  EQU   CELLVOL,L'CELLVOL+L'CELLDSN,C'C'  KEY                    19590000
CELLALIL DS    X             LENGTH OF ALIAS NAME               GP09197 19600000
CELLALI  DS    CL44          ALIAS SDATA SET NAME                       19610000
CELLFLAG DS    X             FLAGS                                      19620000
CFPICK   EQU   X'01'           TO BE DUMPED                             19630000
CFFAIL   EQU   X'02'           FAILED                                   19640000
CFSKIP   EQU   X'04'           NOT SELECTED                             19650000
CFENQ    EQU   X'08'           ENQ FAILED                               19660000
CFDUMP   EQU   X'80'           DUMPED SUCCESSFULLY                      19670000
CELLLEN  EQU   *-CELLSECT    LENGTH OF ONE ENTRY                        19680000
         SPACE 1                                                        19690000
DSSDUMPD CSECT ,             DEFINE AFTER CELL                          19700000
ROOTPATT SERVTREE PFX=PAT,KEYLEN=L'CELLKEY,KEYOFF=CELLKEY-CELLSECT,    *19710000
               RECLEN=CELLLEN,RECNUM=(64*1024-48)/CELLLEN  USE 64K      19720000
BLANKS   EQU   PATREC,CELLLEN,C'C'     REDEFINE                         19730000
         SPACE 1                                                        19740000
SAVE     DSECT ,                                                        19750000
ZEROES   DS    D             CONSTANT                                   19760000
DB       DS    D                                                        19770000
DB2      DS    D                                                        19780000
DB3      DS    D                                                        19790000
         SERVDEFS ,          DEFINE NEEDED CONSTANTS                    19800000
DYNIOWK  DS    0F            START OF WORK PATTERN              GP09194 19810000
SYSPRINT PRTWORK SYSPRINT,SYSOUT,TITLE=3                        GP09194 19820000
SYSIN    INPWORK SYSIN,EODAD=CARDEOD,EDIT=128                   GP09194 19830000
SYSDDNM  DC    CL8'TAPE'                                        GP09194 19840000
DYNIOLEN EQU   *-DYNIOWK     LENGTH TO MOVE                     GP09194 19850000
@VOLREAD DS    A             VOLUME READER                              19860000
NUMCOPY  DS    F             NUMBER OF DATA SETS COPIED                 19870000
NUMPICK  DS    F             NUMBER OF DATA SETS SELECTED               19880000
NUMSKIP  DS    F             NUMBER OF DATA SETS SKIPPED                19890000
NUMFAIL  DS    F             NUMBER OF DATA SETS FAILED                 19900000
NUMDUPE  DS    F             NUMBER OF DUPLICATE NAMES REPLACED         19910000
NUMPFX   DS    F             NUMBER OF PREFIX/RENAME ENTRIES    GP09197 19920000
         SPACE 1                                                        19930000
SUBSAVE  DS    5A                                                       19940000
         SPACE 1                                                        19950000
COMPPARM DS    4A            SUBCOMP SUBROUTINE PARAMETERS              19960000
CMP@STOR DC    A(0)          MORE STORAGE                               19970000
COMPMASK DS    CL44,X        (CURRENT) COMPARE MASK                     19980000
         SPACE 1                                                        19990000
ROOTBALL SERVTREE PFX=REC,KEYLEN=L'CELLKEY,KEYOFF=CELLKEY-CELLSECT,    *20000000
               RECLEN=CELLLEN,RECNUM=(64*1024-48)/CELLLEN  USE 64K      20010000
         SPACE 1                                                        20020000
VOLVOL   DS    CL6           SERIAL LAST USED IN VOLREAD OPEN           20030000
         SPACE 2                                                        20040000
*     PARAMETER LIST AND WORK AREA                                      20050000
*                                                                       20060000
*********************************************************************** 20070000
**   THESE FIELDS MUST STAY CONTIGUOUS FOR CLEARING                  ** 20080000
**                                                                   ** 20090000
         CATSPARM PFX=CSP,DSECT=   SUBCAT INTERFACE PARAMETER AREA      20100000
#SUBCAT  EQU   CSP@SCAT,4,C'V'                                          20110000
#SUBCOMP EQU   CSP@SCMP,4,C'V'                                          20120000
CATCALL  SUBCALL (1,2,3),MF=L  SUBCAT REMOTE PARAMETER LIST             20130000
CMP@WORK DC    A(0)          ADDRESS OF GETMAINED WORK AREA             20140000
CALLLIST DC    A(CMPREQ,CSPMASK,DSNMASK,CMP@WORK)                       20150000
GENERIC  DS    CL8           GENERIC UNIT NAME FOR CURRENT VOLUME       20160000
DSNMASK  DC    CL44' '       USER'S REQUESTED DS NAME OR MASK           20170000
VOLMASK  DC    CL6' ',CL2' '    REFERENCED VOLUME (COMPARE PAD)         20180000
CMPREQ   DC    C'DSN'        COMPARE DSN TO MASK (DSN OR POS)           20190000
         SPACE 1                                                        20200000
DUMPDSN  DC    CL44' '       CURRENT NON-TAPE DUMP DSN          GP09317 20210000
DUMPVOL  DC    CL6'------'     AND VOLUME SERIAL                GP09317 20220000
         SPACE 1                                                        20230000
OUT#BYTE DS    D             OUTPUT BYTES                               20240000
OUT#BLOK DS    F             OUTPUT BLOCKS                              20250000
OUT#SEQ  DS    F             OUTPUT SEGMENTS                            20260000
OUT#MAX  DS    F             LARGEST BLOCK WRITTEN                      20270000
OUT#AVG  DS    F             AVERAGE BLOCK WRITTEN                      20280000
         SPACE 1                                                        20290000
DSN#TRAK DS    F       1/5   DATA SET TRACKS (PHYSICAL)                 20300000
DSN#TMAX DS    F       2/5   MAX TO PROCESS (DS1LSTAR+1)                20310000
DSN#DATA DS    F       3/5   DATA SET TRACKS (LOGICAL)                  20320000
DSN#REC  DS    F       4/5   DATA SET RECORDS                           20330000
NUMPCYL  DS    F       5/5   TRACKS PER CYLINDER                        20340000
CURCCHH  DS    0XL4,2XL2     CURRENT TRACK ADDRESS                      20350000
CUREXT   DS    AL4           ADDRESS OF CURRENT EXTENT                  20360000
CUR#EXT  DS    FL4           EXTENTS LEFT TO DO                         20370000
         SPACE 1                                                        20380000
         MAPPARSE DSECT=NO   @PARSER INVOCATION ADDRESS                 20390000
         SPACE 1                                                        20400000
OPTFLAGS DS    X             PROCESSING OPTIONS                         20410000
FGENQ    EQU   X'80'           GET ENQUEUE WHILE DUMPING DS             20420000
FGVAR    EQU   X'40'           USE RECFM=V FOR OUTPUT                   20430000
FGPSPO   EQU   X'20'           CURRENT DATA SET IS PS OR PO             20440000
FGADAT   EQU   X'10'           DUMP ALL ALLOCATED TRACKS                20450000
FGTEST   EQU   X'08'           TEST MODE - NO OUTPUT WRITTEN            20460000
FGBUG    EQU   X'04'           DEBUG MODE - LOTS OF OUTPUT              20470000
FGEXP    EQU   X'02'           EXPORTING DATA - RESET LOCALS    GP09197 20480000
FGWRITE  EQU   X'01'           UNCHECKED WRITE OUTSTANDING              20490000
         SPACE 1                                                        20500000
PROFLAGS DS    X             PROCESSING OPTIONS                         20510000
PFGDUMP  EQU   X'80'           DUMP REQUEST PENDING                     20520000
PFPREF   EQU   X'20'           PREFIX (ONLY) FORM OF RENAME     GP09197 20530000
PFSOME   EQU   X'02'           NOT USING ALLDATA FOR THIS DS    GP09202 20540000
PFGONCE  EQU   X'01'           AT LEAST ONE DUMP REQUEST                20550000
         SPACE 1                                                        20560000
OCLIST   OPEN  (TAPEDCB,OUTPUT),MF=L                                    20570000
         SPACE 1                                                        20580000
         DS    0D            ALIGN CCW(S)                               20590000
TAPEDCB  DCB   DDNAME=TAPE,MACRF=W,DSORG=PS                             20600000
         WRITE TAPEDECB,SF,TAPEDCB,1-1,2-2,MF=L  WRITE A BLOCK          20610000
TAPELEN  EQU   *-TAPEDCB                                                20620000
         SPACE 1                                                        20630000
         ORG   TAPEDCB                                                  20640000
TAPEEXCP DCB   DDNAME=TAPE,MACRF=E,DSORG=PS,REPOS=Y                     20650000
TAPECCW  CCW   1,3-3,X'40',4-4                                          20660000
         CCW   3,3-3,X'20',1                                            20670000
TAPEXLEN EQU   *-TAPEEXCP    PATTERN TO MOVE                            20680000
TAPEECB  DC    A(0)                                                     20690000
TAPEIOB  DC    X'42,00,00,00'                                           20700000
         DC    A(TAPEECB)                                               20710000
         DC    2A(0)                                                    20720000
         DC    A(TAPECCW)                                               20730000
         DC    A(TAPEDCB)                                               20740000
         DC    2A(0)                                                    20750000
         SPACE 1                                                        20760000
         ORG   ,             LONGER OF BSAM AND EXCP DATA               20770000
         SPACE 1                                                        20780000
@BUF     DS    A             ADDRESS OF TAPE BUFFER                     20790000
#BUFMAX  DS    F             (LOGICAL) SIZE OF BUFFER                   20800000
#DATMAX  DS    F             MAXIMUM TRACK DATA SIZE IN BUFFER          20810000
@BUFCUR  DS    A             NEXT AVAILABLE SPACE                       20820000
@BUFEND  DS    A             (LOGICAL) BUFFER END                       20830000
@MEMCUR  DS    A             DITTO FOR DS NAME TABLE                    20840000
@MEMEND  DS    A             (PHYSICAL) BUFFER END                      20850000
         SPACE 1                                                        20860000
ENQLIST  ENQ   (QMAJ,1-1,E,44,SYSTEM),RET=TEST,MF=L             GP09212 20870000
         ORG   ENQLIST                                          GP09212 20880000
LOCFMT1  DS    (44+96)X      FORMAT 1 DSCB                              20890000
LOCFMT2  DS    (140)X        FORMAT 2 DSCB                              20900000
LOCFMT3  DS    (140)X        FORMAT 3 DSCB                              20910000
         SPACE 1                                                        20920000
EXCMASKS DS    16CL45  1/2   EXCLUSION MASKS FOR ONE SELECT             20930000
EXC#MASK DS    F       2/2   CURRENT EXCLUSION MASK REQUESTS            20940000
         SPACE 1                                                        20950000
PFXOLDL  DS    X             LENGTH OF OLD PREFIX (0<= <23)     GP09197 20960000
PFXOLD   DS    CL23          OLD PREFIX (0<= <23)               GP09197 20970000
PFXNEWL  DS    X             LENGTH OF NEW PREFIX (0<= <23)     GP09197 20980000
PFXNEW   DS    CL23          NEW PREFIX (0<= <23)               GP09197 20990000
PFXLEN   EQU   *-PFXOLDL     ONE RENAME ENTRY                   GP09197 21000000
         DS    (15)XL(PFXLEN)     16 ENTRIES MAX PER RUN        GP09197 21010000
MAXPFX   EQU   (*-PFXOLDL)/PFXLEN   ENTRIES ASSEMBLED           GP09197 21020000
         SPACE 1                                                        21030000
HOLDBDW  DS    CL8           TEMP STORAGE FOR HELD DATA                 21040000
BUFBDW   DS    2AL4          RECFM=V BDW/RDW PREFIX                     21050000
BUFTAPE  DS    256XL256      65K TAPE BUFFER                            21060000
         SPACE 1                                                        21070000
SAVEEND  EQU   *                                                        21080000
         SPACE 1                                                        21090000
         PRINT &PRTSYS                                                  21100000
CRUDFMT1 DSECT ,                                                        21110000
         IECSDSL1 1                                                     21120000
CRUDFMT3 DSECT ,                                                        21130000
         IECSDSL1 3                                                     21140000
CRUDFMT4 DSECT ,                                                        21150000
         IECSDSL1 4                                                     21160000
         IEFUCBOB ,                                                     21170000
         IEZIOB ,                                                       21180000
         IEFTIOT1 ,                                                     21190000
         DCBD  DSORG=PS,DEVD=(TA,DA)                                    21200000
         IHADVCT ,                                                      21210000
         CVT   ,                                                        21220000
         IHAPSA ,                                               JW12114 21222000
CVTSAF   EQU   248 CVTSAF doesn't exist but is a reserved field in 3.8J 21224000
         ICHSAFV  DSECT=YES  map SAFV                           JW12114 21226000
         IEFZB4D0 ,          SVC 99 RB DEFINITION                       21230000
         IEFZB4D2 ,          SVC 99 TEXT UNIT DEFS                      21240000
         SPACE 1                                                        21250000
*        NO USABLE IBM AMCBS MACRO                                      21260000
*                                                                       21270000
AMCBS    DSECT ,                                                        21280000
CBSID    DS    CL2           ID                                         21290000
CBSSIZ   DS    AL2           LENGTH                                     21300000
CBSMCSTA DS    A             CCHH OF MASTER CATLG                       21310000
CBSACB   DS    A             MASTER CAT ACB                             21320000
CBSCBP   DS    A             C B MANIP                                  21330000
CBSCMP   DS    0A            CAT RTNE                                   21340000
CBSMCUCB DS    A             MASTER CAT UCB                             21350000
CBSCAXCN DS    A             CAXWA CHAIN                                21360000
CBSCRACA DS    A             CRA CAXWA CHAIN                            21370000
CBSCRTCB DS    A             CRA TASK TCB                               21380000
CBSVSRT  DS    A                                                        21390000
CBSVUSE  DS    A             VSRT USE COUNT                             21400000
CBSVPTR  DS    A             VSRT                                       21410000
CBSFLAGS DS    X             FLAGS                                      21420000
CBSMICF  EQU   X'80'           MAST IS ICF CATALOG                      21430000
         DS    XL3           SPARE                                      21440000
CBSVVDSA DS    A             VVDS MANAGER                               21450000
CBSDEVNT DS    A             DEVICE NAME TABLE                          21460000
CBSVSICN DS    A             IDAVSI CHAIN                               21470000
CBSFLG1  DS    X             AMCBS FLAGS                                21480000
CBSCUVSI EQU   X'80'           VSI CHAIN CLEAN-UP REQUIRED              21490000
         DS    XL3           SPARE                                      21500000
         SPACE 1                                                        21510000
         IGGCAXWA ,          (PVTMACS)                                  21520000
MYJFCB   DSECT ,                                                        21530000
         IEFJFCBN ,                                                     21540000
         MAPPARST ,                                                     21550000
         SPACE 1                                                        21560000
         PRINT ON,GEN                                                   21570000
         MAPVOLRD ,          RETURN VALUES FROM VOLREAD TRACK           21580000
         TITLE 'D S S D U M P  ***  TAPE RECORD DESCRIPTION'            21590000
* MAP OF ADRDSSU BLOCKS - ORG TO COMMON HEADER                          21600000
*                                                                       21610000
DSSBLOCK DSECT ,                                                        21620000
*** Common Header                                                       21630000
*                                                                       21640000
DTPSEQNO DS    F           Segment sequence number                      21650000
DTPNOSEG DS    XL1         Number of segments per record                21660000
DTPSEGNO DS    XL1         Segment number of record                     21670000
DTPSEGLN DS    XL2         Segment length including prefix              21680000
DTPPFXLN DS    XL1         Length of prefix (constant 16)               21690000
DTPDMPID DS    XL1         Type of dump                                 21700000
DTPLOGCL EQU   X'10'         Logical dump                               21710000
DTPRCID1 DS    XL1         Record Identifier 1                          21720000
DTPTHDR  EQU   X'80'         Tape Header (see DTHDR)                    21730000
DTPDSNL  EQU   X'40'         DSName/Catalog Lst (see DTLDSN)            21740000
DTPDSHDR EQU   X'20'         Dataset Header (see DTDSHDR)               21750000
DTPVOLD  EQU   X'10'         Volume Definition (see DTMVOL)             21760000
DTPDATA  EQU   X'08'         Data Track (see  DTTTRK)                   21770000
DTPDTRLR EQU   X'04'         Dataset Trailer (see DTRTLR)               21780000
DTPRCFL1 DS    XL1         Flag Byte                                    21790000
DTPDDISP EQU   X'80'         If on, 16 bytes of track data has been     21800000
*                            displaced from this segment to the end of  21810000
*                            the last segment for this track.           21820000
DTPRESVD DS    F                  RESERVED                              21830000
DTPSIZE  EQU   *-DSSBLOCK      SIZE OF COMMON HEADER                    21840000
DSSHEDND DS    0F            END OF COMMON HEADER                       21850000
*                                                                       21860000
         ORG   DSSHEDND      X'80'                                      21870000
DTHTIMD  DS    CL8         Date & time of dump                          21880000
DTHIND2  DS    XL1         Dataset type indicators                      21890000
DTHGNVI  EQU   X'80'         no non-VSAM datasets                       21900000
DTHGVI   EQU   X'40'         no VSAM datasets                           21910000
DTHGT64K EQU   X'20'         more than 65535 datasets on volume         21920000
DTHLEN   DS    XL2         Header length                                21930000
DTHVERNO DS    XL1         DSS Version number                           21940000
DTHLVLNO DS    XL1         DSS modification number (level)              21950000
DTHBLKSZ DS    XL2         Maximum blksize                              21960000
DTHNDS   DS    XL2         Number of datasets in list                   21970000
DTHIND1  DS    XL1         Indicators                                   21980000
DTHFCMP  EQU   X'80'         file compressed                            21990000
DTHUNLCD EQU   X'40'         unallocated space dumped                   22000000
DTHSFER  EQU   X'20'         sphere option                              22010000
DTHSIZE  EQU   *-DSSHEDND      SIZE OF TAPE HEADER                      22020000
*                                                                       22030000
*** Dataset Contents List    X'40'                                      22040000
*                                                                       22050000
         ORG   DSSHEDND                                                 22060000
DTLLEN   DS    XL1         Length of dataset name                       22070000
DTLCAT   DS    CL44        Catalog DSN                                  22080000
DTLDSN   DS    0CL44       Data Set name 1-44                           22090000
* ENDED BY X'00' = DTP SIZE                                             22100000
DTLSIZE  EQU   *-DSSHEDND      SIZE OF ONE ENTRY + DSN                  22110000
*                                                                       22120000
*** Dataset Header record    X'20'                                      22130000
*                                                                       22140000
         ORG   DSSHEDND                                                 22150000
DTDLEN   DS    XL1         Length of dataset name                       22160000
DTDCATLN DS    XL1         Length of catalog name                       22170000
DTDDSORG DS    XL2         Dataset org (from FMT 1)                     22180000
DTDOPTCD DS    XL1         Dataset option code (from FMT 1)             22190000
DTDNVOL  DS    XL1         Number of volumes for dataset                22200000
DTDIND   DS    XL1         Dataset indicator                            22210000
DTDRACFG EQU   X'08'         Generic RACF profile               GP09193 22220000
DTDALIAS EQU   X'04'         User catalog alias                         22230000
DTDSPER  EQU   X'02'         Sphere record follows                      22240000
DTDSMS   EQU   X'01'         SMS Managed dataset                        22250000
DTDPSWD  DS    XL8         pswd                                         22260000
         DS    CL44        catlg name                                   22270000
DTDDSN   DS    CL44        dataset name                                 22280000
DTDVCTD  DS    XL1         Volume count for non-vsam                    22290000
         DS    XL1         VSAM index component vol cnt or zero         22300000
DTDIND2  DS    XL1                                                      22310000
DTDAIXSP EQU   X'80'       AIX and part of a sphere                     22320000
DTDCDF   EQU   X'40'       Common format dataset                        22330000
DTDPDSE  EQU   X'20'       PDSE dataset                                 22340000
DTDNTALL EQU   X'10'       Dumped without ALLD or ALLX                  22350000
DTDSAI   EQU   X'08'       DS additional information                    22360000
DTDNOIDX EQU   X'04'       VSAM indexed DS dumped using VALIDATE        22370000
DTDPDSET EQU   X'02'       PDSE dumped as track images                  22380000
DTDSDM   EQU   X'01'       Use system data mover                        22390000
DTDSIZE  EQU   *-DSSHEDND                                               22400000
*                                                                       22410000
*** Volume Definition Record (1 per volume)                             22420000
*                                                                       22430000
         ORG   DSSHEDND    X'10'                                        22440000
DTMVOL   EQU   *                                                        22450000
DTMVSERL DS    CL6         Volume serial number                         22460000
DTMDEVTY DS    XL4         DEVTYPE (UCBTBYT4)                           22470000
         DS    XL2                                                      22480000
DTMTRKCP DS    XL4         Bytes per track                              22490000
DTMLOGCY DS    XL2         Cylinders per volume                         22500000
DTMTRKCY DS    XL2         Tracks per cylinder                          22510000
         DS    XL2         max compress buffer in words                 22520000
DTMFLAGS DS    XL2         flags                                        22530000
DTMCVAF  EQU   X'20'         Indexed VTOC                       GP09193 22540000
DTM#VVRS DS    XL1         Number of VVRS/NVRS dumped                   22550000
DTM#DSCB DS    XL1         Number of DSCBs dumped                       22560000
DTM#EXT  DS    XL1         Number of extents dumped                     22570000
DTMMODNO DS    XL1         Model number (looks like zero for logical)   22580000
DTMDSCB  DS    XL(DS1END-IECSDSL1)  DSCB 1                              22590000
DTMEXTS  DS    1XL10          1-16 EXTENTS (?)                          22600000
DTMVVRS  DS    XL126       Not sure what goes in here           GP09193 22610000
         ORG   DTMVVRS     REDEFINE                             GP09193 22620000
DTMVL1   DS    XL2         Total VVRS LENGTH (x'7E')            GP09193 22630000
DTMVL2   DS    XL2         Length of N segment                  GP09193 22640000
DTMVT1   DS    XL6'D50000000000'                                GP09193 22650000
DTMVDSL  DS    X           Data set name length                 GP09193 22660000
DTMVDSN  DS    0CL44       Data set name                        GP09193 22670000
DTMVT2   DS    XL2'0000'                                        GP09193 22680000
DTMVCSL  DS    X           Catalog  name length                 GP09193 22690000
DTMVCSN  DS    0CL44       Catalog  name                        GP09193 22700000
DTMVT3   DS    X'00'                                            GP09193 22710000
DTMREST  DS    XL84'005422'   Length, x'22' record, zeros       GP09193 22720000
DTMSIZE  EQU   *-DSSHEDND                                               22730000
         ORG   ,           RESTORE MAX SIZE                     GP09193 22740000
*                                                                       22750000
*** Data Track Record                                                   22760000
*                                                                       22770000
         ORG   DSSHEDND    X'08'                                        22780000
DTTTRK   EQU   *                                                        22790000
DTTTRKLN DS    XL2         Length of data on track                      22800000
DTTTRKID DS    XL1         Track indicators                             22810000
DTTIOER  EQU   X'80'         I/O Error                                  22820000
DTTTROVF EQU   X'40'         Last rec on trk is overflow record         22830000
DTTTCMP  EQU   X'20'         Track compressed                           22840000
DTTVFRST EQU   X'10'         First VVDS record                          22850000
DTTINVT  EQU   X'08'         Invalid track format                       22860000
DTTSTAT  EQU   X'04'         User statisical record                     22870000
DTTCCHH  DS    XL4         CCHH of track                                22880000
         DS    XL4         VSAM stuff                                   22890000
         DS    XL5         reserved                                     22900000
DTTR0DAT DS    XL8         Record 0 data                                22910000
DTTCOUNT DS    0X            FIRST COUNT FIELD                          22920000
DTTSIZE  EQU   *-DSSHEDND                                               22930000
*                                                                       22940000
*** Dataset Trailer record                                              22950000
*                                                                       22960000
         ORG   DSSHEDND      X'04'                                      22970000
DTRDLR   DS    XL6           ZEROES ?                                   22980000
DTRSIZE  EQU   *-DSSHEDND                                               22990000
*                                                                       23000000
         END                                                            23010000
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
