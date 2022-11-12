10 REM *********************************
20 REM ** Listing 3.1                 **
30 REM ** QUERY PROGRAM               **
40 REM *********************************
50 CLS 
60 RESTORE: I=0 
70 READ A$: IF A$ <> "END1" THEN GOTO 70 
80 I=I+1: READ A$: IF A$="END2" THEN GOTO 100 
90 GOTO 80 : REM just counting. 
100 P=(I-1) / 3: REM P is no. of personnel records 
110 PRINT "I know something about personnel." 
120 PRINT "Ask me something about someone:"
130 INPUT S$ 
140 FL=0: T=1: REM FL is flag to tell if a match has been found and T shows which field the match was found in 
144 : 
150 RESTORE 
160 READ A$: IF A$="END1" AND FL=0 THEN PRINT "I'm afraid I don't quite understand": PRINT "that question.": PRINT "Could you re-phrase it please ?": GOTO 130 
170 IF A$="888" THEN T=T+1: GOTO 160 
180 FOR I = 1 TO LEN(S$) - LEN(A$) + 1 
190   IF AS <> MIDS$(S$,I,LEN(A$)) THEN GOTO 210 
200   FL=1 
210   NEXT I
220 IF FL=0 THEN GOTO 160 
230 READ A$: IF A$<>"END1" THEN GOTO 230 
240 M=0 
250 FOR J=1 TO P 
260   READ A$
265   Q=0 
270   FOR I=1 TO LEN(S$) - LEN(A$) + 1 
280     IF A$ <> MID$(S$,I,LEN(A$)) THEN GOTO 300
290     PRINT A$;" IS "; FOR Q=1 TO T: READ I$: NEXT: PRINT I$: M=1 
295     REM -- A match has been found in personnel records. 
300     NEXT I
310   IF Q=0 THEN READ A$,A$
320   NEXT J 
330 IF M=0 THEN PRINT "I'm afraid I do't know that." 
340 INPUT "Do you have another question (Y=Yes) ", A$
350 IF A$ = "Y" THEN GOTO 130 
360 END
365 : 
370 REM -- Language Data: 
380 DATA AGE,OLD, 888
385 REM 888 is end-of-field code. 
390 DATA MARRIED, WIFE, HUSBAND, SPOUSE, BACHELOR, WIDOWER, SPINSTER, MARITAL, 888 
400 DATA END1 
410 REM -- Personnell Records: 
420 DATA JOHN SMITH, 37,MARRIED 
430 DATA BILL BLOGGS, 23,SINGLE 
440 DATA JANE HARRIS, 25, SINGLE 
450 DATA FREDA BAGGINS, 43,MARRIED 
460 DATA JIM JENKINS, 67, DIVORCED 
470 DATA JOAN DARBY, 65,WIDOWED
480 DATA END2 
