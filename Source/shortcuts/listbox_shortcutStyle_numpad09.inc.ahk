$1::
;~ $!::
$Numpad1::
CheckWord("$1")
return



$2:: ; ; some users dont have numpad ; 25.03.2018 15:35
;~ $":: ; this is working
; VK07:: ; this is not working 21.04.2017 12:12
; maybe helful for you: http://www.kbdedit.com/manual/low_level_vk_list.html
; VK_OEM_7::



$Numpad2::
CheckWord("$2")
return



$3::  ; some users dont have numpad ; 25.03.2018 15:35
; $�:: ; problem with the paragraph sign. probably becouse of the document format. i dont need it so much. lets deactivate it. 21.04.2017 12:02
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