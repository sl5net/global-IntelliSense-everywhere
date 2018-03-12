; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
#SingleInstance, force
; dontDeleteThisPlaceholder
#Include .\..\Wordlists\wordlistNameFilter.inc.ahk ; global wordlist . pleas dont delete this line! 17-03-06_10-59
wordlistFilterPath = .\Wordlists\ChromeWidgetWin1\wordlistNameFilter.inc.ahk ; richtig

if(false){
	noop:=0
}

#Include *i PRIVATE_wordlistNameFilter.inc.ahk

else if ( instr( activeTitle , "Benachrichtigung:")  &&  RegExMatch( activeTitle , "Gmail")   )
    wordlistNEW := "Benachrichtigung_Google_Chrome"
	
else if (  RegExMatch( activeTitle , "\b(Gmail|Google Contacts - Google Chrome)\b") )
wordlistNEW := "Gmail_Google_Chrome"


else if ( RegExMatch( activeTitle , "Google Kalender"  )    )
    wordlistNEW := "Gmail_Google_Chrome.txt"

if( SubStr( wordlistNEW , -3 ) <> ".txt" ) ; thats corect i proofed it. 11.04.2017 15:47
wordlistNEW .= ".txt"


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
wordlistNEW := maybeSuperglobalWordList(wordlistNEW, wordlistNEW_time_between , ActiveClass )
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; if you want you could use the follwong global variables fot calculating you new wordlistNEW : wordlistDir, wordlistNEW, ActiveClass, activeTitle
if (!wordlistNEW )
    MsgBox, ERROR wordlistNEW is EMPTY 17-03-05_14-51
; Clipboard := wordlistNEW
