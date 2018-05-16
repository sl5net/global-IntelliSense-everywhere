; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
; create own project dir or this
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
isDevellopperMode:=true ; enthï¿½llt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#Include *i %A_ScriptDir%\keysEveryWhere_PRIVATE.inc.ahk

; ___12 create own project dir or this 1|rr||ahk|#Include,..\activeClassManipulation.inc.ahk `n activeClass := RegExReplace( activeClass, "[\W_]+", "") `n d1 = %A_ScriptDir%\%activeClass% `n  FileCreateDir, %d1% `n sleep,99 `n  FileAppend,"temporary empty file. if exist next view dont use the super _global.txt", %d1%\_create_own_project.flag `n MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,1 `n

wordlistsDir := "..\Wordlists"
#Include,..\Wordlists\activeClassManipulation.inc.ahk 
; #Include," . d1 . "\wordlistNameFilter.inc.ahk `;```n Send,yes2 ``n " `n DynaRun(AHKcode)
activeClass := RegExReplace( activeClass, "[\W_]+", "") 
d1 = %wordlistsDir%\%activeClass% 
fileExist := FileExist(d1)
if(fileExist){
  tooltip,ups folder already exist 13.05.2018 06:55
}
if(false){
  globalTxt := d1 "\_global.txt"
  fileExist := FileExist(globalTxt)
  if(fileExist){
    run,% globalTxt
    tooltip, WinWaitActive`, globalTxt
    clipboard := globalTxt
    msgbox,ups globalTxt (its copied to clipboard) already exist `n ExitApp `n 13.05.2018 06:58
    WinWaitActive,% globalTxt
    ExitApp
}}
; ..\Wordlists\VirtualConsoleClass\

folderExist := ""
while(!folderExist && A_Index < 11){
  FileCreateDir, %d1% `n sleep,99 
  folderExist := FileExist(d1)
}
  if( !folderExist ){
    msgbox,ERROR: folder NOT exist 13.05.2018 06:55
    ExitApp
  }

FileAppend,"temporary empty file. if exist next view dont use the super _global.txt", %d1%\_create_own_project.flag 
; MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,1 ; thats only trick. so it should reload another wordklist.
MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,99 ; thats only trick. so it should reload another wordklist.
; it not need to be closed active bevor 13.05.2018 19:23. now we close it active. so its litle faster then a second . thats nice

; try sppedup it with DynaRun(AHKcode)
;AHKcode := "MsgBox,0,created token=17-08-10_16-17,token=17-08-10_16-17,9"
;DynaRun(AHKcode)


;FileDelete, % "..\Wordlists\" . ActiveClass . "\_create_own_project.flag"
ExitApp
; sorry we dont know actually (wordlistNEW) the 
; wordlistNEW inside this script.
; therefore we need the created token=17-08-10_16-17 token.
if(!wordlistNEW){
      Msgbox,:( !wordlistNEW ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
      ExitApp
}
contend =
(
#Include ..\_globalWordLists\_global.txt
#Include ..\%ActiveClass%\_global.txt

; #Include ..\_globalWordLists\examplesForBeginners.txt
___open global library|rr||ahk|run,..\_globalWordLists\_global.txt
___open class library|rr||ahk|run,_global.txt
___open window library |rr||ahk|run,%wordlistNEW%
)
globalClassTxtAddress := "..\Wordlists\" . ActiveClass . "\_global.txt"
if(!FileExist(globalClassTxtAddress))
  FileAppend,% "", % globalClassTxtAddress
wordlistNEWAddress := "..\Wordlists\" . ActiveClass . "\" . wordlistNEW
if( FileExist( wordlistNEWAddress ) ){
    run, % wordlistNEWAddress
    Msgbox,ups wordlistNEW = >>>>%wordlistNEW%<<< `n exist already ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
    EXIT
}
if( !FileExist( globalClassTxtAddress ) ){
    Msgbox,ups ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
    EXIT
}
     FileAppend,% contend,   % wordlistNEWAddress
if( !FileExist(wordlistNEWAddress) ){
    Msgbox,ups ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
EXIT
}
     Sleep,100
     ; msgbox,%wordlistNEW% = wordlistNEW ,`%wordlistNEW`% = wordlistNEW 18-03-06_13-31 `n (%A_LineFile%~%A_LineNumber%)

     run, % wordlistNEWAddress






ExitApp
reload



#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise mï¿½sen ans Dateiende
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk

