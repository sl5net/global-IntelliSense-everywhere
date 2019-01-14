; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
/*
checks script and ifExist the include of it (only one include) and relads if changed 22.03.2017 07:46 17-03-22_07-46
if its usinge the name scriptname.inc.ahk
*/





;~ #Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
FileGetTime, ModiTime, %A_ScriptFullPath%, M
inc17032207130:= SubStr(A_ScriptName,1,strlen(A_ScriptName)-4) . ".inc.ahk"
; Msgbox,%inc17032207130% `n (from: %A_LineFile%~%A_LineNumber%)
if(FileExist(inc17032207130)){
; Msgbox,%inc17032207130% `n (from: %A_LineFile%~%A_LineNumber%)
    FileGetTime, incModiTime, %inc17032207130%, M
    incModiTime_OLD:=incModiTime
}
ModiTime_OLD:=ModiTime

;<<<<<<<< UPDATEDSCRIPT <<<< 180208165803 <<<< 08.02.2018 16:58:03 <<<<
UPDATEDSCRIPT:
;feedbackMsgBox("ModiTime:=f1703220615",A_LineNumber . " " .  A_LineFile,1,1)

DetectHiddenWindows,on
SetTitleMatchMode,2
IfWinExist,hideAllAhkTray.ahk
{
  ;~ MsgBox,% msg
  ToolTip,you hopefully already uncomment # NoTrayIcon inside init_global.init.inc.ahk `n  %msg% `n 
  Sleep,1000
  WinClose,hideAllAhkTray.ahk
  ;~ WinKill,hideAllAhkTray.ahk
            RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, Reload , % A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
  reload
}


    ; http://www.autohotkey.com/board/topic/81732-try-catch-doesnt-work/
    ;~ .. but here's how to suppress load-time "function not found" errors:
    blank := " "

	; sicherlich falsch, korrektur unten 17-11-23_08-45: msg:="A_LineNumber . "" "" . A_ScriptName . "" "" . Last_A_This . ""`nA_ScriptFullPath= "" . A_ScriptFullPath "

msg:="A_LineNumber . "" "" . A_ScriptName . "" (token37) "" . Last_A_This `nA_ScriptFullPath= ""(token48)" . A_ScriptFullPath 

ToolTip1sec%blank%(A_ScriptFullPath)

;feedbackMsgBox("ModiTime:=f1703220615",A_LineNumber . " " .  A_LineFile,1,1)

;ToolTip,51: ModiTime = %ModiTime%
ModiTime:=f1703220615(ModiTime_OLD, ModiTime, A_ScriptDir, A_ScriptName, A_ScriptFullPath)
ModiTime_OLD:=ModiTime
if(SubStr(A_ScriptName,1,-7)<>".inc.ahk"){
    inc1703220730:= SubStr(A_ScriptName,1,strlen(A_ScriptName)-4) . ".inc.ahk"
    
    if(FileExist(inc1703220730)){
        incModiTime := f1703220615(incModiTime_OLD, incModiTime, A_ScriptDir, inc1703220730, A_ScriptDir . "\" . inc1703220730)
        incModiTime_OLD:=incModiTime
    }
}
Return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

f1703220615(ModiTime_OLD, ModiTime, ScriptDir, ScriptName, ScriptFullPath){
    FileGetTime, ModiTime, %ScriptFullPath%, M
   ; ToolTip,ModiTime = %ModiTime%
  if(ModiTime_OLD > 0 AND ModiTime > ModiTime_OLD){
    temp:=LineNumber . " " . ScriptName . " " . Last_A_This . "`n" . ModiTime_OLD . ":=" . ModiTime
    ToolTip,%temp%
    Sleep,500

    UpdaSplashTit = Updated script: %A_LineNumber%

    FileSetAttrib,-A,%ScriptFullPath%
    SplashTextOn,,,%UpdaSplashTit%,%UpdaSplashTit%
    Sleep,500
   ;~ only one SplashText window per script is possible.
  SplashTextOff,%UpdaSplashTit%

scriptDir := RegExReplace( A_ScriptDir, "(\\AutoHotKey).*" , "$1") ; maybe file is started from subfolder. 18.04.2017 12:18
;feedbackMsgBox(scriptDir = "scriptDir",A_LineNumber . " " .  A_LineFile,1,1)
 
SetWorkingDir, % scriptDir ; thats not worked. Line later A_ScriptDir was not changed. so SetWorkingDir is probably buggy 18.04.2017 13:23
; Msgbox,%scriptDir% ?= `n%A_ScriptDir% `n`n (from: %A_LineFile%~%A_LineNumber%)

  ; if(FileExist( A_ScriptDir . "\SaveLast5_to_BackupSL5.ahk" )
;  fileAHKabs = %ScriptDir% ; \SaveLast5_to_BackupSL5.ahk
 ;   run, %A_ScriptDir%\SaveLast5_to_BackupSL5.ahk "%ScriptFullPath%"
 
 ;<<<<<<<< SaveLast5_to_BackupSL5 <<<< 171003084729 <<<< 03.10.2017 08:47:29 <<<<
 ; i want copy it in the same path and into a google drive path
ToolTip2sec("RunWait `n `n `n " . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
RunWait, %scriptDir%\SaveLast5_to_BackupSL5.ahk "%ScriptFullPath%", %scriptDir%
RunWait, %scriptDir%\SaveLast5_to_BackupSL5.ahk "%ScriptFullPath%" "c:/fre/private/Google_Drive/fax.sl5net/backup", %scriptDir%
;>>>>>>>> SaveLast5_to_BackupSL5 >>>> 171003084736 >>>> 03.10.2017 08.47:36 >>>>
  
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, Reload , % A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
    Reload
  }
    Return ModiTime
}

#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
