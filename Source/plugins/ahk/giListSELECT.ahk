; Hallo: https://www.autohotkey.com/boards/viewtopic.php?f=6&t=45684&p=257223#p257223  19-01-10_10-27
; test 

#SingleInstance,Force
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_permanentSELECT, % "SELECT actionList FROM actionLists WHERE actionList Like '%g_Word%' AND actionList NOT Like 'isNotAProject.ahk' order by actionList"
bodyText =
(
Search ActionLists saved in DB. Chance to set ony permanent as long this window exist. SQL command is simply taken from the WindowTitle (needet token: giListSELECT )
usually the ActionLists automatically are choosen dependent on the title and your configuration. ESC closes the window
)
Gui, Add, Text, x10 y1 h40, % bodyText
Gui, Add, Edit, yp+40 wp vSearch, 
; Gui, Add, Button, yp+30 w77 h26 gAdd2Reg, &set this list permanent
; Gui, Add, Button, xp+85 wp hp gfSearch, &Forum Search
; Gui, Add, Button, xp+85 wp hp ggSearch, &Google It!
Gui, Show, AutoSize Center, % substr(A_ScriptName , 1, -4)
; newTitle = giListSELECT actionList FROM actionLists WHERE actionList Like 'g_Word' AND actionList NOT Like 'isNotAProject.ahk' order by actionList
; Gui, Show, w900 Center, % newTitle
WinGet, active_id, ID, % substr(A_ScriptName , 1, -4)
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

Add2Reg:
Gui, Submit
actionListNewTemp_withoutExt := SubStr( Search ,1 , -4 )
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, % actionListNewTemp_withoutExt
MsgBox,% Search
return


GuiClose:
Gui, Destroy
return

