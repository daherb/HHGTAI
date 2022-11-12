10 REM *********************************
20 REM ** Listing 2.1 :               **
30 REM ** SIMPLE, DETERMINISTIC,      **
40 REM ** FORWARD-CHAINING            **
50 REM ** EXPERT SYSTEM               **
60 REM *********************************
70 REM -- Inference Engine:
80 CLS : PRINT ,"EXPERT": PRINT ,"------"
90 X=100: V=3: REM X is no. of different models the program can consider and V is the no. of variables on each model 
100 REM S%(X) is flag array = 1 if hypothesis is still to be considered 
110 REM A$(X,V) is answer submitted by user 
120 REM Q$(X,V) is name of question variable 
130 REM R$(X,V) is correct answer 
140 REM N$(X) is name of hypothesis 
150 DIM S%(X),A$(X,V) ,Q$(X,V),R$(X,V),N$(X) 
160 REM -- Read knowledge base into these arrays: 
170 RESTORE: C=0
180 READ A$: IF A$ = "999" THEN GOTO 250 
190 C=C+1: S%(C)=1: N$(C)=A$
200 FOR I=1 TO V: READ A$ 
210   FOR J=1 TO LEN(A$) 
220     IF MID$(A$,J,1)=" " THEN L=J: J=LEN(A$): Q$(C,I)=LEFT$(A$,L): R$(C,i)=RIGHT$(A$,LEN(A$)-L) 
230   NEXT J 
240 NEXT I: GOTO 180: REM input loop. 
250 X=C
260 REM -- Start questioning the user: 
270 FOR C=1 TO X 
280   IF S%(C)=0 THEN GOTO 540 
290   FOR I=1 TO V: IF AS(C,I) <> "" THEN GOTO 500 
300     PRINT: PRINT "What is ";Q$(C,I);" ?"
310     PRINT "(You could reply :"
320     FOR Q=1 TO X: IF S%(Q)=1 THEN PRINT SPC(20);R$(Q,I) 
330       NEXT
340     PRINT "to match the current possibilities. )"
350     INPUT A$(C,I)
360     REM -- Look for any other Q's this answer might also apply to: 
370     FOR Q = C+1 TO X 
380       FOR P=1 TO V 
390         IF Q$(Q,P)=Q$(C,I) THEN A$(Q,P)=A$(C,I) 
400         NEXT P: NEXT Q 
410     REM -- Look for any theories that can be discounted due to this answer: 
420     FOR Q = 1 TO X 
430       FOR P = 1 TO V
440         IF (A$(C,I)=R$(Q,P) AND Q$(Q,P)=QS(C,I)) OR Q$(Q,P) <> Q$(C,I) OR S%(Q)=0 THEN GOTO 470 
450         S%(Q)=0 
460         PRINT: PRINT N$(Q);" is ruled out.": PRINT "Would you like to know why (Y/N)";: INPUT A$: IF A$="Y" THEN PRINT "It has ";Q$(Q,P);" of ";R$(Q,P) 
470         NEXT P: NEXT Q 
480     P=0: FOR Q=1 TO X: P=P+S%(Q): NEXT: IF P=0 THEN PRINT:PR INT "No theories are suitable for you.": I=V: C=X: GOTO 500 
490     REM -- now try the next question 
500     NEXT I 
505   :
510   REM -- Display any theories which fit the user's answers 
520   IF S%(C)=1 THEN PRINT: PRINT N$(C);" is possible.": PRINT "Would you like to know how (Y/N) ";: INPUT A$ : IF A$ = "Y" THEN GOSUB 1200 
530   REM -- Now try another theory: 
540   NEXT C 
550 PRINT: PRINT "Would you like another run (Y/N) ";: INPUT A$
560 IF AS="Y" THEN GOSUB 1300 
570 IF AS="N" THEN END 
580 GOTO 260: REM loop-back 
999 : 
1000 REM -- Knowledge Base: 
1010 REM -- K.B. format is: 
1020 REM Name of Hypothesis (,Variable name<sapce>variable value) 
1030 DATA MODEL A, PRICE 200, COLOUR YES, RAM(K) 48 
1040 DATA MODEL B, PRICE 300, COLOUR YES, RAM(K) 64 
1050 DATA MODEL C, PRICE 100, COLOUR NO, RAM(K) 48 
1060 DATA MODEL D, PRICE 50, COLOUR NO, RAM(K) 16 
1070 DATA 999 
1080 REM -- 999 is stop code & follows final item. 
1199 : 
1200 REM -- 'How' Routine: 
1210 PRINT: PRINT "It has :"
1220 FOR Q = 1 TO V 
1230   PRINT Q$(C,Q);" of ";R$(C,Q) 
1240   NEXT Q 
1250 RETURN 
1290 : 
1300 REM -- Re-initializing Routine: 
1310 FOR Q=1 TO x 
1320   FOR P=1 TO V 
1330     A$(Q,P)="": NEXT P 
1340   S%(Q)=1: NEXT Q 
1350 RETURN 