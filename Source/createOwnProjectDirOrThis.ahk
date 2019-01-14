; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
; create own project dir
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
isDevellopperMode:=true ; enthï¿½llt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#Include *i %A_ScriptDir%\keysEveryWhere_PRIVATE.inc.ahk

g_config := {}
#Include %A_ScriptDir%\inc_ahk\minify\config.minify.inc.ahkSTATIC.ahk
; #Include *i %A_ScriptDir%\inc_ahk\minify\config.minify.inc.ahkSTATIC.ahk
; # Include *i %A_ScriptDir%\inc_ahk\minify\config.minify.inc.ahk ; update_configMinify_incAhkFile()

if(1 && InStr(A_ComputerName,"SL5") )
    g_doSound := true



if(g_doSound){
    global g_ttSpeakObject
    g_ttSpeakObject := new TTS()
    ; s.SetRate(-2)
    g_ttSpeakObject.SetRate(5) ; speed higher value is faster. 2 is about 200 procent. 1 sounds like normal speak
    ; -1 is very slow
    ; -5 is terrible slow
    ; 0 seems normal
    ; 2 little faster
    ; 5 reaky fast but possible to understand
    g_ttSpeakObject.SetPitch(10)
}



;msgbox,% "hi inside  :-) (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
; tooltip,% "hi inside  :-) (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"



actionListsDir := "..\actionLists"
#Include,..\actionLists\activeClassManipulation.inc.ahk
; #Include," . d1 . "\actionListNameFilter.inc.ahk `;```n Send,yes2 ``n " `n DynaRun(AHKcode)
activeClass := RegExReplace( activeClass, "[\W_]+", "") 
d1 = %actionListsDir%\%activeClass%
fileExist := FileExist(d1)
if(fileExist){
  tooltip,ups folder already exist 13.05.2018 06:55  `n (%A_LineFile%~%A_LineNumber%)
}
if(false){
  globalTxt := d1 "\_global.ahk"
  fileExist := FileExist(globalTxt)
  if(fileExist){
    run,% globalTxt
    tooltip, WinWaitActive globalTxt  `n (%A_LineFile%~%A_LineNumber%)
    clipboard := globalTxt
    msgbox,ups globalTxt (its copied to clipboard) already exist `n ExitApp `n 13.05.2018 06:58
    WinWaitActive,% globalTxt
    ExitApp
}}
; ..\actionLists\VirtualConsoleClass\



