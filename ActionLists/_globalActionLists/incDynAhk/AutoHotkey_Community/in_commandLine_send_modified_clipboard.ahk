#SingleInstance,Force

if 0 > 0  ; The left side of a non-expression if-statement is always the name of a variable.
{
	ToolTip, % "0=" A_Args[0] "`n 1=" A_Args[1] "`n 2=" A_Args[2] " `n 3=" A_Args[3]
	if(false)
		for n, param in A_Args  ; For each parameter:
		{
			msgbox, Parameter number %n% is %param%.`n
    ; Send, Parameter number %n% is %param%.`n
		}
	Sleep,5000
	ToolTip,
}

links =
(
Doku:
run or include external scripts incDynAhk
https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-135
)

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

c := trim(clipboard)
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
[size=50]^- produced with [url=https://github.com/sl5net/global-IntelliSense-everywhere/blob/master/ActionLists/_globalActionLists/AutoHotkey_Community.ahk#L18
]ActionLists...AutoHotkey_Community[/url][/size]
[/spoiler2]
)
Clipboard := ahkCode
send, ^v
