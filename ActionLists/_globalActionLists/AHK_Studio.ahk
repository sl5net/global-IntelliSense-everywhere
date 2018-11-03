#Include ..\_global.ahk
___open ActionList|rr||ahk|openInEditor,AHK_Studio.ahk
; ä = thats a au 



multi ahk Template|rr||ahk|
; Gi: do_indexFollowingLines4search = true
m=
(
quote_rr_ahk|rr|quote|rr|| ahk||ahk|ExitApp
ClipboardBackup := Clipboard
s = 
( )
Clipboard := s
Sleep,50
Suspend,On 
send, ^v
Suspend,Off
)
Suspend,On 
Clipboard := m
Suspend,Off
send,^v



multi_quote_demo 2|rr||ahk|
; Gi: do_indexFollowingLines4search = true
m=
(
quote_rr_ahk|rr|quote|rr|| ahk||ahk|ExitApp
ClipboardBackup := Clipboard
timeoutSec := 9
userNameDefault := "jeeswg joedf"
; InputBox, OutputVar , Title, Prompt, HIDE, Width, Height, X, Y, Font, Timeout, Default
InputBox, userName, userName? (AHK-Community), [quote="`%userName`%"], , 350, 100,,,,`%timeoutSec`%,`%userNameDefault`%
if ErrorLevel
	return
s = 
(
quote="`%userName`%"]|r|[quote="`%userName`%"]
`%ClipboardBackup`%[/quote]|r|`%ClipboardBackup`%[/quote]
MsgBox,278564,Insert into AHK-Community?,`% s
IfMsgBox,yes
{
	Clipboard := s
	Sleep,50
	Suspend,On 
	send, ^v
	Suspend,Off
}
)
Suspend,On 
Clipboard := m
Suspend,Off
send,^v






replacment rr |rr||ahk|
m = 
(
key for ahk|rr|sending|ahk|code
)
Send,% m

replacment r|rr||ahk|
m = 
(
replacment text|r|text
)
Send,% m

lklk ; __