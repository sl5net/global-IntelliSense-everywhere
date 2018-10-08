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
; Gi: do_indexFollowingLines4search = true 
MouseMove,52,0, 9, R
MouseMove,0,52, 9, R
MouseMove,-52,0, 9, R
MouseMove,0,-52, 9, R

send msg multi |rr||ahk|
; Gi: do_indexFollowingLines4search := true
msg = 
(
Thanks for your message.
When is best time for you make a call?
Best regards
)
send,% msg

multi text|r| ; thats not possible for the moment.
Thanks for your message.
When is best time for you make a call?
Best regards

