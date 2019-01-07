; DetectHiddenWindows, On ;  Determines whether invisible windows are "seen" by the script.
; SetTitleMatchMode,1 ;  Sets the matching behavior of the WinTitle parameter in commands such as WinWait.
; #IfWinActive, Action List Appears Here


; ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\"; ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )) ":"  A_LineNumber ")" )
; tool1
; tToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\"; % tip) ":"  A_LineNumber ")" )
; tool1
; ahk_id 0x5190348
; ahk_class AutoHotkeyGUI
; Action List Appears Here
; Control: ListBox10

;tool ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
; tool ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
; tRemoveToolTip()
; ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )

#If MouseIsOver(g_ListBoxTitle " ahk_class AutoHotkeyGUI") ; https://www.autohotkey.com/docs/commands/_If.htm#Examples
$1::
;~ $!::
$Numpad1::

if(0){ ; deprecated. works but celeaner to use https://www.autohotkey.com/docs/commands/_If.htm#Examples 19-01-07_21-41
MouseGetPos, , , mouseID, mouseControl
WinGetTitle, mouseTitle, ahk_id %mouseID%
WinGetClass, mouseClass, ahk_id %mouseID%
; if(mouseTitle == "Action List Appears Here")
if(mouseTitle == g_ListBoxTitle ){
    tip = ahk_id %mouseID%`nahk_class %mouseClass%`n%mouseTitle%`nControl: %mouseControl%
    ToolTip, % tip
    clipboard := tip
    msgbox,% tip
    }
}
CheckWord("$1")
return

; testringDifference(string1, string2, maxOffset=1)
; FileAppend, tes te, Filename, Encoding

$2:: ; ; some users dont have numpad ; 25.03.2018 15:35
;~ $":: ; this is working
; VK07:: ; this is not working 21.04.2017 12:12
; maybe helful for you: http://www.kbdedit.com/manual/low_level_vk_list.html
; VK_OEM_7::



$Numpad2::
CheckWord("$2")
return



$3::  ; some users dont have numpad ; 25.03.2018 15:35
; $ï¿½:: ; problem with the paragraph sign. probably becouse of the document format. i dont need it so much. lets deactivate it. 21.04.2017 12:02
$Numpad3::
CheckWord("$3")
return
$4::  ; some users dont have numpad ; 25.03.2018 15:35
;~ $$::
$Numpad4::
CheckWord("$4")
return
$5::  ; some users dont have numpad ; 25.03.2018 15:35
$Numpad5::
CheckWord("$5")
return
$6::  ; some users dont have numpad ; 25.03.2018 15:35
;~ $&::
$Numpad6::
CheckWord("$6")
return
$7:: ;  ; some users dont have numpad ; 25.03.2018 15:35
;~ $/::
;~ ${::
$Numpad7::
CheckWord("$7")
return
$8::  ; some users dont have numpad ; 25.03.2018 15:35
;~ $(::
;~ $[::
$Numpad8::
CheckWord("$8")
return
$9::  ; some users dont have numpad ; 25.03.2018 15:35
;~ $)::
;~ $]::
$Numpad9::
CheckWord("$9")
return
$0:: ; some users dont have numpad ; 25.03.2018 15:35
;msgbox,0
CheckWord("$0")
;~ $=::0000
;~ $}::
return
$Numpad0::
;msgbox,Numpad0
CheckWord("$Numpad0")
; CheckWord(A_ThisHotkey)
Return
; to  tooltip green|r|Tooltip, is green

#IfWinActive,


; tTooltip, `n (from: %A_LineFile%~%A_LineNumber%)
; boxm boxmsg1 bMsgBoxMM(mm) MsgBox,262160,% ":(`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":(`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

; https://www.autohotkey.com/docs/commands/_If.htm#Examples
MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}