; Problem with include: https://autohotkey.com/boards/viewtopic.php?f=5&t=46608&p=210142#p210142


; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#SingleInstance force



CoordMode, ToolTip,Screen



StringCaseSense, On ; Determines whether string comparisons are case sensitive (default is "not case sensitive").



Menu, Tray, Tip , % Chr(8203) ; i dont want text there. The tray icon's tooltip is displayed when the mouse hovers over it.



;/¯¯¯¯ g_ignReg ¯¯ 181124115548 ¯¯ 24.11.2018 11:55:48 ¯¯\
;/¯¯¯¯ g_ignReg ¯¯ 181124115548 ¯¯ 24.11.2018 11:55:48 ¯¯\
;/¯¯¯¯ g_ignReg ¯¯ 181124115548 ¯¯ 24.11.2018 11:55:48 ¯¯\
if(InStr(A_ComputerName,"xxxxxxxxx SL5")) ; do ignore nothing. development computer
global g_ignReg := { feedbackMsgBox:{tit:".^", text:".^"} ,          saveLogFiles: {ln:".^", scriptName:"\b(Window|ListBox)\.ahk", text:"(WordIndex|CloseListBox|HotKeys|g_ListBox_Id)\b"},                    sqlQuery: {ln:".^", scriptName:".^", text:".^"},                    hotKeyStuff: {ln:".^", scriptName:".^", text:".^"},                    runLogFile: {ln:".^", scriptName:".^", text:".^"} } ;;;; regEx ignoreConfigList ;;;;
; please use it like this:     if( 1<RegExMatch(0 . A_ScriptName, g_ignReg["saveLogFiles"]["scriptName"])	|| ......
		; OR: the regEx .^ never match anything. if you use .^ i recomand using: if( RegExMatch(ln, g_ignReg["saveLogFiles"]["ln"])	|| ......
else ; ignore all ==> means for e.g. no log then
global g_ignReg := { feedbackMsgBox:{tit:".^", text:".^"} ,          saveLogFiles: {ln:".^", scriptName:".^", text:".^"},                    sqlQuery: {ln:".^", scriptName:".^", text:".^"},                    hotKeyStuff: {ln:".^", scriptName:".^", text:".^"},                    runLogFile: {ln:".^", scriptName:".^", text:".^"} } ;;;; regEx ignoreConfigList ;;;;



; https://autohotkey.com/boards/viewtopic.php?f=6&t=44696&p=202322#p202322
g_ignReg_exampleUsing =
(
if(RegExMatch(A_ScriptName, g_ignReg["saveLogFiles"]["scriptName"]))
	MsgBox,ignore matched
else
	MsgBox,ignore NOT matched
)
lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"hey from ini ")



g_ignReg["saveLogFiles"]["scriptName"] := "\b(gi\-|Typing|ListBox)" ;



;\____ g_ignReg __ 181124115556 __ 24.11.2018 11:55:56 __/
;\____ g_ignReg __ 181124115556 __ 24.11.2018 11:55:56 __/
;\____ g_ignReg __ 181124115556 __ 24.11.2018 11:55:56 __/



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



;Wenn es dir auch auf den Keks geht, dass die [Capslock]-Taste (die Ã¼ber die [Umschalt]-Taste), immer wieder ausversehen aktiviert wird, dann schreibe folgendes in dein Script:
; CapsLock::SetCapsLockState, AlwaysOff
SetCapsLockState,Off
SetScrollLockState,Off ; Im Ãœbrigen reagieren nur noch einige Uralt-Programme, etwa Word 5 fÃ¼r DOS, auf diese Taste. Damit bietet sie sich als idealer Kandidat fÃ¼r selbst definierte Hotkeys an.
SetNumLockState, AlwaysOn



CoordMode, Caret, Screen
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
CoordMode, Menu, Screen



msg:=""  . A_ScriptName . ">" . A_LineNumber . " (greetings from init script)"



; todo: lines redundant
logFileName = log\%A_LineFile%.log.txt
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



msg:=A_LineFile ":" A_ScriptName ">" RegExReplace(A_LineFile, ".*\")" (greetings from init script) "
ToolTip,%msg%
lll%blank%(msg)



;~ The number of milliseconds since the computer was rebooted.
StartTime := A_TickCount



; #Persistent ; Keeps a script permanently running (that is, until the user closes it or ExitApp is encountered).
#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.



msg:=A_LineFile ":" A_ScriptName ">" RegExReplace(A_LineFile, ".*\")" (greetings from init script) "
ToolTip,%msg%
lll%blank%(msg)



HardDriveLetter := SubStr(A_ScriptDir, 1 , 1)
#Include %A_ScriptDir%\inc_ahk\ScriptNameLetterIcon.inc.ahk



msg:=A_LineFile ":" A_ScriptName ">" RegExReplace(A_LineFile, ".*\")" (greetings from init script) "
ToolTip,%msg%
lll%blank%(msg)



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; do temporary comment it. if you want test the initpart seperate. cant in the init part. sorry. you cant test the init part bye this. you need do reload manually during developing.
; SetTimer,UPDATEDSCRIPT,2000



;~ #Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk ; do temporary comment it.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



msg:=A_LineFile ":" A_ScriptName ">" RegExReplace(A_LineFile, ".*\")" (greetings from init script) "
ToolTip,%msg%
lll%blank%(msg)
ToolTip,
