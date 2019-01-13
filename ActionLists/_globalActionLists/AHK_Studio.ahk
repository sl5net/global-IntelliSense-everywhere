#Include _global.ahk
; #Include ..\_globalActionListsGenerated\_ahk_global.ahk


___open AHK_Studio|rr||ahk|openInEditor,AHK_Studio.ahk
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
quote="`%userName`%"]|r |[quote="`%userName`%"]
`%ClipboardBackup`%[/quote]|r |`%ClipboardBackup`%[/quote]
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






replacment rr|rr||ahk|
m = 
(
key for ahk|rr|sending|ahk|code
)
Send,% m

replacment r|rr ||ahk|q
m = 
(
replacment text|r |text
)
Send,% m



____open ahk_global|rr||ahk|openInEditor,_ahk_global.ahk
open ahk_global|rr||ahk|openInEditor,_ahk_global.ahk

msgbox,% "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
Msgbox,% "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
MsgBox info on top|r|MsgBox,262208,% ":)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
MsgBox error on top|r|MsgBox,262160,% ":(`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":(`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
Msgbox,`n(%A_LineFile%~%A_LineNumber%)
Msgbox|rr|Msgbox,`n(%A_LineFile%~%A_LineNumber%)|ahk|Send,{shift down}{left 33}{shift up}

Speak(,"PROD")
Speak( A_ThisFunc,"PROD")
Speak(" found","PROD")



rTrim(clipboard," `t`r`n")

RegExReplace(A_LineFile,".*\\")

RegExMatch(fileName, "\.ahk$")
RegExMatch(activeTitle , "i)\b(Gmail|Google Contacts|Google Kalender)\b"  )  

InStr(A_fi, "D") )
InStr(A_LoopFileName, "" )

; Speak(A_LineNumber ":" A_thisFunc A_ThisLabel)
ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
ComputerName A_ComputerName|r|if(1 && InStr(A_ComputerName,"SL5"))

SoundbeepString2Sound()


ReplacedStr := StrReplace(Haystack, SearchText , ReplaceText, OutputVarCount, Limit := -1)

RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, toDo, A_ScriptName " " A_LineNumber ": "  ; RegWrite , RegSave , Registry

 
chat:|r|https://autohotkey.com/boards/viewtopic.php?f=5&t=59
Server IRQ: chat.freenode.net
Port IRQ: 6667 (6697 for SSL)
Channel IRQ: #ahk

ActionLists
Source

Msgbox,% "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
MsgBox info on top|r|MsgBox,262208,% ":)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
MsgBox error on top|r|MsgBox,262160,% ":(`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":(`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
Msgbox,`n(%A_LineFile%~%A_LineNumber%)
Msgbox|rr|Msgbox,`n(%A_LineFile%~%A_LineNumber%)|ahk|Send,{shift down}{left 33}{shift up}


ToolTip2sec lineFileName|rr|ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip2sec lineFileName|rr|ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip4sec lineFileName|rr|ToolTip4sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip5sec lineFileName|rr|ToolTip5sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip6sec lineFileName|rr|ToolTip6sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip7sec lineFileName|rr|ToolTip7sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip8sec lineFileName|rr|ToolTip8sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip9sec lineFileName|rr|ToolTip9sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}


Sleep, 000|rr|Sleep, 000|ahk|Send,{left 3}

FileMove
FileMove,% A_LoopFileFullPath, % A_LoopFileDir "\" fileNameNew

InputBox, UserInput|rr||ahk
m =
(
InputBox, userName, userName? (AHK-Community), [quote="%userName%"] `n timeoutSec = %timeoutSec%, , 350, 100,,,,%timeoutSec%,%userNameDefault% 
if ErrorLevel
	return
)
Suspend,On 
Clipboard := m
send, ^ v
Suspend,off


ToolTip2sec|rr|ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip2sec|rr|ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip4sec|rr|ToolTip4sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip5sec|rr|ToolTip5sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTipSec(t,x=123,y=321,sec=1000)
Tooltip, `n (from: %A_LineFile%~%A_LineNumber%)

lineFileName := RegExReplace(A_LineFile,".*\\")


ToolTipSec(t,x=123,y=321,sec=1000)
Tooltip, `n (from: %A_LineFile%~%A_LineNumber%)


regEx find AHK functios definitions|r|^[ ]*?\w[\w\d_]{5,}\s*\([^()+<>]+\)[\s\S]{0,5}?\{
	
	
	runIfNotExist|rr||ahk|s=runIfNotExist(m_r , m_WinTitle = "",m_category="", doFeedbackMsgBox:=258)`nSend,%s%
	LTrim(String)
	RTrim(String)
	
	
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
	FileAppend, Text, Filename, Encoding|rr|FileAppend, |ahk|m=Text, Filename, Encoding`n ll:=strlen(m)+1 `n lr:=4 `n send, %m% {left %ll%}{shift down}{right %lr%}{shift up}
	
; gi-everywhere-master\Source\gi-everywhere.ahk
	FileAppend dynAhk|rr|; FileAppend .. HelloWorld2.ahk|ahk|FileAppend, msgbox`, HelloWorld (from: %A_LineFile%~%A_LineNumber%)``n , incDynAhk\HelloWorld2.ahk
	AHKdyn Example run|rr||ahk|f=incDynAhk\HelloWorld3.ahk `n if(Fileexist(f)) `n run,%f%
	
	
	timestamp yy:MM:dd HH:mm:ss|r|FormatTime, timestampyyMMddHHmmss, %A_now%,yy:MM:dd HH:mm:ss
	timestamp dd.MM.yy HH:mm Uhr|r|FormatTime, ddMMyyHHmm, %A_now%,dd.MM.yy HH:mm Uhr; MsgBox,%ddMMyyHHmm% `n = ddMMyyHHmm (%A_LineFile%~%A_LineNumber%)
	timestampyyMMddHHmmss|r|FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
	timestampHHmmss|r|FormatTime, timestampHHmmss, %A_now%,HH:mm:ss
	