isFolderExist := false
FileCreateDir, %d1%
while(!isFolderExist && A_Index < 31){
  sleep,99
  isFolderExist := FileExist(d1)
}
  if( !isFolderExist ){
    msg=ERROR: folder NOT exist 13.05.2018 06:55 `n >%d1%<
    msgbox, % msg  "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
    Speak(msg)
    ExitApp
  }



Speak("Start registry write")



;/¯¯¯¯ try_faster_reload_if_created ¯¯ 181025152605 ¯¯ 25.10.2018 15:26:05 ¯¯\
; I hope the with this method is reloaded after creating a new list (much faster). 25.10.2018 15:25
; no success 25.10.2018 15:30
globalActionListDir := "..\actionLists"
; globalActionList := globalActionListDir "\_globalActionListsGenerated\_global.ahk"
globalActionList := globalActionListDir   "\_globalActionListsGenerated\isNotAProject.ahk"
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionListNEW, %globalActionList% ; RegWrite , RegSave , Registry
setRegistry_actionList( globalActionList )
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_ScriptName, %globalActionList% ; RegWrite , RegSave , Registry



RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_ScriptName, % A_ScriptName ; RegWrite , RegSave , Registry
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite , RegSave , Registry
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite , RegSave , Registry



RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, CreatedDir, % d1 ; RegWrite , RegSave , Registry
;\____ try_faster_reload_if_created __ 181025152609 __ 25.10.2018 15:26:09 __/



; msgbox,,% " Created  (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")",1



Speak("CreatedDir with d1")



run,Typing_Aid_everywhere_multi_clone.ahk
; run,gi-everywhere.ahk



FileAppend,"temporary empty file. if exist next view dont use the super _global.ahk", %d1%\_create_own_project.flag
IfNotExist,%d1%\_global.ahk
    FileAppend,% "", %d1%\_global.ahk
;    FileAppend,% "#" "Include _global.ahk", %d1%\_global.ahk



if(1){
    ; lateer then hopfefully: thats only vor optic. has no function. as dynarun its probalby little faster
    ahkCode := "MsgBox,262208,created token=17-08-10_16-17,Maybe you want to make your first entries now,1"
    DynaRun(AHKcode)
}



; MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,1 ; thats only trick. so it should reload another wordklist.
; MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,99 ; thats only trick. so it should reload another wordklist.
; it not need to be closed active bevor 13.05.2018 19:23. now we close it active. so its litle faster then a second . thats nice



; try sppedup it with DynaRun(AHKcode)
; AHKcode := "MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,9"
; DynaRun(AHKcode)



; sleep,3000
; openInEditorFromIntern(d1 "\_global.ahk" ) ; we dont know the ecact name from here



;FileDelete, % "..\actionLists\" . ActiveClass . "\_create_own_project.flag"
ExitApp



; sorry we dont know actually (actionListNEW) the
; actionListNEW inside this script.
; therefore we need the created token=17-08-10_16-17 token.
if(!actionListNEW){
      Msgbox,:( !actionListNEW ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
      ExitApp
}
contend =
(
#Include ..\_globalActionLists\_global.ahk
#Include ..\%ActiveClass%\_global.ahk



; #Include ..\_globalActionLists\examplesForBeginners.txt
___open _globalActionLists\_global|rr||ahk|openInEditor,..\_globalActionLists\_global.ahk
___open _global|rr||ahk|openInEditor,_global.ahk
___open actionList|rr||ahk|openInEditor,%actionListNEW%
; if you could read this germen special character (umlaute) your file format is correct (please use UTF8)
; ä = thats a au
)
globalClassTxtAddress := "..\actionLists\" . ActiveClass . "\_global.ahk"
if(!FileExist(globalClassTxtAddress))
  FileAppend,% "", % globalClassTxtAddress
actionListNEWAddress := "..\actionLists\" . ActiveClass . "\" . actionListNEW



if( SubStr( actionListNEWAddress , -3 ) <> ".ahk" ) ; 06.03.2018 13:09
    actionListNEWAddress .= ".ahk"



if( FileExist( actionListNEWAddress ) ){
    ; run, % actionListNEWAddress ; this works for .txt extension. that we dont use anymore 01.10.2018 11:12
    openInEditor("..\actionLists\" . ActiveClass, true, "run," actionListNEW, true, true, true)



    Msgbox,ups actionListNEW = >>>>%actionListNEW%<<< `n exist already ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
    EXIT
}



if( !FileExist( globalClassTxtAddress ) ){
    Msgbox,ups ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
    EXIT
}
if(1 && InStr(A_ComputerName,"SL5")){
    ToolTip5sec("FileAppend (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
    msgBox,% "FileAppend : (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
}
 FileAppend,% contend,   % actionListNEWAddress
if( !FileExist(actionListNEWAddress) ){
    Msgbox,ups ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
EXIT
}
Sleep,100
     ; msgbox,%actionListNEW% = actionListNEW ,`%actionListNEW`% = actionListNEW 18-03-06_13-31 `n (%A_LineFile%~%A_LineNumber%)



 ; run, % actionListNEWAddress ; this works for .txt extension. that we dont use anymore 01.10.2018 11:12
; actionListNEWAddress := "..\actionLists\" . ActiveClass . "\" . actionListNEW
; openInEditor(isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib)
; openInEditor(actionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib){
  openInEditor("..\actionLists\" . ActiveClass, true, "run," actionListNEW, true, true, true)



ExitApp
reload



#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk



#Include %A_ScriptDir%\inc_ahk\openInEditor_actionList.inc.ahk
;__ __ __ ______ ____ ___
;
#Include,%A_ScriptDir%\RegWrite181031.ahk
#Include %A_ScriptDir%\inc_ahk\soundBeep.inc.ahk
