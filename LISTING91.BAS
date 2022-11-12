10 REM ********************************
11 REM ** Listing 9.1 :              **
12 REM ** GRAPHICAL GRAMMAR TEST     **
13 REM ********************************
50 MODE 6
100 REM -- Main Line: 
120 GOSUB 1000 : REM initialize 
140 GOSUB 2000 : REM read grammar 
200 REPEAT 
202   GOSUB 1010 : REM re-initialize 
210   GOSUB 3000 : REM compose S$ 
220   CLS : PRINT S$ 
230   GOSUB 4000 : REM interpret S$ 
240   C%=INKEY(777) : REM pause 
250   INPUT "More (Y=YES) ", Y$
270 UNTIL Y$<>"Y" AND YS<>"y" 
280 MODE 6 
300 END 
330 :
500 REM -- data for graphic grammar: 
510 DATA A=BCCB 
520 DATA A=BBC
530 DATA A=BB 
535 DATA A=0234B 
540 DATA B=DDED
550 DATA B=DC 
560 DATA C=0 
570 DATA C=0E 
580 DATA C=0120 
585 DATA C=30 
588 DATA C=44 
590 DATA D=01
600 DATA D=11
605 DATA D=10 
606 DATA D=3 
607 DATA D=43224 
610 DATA E=2 
620 DATA E=12 
630 DATA E=1212 
640 DATA E=20 
650 DATA 0=R9F7R9F7R9F7R9F7 
660 DATA 1=C6L5+5F8F8 
670 DATA 2=C4L4L4F4 
680 DATA 3=U8C1
688 DATA 4=F8F8R3R9F8F8R3R9F8F8R9R6 
690 DATA 4=F8L9L3F8L9L3F8L6 
770 DATA ""
777 REM this defines a picture grammar. 
999 :
1000 REM --Initializing Routine: 
1001 MODE 2 
1005 S$=STRING$(220," ") 
1010 TA=0 : REM turtle angle 
1020 TX=RND(800)+200 : REM turtle x-coord 
1030 TY=RND(700)+200 : REM turtle Y-coord 
1040 GCOL 0,7 : REM initial colour white 
1050 MOVE TX,TY : REM at start point 
1080 RETURN 
1090 :
2000 REM -- Read in Picture Grammar: 
2010 DIM PG$(33), PN%(25) 
2020 RESTORE 
2030 FOR L%=0 TO 25 
2040   PN%(L%)=0 : NEXT 
2050 L%=0 
2060 REPEAT L%=L%+1 
2070   READ R$
2080   L$=LEFT$(R$,1) 
2090   PG$(L%)=R$ 
2100   N%=ASC(L$)-48 
2110   IP N%>=0 THEN PN%(N%)=PN%(N%)+1 
2120   UNTIL R$="" OR L%>32 
2122 GR%=L%-1 : REM rule count 
2140 PRINT "Rules Read in = ";GR% 
2150 RETURN
2160 :
3000 REM -- Composition Routine:
3010 S$="A" : REM A is always initial symbol 
3020 S%=1 
3040 REPEAT 
3050   GOSUB 3300 : REM next letter -> L$ 
3055   REM also sets S$. 
3060   GOSUB 3500 : REM replace L$ -> R$
3070   IF L$<>"" THEN S$=LEFT$(S$, S%-1}+R$+MID$(S$, S%+1) 
3080   REM expands L$ as R$ 
3090   UNTIL L$="" OR LEN(S$)>220 
3100   RETURN 
3120 :
3300 REM -- Next non-terminal -> L$ 
3320 REPEAT 
3330   L$=MID$(S$,S%,1) 
3340   IF L$<"A" THEN S%=S%+1 : REM terminal symbol 
3350   UNTIL L$>="A" OR S%>LEN(S$) 
3355 IF S%>LEN(S$) THEN L$=""
3370 RETURN 
3380 :
3500 REM -- Symbol Replacement routine: 
3510 IF S%>LEN(S$) THEN RETURN 
3515 IF L$="" THEN RETURN 
3520 L$=ASC(L$)-48 
3530 LL%=RND(PN%(L%)) 
3535 IF LL%<1 THEN LL%=1 
3540 L%=0 : RS="" 
3550 FOR R%=1 TO GR% 
3560   IF L$=LEFT$(PG$(R%),1) THEN L%=L%+1 
3570   IF L%>=LL% THEN R$=MID$(PG$(R%),3): R%=GR% 
3580   NEXT R%
3590 IF R$="" THEN R$=L$: PRINT “No rule! ";R$ 
3600 RETURN 
3610 : 
4000 REM -- Interpret S$ as rule-string: 
4010 L%=LEN(S$) 
4020 FOR S%=1 TO L%
4030   R$=MID$(S$,S%,1) 
4033   K%=0: LL%=RND(PN%(ASC(R$)-48)) 
4035   IF LL%<1 THEN LL%=1 
4040   FOR R%=GR% TO 1 STEP -1 
4050     IF R$=LEFT$(PG$(R%),1) THEN L$=MID$(PG$(R%),3): K%=K%+1 
4055     IF K%>=LL% THEN R%=0 
4060     NEXT R%
4070   REPEAT 
4080     TC$=LEFT$(LS$,2) : REM turtle command 
4090     GOSUB 5000 
4100     L$=MID$(L$,3): REM rest of string 
4110   UNTIL LEN(L$)<1 
4125   NEXT S% 
4140 RETURN 
5000 REM -- Command Interpreter: 
5010 REM :: TC$ --> TA,TX,TY (C$,C%) 
5020 IF TC$="" THEN RETURN 
5030 C$=LEFT$(TC$,1) 
5040 C%=VAL(MID$(TC$,2)) 
5050 IF C$="C" THEN GCOL 0,C%: RETURN 
5060 IF C$<>"+" THEN C%=C%*10 
5070 IF C$>"Z" THEN C$=CHR$(ASC(C$)-32)
5080 IF C$="A" THEN TA=C% 
5090 IF C$="L" THEN TA=TA-C% 
5100 IF C$="R" OR C$="+" THEN TA=TA+C%
5110 IF C$="U" THEN TY=TY+C%
5120 IF C$="D" THEN TY=TY-C% 
5130 IF C$<>"F" THEN RETURN 
5140 IF TA>360 THEN TA=TA-360 
5150 IF TA<O THEN TA=360+TA 
5160 REM -- movement: 
5170 TX=TX+SIN(RAD(TA))*C% 
5180 TY=TY+COS(RAD(TA))*C%
5190 IF TX>1280 THEN TX=TX-1280:C%=-1 
5200 IF TX<O THEN TX=TX+1280:C%=-1 
5210 IF TY>1024 THEN TY=TY-1024:C%=-1 
5220 IP TY<O THEN TY=TY+1024:C%=-1 
5230 IF Ct=-1 THEN MOVE TX,TY 
5240 DRAW TX,TY 
5250 RETURN 
5260 REM draws a line to TX,TY. 
5265 REM TCS is turtle command. 
5270 : 