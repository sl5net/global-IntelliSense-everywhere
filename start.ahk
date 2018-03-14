; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
#NoTrayIcon
SetWorkingDir %A_ScriptDir%\Source

DetectHiddenWindows,on
SetTitleMatchMode,2
name=Typing_Aid_everywhere_multi_clone.ahk ahk_class AutoHotkey
;name := "Typing_Aid_everywhere_multi_clone" ; .ahk ; ahk_class AutoHotkey
;name=TypingAid ahk_class AutoHotkey
while(WinExist(name) && A_Index < 999){
	ToolTip, % A_Index
	WinClose,% name
}
;run,TypingAid.ahk ; ,%A_ScriptDir%\Source
; run,%A_ScriptDir%\TypingAid.ahk ; ,%A_ScriptDir%\Source
;MsgBox, ExitApp
; ExitApp

while(WinExist(name) && A_Index < 9)
	WinKill,% name


	
DetectHiddenWindows,Off
SetTitleMatchMode,2
	
name=TypingAid.ahk ahk_class AutoHotkey
while(WinExist(name) && A_Index < 9)
	WinClose,% name
while(WinExist(name) && A_Index < 9)
	WinKill,% name


name=TypingAid ahk_class AutoHotkey
while(WinExist(name) && A_Index < 9)
	WinClose,
while(WinExist(name) && A_Index < 9)
	WinKill,

; ahk_class AutoHotkey
name=TypingAid - Active
while(WinExist(name) && A_Index < 9)
	WinClose,
while(WinExist(name) && A_Index < 9)
	WinKill,

; ahk_class AutoHotkey
name=TypingAid - Inactive
while(WinExist(name) && A_Index < 9)
	WinClose,
while(WinExist(name) && A_Index < 9)
	WinKill,

; msgbox, lets start 17.02.2018 22:14

run,TypingAid.ahk,%A_ScriptDir%\Source
Sleep,1000
run,Typing_Aid_everywhere_multi_clone.ahk,%A_ScriptDir%\Source


