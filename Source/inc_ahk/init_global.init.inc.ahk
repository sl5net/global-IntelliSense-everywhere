#SingleInstance force

;<<<<<<<< g_ignReg <<<< 180224082501 <<<< 24.02.2018 08:25:01 <<<<
global g_ignReg := { feedbackMsgBox:{tit:".^", text:".^"} ,          saveLogFiles: {ln:".^", scriptName:".^", text:".^"},                    sqlQuery: {ln:".^", scriptName:".^", text:".^"},                    hotKeyStuff: {ln:".^", scriptName:".^", text:".^"},                    runLogFile: {ln:".^", scriptName:".^", text:".^"} } ;;;; regEx ignoreConfigList ;;;;
; please use it like this:     if( 1<RegExMatch(0 . ln, g_ignReg["saveLogFiles"]["ln"])	|| ......
		; OR: the regEx .^ never match anything. if you use .^ i recomand using: if( RegExMatch(ln, g_ignReg["saveLogFiles"]["ln"])	|| ......
; https://autohotkey.com/boards/viewtopic.php?f=6&t=44696&p=202322#p202322
;>>>>>>>> g_ignReg >>>> 180224082506 >>>> 24.02.2018 08:25:06 >>>>

if(instr(A_LineFile,A_ScriptName)){
	MsgBox,WTF 18-02-27_18-19
	ExitApp
}else{
	; thats like expected : ) 27.02.2018 18:05
}
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; hideAllAhkTray.ahk <= start this empty script and uncoment next line (if you want no trayicons)
;~ #NoTrayIcon ; ToolTip,you hopefully already uncomment # NoTrayIcon inside init_global.init.inc.ahk `n  %msg% `n 
; 16-01-19_23-11
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CoordMode, Caret, Screen
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
CoordMode, Menu, Screen


msg:=""  . A_ScriptName . ">" . A_LineNumber . " (greetings from init script)"

; todo: lines redundant
logFileName = log\%A_ScriptName%.log.txt
if(FileExist(logFileName))
{
	FileDelete,%logFileName%
	; MsgBox,%logFileName%=logFileName
	if(FileExist(logFileName))
	{
		MsgBox,15-05-15_12-55
	}
	;ExitApp
}



;~ init cant containss label with return statement
;~ labels disable running throw the script. start is like a main function


;~ SplashTextOff
ToolTip,

; http://www.autohotkey.com/board/topic/81732-try-catch-doesnt-work/
;~ .. but here's how to suppress load-time "function not found" errors:
blank := " "
;~ commaBlank := ", "
msg:=A_LineNumber . ": " . A_ScriptName . " (greetings from init script) "
;~ ToolTip,%msg% `n 
ToolTip,%msg%
ToolTip1sec%blank%(msg)

msg:=A_LineNumber . ", " . A_ScriptName . " (greetings from init script) "
ToolTip,%msg%
lll%blank%(msg)

;~ The number of milliseconds since the computer was rebooted.
StartTime := A_TickCount

; #Persistent ; Keeps a script permanently running (that is, until the user closes it or ExitApp is encountered).
#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

msg:=A_LineNumber . ", " . A_ScriptName . " (greetings from init script) "
ToolTip,%msg%
lll%blank%(msg)


HardDriveLetter := SubStr(A_ScriptDir, 1 , 1)
#Include %A_ScriptDir%\inc_ahk\ScriptNameLetterIcon.inc.ahk


msg:=A_LineNumber . ", " . A_ScriptName . " (greetings from init script) "
ToolTip,%msg%
lll%blank%(msg)

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; do temporary comment it. if you want test the initpart seperate. cant in the init part. sorry. you cant test the init part bye this. you need do reload manually during developing.
SetTimer,UPDATEDSCRIPT,2000

;~ #Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk ; do temporary comment it.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

msg:=A_LineNumber . ", " . A_ScriptName . " (greetings from init script) "
ToolTip,%msg%
lll%blank%(msg)
ToolTip,
