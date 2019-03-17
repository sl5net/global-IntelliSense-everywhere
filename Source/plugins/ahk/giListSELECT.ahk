#SingleInstance,Force



; Hallo: https://www.autohotkey.com/boards/viewtopic.php?f=6&t=45684&p=257223#p257223  19-01-10_10-27
; test 

; rep := "RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, " actionListNewTemp_withoutExt "`n"

; g_config["list"]["change"]["stopRexExTitle"]:="."
; ``n RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change, 1

; ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe ahk_id 0xf31790
; Cursor:  Arrow  ▪  Caret:  x19 y86  ▪  Client area:  x3 y32 w1051 h85

SELECTpre =
(
SELECT distinct replace(actionList, rtrim(actionList, replace(actionList, '\', '')), '')
|| '|rr|'
|| '|ahk|RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, '
|| substr(actionList, 1, length(actionList)-4) || '
``n SetTitleMatchMode,2
``n WinClose, (giListSELECT) ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
``n RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_permanentSELECT, 
``n RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change, 1
``n RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, ' || actionList || '
``n MsgBox, , OK  :-) actionList was set, to a permanent list. valid as long as this window exists , 2
``n WinClose, giListSELECT ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe'
FROM actionLists
WHERE actionList Like '`%g_Word`%' Limit 10  ; 
)

SELECT := RegExReplace(SELECTpre, "m)\n", " ")
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change, % ""
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_permanentSELECT, % SELECT
; MsgBox, % SELECT
if(0 && InStr(A_ComputerName,"SL5") )
     Clipboard := SELECT


bodyText =
(
Search actionLists saved in DB. Chance to set ony permanent as long this window exist. SQL command is simply taken from the WindowTitle (needet token: giListSELECT )
usually the actionLists automatically are choosen dependent on the title and your configuration. ESC closes the window. F5 reloads the window. CTRL+SHIFT+c copy SELECT
)

wTitle := substr(A_ScriptName , 1, -4)
MsgBox, , % wTitle, Welcome to Choose actionList, 4 ; take a liitle time for script to read in the new values 19-01-19_11-13

; toool tooo tool

Gui, Add, Text, x10 y1 h140, % bodyText
Gui, Add, Edit, yp+40 wp vSearch, 
Gui, Add, Button, yp+30 w277 h126 gStopPmanentSELECT, &stop permanentList and (re-)enable automatically change the lists and exit %wTitle%
; Gui, Add, Button, yp+30 w77 h26 gAdd2Reg, &set this list permanent
; Gui, Add, Button, xp+85 wp hp gfSearch, &Forum Search
; Gui, Add, Button, xp+85 wp hp ggSearch, &Google It!
Gui, Show, AutoSize Center, % wTitle
;Sleep,500 ; becouse Typing... will overwrite it first. 19-01-17_17-52
; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, % ""
;ToolTip, % SELECT "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" 
; Sleep, 250
; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, % ""

; newTitle = giListSELECT actionList FROM actionLists WHERE actionList Like 'g_Word' AND actionList NOT Like 'isNotAProject.ahk' order by actionList
; Gui, Show, w900 Center, % newTitle
WinGet, active_id, ID, % wTitle
; hWnd := DllCall("GetParent",UInt,hWnd, UInt)
; WinSetTitle,% A_ScriptName ,% newTitle
; Send,{tab} ; focus first button
return

SetTitleMatchMode,2
~esc::
; ToolTip, % "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" 
IfWinNotActive, ahk_id %active_id%
{
;	ToolTip, % active_id " - " hWnd "=active_id`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" 
	return
}
; ToolTip, % "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" 
Gui, Destroy
exitapp
return
; enter:: ; deprecated
     ; Send,!f
; return


~^+c::
IfWinNotActive, ahk_id %active_id%
	return
Clipboard := SELECTpre
MsgBox, , ^+c detected, SELECT is copied to Clipboard , 2
return


~^+F5::
~F5::
IfWinNotActive, ahk_id %active_id%
	return
;MsgBox,reload
Gui, Destroy
; MsgBox, , F5 detected => reload, , 2
Reload
return

Add2Reg:
Gui, Submit
actionListNewTemp_withoutExt := SubStr( Search ,1 , -4 )
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, % actionListNewTemp_withoutExt
MsgBox,% Search
return

StopPmanentSELECT:
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change, % ""
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_permanentSELECT, % ""
Gui, Destroy
ExitApp, 1
return

GuiClose:
Gui, Destroy
ExitApp, 1
return

