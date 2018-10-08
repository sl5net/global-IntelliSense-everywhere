; 'Dokument.rtf - WordPad' ; (Source\inc_ahk\Typing_Aid_everywhere_multi_clone.inc.ahk~119) 
; #Include ..\_globalActionLists\examplesForBeginners.txt ; updated: 21.03.2018 07:33
___open ActionList|rr||ahk|run,Dokument_rtf_WordPad.ahk
; if you could read this germen special character (umlaute) your file format is correct (please use UTF8)
; ä = thats a au 

multi 1|rr||ahk|
MouseMove,51,0, 9, R
MouseMove,0,51, 9, R
MouseMove,-51,0, 9, R
MouseMove,0,-51, 9, R

multi 2|rr||ahk|
; Gi: indexFollowingLines4search = true 
MouseMove,52,0, 9, R
MouseMove,0,52, 9, R
MouseMove,-52,0, 9, R
MouseMove,0,-52, 9, R

multi text|r| ; thats not possible for the moment.
line 1
line 2


