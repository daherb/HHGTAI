10 REM *********************************
20 REM ** Listing 4.1 :               **
30 REM ** PERCEPTRON-TYPE             **
40 REM ** VISION SYSTEM               **
50 REM *********************************
55 MODE 7 
60 DIM I%(16,16) 
64 DIM D% 8192 
65 REM D& is a byte-array (BBC) 
70 REM -- I% is image array, D& is address array. 
80 REM -- Note: I% contains either 0 or 1 
88 GOSUB 1000: REM clear D% array. 
90 INPUT “Which class is it (0/1) ",C%
100 FOR I%=1 TO 16: FOR J%=1 TO 16: I%(I%,J%)=0 
101     NEXT: NEXT 
110 REM -- Input an image at this point. 
120 GOSUB 2000 
130 R=RND(-1): REM random seed value 
140 FOR I%=1 TO 32 
150   A%=256 * (I%-1) 
160   FOR J%=0 TO 7 
170     R1%=INT(RND(1)*16 + 1) 
180     R2%=INT(RND(1)*16 + 1) 
190     A%=A%+ I%(R1%,R2%) * 2^J% 
200   NEXT J 
210   PROCdset (A%, C%) 
220   NEXT I%
230 INPUT "Another training session (Y/N) ", A$: IF A$="Y" THEN GOTO 90 
233 IF A$="y" THEN GOTO 90 
240 FOR I%=1 TO 16: FOR J%=1 TO 16 
244     I%(1%,J%)=0 
245     NEXT: NEXT 
250 REM -- Input an example for classification at this point 
260 GOSUB 2000 
270 R=RND(-1) 
280 C0=0: C1=0: REM category scores 
290 FOR I%=1 TO 32
300   A%=256 * (1%-1) 
310   FOR J%=0 TO 7 
320     R1%=INT(RND(1)*16 + 1) 
330     R2%=INT(RND(1)*16 + 1) 
340     A%=A%+I%(R1%,R2%) * 2^J% 
350     NEXT 
360   IF FNdget(A%,0) > 0 THEN CO=CO+1 
370   IF PNdget(A%,1) > 0 THEN C1=C1+1
380   NEXT I%
390 PRINT "Class 0 has a score of ";C0/32 
400 PRINT "Class 1 has a score of ";C1/32 
404 IF CO>C1 THEN PRINT "Class 0" ELSE “Class 1" 
410 INPUT "Do you want to classify another image (Y=Yes) ", A$
420 IF AS="Y" OR AS="y" THEN GOTO 240
440 PRINT: PRINT “Bye!” 
444 END 
999 : 
1000 REM -- Address-array Initialization: 
1010 POR I%=1 TO 8192 
1020   REM -- uses byte-subscripting (?): 
1030   ?(D%+I%)=0 
1040   NEXT 
1050 RETURN 
1199 : 
1200 DEF PROCdset (A%,C%) 
1210 REM --------
1220 ?(D%+A%) = (D%?A%) OR 2^C%
1230 ENDPROC
1240 REM sets a bit in D8 array 
1250 DEF FNdget(A8,C8) 
1260 REM ------
1270 ?(D%?A%) AND 2^C% 
1280 REM extracts bit from D% array 
1288 REM A% is 1..8192; C% is 0..7 
1290 : 
2000 REM -- Image-making Routine: 
2010 CLS: PRINT TAB(0,20);"(Use: U, D, L, R, X, * or space.)"
2020 T%=0: A$=" "
2030 H%=1: V%=1 
2040 REPEAT C$=INKEY$(222) 
2050   IF C$="U" THEN V%=V%-1 
2060   IF C$="D" THEN V%=V%+1 
2070   IF C$="L" THEN H%=H%-1 
2080   IF C$="R" THEN H%=H%+1 
2090   IF H%>16 THEN H%=1 
2095   IF H%<1 THEN H%=16 
2100   IF V%>16 THEN V%=1 
2105   IP V%<1 THEN V%=16 
2110   IF C$=" " THEN T%=0: A$=C$
2120   IF CS="*" THEN T%=1: A$=C$ 
2130   I%(H%,V%)=T% 
2140   PRINT TAB(H%,V%);A$; 
2150 UNTIL C$="X"
2155 GOSUB 2200 : REM Re-display 
2160 RETURN 
2170 : 
2200 REM -- display Routine: 
2210 FOR H%=1 TO 16 
2220   FOR V%=1 TO 16 
2230     IF I%(H%,V%)>0 THEN PRINT TAB(H%,V%);":" ELSE PRINT TAB(H%,V%);" " 
2240     NEXT: NEXT 
2250 PRINT TAB(0,17); 
2260 RETURN 
2270 :
