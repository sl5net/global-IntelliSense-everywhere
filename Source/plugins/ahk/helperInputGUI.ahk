its not needet anymore for the moment.



see:



\Source\inc_ahk\functions_global.inc.ahk
if(0 && winActive("ahk_class AutoHotkeyGUI")){
        ; what was the motivation for this attitude? 18-12-29_11-40
        ; which error should that fix?
        ; which difficulty`?
        ; ==> then some script i not usabal with gi. nearly all GUIs ant also AHK_Studio



#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



Name := A_ScriptName
Gui, 3: Add, Edit, x1 y1 w500 h65 vNT, default value
Gui, 3: Add, Button, x10  y70 gLable, Start
Gui, 3: Add, Button, x140 y70 gCancel, Cancel
Gui, 3: Show, Center h95 w502, %Name%
Return
Esc::ExitApp
Cancel:
ExitApp
Lable:
Gui, 3: Submit, NoHide
MsgBox, 262208, , %NT%
Return



; zool tool tool 
; tool  ToolTip5sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )



; tool ToolTip4sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )