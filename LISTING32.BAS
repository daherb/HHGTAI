10 REM *********************************
20 REM ** Listing 3.2 :               **
30 REM ** RULES OF GRAMMAR            **
40 REM *********************************
1000 REM Note that no spaces are allowed except where shown: 
1010 DATA <SENTENCE>=<NOUN.PHRASE> <VERB.PHRASE-PREPOSITIONAL.PHRASES>
1020 DATA <SENTENCE>=<SENTENCE> <CONJUNCTION> <SENTENCE> 
1030 DATA <NOUN.PHRASE>=<DETERMINER> <ADJECTIVES-NOUN> 
1040 DATA <ADJECTIVES-NOUN>=<ADJECTIVE> <ADJECTIVES-NOUN>
1050 DATA <ADJECTIVES-NOUN>=<NOUN>
1060 DATA <VERB.PHRASE-PREPOSITIONAL.PHRASES>=<VERB.PHRASE-PREPOSITIONAL.PHRASES> <PREPOSITIONAL.PHRASE> 
1070 DATA <VERB.PHRASE-PREPOSITIONAL.PHRASES>=<VERB.PHRASE> 
1080 DATA <VERB.PHRASE>=<VERB> <NOUN.PHRASE> 
1090 DATA <VERB.PHRASE-PREPOSITIONAL.PHRASES>=<VERB> <PREPOSITIONAL.PHRASE> 
1100 DATA <PREPOSITIONAL.PHRASE>=<PREPOSITION> <NOUN.PHRASE>
1110 DATA <VERB.PHRASE>=<VERB>
1120 DATA <DETERMINER>=A,THE,THIS,THAT 
1130 DATA <ADJECTIVE>=GREEN,RED,STRONG
1140 DATA <NOUN>=ROSE,GRASS,SUN 
1150 DATA <VERB>=GREW, SHONE 
1160 DATA <PREPOSITION>=TO,OF 
1170 DATA <CONJUNCTION>=AND
