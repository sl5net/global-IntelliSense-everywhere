; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
; create own project dir or this
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
isDevellopperMode:=true ; enthï¿½llt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#Include *i %A_ScriptDir%\keysEveryWhere_PRIVATE.inc.ahk


;msgbox,% "hi inside  :-) (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
; tooltip,% "hi inside  :-) (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"

ActionListsDir := "..\ActionLists"
#Include,..\ActionLists\activeClassManipulation.inc.ahk
; #Include," . d1 . "\ActionListNameFilter.inc.ahk `;```n Send,yes2 ``n " `n DynaRun(AHKcode)
activeClass := RegExReplace( activeClass, "[\W_]+", "") 
d1 = %ActionListsDir%\%activeClass%
fileExist := FileExist(d1)
if(fileExist){
  tooltip,ups folder already exist 13.05.2018 06:55  `n (%A_LineFile%~%A_LineNumber%)
}
if(false){
  globalTxt := d1 "\_global.ahk"
  fileExist := FileExist(globalTxt)
  if(fileExist){
    run,% globalTxt
    tooltip, WinWaitActive`, globalTxt  `n (%A_LineFile%~%A_LineNumber%)
    clipboard := globalTxt
    msgbox,ups globalTxt (its copied to clipboard) already exist `n ExitApp `n 13.05.2018 06:58
    WinWaitActive,% globalTxt
    ExitApp
}}
; ..\ActionLists\VirtualConsoleClass\

folderExist := ""
while(!folderExist && A_Index < 11){
  FileCreateDir, %d1% 
  sleep,99 
  folderExist := FileExist(d1)
}
  if( !folderExist ){
    msgbox,ERROR: folder NOT exist 13.05.2018 06:55 `n >%d1%<
    ExitApp
  }

;/¯¯¯¯ try_faster_reload_if_created ¯¯ 181025152605 ¯¯ 25.10.2018 15:26:05 ¯¯\
; I hope the with this method is reloaded after creating a new list (much faster). 25.10.2018 15:25
; no success 25.10.2018 15:30
globalActionListDir := "..\ActionLists"
; globalActionList := globalActionListDir "\_globalActionListsGenerated\_global.ahk"
globalActionList := globalActionListDir   "\_globalActionListsGenerated\isNotAProject.ahk"
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListNEW, %globalActionList% ; RegWrite , RegSave , Registry
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionList, %globalActionList% ; RegWrite , RegSave , Registry
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, lastImportant_ScriptName, %globalActionList% ; RegWrite , RegSave , Registry

RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, lastImportant_ScriptName, % A_ScriptName ; RegWrite , RegSave , Registry
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite , RegSave , Registry
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite , RegSave , Registry
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, CreatedDir, % d1 ; RegWrite , RegSave , Registry
;\____ try_faster_reload_if_created __ 181025152609 __ 25.10.2018 15:26:09 __/

run,Typing_Aid_everywhere_multi_clone.ahk
run,gi-everywhere.ahk

FileAppend,"temporary empty file. if exist next view dont use the super _global.ahk", %d1%\_create_own_project.flag
IfNotExist,%d1%\_global.ahk
    FileAppend,% "#" "Include _global.ahk", %d1%\_global.ahk
; MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,1 ; thats only trick. so it should reload another wordklist.
; MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,99 ; thats only trick. so it should reload another wordklist.
; it not need to be closed active bevor 13.05.2018 19:23. now we close it active. so its litle faster then a second . thats nice

; try sppedup it with DynaRun(AHKcode)
;AHKcode := "MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,9"
;DynaRun(AHKcode)


;FileDelete, % "..\ActionLists\" . ActiveClass . "\_create_own_project.flag"
ExitApp

; sorry we dont know actually (ActionListNEW) the
; ActionListNEW inside this script.
; therefore we need the created token=17-08-10_16-17 token.
if(!ActionListNEW){
      Msgbox,:( !ActionListNEW ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
      ExitApp
}
contend =
(
#Include ..\_globalActionLists\_global.ahk
#Include ..\%ActiveClass%\_global.ahk

; #Include ..\_globalActionLists\examplesForBeginners.txt
___open _globalActionLists\_global|rr||ahk|openInEditor,..\_globalActionLists\_global.ahk
___open _global|rr||ahk|openInEditor,_global.ahk
___open ActionList|rr||ahk|openInEditor,%ActionListNEW%
; if you could read this germen special character (umlaute) your file format is correct (please use UTF8)
; ä = thats a au
)
globalClassTxtAddress := "..\ActionLists\" . ActiveClass . "\_global.ahk"
if(!FileExist(globalClassTxtAddress))
  FileAppend,% "", % globalClassTxtAddress
ActionListNEWAddress := "..\ActionLists\" . ActiveClass . "\" . ActionListNEW
if( FileExist( ActionListNEWAddress ) ){
    ; run, % ActionListNEWAddress ; this works for .txt extension. that we dont use anymore 01.10.2018 11:12
    openInEditor("..\ActionLists\" . ActiveClass, true, "run," ActionListNEW, true, true, true)

    Msgbox,ups ActionListNEW = >>>>%ActionListNEW%<<< `n exist already ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
    EXIT
}

if( !FileExist( globalClassTxtAddress ) ){
    Msgbox,ups ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
    EXIT
}
if(1 && InStr(A_ComputerName,"SL5")){
    ToolTip5sec("FileAppend (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
    msgBox,% "FileAppend : (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
}
 FileAppend,% contend,   % ActionListNEWAddress
if( !FileExist(ActionListNEWAddress) ){
    Msgbox,ups ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
EXIT
}
Sleep,100
     ; msgbox,%ActionListNEW% = ActionListNEW ,`%ActionListNEW`% = ActionListNEW 18-03-06_13-31 `n (%A_LineFile%~%A_LineNumber%)

 ; run, % ActionListNEWAddress ; this works for .txt extension. that we dont use anymore 01.10.2018 11:12
; ActionListNEWAddress := "..\ActionLists\" . ActiveClass . "\" . ActionListNEW
; openInEditor(isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib)
; openInEditor(ActionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib){
  openInEditor("..\ActionLists\" . ActiveClass, true, "run," ActionListNEW, true, true, true)





ExitApp
reload



#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk

#Include %A_ScriptDir%\inc_ahk\openInEditor_actionList.inc.ahk
;__ __ __
;