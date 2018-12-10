; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#NoTrayIcon

Critical , On

SetWorkingDir %A_ScriptDir%\Source

SetTitleMatchMode,1
name=temp.ahk ahk_class #32770
while(WinExist(name) && A_Index < 9)
	WinClose,% name
while(WinExist(name) && A_Index < 9)
	WinKill,% name

DetectHiddenWindows,on
SetTitleMatchMode,2
name=Typing_Aid_everywhere_multi_clone.ahk ahk_class AutoHotkey
;name := "Typing_Aid_everywhere_multi_clone" ; .ahk ; ahk_class AutoHotkey
;name=gi-everywhere ahk_class AutoHotkey
while(WinExist(name) && A_Index < 999){
	; ToolTip, %A_Index%: WinClose `n (%A_LineFile%~%A_LineNumber%)
	WinClose,% name
}
;run,gi.ahk ; ,%A_ScriptDir%\Source
; run,%A_ScriptDir%\gi.ahk ; ,%A_ScriptDir%\Source
;MsgBox, ExitApp
; ExitApp

while(WinExist(name) && A_Index < 9)
	WinKill,% name


	
;DetectHiddenWindows,Off ; <== never do this again. all in taskbar was not closed !! 02.10.2018 12:33

; 1: A window's title must start with the specified WinTitle to be a match.
; 2: A window's title can contain WinTitle anywhere inside it to be a match.
; 3: A window's title must exactly match WinTitle to be a match.
SetTitleMatchMode,3
name=gi.ahk ahk_class AutoHotkey
while(WinExist(name) && A_Index < 9)
	WinClose,% name
while(WinExist(name) && A_Index < 9)
	WinKill,% name


name=gi ahk_class AutoHotkey
while(WinExist(name) && A_Index < 9)
	WinClose,
while(WinExist(name) && A_Index < 9)
	WinKill,

; ahk_class AutoHotkey
name=gi - Active
while(WinExist(name) && A_Index < 9)
	WinClose,
while(WinExist(name) && A_Index < 9)
	WinKill,

; ahk_class AutoHotkey
name=gi - Inactive
while(WinExist(name) && A_Index < 9)
	WinClose,
while(WinExist(name) && A_Index < 9)
	WinKill,

; msgbox, lets start 17.02.2018 22:14

FileDelete, ActionListLearned.db
Sleep,100

run,gi-everywhere.ahk,%A_ScriptDir%\Source
winwait,gi-everywhere.ahk,,9
Sleep,1000
run,Typing_Aid_everywhere_multi_clone.ahk,%A_ScriptDir%\Source


exitApp