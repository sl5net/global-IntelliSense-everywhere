; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ please use this ! as first line in every script before all includes! :)
isDevellopperMode:= true ; enthï¿½llt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

#SingleInstance,force


; this script is very importand becouse of this errors:
; Dein Video wird hier zu sehen sein: https://youtu.be/TzNBKFoe6Tg.
; it hopefully then not happens any more. 12.07.2017 20:35

; Abtretbarkeit dieses Programm soll feststellen, ob das Hauptprogramm festgelegt. Sich nicht mehr weiter bewegt aus einer bestimmten Zeile im Programm. Deswegen wird eine Programmzeile in ein File geschrieben und dazu eine Uhrzeit. Auch



DetectHiddenWindows,On
DetectHiddenText,On


FOUNDmyselfCounter := 0
loop,9999
{
Sleep,4000

gosub,couldIfindMyself 


SetTitleMatchMode,1
IfWinExist, gi-everywhere - Inactive
{
   WinClose,
   lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"34: RunWait,gi-everywhere.ahk")
   RunWait,gi-everywhere.ahk
}

   WinWait,gi-everywhere - Active,,3
   
   ; if(!FileExist("gi-everywhere_programmCounter_LineAndTime.txt")) ; 26.09.2018 16:36 home we dont need it
   ;   ExitApp
   
   FileRead,gi-everywhereContentStatus, gi-everywhere_programmCounter_LineAndTime.txt
   gi-everywhereTimestamp := RegExReplace(gi-everywhereContentStatus, ".*?(\d+)$", "$1") ; Gibt "abc123xyz" zurï¿½ck, weil durch $ eine ï¿½bereinstimmung nur am Ende vorkommen darf.
   
   FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
   secondsProgrammIsNotMoving := timestampyyMMddHHmmss - gi-everywhereTimestamp
   
   if(secondsProgrammIsNotMoving > 15 || true) {
      
         ; Alternativ is auch gut das gi-everywhere.ahk.log modified Datum auszulesen
         FileGetTime, logModifiedTimeYYYYMMDDHH24MISS, gi-everywhere.ahk.log  ; Retrieves the modification time by default.
         secondsSincelogModified := timestampyyMMddHHmmss - SubStr(logModifiedTimeYYYYMMDDHH24MISS,3)
;         MsgBox,% SubStr(logModifiedTimeYYYYMMDDHH24MISS,3)
         ; MsgBox, %secondsSincelogModified% = %timestampyyMMddHHmmss% - %logModifiedTimeYYYYMMDDHH24MISS%
         if(secondsSincelogModified  <= 15) 
            continue
      
         WinClose, gi-everywhere - Active ; :( dosent work 10.07.2017 20:47
         WinClose, gi-everywhere - Inactive ; :( dosent work 10.07.2017 20:47
         ; Msgbox,:-( ist not moving since %secondsProgrammIsNotMoving% sec (%timestampyyMMddHHmmss% - %gi-everywhereTimestamp%) `n (%A_LineFile%~%A_LineNumber%)
         ; IfWinNotExist,gi-everywhere
            Run,gi-everywhere.ahk

   }
}




; Msgbox,`n (%A_LineFile%~%A_LineNumber%)


; if you to stupid to find yourself better do nothing! 11.07.2017 15:11
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
couldIfindMyself:
DetectHiddenWindows,On
SetTitleMatchMode 2
IfWinNotExist,% A_ScriptName
{
   ToolTip, i cant find myself `n ( %A_LineFile% ) `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n (programmed at 11.07.2017 15:12)
   ; thats a totally stupid situation, but it happen often.
   ; not always but often.
   ; then i think no autohotkey scrpt should start oter scripts. 
   ; its to dangerous that a stack overflow happens.
   ; may one good workaround could be, wait a lang time and then try it again or pause the script for ever..... and ever ...
   suspend,On 
   min := 60 * 1000
   ; sleep, % 9 * min 
   ; reload 
   Pause
}
FOUNDmyselfCounter += 1
if(false){
ToolTip, i FOUND :-) myself yeaah `n not a totally idiot :) `n ( %A_LineFile% )  `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n  (programmed at 11.07.2017 20:26)
}
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk

#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
