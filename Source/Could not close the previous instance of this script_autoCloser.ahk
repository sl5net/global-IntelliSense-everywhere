; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ please use this ! as first line in every script before all includes! :)
isDevellopperMode=true ; enth�llt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

DetectHiddenWindows,on
SetTitleMatchMode,1
#SingleInstance
#NoTrayIcon

sdSec := 10
counter := 0
isShutdownCommandSend := false
while(true){
  
  counter += 1
  
  FormatTime, timestampyyMMddHHmmss , %A_now%,yyMMddHHmmss
  FormatTime, timestampyyMMddHHmmssPretty, %A_now%,yy:MM:dd HH:mm:ss
  lastFoundTimestampOLD := lastFoundTimestamp 
  lastFoundTimestamp := timestampyyMMddHHmmss 
  lastFoundSeconds := lastFoundTimestamp - lastFoundTimestampOLD
  
if(counter < 10 && lastFoundSeconds > 8 ){
  ; it happens very slow. so its not so dangerous ==> lets reset the counter.
  counter := 0
  ToolTip, ; empty tooltip also :) 26.07.2017 11:47
}
if(counter == 15){
    SplashTextOn, 100, 100, system will shutdown, to many windows could not closed. %counter% 14.07.2017 09:34 17-07-14_09-34 `n Shutdown in %sdSec% secs ; better use SplashTextOn, so we could see tooltips on the sceen. 14.07.2017 12:20 17-07-14_12-20
}

if(counter >= 15 && !isShutdownCommandSend ){
    Run, C:\Windows\System32\shutdown.exe /s /f /t %sdSec%,,Hide
    isShutdownCommandSend := true
}
  
temp = 
(
TypingAid.ahk
ahk_class #32770
ahk_exe AutoHotkey.exe

&Ja
&Nein
Could not close the previous instance of this script.  Keep waiting?
)

; TypingAid.ahk ahk_class #32770

  text1=Could not close the previous instance of this script.  Keep waiting?
  text2=Could not close the previous instance of this script.
  
  
  WinWait,TypingAid.ahk ahk_class #32770,Could not close the previous instance of this script.  Keep waiting?
  WinClose,TypingAid.ahk ahk_class #32770,Could not close the previous instance of this script.  Keep waiting? ; this try not woks. it not closese the window. and there are nearly every 2 seconds an new such window. 12.07.2017 20:25
  WinActivate, TypingAid.ahk ahk_class #32770
  WinWaitActive,TypingAid.ahk ahk_class #32770,,1
  send,j ; yes keep waiting. it woks :) but now wie have two typing AID script. for shurt time. and now its only one. so maybe it solves the prolem !!!!! 12.07.2017 20:22

  ; next 3 lines are not tested. probably woks same as the line above. 12.07.2017 20:31
  WinActivate, TypingAid.ahk ahk_class #32770,%text2%
  WinWaitActive,TypingAid.ahk ahk_class #32770,%text2%,1
;  send,j

  IfWinActive,TypingAid.ahk ahk_class #32770,%text2%
  send,n ; no dont keep waiting . do this also. if it may not was closed . 12.07.2017 20:39 
  ToolTip,Typing: Could not close the previous instance of this script. `n %A_ScriptName%:%A_LineNumber% `n %counter% = counter
}

return



; #Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise m�sen ans Dateiende
; #Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
