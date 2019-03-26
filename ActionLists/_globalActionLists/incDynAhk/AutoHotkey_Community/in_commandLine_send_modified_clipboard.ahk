#SingleInstance,Force

#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
; Process, Priority,, Normal
; SetBatchLines, 20ms ; addet 03.11.2018 18:51
; SetBatchLines, 10
SetKeyDelay, -1, -1
SetWinDelay, -1 ; Sets the delay that will occur after each windowing command, such as WinActivate.
; SetWinDelay, 10
SetControlDelay, -1 ; A short delay (sleep) is done automatically after every Control command that changes a control, namely Control, ControlMove, ControlClick, ControlFocus, and ControlSetText (ControlSend uses SetKeyDelay).
; SetControlDelay, 10
; https://autohotkey.com/docs/commands/Process.htm#Priority
; L (or Low), B (or BelowNormal), N (or Normal), A (or AboveNormal), H (or High), R (or Realtime)
Process, Priority,, H ; <=== only use this if its not in a critical development 05.11.2018 13:20
; Process, Priority,, R ; <=== it acts on me as if the script was working more UNstable
; Thread, NoTimers ; https://autohotkey.com/docs/commands/Thread.htm


example =
(
config.inc.ahk:
	code_AutoHotkey_Community: 
	A_ScriptDir "\..\actionLists\_globalActionLists\incDynAhk\AutoHotkey_Community\in_commandLine_send_modified_clipboard.ahk"
in a actionList:
code_externExe_Hi_all|rr||code_AutoHotkey_Community|MsgBox,Hi all :-)
)

links =
(
Doku:
run or include external scripts incDynAhk
https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-135
)

; in_commandLine_send_modified_clipboard.ahk
; folowing works
; codeSpoilerIncDyn_externExe|rr||code_AutoHotkey_Community|#incDynAhk\AutoHotkey_Community\in_commandLine_send_modified_clipboard.ahk


code := ""
if 0 > 0  ; The left side of a non-expression if-statement is always the name of a variable.
{
	; 3=" code 
	code := UrlDecode(SubStr(A_Args[3],3))
	; ToolTip, % "0=" A_Args[0] "`n 1=" A_Args[1] "`n 2=" A_Args[2] " `n 3=" code 
	if(false)
		for n, param in A_Args  ; For each parameter:
		{
			msgbox, Parameter number %n% is %param%.`n
    ; Send, Parameter number %n% is %param%.`n
		}
}


SetTitleMatchMode,2
; wt := "- AutoHotkey Community - Google Chrome"
wt := "AutoHotkey Community"
WinActivate, % wt
ToolTip,% " WinActivate `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" 
WinWaitActive, % wt,,9
IfWinNotActive, % wt
{
	MsgBox,262160,% ":(`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":(`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	ExitApp
}
thisFileName := RegExReplace(A_LineFile,".*\\")
if(!code)
	while(A_index < 150){
		c:= clipboard
		if(c)
			Break
		Sleep,5
	}
c := (code) ? code : clipboard
if(!code){
    MsgBox,262160,% ":(`n" ,% " Oops !code is empty. please try again `n`n`n:(`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    exitApp
}
c := Trim(c," `t`r`n")
if( RegExMatch(c, "\n" )){
	c := RegExReplace(c,"im)\[code\]","[CODE]") 
	c := RegExReplace(c,"im)\[/code\]","[/C0DE]") 
	shortName := SubStr(c,1,20)
	shortName := RegExReplace(shortName,"m)\s+"," ")
	ahkCode = 
(
[spoiler2=%shortName%]
[code]
%c%
[/code]
[size=50]^- preparser: [url=https://github.com/sl5net/global-IntelliSense-everywhere/blob/master/ActionLists/_globalActionLists/AutoHotkey_Community.ahk#L18
]%thisFileName%[/url][/size]
[/spoiler2]
)
}else{
	c := RegExReplace(c,"im)\[c\]","[C]") 
	c := RegExReplace(c,"im)\[/c\]","[/C]")
	ahkCode := "[c]" c "[/c]"
}
Clipboard := ahkCode
send, ^v
suspend,on
send,+{tab} ; lets focus subject
suspend,off
; MsgBox,262208,% ":)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ahkCode "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"


Sleep,6000
ToolTip,


;/¯¯¯¯ UrlDecode ¯¯ 190121070309 ¯¯ 21.01.2019 07:03:09 ¯¯\
UrlDecode(encURL){
; from: https://www.rosettacode.org/wiki/URL_decoding#AutoHotkey
; encURL := "http%3A%2F%2Ffoo%20bar%2F"
	SetFormat, Integer, hex
	Loop Parse, encURL
		If A_LoopField = `%
			reading := 2, read := ""
	else if reading
	{
		read .= A_LoopField, --reading
		if not reading
			out .= Chr("0x" . read)
	}
	else out .= A_LoopField
		;tooltip % out ; http://foo bar/
		Return, out
}
;\____ UrlDecode __ 190121070314 __ 21.01.2019 07:03:14 __/

