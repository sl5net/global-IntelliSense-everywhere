;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ please use this ! as first line in every script before all includes! :)
isDevellopperMode=true ; enth�llt auch update script.
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
IfWinExist, TypingAid - Inactive
{
   WinClose,
   lll(A_LineNumber, A_ScriptName, "34: RunWait,TypingAid.ahk")
   RunWait,TypingAid.ahk
}

   WinWait,TypingAid - Active,,3
   
   if(!FileExist("TypingAid_programmCounter_LineAndTime.txt"))
      ExitApp 
   
   FileRead,TypingAidContentStatus, TypingAid_programmCounter_LineAndTime.txt
   TypingAidTimestamp := RegExReplace(TypingAidContentStatus, ".*?(\d+)$", "$1") ; Gibt "abc123xyz" zur�ck, weil durch $ eine �bereinstimmung nur am Ende vorkommen darf. 
   
   FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
   secondsProgrammIsNotMoving := timestampyyMMddHHmmss - TypingAidTimestamp
   
   if(secondsProgrammIsNotMoving > 15 || true) {
      
         ; Alternativ is auch gut das TypingAid.ahk.log modified Datum auszulesen
         FileGetTime, logModifiedTimeYYYYMMDDHH24MISS, TypingAid.ahk.log  ; Retrieves the modification time by default.
         secondsSincelogModified := timestampyyMMddHHmmss - SubStr(logModifiedTimeYYYYMMDDHH24MISS,3)
;         MsgBox,% SubStr(logModifiedTimeYYYYMMDDHH24MISS,3)
         ; MsgBox, %secondsSincelogModified% = %timestampyyMMddHHmmss% - %logModifiedTimeYYYYMMDDHH24MISS%
         if(secondsSincelogModified  <= 15) 
            continue
      
         WinClose, TypingAid - Active ; :( dosent work 10.07.2017 20:47
         WinClose, TypingAid - Inactive ; :( dosent work 10.07.2017 20:47
         ; Msgbox,:-( ist not moving since %secondsProgrammIsNotMoving% sec (%timestampyyMMddHHmmss% - %TypingAidTimestamp%) `n (%A_ScriptName%~%A_LineNumber%) 
         ; IfWinNotExist,TypingAid
            Run,TypingAid.ahk

   }
}




; Msgbox,`n (%A_ScriptName%~%A_LineNumber%) 


; if you to stupid to find yourself better do nothing! 11.07.2017 15:11
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
couldIfindMyself:
DetectHiddenWindows,On
SetTitleMatchMode 2
IfWinNotExist,% A_ScriptName
{
   ToolTip, i cant find myself `n ( %A_ScriptName% ) `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n (programmed at 11.07.2017 15:12)
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
ToolTip, i FOUND :-) myself yeaah `n not a totally idiot :) `n ( %A_ScriptName% )  `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n  (programmed at 11.07.2017 20:26)
}
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#Include %A_ScriptDir%\..\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\..\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\..\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\..\inc_ahk\functions_global.inc.ahk

#Include %A_ScriptDir%\..\inc_ahk\functions_global_dateiende.inc.ahk
