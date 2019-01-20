#SingleInstance,Force

links =
(
Doku:
run or include external scripts incDynAhk
https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-135
)

SetTitleMatchMode,2
; wt := "- AutoHotkey Community - Google Chrome"
wt := "AutoHotkey Community -"
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
[size=50]^- produced with [url=https://github.com/sl5net/global-IntelliSense-everywhere/blob/master/ActionLists/_globalActionLists/AutoHotkey_Community.ahk#L108
]ActionLists...AutoHotkey_Community[/url][/size]
[/spoiler2]
)
Clipboard := ahkCode
send, ^v
