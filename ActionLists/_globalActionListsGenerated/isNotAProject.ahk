; #Include *i _global.ahk ; that makes confusen here. keep it simple. 19-01-06_11-03
; !! importand: never delte this line or this file! with this line you are able to usa a special project configuaratioin 09.08.2017 20:07 17-08-09_20-07
; isNotAProject.ahk

;___create actionList|rr||ahk|msgbox,% ">>>" aScriptDir "<<<"
; if this german au is readable your UTF8 is probalby corre
; create_own_project|rr||ahk|run,..\..\Source\createOwnProjectDirOrThis.ahk
; ___create actionList project|rr||ahk|run,..\..\..\Source\createOwnProjectDirOrThis.ahk
; ___create actionList project|rr||ahk|run,..\Source\createOwnProjectDirOrThis.ahk
; ___create actionList project|rr||ahk|run,..\Source\createOwnProjectDirOrThis.ahk
; ___create actionList|rr||ahk|run,%aScriptDir%\createOwnProjectDirOrThis.ahk
; ___create actionList|rr||ahk|run,%rootAbs%\Source\createOwnProjectDirOrThis.ahk
; ___create actionList|rr||ahk|run,%rootAbs%\Source\createOwnProjectDirOrThis.ahk,%rootAbs%\Source\
___create actionList|rr||ahk|
RegRead, isNotYet_actionList, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, isNotYet_actionList
; msgbox,% isNotYet_actionList
content =
(
one
two
three
four
five
six
seven
eight
nine
ten
)
actionListDir := RegExReplace(isNotYet_actionList, "\\[^\\]*$")
temp =
(
%actionListDir%
%isNotYet_actionList%
)
if(!FileExist(actionListDir)){
    FileCreateDir, % actionListDir
    sleep,90
}
FileAppend, % content, % isNotYet_actionList ".ahk"
if(!FileExist(actionListDir "\al-route.inc.ahk")){
    content := "#" "Include ..\actionLists\al-route-header.inc.ahk"
    FileAppend, % content, % actionListDir "\al-route.inc.ahk"
}
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, % isNotYet_actionList




