; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk

global g_CaretX_Old
global g_CaretY_Old
; global g_ignReg

global feedbackMsgBox1PosBackup_x
global feedbackMsgBox1PosBackup_y



isInteger(var) {
    return var~="^\s*[\+\-]?((0x[0-9A-Fa-f]+)|\d+)\s*$"
}
 

;/¯¯¯¯ update_configMinify_incAhkFile ¯¯ 190111201847 ¯¯ 11.01.2019 20:18:47 ¯¯\
update_configMinify_incAhkFile(configIncAhkAddress := "\config\config.inc.ahk"
        , configMinifyIncAhkAddress := "\config.minify.inc.ahk" ){
    ; needs start with: g_config (12.01.2019 10:57, 19-01-12_10-57)
    configIncAhkAddress         := A_ScriptDir configIncAhkAddress
    configMinifyDIR   := A_ScriptDir "\inc_ahk\minify"
    configMinifyIncAhkAddress   := configMinifyDIR configMinifyIncAhkAddress

; call it like (11.01.2019 20:19):
useItLike =
(
SetTimer,check_configFile_Changed,2000
g_config := {} ; <= or every name you like
if(... := update_configMinify_incAhkFile()){
    ; reload ...
}
# Include *i %A_ScriptDir%\inc_ahk\minify\config.minify.inc.ahk
)
; Changes always become active on the next next call. becouse include is a preparser command. 19-01-11_18-33
; discussion here: https://stackoverflow.com/questions/54149980/remove-all-unnecessary-whitespaces-from-json-string-with-regex-in-autohotkey


    doUpdate := false
    FileGetTime, modifiedTime_configMinify, % configMinifyIncAhkAddress
    if(!modifiedTime_configMinify){
        doUpdate := true
        FileCreateDir, % configMinifyDIR
        if(!instr(FileExist(configMinifyDIR), "D")) ; would be true only if the file exists and is a directory.
            MsgBox,262160,% "problem with :" configMinifyDIR " `n`n :(`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":(`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    }else{
        FileGetTime, modifiedTime, % configIncAhkAddress
        toOldMilliSec := modifiedTime - modifiedTime_configMinify
        if(modifiedTime
        && modifiedTime_configMinify
        && toOldMilliSec > 0  ) ; + 900 becouse humans are not so fast 19-01-14_13-56
            doUpdate := true
         else if(toOldMilliSec < -2000){
            msgbox, % "ups error hacker attack? please dont edit the minify version. toOldMilliSec = " toOldMilliSec " (" A_ThisFunc ": " A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
         }
    }

    If(!doUpdate)
        return

        ; msgbox,% toOldMilliSec " = toOldMilliSec   "

    msg := toOldMilliSec " = toOldMilliSec   " doUpdate " = doUpdate (" A_ThisFunc ": " A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    feedbackMsgBox( msg, msg )
    ToolTip9sec( msg, 1, 200, 9 )

	FileRead, configContent , % configIncAhkAddress
	; configContentminify := ""
	; configContentminify := "configContent =`n(`n" ; configContentminify .= "`n)`n"
	; ((?!\bg_config\b).)*$
	; configContentminify .= RegExReplace( configContent , "i)[\s\t ]*[\n\r]+([^\n\r]+)(?!\[a-z][_\d]\b)[\s\t ]*", "`n$1" )

	; dont work 19-01-13_11-00: configContentminify := RegExReplace( configContent , "m)[\n\r]+(?!(/\*|\*/|[a-z]+[_\d]*))", " " )
	configContentminify := RegExReplace( configContent , "m)[\n\r]+(?!(\*|/|`;|[a-z]+[_\d]*))", " " )
	; configContentminify := RegExReplace( configContent , "m)[\n\r]+(?!([a-z]+[_\d]*))", " " )
	tempFileAddress := A_ScriptDir "\" A_TickCount ".temp.txt"
	FileAppend, % configContentminify, % tempFileAddress
	FileCopy,% tempFileAddress, % configMinifyIncAhkAddress, 1
	Sleep,200
	FileDelete,% tempFileAddress
	; reload

	configMinify := { Address: configMinifyIncAhkAddress, content: configContentminify }
    ; configMinifyIncAhkContent := configMinify["content"]
    ; configMinifyIncAhkAddress := configMinify["Address"]
    msg := configMinify["Address"] " = Address (" A_ThisFunc ": " A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), msg, 1, 1, 6 )
  	Return configMinify
}
;\____ update_configMinify_incAhkFile __ 190111201850 __ 11.01.2019 20:18:50 __/
;\____ update_configMinify_incAhkFile __ 190111201850 __ 11.01.2019 20:18:50 __/
;\____ update_configMinify_incAhkFile __ 190111201850 __ 11.01.2019 20:18:50 __/


JEE_millis_since_midnight(vOpt:=""){ ; renamed from JEE_TimeNowMSec
    VarSetCapacity(SYSTEMTIME, 16, 0)
    if (vOpt = "UTC")
        DllCall("kernel32\GetSystemTime", Ptr,&SYSTEMTIME)
    else
        DllCall("kernel32\GetLocalTime", Ptr,&SYSTEMTIME)
    vHour := NumGet(&SYSTEMTIME, 8, "UShort") ;wHour
    vMin := NumGet(&SYSTEMTIME, 10, "UShort") ;wMinute
    vSec := NumGet(&SYSTEMTIME, 12, "UShort") ;wSecond
    vMSec := NumGet(&SYSTEMTIME, 14, "UShort") ;wMilliseconds
    return vHour*3600000 + vMin*60000 + vSec*1000 + vMSec
}



getCaretPos(activedoProtectOutOfWindowPos:=true){
	CaretX := A_CaretX
	CaretY := A_CaretY 
	if(activedoProtectOutOfWindowPos){
		WinGetPos,wX,wY,wW,wH,A
		if(CaretX < wX || CaretY < wY || CaretX > (wX+wH) || CaretY > (wX+wH)){
			ToolTip5sec(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")  " (copy2clipBoard.functions.inc.ahk : 24)" )
			CaretX := g_CaretX_Old 
			CaretY := g_CaretY_Old 
		} 
		if(CaretX < wX || CaretY < wY || CaretX > (wX+wH) || CaretY > (wX+wH)){
			msg=line29 :( thats out. `n Caret = (%CaretX% : %CaretY%) `n
			ToolTip5sec(msg . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . A_ThisFunc ,0,0 )
			return
		}
	}
	g_CaretX_Old := CaretX
	g_CaretY_Old := CaretY
	msg=line35: Caret = (%CaretX%,%CaretY%) `n
	ToolTip5sec(msg . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . A_ThisFunc ,0,0 )
	p := {x:CaretX, y:CaretY}
	return p
}


varExist(ByRef v) {
	; Requires 1.0.46+
	; 0 indicates that the variable does not exist
	; 1 indicates that the variable does exist and contains data
	; 2 indicates that the variable does exist and is empty
	; Edit: 03-Dec-2006 : The following fine piece of 56 character code was written by Titan:
	return &v = &n ? 0 : v = "" ? 2 : 1
}





;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
lll(ByRef ln, scriptName, text := "") {
    global g_ignReg

    debugIt := 0

	ln .= "`n"
	n := "`n"
if(0){
	msg=`n (%A_LineFile%~%A_LineNumber%)
	tooltip,% A_LineNumber n logFileName n g_ignReg["saveLogFiles"]["ln"] n g_ignReg["saveLogFiles"]["scriptName"] n g_ignReg["saveLogFiles"]["text"] msg
}
	scriptName := trim(scriptName)
	scriptName := RegExReplace( scriptName, "^.+\\([^\\]+)$" , "$1") ; cut away folder name
	logFileName := "log\" scriptName ".log.txt"
    l:=": scriptName = " scriptName " logFileName = " logFileName n

 	is_ignReg_defined := varExist(g_ignReg)
	if( !is_ignReg_defined ){
		; msgbox,ERROR g_ignReg is not defined msg=`n (%scriptName%~%ln%) >`n (%A_LineFile%~%A_LineNumber%)
		;0 indicates that the variable does not exist
		;1 indicates that the variable does exist and contains data
		;2 indicates that the variable does exist and is empty
	}

if(1){
	if(is_ignReg_defined ){
	if( RegExMatch( ln, g_ignReg["saveLogFiles"]["ln"]) ){

	    if(debugIt)
	        msgbox, return %ln% `n (%A_LineFile%~%A_LineNumber%)
		return
	}
	if( RegExMatch( scriptName, g_ignReg["saveLogFiles"]["scriptName"])	){
	    if(debugIt)
	        msgbox, return %scriptName% `n (%A_LineFile%~%A_LineNumber%)

		return
	}
    if( RegExMatch( text, g_ignReg["saveLogFiles"]["text"]) ){
	    if(debugIt)
	        msgbox, return %text% `n (%A_LineFile%~%A_LineNumber%)
		return
	}}
}
	; if(0 && Instr(text,"append"))
	;	Msgbox,% text " | " g_ignReg["saveLogFiles"]["text"] "445555555"

if(!Instr(logFileName,scriptName)){ ; plausibillity check . hopefully never happesns. addet becouse of strange bug
	Clipboard := "`n scriptName=" scriptName  "`n logFileName=" logFileName " `n(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
	Msgbox,ups `n Clipboard = `n`n %Clipboard% `n (%A_LineFile%~%A_LineNumber%)
}

;l:=A_LineNumber ": scriptName = " scriptName n " logFileName = " logFileName n " GLOBAL_lllog_only_this_scriptName = " GLOBAL_lllog_only_this_scriptName n n
;FileAppend, % l, lll.log.txt

	text .= "`n"

	GLOBAL_lllog_only_this_scriptName := trim(GLOBAL_lllog_only_this_scriptName)
	if(StrLen(GLOBAL_lllog_only_this_scriptName)>1) {
		do_createLog_notAppendLog:=true
		if(scriptName != GLOBAL_lllog_only_this_scriptName){
			l:=A_LineNumber ": scriptName = " scriptName n " logFileName = " logFileName n " GLOBAL_lllog_only_this_scriptName = " GLOBAL_lllog_only_this_scriptName n n
			FileAppend, % l, lll.log.txt

			return false
		}
	}

;l:=A_LineNumber ": scriptName = " scriptName n " logFileName = " logFileName n " GLOBAL_lllog_only_this_scriptName = " GLOBAL_lllog_only_this_scriptName n n
;FileAppend, % l, lll.log.txt

	;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	; proof randomly if ye should delte the log file 16.07.2017 12:05
	Random, rand, 1, 150
	if(rand == 1){
		FileGetSize, logFileKbytes, %logFileName%, K  ; Retrieve the size in Kbytes.
		if(!logFileKbytes){
			; msgbox,Oops  %A_LineNumber%
			if(!fileexist(logFileName))
    			msgbox,Oops  %A_LineNumber%
        }
		if(logFileKbytes > 100){
			FileDelete,%logFileName%
			FileAppend, %A_LineNumber%: logFileDeleted %timestampHHmmss%, %logFileName%
			; msgbox,deleted :) %A_LineNumber%
		}else{
			; M = Modification time (this is the default if the parameter is omitted)
			FileGetTime, cFileMTime, %logFileName%, M

			diff_cFileMTime_Now_hour:=A_Now
			EnvSub, diff_cFileMTime_Now_hour, %cFileMTime%, hours

			diff_cFileMTime_Now_min:= Round(diff_cFileMTime_Now_hour / 60)

			diff_cFileMTime_Now_day:=A_Now
			EnvSub, diff_cFileMTime_Now_day, %cFileMTime%, days

			diff_cFileMTime_Now_year:= Round(diff_cFileMTime_Now_day / 365)
			;~ EnvSub, diff_cFileMTime_Now_year, %cFileMTime%, year

			if(diff_cFileMTime_Now_hour > 1){
				FileDelete,%logFileName%
				FileAppend, %A_LineNumber%: logFileDeleted %timestampHHmmss%, %logFileName%
			}
		}
		; proof randomly if ye should delte the log file 16.07.2017 12:05
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		;~ if(diff_cFileMTime_Now_day > 7)
			;~ FileDelete,%logFileName%
	}



	if(StrLen(scriptName) < 5 ) ; || "functions_global.inc.ahk" != A_ScriptName ... for that we need a PreCompiler !!!
	{
		lll(A_LineNumber, "functions_global.inc.ahk")

		;~ t := ""
		;~ t .= "# Include *i init_global.init.inc.ahk" . "`n"
		;~ t .= "# Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk" . "`n"
		;~ Clipboard := t

		Clipboard="%A_LineFile%"
		MsgBox, functions_global.inc.ahk `n ln=%ln% `n  scriptName = %scriptName% `n parameter FILE must not be empty `n `n you find this now inside your clipboard : %Clipboard% `n `n move to line %ln% and fix the bug. `n `n or let run the SL5_AHK_preparser.ahk
		return -1
	}
	;~ tipp: use notepadd++ , diverses> ohne rï¿½ckfraen aktuallisieren
	;~ tipp: use notepadd++ , diverses> nach aktuallisierung zum ende springen
	msg:=""
	;~ msg.= ";<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<`n"

	;~ if(strlen(text)>0)
;~ 		msgtext := """" . text . """"
;~ 	else
		;~ msgtext := text
    msgtext := text


	msg.= scriptName "(ign:SN=" . g_ignReg["saveLogFiles"]["scriptName"] . ", t=" . g_ignReg["saveLogFiles"]["text"] . ", ln=" . g_ignReg["saveLogFiles"]["ln"] . ")>" ln msgtext "`n"
	;~ msg.= ";>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>`n`n"

	global lll
	if(StrLen(lll)>0)
		lll .= msg
	else
		lll := msg
	; Suspend,on ; Disables or enables all or selected hotkeys and hotstrings.
	if(!FileExist("log"))
	{
		FileCreateDir,log
		if(true != InStr(FileExist("log"), "D") )
		{
		;~ would be true only if the file exists and is a directory
		MsgBox,15-05-15_17-00 ops Who could we store logfiles ?
		}
	}

;~if(StrLen(GLOBAL_lllog_only_this_scriptName)>0
	if(do_createLog_notAppendLog)
	{
		FileDelete,%logFileName%
		while(FileExist(logFileName))
			Sleep,100
		gLOBAL_lllog = GLOBAL_lllog_only_this_scriptName
		strLen_GLOBAL_lllog := StrLen(gLOBAL_lllog)
		subStr_lll__strLen := SubStr(lll,1,strLen_GLOBAL_lllog)
		if(subStr_lll__strLen != gLOBAL_lllog)
		{
		;~ MsgBox,%subStr_lll__strLen% %GLOBAL_lllog_only_this_scriptName% := GLOBAL_lllog_only_this_scriptName `n
		lll := "GLOBAL_lllog_only_this_scriptName = " . GLOBAL_lllog_only_this_scriptName . "`n" . lll
		}
	}
    FormatTime, timestampHHmmss, %A_now%,HH:mm:ss
	FileAppend, % timestampHHmmss . "   " .  lll, % logFileName
	;~ MsgBox,%lll%
	;Suspend,off
	text := "" ; iam suspicious with autohotkey dis days ;) 16.07.2017 21:03 usally we dont need to do so
	lll := ""


	return
}
;>>>>>>>>>lll >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; varExist(ByRef v) 

FileSave(ByRef content, fileName ){
	FormatTime, timestamp, % A_now, yy-MM-dd_HH-mm
	tempFileName := timestamp A_TickCount
	FileAppend, % content, % tempFileName
	i := 0
	while(i++ < 100 && !FileExist(logFileName))
		Sleep,100

	FileCopy,% tempFileName, % fileName, 1
	FileDelete, % tempFileName
}



;<<<<<<<< sendClipboard <<<< 180111182313 <<<< 11.01.2018 18:23:13 <<<<
sendClipboard(c){
	if(!c)
		Return

	SetTitleMatchMode,3 ;3: A window's title must exactly match WinTitle to be a match.
	WinGetActiveTitle,at
	SetKeyDelay,-1 ; By contrast, a delay of -1 will never sleep. For better reliability, 0 is recommended as an alternative to -1.
	Suspend,On
	if(c == Clipboard){
		Clipboard := Clipboard . " " ; sollte anfangs schon ein bisschen unterschiedlich sein 11.01.2018 18:31
	}
	if(c == Clipboard){
		isError := true
		Msgbox,:( Oops `n c == Clipboard (%A_LineFile%~%A_LineNumber%)
		return
	}

	ClipboardBackup := Clipboard
	Clipboard := c
	IfWinActive,% at
	{
		Clipboard := c
		Send,^v
	}else{
		isError := true
		Msgbox,:( Oops `n NOTActive %at% (%A_LineFile%~%A_LineNumber%)
	}
	if(c <> Clipboard){
		isError := true
		Msgbox,:( Oops `n c <> Clipboard (%A_LineFile%~%A_LineNumber%)
	}
	Suspend,Off
	if(InStr(Clipboard,"~token:")){
		Clipboard := ClipboardBackup
		send,^z^z
		Msgbox,:( Mist token inside :( `n (%A_LineFile%~%A_LineNumber%)
	}
	Clipboard := ClipboardBackup
	if(ClipboardBackup <> Clipboard){
		isError := true
		l1 := StrLen(ClipboardBackup)
		l2 := StrLen(Clipboard)
		Msgbox,:( Oops `n l1=%l1%`n l2=%l2% `n ClipboardBackup == Clipboard (%A_LineFile%~%A_LineNumber%)
	}
	return
}
;>>>>>>> sendClipboard >>>> 180111182318 >>>> 11.01.2018 18:23:18 >>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
changeAllIncludeDir_and_copy2dir(used_ahk,preFix,copy2dir){
	if(!FileExist(copy2dir) )
		MsgBox,copydir=%copydir% preFix=%preFix% copydir=%copydir% 
f:=A_ScriptDir . "\" . used_ahk
source:=""
source:=changeAllIncludeDir(f,preFix)
StrLen_source:=StrLen(source)
if(StrLen_source < 100 )
{
	errormsg=ERROR StrLen(source of %f%) < 100 `n source=%source% `n f=%f% `n
	;~ MsgBox,,,errormsg=%errormsg% `n , 2
	; ToolTip,errormsg=%errormsg% `n
	ToolTip4sec( errormsg " = errormsg `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ") 19-01-16_18-41" )
	;~ Reload
	return -1
}



 b:=";<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<`n"
 e:=";>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>`n"
 source := b . "; warning: this is a copy only! never edit in this file! thanks :-)`n" . e . source . newLine . "`n"
 ;~ MsgBox, ,,%source%,4
 newFileAdress:= copy2dir . "\" .  used_ahk

 FileGetTime, sourceModifiedTime, %f%  ; Retrieves the modification time by default.
exist_newFileAdress:=FileExist(newFileAdress)

if(exist_newFileAdress){
 FileGetTime, targetCreatedTime, %newFileAdress%, C  ; Retrieves the creation time.
 ToolTip,sourceModifiedTime=%sourceModifiedTime%  > %targetCreatedTime% `n

 ;~ MsgBox,,,exist_newFileAdress = %exist_newFileAdress% `n`n newFileAdress=%newFileAdress% `nsourceModifiedTime=%sourceModifiedTime% `n targetCreatedTime=%targetCreatedTime% `n,20



sourceNewerDiff := sourceModifiedTime - targetCreatedTime

   if(InStr(f,"test_area"))
   {
      MsgBox,sourceNewerDiff=%sourceNewerDiff% `n  
      ;~ continue
   }


 if(sourceModifiedTime > targetCreatedTime ) 
{
 ;~ MsgBox,sourceModifiedTime=%sourceModifiedTime%  > %targetCreatedTime% `n

  FileDelete,%newFileAdress%
	;~ MsgBox,FileDelete %newFileAdress%
}
 else
 {
	; thats ok. if source is older we dont need to copy. it takes time so that the copyied files always little newer.
	; lets do nothing and return -1 means not copied
 ;~ MsgBox,sourceModifiedTime=%sourceModifiedTime%  < %targetCreatedTime% `n newFileAdress=%newFileAdress% `n sourceNewerDiff=%sourceNewerDiff% `n
  if( timeDiff > 9 * 1000 * 1000 ) ; if its much newer we take it back to the root version. all changes overwrite.
   return -1
 }
}

 FileAppend,%source%,%newFileAdress%
exist_newFileAdress:=FileExist(newFileAdress)
if(!exist_newFileAdress)
{
	Clipboard=%newFileAdress%
	MsgBox,%A_LineNumber%: ERROR=>Reload  (!exist_newFileAdress)  newFileAdress=%newFileAdress% `n copy2dir=%copy2dir% `n f=%f% `n StrLen_source=%StrLen_source% `n
	Reload
}

return 1
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;~ whats shift + f5 ?ï¿½ï¿½?ï¿½
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
changeAllIncludeDir(f,preFix)
{ 
 source := ""
 Loop
 {
     FileReadLine, line, %f%, %A_Index%
     if ErrorLevel
         break
     newLine := RegExReplace(line, "i)(^#include)(\s+)([^;]+)", "$1$2" . preFix . "\$3 `; automatically replaced by changeAllIncludeDir ") ; case insesitive 
     ;~ newLine := StringReplace(newLine, "\\", "\") ; case insesitive 
     StringReplace, newLine, newLine, \\, \, All

     ;~ source := source . line . "`n"
     source := source . newLine . "`n"
     ;~ if(A_Index > 22)
      ;~ break
     ;~ MsgBox, 4, , Line #%A_Index% is "%line%".  Continue?
     ;~ IfMsgBox, No
         ;~ return
 }
 return source
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


isFile(Path) {
    Return !InStr(FileExist(Path), "D") 
 }

isDir(Path)
{
   Return !!InStr(FileExist(Path), "D") 
}

;/¯¯¯¯ runIfNotExist ¯¯ 190110155137 ¯¯ 10.01.2019 15:51:37 ¯¯\
runIfNotExist(m_r , m_WinTitle = "",m_category="", doFeedbackMsgBox:=258){

DetectHiddenWindows,On
SetTitleMatchMode,2
; Sleep,50

	fileName := (isHttp) ? m_r : RegExReplace(m_r, ".*\\([\w\s\.]+)$", "$1")
	fileNameWithoutPATHandEXT := RegExReplace(m_r, ".*\\([\w\s\._]+)\.\w+$", "$1")

	if(!m_WinTitle){
	  m_WinTitle := fileNameWithoutPATHandEXT
	}
	IfWinExist, %m_WinTitle%
	{
	  Return
	}
  
	global runCount ,SleepBeforeRundIfExist 
	; This global variable was previously given a value somewhere outside this function.
	Sleep,%SleepBeforeRundIfExist%

	;~ debug:=1
	debug:=0

; isHttp := ( SubStr( m_r , 1, 4 ) == "http" )
isHttp := ( Instr(m_r ,"http") )

;~ if(isHttp)
;~     Msgbox,'%m_r%' = m_r  `n (line:%A_LineNumber%) n



if(!isHttp){
	if( strlen( m_WinTitle ) > 0 ){
		fileNameWithoutPATHandEXT := m_WinTitle
	}else
	{
		;~ fileNameWithoutPATH := RegExReplace(m_r, ".*\\([\w\s\._]+)\.\w+$", "$1")
	}

	if(InStr(fileName,"Thunderbird-Portable.exe"))
		fileNameWithoutPATHandEXT=Mozilla Thunderbird ahk_class MozillaUIWindowClass

;~ if(debug && InStr(fileName,"PhpStorm.exe"))
	;~ {
		;~ MsgBox, IfWinNotExist %fileNameWithoutPATHandEXT% `n fileName = %fileName% `n %A_LineNumber%
	;~ }
}else {
fileNameWithoutPATHandEXT := m_r
}


	if(0)
	{
		; during debuging sometimes to many windows.
		WinClose,%fileNameWithoutPATHandEXT%
		WinClose,%m_r%
		return
	}
	fExist := FileExist(m_r)
	if(!fExist && doFeedbackMsgBox)
		feedbackMsgBox(A_ScriptName,":-( !FileExist(" fileName ") `n runIfNotExist, line = " . doFeedbackMsgBox . ">" . A_LineNumber,1,1)

if(isHttp || fExist) {
		IfWinNotExist,%fileNameWithoutPATHandEXT%
		{

			;~ Clipboard=OR fileName="%fileName%"
			;~ MsgBox,%fileName%
			;~ MsgBox, IfWinNotExist %fileNameWithoutPATHandEXT% `n fileName = %fileName%
			;~ ExitApp

			tip = %m_category%: %fileNameWithoutPATHandEXT%
			ToolTip5sec( tip "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ") 19-01-16_18-41" )
			;feedbackMsgBox(A_ScriptName,"run," . m_r . " `n line = " . A_LineNumber)
			run,%m_r%
			; Waits until the specified window exists.
			WinWait,%fileNameWithoutPATHandEXT%,,5

			runCount := runCount + 1
			;~ run,%m_r%

			if(debug = 1 && InStr(fileName,"PhpStorm.exe"))
			{
				;~ MsgBox, IfWinNotExist %fileNameWithoutPATHandEXT% `n fileName = %fileName% `n %A_LineNumber%
				ToolTip, IfWinNotExist %fileNameWithoutPATHandEXT% `n fileName = %fileName% `n %A_LineNumber%
			}

			IfWinNotExist,%fileNameWithoutPATHandEXT%
			{

				;~ MsgBox,this should not happen
				;~ MsgBox,this should not happen %A_LineNumber%: IfWinNotExist %fileNameWithoutPATHandEXT% `n fileName = %fileName%
				ToolTip,this should not happen %A_LineNumber%: IfWinNotExist %fileNameWithoutPATHandEXT% `n fileName = %fileName%
				; PhpStorm
			}

		}
		else{
			;~ MsgBox,else:  %fileName%
		}



	}else
	{
		if(debug = 1 && InStr(fileName,"PhpStorm.exe"))
		{
			MsgBox, IfWinNotExist %fileNameWithoutPATHandEXT% `n fileName = %fileName% `n %A_LineNumber%
		}
	}
	ToolTip,
	return,runCount

}
;\____ runIfNotExist __ 190110155142 __ 10.01.2019 15:51:42 __/

;/¯¯¯¯ winGetPos ¯¯ 190110155148 ¯¯ 10.01.2019 15:51:48 ¯¯\
winGetPos(){
         WinGetPos , left, top, width, height, A   ;, %needle
		    ;~ mm := {left:left, top:top, width:width, height:height}
		    mm := {left:left, top:top, width:width, height:height,right:left + width, bottom:top + height}
return mm
		
}
;\____ winGetPos __ 190110155152 __ 10.01.2019 15:51:52 __/

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
WinActivateTry(wintit,tries){
  SetTitleMatchMode,2 ; anywhere
  ;Frameset neues Spiel (schacharena.de) - Mozilla Firefox ahk_class MozillaUIWindowClass
  ;firefox=Mozilla Firefox ahk_class MozillaUIWindowClass
  Loop,%tries%
  {
    WinActivate , %wintit%
    IfWinActive , %wintit%
      return true
    sleep,100
  }  
  return false
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<< contextHelp <<<< 180304133425 <<<< 04.03.2018 13:34:25 <<<<
contextHelp(HardDriveLetter){
	ToolTip1sec(A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . A_ThisFunc . A_ThisLabel)
	SetTitleMatchMode, 1 ; must start match

	;WinGetActiveStats, activeTitle, w, h, x, y
	Seconds:=1

	WinGetActiveTitle, activeTitle
	ActiveTitle2:=activeTitle

	wText=dummy ; wText abzufragen wï¿½re vermutlich zu ï¿½bertrieben.
	wText2:=wText
	;WinGetText, wText, %activeTitle%

	WinGetClass, ActiveClass, A
	ActiveClass2:=ActiveClass

	WinGetActiveStats, ActiveTitle3, w, h, x, y 

	;SendPlay,{f1}

	; F1 hatte keine auswirkung, wir machen unser eigenes Hilfe
	;WinGetClass, ActiveClass, %activeTitle%, %wText%
;###############################
	temp := RegExReplace(ActiveClass, "\W+", "", ReplacementCount)  ;

  ; nur anfangsbuchstaben des titells, maximal begrentzt stï¿½ck
  ; nur anfangsbuchstaben des titells, maximal begrentzt stï¿½ck
	temT := SubStr( RegExReplace(activeTitle, "([\d\w])\w*\W*", "$1", ReplacementCount) , 1 , 6 )

	; ToolTip3sec(temT )
	ToolTip5sec(temT  "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ") 19-01-16_18-41" )

	fNameContextHelp=%temp%.txt ; class_spezifisch
  ;MsgBox, %temT% 91
	if(temT)
	{
    ;MsgBox, %temT% 94
   	fNameContextHelp2=%temp%_%temT%.txt ; classTitle_spezifisch
  }
  else
   	fNameContextHelp2:=fNameContextHelp 

  ;###############################

	wTitleContextHelp=%fNameContextHelp% ahk_class Notepad
	wTitleContextHelp2=%fNameContextHelp2% ahk_class Notepad


	visible1:=runContextHelpFile(fNameContextHelp, HardDriveLetter, ActiveClass, activeTitle)


	if(fNameContextHelp <> fNameContextHelp2)
  	visible2:=runContextHelpFile(fNameContextHelp2, HardDriveLetter, ActiveClass, activeTitle)
  else
    	visible2:=visible1

  ;  MsgBox,%A_LineNumber%


  ; msgbox, %visible2% fNameContextHelp=%fNameContextHelp% fNameContextHelp2=%fNameContextHelp2%

	if(visible2)
	{
  ;  msgbox,%visible2% %fNameContextHelp2%

  	SetTitleMatchMode, 2 
		WinWaitNotActive, %wTitleContextHelp2%,,%Seconds%
		; WinSet, Attribute, Value [, WinTitle, WinText, ExcludeTitle, ExcludeText]
		WinSet, Style, -0xC00000, %wTitleContextHelp2% ; Remove the active window's title bar (WS_CAPTION).

		bottom:=h+y
		minHeight:=150
		if y > minHeight
			minHeight:=y
		;WinMove, %fName%,, %x%, %bottom% , %w%, 100 ; unten dran kleben
ControlClick , ,  ahk_class Notepad
		;WinMove, %wTitleContextHelp%,, 1, 1 , %w%, %minHeight% ; oben dran kleben
		WinGetActiveStats, bcTitle, Aw, Ah , Ax, Ay 
		x:= Ax
		y:= -20
		w:= Aw
		h:= AY + y * ( -1 ) 
		;h:=  ;minHeight
		WinMove, %wTitleContextHelp2%,, %x%, %y% , %w%, %h%
		; oben dran kleben
	}
	WinActivate, %wTitleContextHelp2%
	WinWaitActive, %wTitleContextHelp2%,,%Seconds%
	sendplay,{control down}{End}{control up}
	
Return
} ;  ; 
;>>>>>>>> contextHelp >>>> 180304133439 >>>> 04.03.2018 13:34:39 >>>>

;<<<<<<<< runCopyQ_Ctrl_Shift_v <<<< 180304133515 <<<< 04.03.2018 13:35:15 <<<<
runCopyQ_Ctrl_Shift_v(){
	;~ MsgBox,Ctrl Shift v `n  dont work actually. `n please use Ctrl Shift 1. `n Sorry about that. thanks. 15.06.2015
	;~ return
	; ï¿½<LEER> - CopyQ ahk_cl!A_ScriptDir!A_ScriptDir!A_ScriptDiraA_ScriptDirA_ScriptDirss QWidget...ï¿½ (3 Zeilen) - CopyQ ahk_class1`11`n`n`n
		SetTitleMatchMode,2
		DetectHiddenWindows,on
	IfWinNotExist,CopyQ ahk_class QWidget
	{
		MsgBox,it not exist
		run,SL5_AHK_Refactor_engine\copyq-windows\copyq.exe
		Sleep,2000
	}
  ; ^+v!; ^+v!; ^+v!; ^+v!; ^+v!; ^+v!; ^+v!; ^+vCopyQ ahk_class QWidget
    ; ^+v7!; ^+v!; ^+v!; ^+v!; ^+v!; ^+v\SL5_AHK_Refactor_engine\SL5_AHK_Refactor_engine\SL5_AHK_Refactor_engine
    Last_A_This:=A_ThisFunc . A_ThisLabel . " p"
    lll(A_LineNumber, A_LineFile,Last_A_This)
	
    ToolTip1sec(A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
; 
SetKeyDelay,80,80
		
		Sleep,500
		 ;~ if(GetKeyState("ctrl", "P") )
		;~ {
			;~ ToolTip,:( oops 15-06-14_23-49
			;~ return
		;~ }CopyQ ahk_class QWidgetCopyQ ahk_class QWidget
		SetTitleMatchMode,2
		; {ShiftDown}^1{ShiftUp}
	DetectHiddenWindows,on
	Send,{CtrlDown}{ShiftDown}
	Loop,10
	{
		;~ ControlSend, , - CopyQ{ShiftDown}^1{ShiftUp},ahk_class QWidget- CopyQ
		;~ Sen- CopyQd,{S- CopyQhiftDown}^1{ShiftUp} 1runCopyQ_Ctrl_Shift_v1runCopyQ_Ctrl_Shift_v
		Suspend,on
		send,{Numpad1}
		WinActivate,- CopyQ
		Sleep,100
		IfWinActive,- CopyQ
			break
	}
		Send,{ShiftUp}{CtrlUp} 
		Suspend,Off
		;~ MsgBox, :) great CopyQ is active 
	; CopyQCopyQ CopyQCopyQCopyQCopyQCopyQ{CtrlDown}{ShiftDown}1{ShiftUp}{CtrlUp}{CtrlDown}{- CopyQShiftDown}1{ShiftUp}{CtrlUp}
	WinSet, AlwaysOnTop,On,- CopyQ ; Toggle the always-on-top status of Calculator.
    WinWaitActive, - CopyQ ,,2
    if !WinExist("- CopyQ")
      MsgBox, please install CopyQ and add a global hotkey STRG+SHIFT+1 (v is not possible there - or?)

    WinWaitNotActive, - CopyQ,,9
	; - CopyQ- CopyQ
	; cl- CopyQeanUp 
	Clipboard = %Clipboard% 
	
    return
}
;>>>>>>>> runCopyQ_Ctrl_Shift_v >>>> 180304133554 >>>> 04.03.2018 13:35:54 >>>>


file_put_contents(f, c, doOverwrite=1)
{
	;~ MsgBox,f=%f% `n c=%c% `n 
	;~ return
	if(StrLen(c)<1)
	{ 
		MsgBox,really want overwrite with empty? not allowed
		return -1
	}
	if(InStr(f,"*"))
	{
		MsgBox,wildcards not allowed
		return -1
	}
	atc := A_TickCount
	;~ FormatTime, timestamp, %A_now%,yy-MM-dd_HH-mm
	FormatTime, minute, %A_now%,mm
	;~ atc := A_TickCount
	atc := SubStr(minute,2,1)
	;~ MsgBox,atc=%atc% %f% = f `n 
	;~ file_moveName = %f%_%atc%.move

	file_backName = %f%_%atc%.backup
	file_creName = %f%_%atc%.create

	; backup
	FileCopy,%f%,%file_backName%

	; move
	;~ FileMove,%f%,%fileMove_backup%
	

	; write source in temp
	FileAppend, %c%, %file_creName%
	Sleep,100
	
	; overwrite target
	FileMove, %file_creName%, %f%, %doOverwrite%
	Sleep,100

	fileExistf := FileExist(f)
	Sleep,50
	
	if(StrLen(fileExistf) < 1)
	{
		/*
		FileExist(FilePattern): Returns a blank value (empty string) if FilePattern does not exist (FilePattern is assumed to be in A_WorkingDir if an absolute path isn't specified). Otherwise, it returns the attribute string (a subset of "RASHNDOCT") of the first matching file or folder. If the file has no attributes (rare), "X" is returned. FilePattern may be the exact name of a file or folder, or it may contain wildcards (* or ?). Since an empty string is seen as "false", the function's return value can always be used as a quasi-boolean value. For example, the statement if FileExist("C:\My File.txt") would be true if the file exists and false otherwise. Similarly, the statement if InStr(FileExist("C:\My Folder"), "D") would be true only if the file exists and is a directory. Corresponding commands: IfExist and FileGetAttrib.
		*/
		MsgBox,problem f=%f% `n fileExistf=%fileExistf% `n was probably not created :-( `n LETS TRY RESTORE from BACKUP
		FileMove,%file_backName%,%f%
		return -1
	}
	;~ MsgBox,fileExistf=%fileExistf% `n 
	return fileExistf
}
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ hilft bei der Adress-Suche vom Icon
runContextHelpFile(fNameContextHelp, HardDriveLetter, ActiveClass, activeTitle)
{	
  SetTitleMatchMode, 2
	IfWinExist, %fNameContextHelp%
	{
	   return true
	}

  path=%HardDriveLetter%:\fre\private\contextHelpAutohotkeyGenerated
	fAdressContextHelp=%path%\%fNameContextHelp% ;

	IfNotExist, %fAdressContextHelp%
  {
  IfNotExist, %HardDriveLetter%:\fre
    FileCreateDir, %HardDriveLetter%:\fre
  IfNotExist, %HardDriveLetter%:\fre\private
    FileCreateDir, %HardDriveLetter%:\fre\private
  IfNotExist, %path%
    FileCreateDir, %path%
		FileAppend, `n`n`n%ActiveClass%-%activeTitle% - ShortCut-Notizen und ï¿½hnliches:`n`;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<`n%path%, %fAdressContextHelp%
  }
	Run,%fAdressContextHelp%
	Sleep,100
	WinWait, %fNameContextHelp%, , 2000
	IfWinExist, %fNameContextHelp%
	{
	   return true
	}
	return false
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sendByStrgV(s) {

    suspend,on
    disableCopyQ()

    
	ClipboardOLD := Clipboard

clipboard := ""
clipboard := s
while(clipboard<>s){
    Sleep,200
    clipboard := s
}
    Send,^v
    Sleep,500

	Clipboard := ClipboardOLD

	   enableCopyQ()
       suspend,off

	return, Clipboard
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sendStrgC(trycount = 10)
{
	ClipboardOLD := Clipboard
	Loop,%trycount%
	{
		Sleep,100
		Send,^c
		if(  ClipboardOLD <> Clipboard )
		  break    
	}
	return, Clipboard
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


ternaryOperator( bool , t := true, f := false)
{
	if(bool)
		return t
	else
		return f
}

get_obj_ToString(obj){
   s= (line:%A_LineNumber%) `n `n  
   For key,value in obj
      s .= key . " = '" . value . "' `n "
   s = %s% `n `n 
   return s
}

SoundBeepString(s4){
   ; converts letters to a 4 digit number oft the alphabet
   ;~ s4:=lower(s4)
   asc_a := Asc("a")
   n:=""
   Loop,4
   {
      l:= SubStr(s4 , A_Index , 1 ) 
	   StringLower,l,l
      l:= Asc( l ) - asc_a + 1
      n .= l
      if(StrLen(n)>4){
         n := SubStr(n,1,4) ; 
		 ;~ if(n > 10000) ; 32767 any peope cant hear
			;~ n = 10000
         break
      }
      
   }
;~ MsgBox, '%s4%' = s4  `n to `n  '%n%' = n (line:%A_LineNumber%) `n        ;  ; 
   ; SoundBeep,n ,200 ; high beep

return n
}


IfMsgBox_set2Bool:
IfMsgBox Yes
    IfMsgBox:=true
else
    IfMsgBox:=false


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
convert123To_NumPad123(t)
{
  StringReplace, t, t, 1 , {numpad1}, All 
  StringReplace, t, t, 2 , {numpad2}, All 
  StringReplace, t, t, 3 , {numpad3}, All 
  StringReplace, t, t, 4 , {numpad4}, All 
  StringReplace, t, t, 5 , {numpad5}, All 
  StringReplace, t, t, 6 , {numpad6}, All 
  StringReplace, t, t, 7 , {numpad7}, All 
  StringReplace, t, t, 8 , {numpad8}, All 
  StringReplace, t, t, 9 , {numpad9}, All 
  StringReplace, t, t, 0 , {numpad0}, All 
  msg = '%t%' = t (line:%A_LineNumber%) `n 
   msg .= A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") . " " . A_ThisFunc . A_ThisLabel
	ToolTip2sec(msg)
  return t
}  
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
clipboardPaste(s){
  ToolTip1sec(A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . A_ThisFunc . A_ThisLabel)
	if(!s){
		MsgBox, :(  clipboardPaste(s)  '%s%' = s (line:%A_LineNumber%) `n 
		return false
	}

  clipboardOld := clipboard
  clipboard := s
  Suspend,on
  Send,^v
  Suspend,off
  clipboard := clipboardOld


  return true
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

FuzzySearch(string1, string2)
{
	lenl := StrLen(string1)
	lens := StrLen(string2)
	if(lenl > lens)
	{
		shorter := string2
		longer := string1
	}
	else if(lens > lenl)
	{
		shorter := string1
		longer := string2
		lens := lenl
		lenl := StrLen(string2)
	}
	else
		return StringDifference(string1, string2)
	min := 1
	Loop % lenl - lens + 1
	{
		distance := StringDifference(shorter, SubStr(longer, A_Index, lens))
		if(distance < min)
			min := distance
	}
	return min
}
;By Toralf:
;basic idea for SIFT3 code by Siderite Zackwehdex 
;http://siderite.blogspot.com/2007/04/super-fast-and-accurate-string-distance.html 
;took idea to normalize it to longest string from Brad Wood 
;http://www.bradwood.com/string_compare/ 
;Own work: 
; - when character only differ in case, LSC is a 0.8 match for this character 
; - modified code for speed, might lead to different results compared to original code 
; - optimized for speed (30% faster then original SIFT3 and 13.3 times faster than basic Levenshtein distance) 
;http://www.autohotkey.com/forum/topic59407.html 
StringDifference(string1, string2, maxOffset=1) {    ;returns a float: between "0.0 = identical" and "1.0 = nothing in common" 
  If (string1 = string2) 
    Return (string1 == string2 ? 0/1 : 0.2/StrLen(string1))    ;either identical or (assumption:) "only one" char with different case 
  If (string1 = "" OR string2 = "") 
    Return (string1 = string2 ? 0/1 : 1/1) 
  StringSplit, n, string1 
  StringSplit, m, string2 
  ni := 1, mi := 1, lcs := 0 
  While((ni <= n0) AND (mi <= m0)) { 
    If (n%ni% == m%mi%) 
      EnvAdd, lcs, 1 
    Else If (n%ni% = m%mi%) 
      EnvAdd, lcs, 0.8 
    Else{ 
      Loop, %maxOffset%  { 
        oi := ni + A_Index, pi := mi + A_Index 
        If ((n%oi% = m%mi%) AND (oi <= n0)){ 
            ni := oi, lcs += (n%oi% == m%mi% ? 1 : 0.8) 
            Break 
        } 
        If ((n%ni% = m%pi%) AND (pi <= m0)){ 
            mi := pi, lcs += (n%ni% == m%pi% ? 1 : 0.8) 
            Break 
        } 
      } 
    } 
    EnvAdd, ni, 1 
    EnvAdd, mi, 1 
  } 
  Return ((n0 + m0)/2 - lcs) / (n0 > m0 ? n0 : m0) 
}

stringLower(s)
{
	stringLower,s,s
	return s	; 
}

isUrlAvailable(URL){
   ;~ URL := "http://localhost/xampp/"
   ;~ isUrlAvailable:=isUrlAvailable(URL)

   isUrlAvailable:=true
   try{
      whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
      whr.Open("GET", URL , true)
      whr.Send()
      whr.WaitForResponse()
      ;~ whr_ResponseText := whr.ResponseText
   } catch e
   {
      isExceptionThrown:=true
      ;~ MsgBox, An exception was thrown!`nSpecifically: %e%
   }
   if(ErrorLevel || isExceptionThrown)
   {
      isUrlAvailable:=false
   }
   if(false){
      infoMsg = '%isUrlAvailable%' = isUrlAvailable  `n '%isExceptionthrown%' = isExceptionThrown `n  '%whr_ResponseText%' = whr_ResponseText   `n `n `n `n '%ErrorLevel%' = ErrorLevel `n   '%html%' = html  `n  '%A_AhkVersion%' = A_AhkVersion '%whr%' = whr (line:%A_LineNumber%) `n `n '%whr_status%' = whr_status
      ToolTip, % infoMsg
      Sleep,6000
   }
   return isUrlAvailable
}


;<<<<<<<< disableCopyQ <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
disableCopyQ(){
	if(fileExist("C:\Program Files (x86)\_\CopyQ\copyq.exe"))
  		run,"C:\Program Files (x86)\_\CopyQ\copyq.exe" disable, C:\Program Files (x86)\_\CopyQ\
  return
}
enableCopyQ(){
if(fileExist("C:\Program Files (x86)\_\CopyQ\copyq.exe"))
  run,"C:\Program Files (x86)\_\CopyQ\copyq.exe" enable, C:\Program Files (x86)\_\CopyQ\
  return
}
runCopyQ(){
if(fileExist("C:\Program Files (x86)\_\CopyQ\copyq.exe"))
  run,"C:\Program Files (x86)\_\CopyQ\copyq.exe", C:\Program Files (x86)\_\CopyQ\
  return
}

;>>>>>>>> disableCopyQ >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




feedbackMsgBoxCloseAllWindows(){

; DetectHiddenWindows,On
settitlematchmode,1
if(WinExist("1:")){
	winGetPos,x,y
	global feedbackMsgBox1PosBackup_x
	global feedbackMsgBox1PosBackup_y
	feedbackMsgBox1PosBackup_x := x
	feedbackMsgBox1PosBackup_y := y
    WinClose,1:
    WInWaitClose,1:
    Sleep, 1000
}
;
}

;<<<<<<<< feedbackMsgBox <<<< 170814121750 <<<< 14.08.2017 12:17:50 <<<<
feedbackMsgBoxNr(tit := "",text := "" ,x:=1,y:=1, closeInSeconds := 0){
;Tooltip, next try pls write feedbackMsgBox NOT feedbackMsgBoxNr `n (from: %A_LineFile%~%A_LineNumber%) `
    return feedbackMsgBox(tit ,text ,x,y, closeInSeconds)
}


;/¯¯¯¯ feedbackMsgBox ¯¯ 181027092614 ¯¯ 27.10.2018 09:26:14 ¯¯\
feedbackMsgBox(tit := "",text := "" ,x:=1, y:=1, closeInSeconds := 0, MAXcountMsgBoxNr := 15){ ; 20 ; 15 my monitor is perfect filled 18-11-15_07-43
	WinGetActiveTitle,at
	at := RegExReplace(at, "m)\n.*", "") ; title should never is multioline. this proof is hoprefulle1
	if(!at || RegExMatch(at, "^(\d:|temp\.ahk)")){ ; check for probably wrong title. dont know why its happens sometimes. :(
        lll( A_LineNumber, A_ScriptName, "return")
		return
	}
	;if(g_ignReg[A_ThisFunc]["tit"])
    ;msgbox, % g_ignReg[A_ThisFunc]["tit"] "(" RegExReplace(A_LineFile,".*\\") ":" A_LineNumber

    tit := RegExReplace(tit,"i)[\s,]+", " ")
    text := RegExReplace(text,"i)[ ,]+", " ")

	; g_ignReg := { feedbackMsgBox:{tit:"", text:"."} , ...
	; ; please use it like this: if( RegExMatch( ln, g_ignReg["saveLogFiles"]["ln"])	|| ......
	if(    ( g_ignReg[A_ThisFunc]["tit"]  && RegExMatch( tit, g_ignReg[A_ThisFunc]["tit"]   ) )
	    || ( g_ignReg[A_ThisFunc]["text"] && RegExMatch( text, g_ignReg[A_ThisFunc]["text"] ) ) ){
        lll( A_LineNumber, A_ScriptName, "return")
		return
    }

if(!text)
    text:=tit

; msgbox,% "g_ignReg..[tit]=>" . g_ignReg[A_ThisFunc]["tit"] . "< = >" . (RegExMatch(tit, g_ignReg[A_ThisFunc]["tit"])) . "< tit = >" . tit . "< `n `n " . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") . " "

global g_feedbackMsgBoxNr
if(!g_feedbackMsgBoxNr)
    g_feedbackMsgBoxNr := 1
if(!feedbackMsgBoxNr && g_feedbackMsgBoxNr)
    feedbackMsgBoxNr  := g_feedbackMsgBoxNr

feedbackMsgBoxNrPre := feedbackMsgBoxNr
;tooltip, % feedbackMsgBoxNrPre

settitlematchmode,1
settitlematchmode,slow
DetectHiddenWindows,Off
while(feedbackMsgBoxNrPre > 0 && !winexist(feedbackMsgBoxNrPre . ":"))
    feedbackMsgBoxNrPre--
;Msgbox,%feedbackMsgBoxNrPre% `n (%A_LineFile%~%A_LineNumber%)

if(!feedbackMsgBoxNrPre)
    feedbackMsgBoxNrPre := 0
feedbackMsgBoxNr := feedbackMsgBoxNrPre + 1

if(feedbackMsgBoxNrPre == MAXcountMsgBoxNr || feedbackMsgBoxNr === MAXcountMsgBoxNr){
    ; tit .= "MAXcount" MAXcountMsgBoxNr ; doesent work 18-11-14_10-09
    text .= "`nMAXcount: " MAXcountMsgBoxNr
}
if(feedbackMsgBoxNrPre > MAXcountMsgBoxNr || feedbackMsgBoxNr > MAXcountMsgBoxNr){
	ToolTip5sec(":( Oops `n feedbackMsgBoxNr>MAX `n " . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This,1,1)
	; for some reasion sometimes there anyway to many windows. therfor this dirty-bugFix:
	SetTitleMatchMode,1
	DetectHiddenWindows,Off
	WinClose,%feedbackMsgBoxNr%:
	;WinClose,%feedbackMsgBoxNrPre%:
	; and slow down
	sleep,1500
    return
}
g_feedbackMsgBoxNr := feedbackMsgBoxNr

global feedbackMsgBox1PosBackup_x
global feedbackMsgBox1PosBackup_y
if(feedbackMsgBoxNr == 1){
if(feedbackMsgBox1PosBackup_x && feedbackMsgBox1PosBackup_y && x==1  && y==1 ){
	x := feedbackMsgBox1PosBackup_x
	y := feedbackMsgBox1PosBackup_y
	;msgbox,%feedbackMsgBoxNr% %feedbackMsgBox1PosBackup_x%,%feedbackMsgBox1PosBackup_y% %x%,%y%
}}


;<<<<<<<< AHKcode <<<< 170814212731 <<<< 14.08.2017 21:27:31 <<<<
AHKcode=
(
OnExit("OnExi1883") ; Register a function to be called on exit:
settitlematchmode,slow
loop,1
{
WinGetActiveTitle , at ; seems not working in ayyn window
at := RegExReplace(at, "m)\n.*", "") ; title should never is multioline. this proof is hoprefulle
if(at)
    break
    sleep,99
}
feedbackMsgBoxNr := %feedbackMsgBoxNr%
feedbackMsgBoxNrPre := feedbackMsgBoxNr - 1
tit =
`(
%tit%
`)
text =
`(
%text%
`)
settitlematchmode,1
SetTimer,myExitApp,500
settitlematchmode,1
boxTitle := `% feedbackMsgBoxNr . ":" . tit
if(feedbackMsgBoxNr == %MAXcountMsgBoxNr%)
text .= "``n feedbackMsgBoxNr == MAXcountMsgBoxNr == %MAXcountMsgBoxNr%"
Msgbox ,,`% boxTitle, `% text , %closeInSeconds%
; ScrollBox(text ,"WP") ; Word Wrap and Pause
; WinWait, ScrollBox
; WinSetTitle,ScrollBox,,%boxTitle%
sleep,200
; WinWait,`% boxTitle
WinMove, `% boxTitle , , `% x , `% y, 350
WinSet, Transparent, 125, `% boxTitle
WinSet, Bottom,,%feedbackMsgBoxNr%
;tooltip, `% at
maxTryes:=1
while(!winactive(at)){ ; :( no effect 14.08.2017 18:56
	tooltip, while(!winactive(`%at`%))
    sleep,100
    WinActivate,`% at
    if(--maxTryes<1)
        break
}
sleep,500
WinActivate,%at%

myExitApp:
;tooltip, %x%=x
WinGetPos,x,y,w,h,%feedbackMsgBoxNrPre%:
If( GetKeyState("LButton") =1 )
 return
; tooltip,search : %feedbackMsgBoxNrPre%
if(feedbackMsgBoxNr>1 ){
	
if( y+h+h > A_ScreenHeight){
	WinGetPos,,y1,,,1:
	y := y1
	x += w
}else{
	y := y + h - 4
}
WinMove,%feedbackMsgBoxNr%:,,`% x,`% y, 400, `% h
if(x <> xOld || y <> yOld ){
 WinActivate,%feedbackMsgBoxNr%
 WinSet, Top, ,%feedbackMsgBoxNr%
 ;WinSet, AlwaysOnTop, Off, ,%feedbackMsgBoxNr%
}
xOld := x
yOld := y
IfWinNotExist, %feedbackMsgBoxNrPre%
{
    ExitApp
}
IfWinNotExist, 1:
{
    ExitApp
}
} ; END Of feedbackMsgBox
return

OnExi1883(){
    g_feedbackMsgBoxNr := g_feedbackMsgBoxNr - 1 ; sad :( onbound not possible
    sleep,100
    return
}

)
AHKcode := "#" . "NoTrayIcon" . "`n" . AHKcode
;>>>>>>>> AHKcode >>>> 170814212827 >>>> 14.08.2017 21:28:27 >>>>
; tooltip,%AHKcode%`n `n (%A_LineFile%~%A_LineNumber%)
; Msgbox,`n (%A_LineFile%~%A_LineNumber%) `
;ToolTip4sec(A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " `n" . at)
;If(!WinExist(feedbackMsgBoxNr . ":")) ; shuld never happens
SetTitleMatchMode,1
while(0 && WinExist(feedbackMsgBoxNr . ":")){
	WinClose,% feedbackMsgBoxNr . ":"_
	WinWaitClose,% feedbackMsgBoxNr . ":",, 1
}

If(!WinExist(feedbackMsgBoxNr . ":")) ; shuld never happens 10.02.2018 12:51
	DynaRun(AHKcode)
else
	feedbackMsgBoxNr(tit,text,x,y,%closeInSeconds%)
WinWait,% feedbackMsgBoxNr . ":",,1
ifWinNotExist,% feedbackMsgBoxNr . ":"
    return false

if(feedbackMsgBoxNr ==1)
	WinMove, % feedbackMsgBoxNr . ":" , , % x , % y ; whay again? bugdif 10.02.2018 14:49
sleep,100 ; we need this small wait becouse of the stupid focus ;) it needs little time after exist to catch the focus ;) 10.02.2018 13:40
if(at && !RegExMatch(at, "^(\d:|temp\.ahk)")){ ; check for probably wrong title. dont know why its happens sometimes. :(
	;feedbackMsgBox("at= >" . at . "<","at= >" . at . "<`n" . A_ScriptName . "~" . A_LineNumber)
	loop,10
	{
		maxTryes:=350
		while(!WinActive(at) && winExist(at)){ ; works :)  14.08.2017 19:34
			sleep,10
			; tooltip,WinActivate %at%

			WinActivate,% at
			if(--maxTryes<1)
				break
		}
	}
	if(!WinActive(at))
		feedbackMsgBox(":( ups !WinActive(at)", A_ScriptName . "~" . A_LineNumber)
}
    WinActivate,%at% ; <== useless?? 27.10.2018 09:35
    return, feedbackMsgBoxNr
}
;>>>>>>>> feedbackMsgBox >>>> 170814121755 >>>> 14.08.2017 12:17:55 >>>>







;<<<<<<<< show_rectangle_by_mouseMove_animation <<<< 171010135140 <<<< 10.10.2017 13:51:40 <<<<
show_rectangle_by_mouseMove_animation(rArea){
   if(!rArea){
    Msgbox,:( !rArea `n (%A_LineFile%~%A_LineNumber%)
   }
   
   if(!rArea["bottom"])
      rArea["bottom"] := rArea["top"] + rArea["height"]
   if(!rArea["right"])
      rArea["right"] := rArea["left"] + rArea["width"]
   
   
     ;~ msg := "`nleft" . mm["left"] . "`ntop" . mm["top"] . "`nwidth" . mm["width"] . "`nheight" . mm["height"] 
     msg := "`nleft " . rArea["left"] . "`ntop " . rArea["top"] . "`nwidth " . rArea["width"] . "`nheight " . rArea["height"] 

   SplashTextOn , rArea["width"], rArea["height"], SplashTextTitle, SplashText `n `n (line:%A_LineNumber%) `n`n %msg%
   WinMove, SplashTextTitle, , rArea["left"], rArea["top"]  ; Move the splash window to the top left corner.
Sleep,2000
SplashTextOff
return

   
	if(rArea != false && rArea["left"] )
	{ 
		sloopMili:=200
		MouseGetPos,x,y
		Loop,2
	{
		;~ Ms	gBox,% rArea["left"] . " , " . rArea["top"]
		DllCall("SetCursorPos", int, rArea["left"], int, rArea["top"])
		Sleep,%sloopMili%
		;~ MsgBox,% rArea["right"] rArea["top"]
		DllCall("SetCursorPos", int, rArea["right"], int, rArea["top"])
		Sleep,%sloopMili%
		;~ MsgBox,% rArea["right"] rArea["bottom"]
		DllCall("SetCursorPos", int, rArea["right"], int, rArea["bottom"])
		Sleep,%sloopMili%
		;~ MsgBox,% rArea["left"] rArea["bottom"]
		DllCall("SetCursorPos", int, rArea["left"], int, rArea["bottom"])
		Sleep,%sloopMili%
		;~ MsgBox,% rArea["left"] rArea["top"]
		DllCall("SetCursorPos", int, rArea["left"], int, rArea["top"])
		Sleep,%sloopMili%
	}
rArea_left := rArea["left"]
rArea_top := rArea["top"]
rArea_right := rArea["right"]
rArea_bottom := rArea["bottom"]
	MouseMove,%x%,%y%
	;; show area
	}
	else
		ToolTip, % "134:`n :(   left= " . rArea["left"] . rArea[left]
        
        MsgBox, :-) OK ?  (line:%A_LineNumber%) `n '%rArea_left%' = rArea_left `n '%rArea_top%' = rArea_top  `n '%rArea_right%' = rArea_right   `n '%rArea_bottom%' = rArea_bottom `n 
	return
}
;>>>>>>>> show_rectangle_by_mouseMove_animation >>>> 171010135147 >>>> 10.10.2017 13:51:47 >>>>

;<<<<<<<< RegExSplit <<<< 171024004832 <<<< 24.10.2017 00:48:32 <<<<
; https://autohotkey.com/board/topic/109660-regexsplit-script/
RegExSplit(psText, psDelimiterPattern)
{
  if psText
  {
    if !psDelimiterPattern
      aRetVal := StrSplit(psText)
    else
    {
      aRetVal := Array()
      iLastFoundPos := 1
      Loop
      {
        if (iFoundPos := RegExMatch(psText, "P)" . psDelimiterPattern, iFoundLen, iLastFoundPos))
        {
          aRetVal.Insert(SubStr(psText, iLastFoundPos, (iFoundPos - iLastFoundPos)))
          iLastFoundPos := iFoundPos + iFoundLen
        }
        else
          break
      }
      aRetVal.Insert(SubStr(psText, iLastFoundPos, ((StrLen(psText) + 1) - iLastFoundPos)))
    }
  }
  return aRetVal
}
;>>>>>>>> RegExSplit >>>> 171024004836 >>>> 24.10.2017 00:48:36 >>>>


;<<<<<<<< setSearchAreaToWinTitleArea <<<< 171024094733 <<<< 24.10.2017 09:47:33 <<<<
setSearchAreaToWinTitleArea(winTitle){
   if(!winTitle)
      MsgBox, ERROR: '%winTitle%' = winTitle (line:%A_LineNumber%) `n
   SetTitleMatchMode,2
   WinGetPos, wL, wT, wW, wH, % winTitle
   mm := {left:wL, top:wT, width:wW, height:wH}

   ;~ mm["left"] := wL
   ;~ mm["top"] := wT
   ;~ mm["width"] := wW
   ;~ mm["height"] := wH
  msg := "left" . mm["left"] . "top" . mm["top"] . "width" . mm["width"] . "height" . mm["height"]
   return mm
}
;>>>>>>>> setSearchAreaToWinTitleArea >>>> 171024094739 >>>> 24.10.2017 09:47:39 >>>>

DynaRunFROMAhkSudio(Script,Wait:=true,name:="Untitled"){
	static exec,started,filename
	if(!IsObject(v.Running))
		v.Running:=[]
	filename:=name,MainWin.Size(),exec.Terminate()
	if(Script~="i)m(.*)\{"=0)
		Script.="`n" "m(x*){`nfor a,b in x`nlist.=b Chr(10)`nMsgBox,,AHK Studio,% list`n}"
	if(Script~="i)t(.*)\{"=0)
		Script.="`n" "t(x*){`nfor a,b in x`nlist.=b Chr(10)`nToolTip,% list`n}"
    msgBox, 19-01-16_19-59 19-01-16_19-59 19-01-16_19-59 19-01-16_19-59 19-01-16_19-59
	shell:=ComObjCreate("WScript.Shell"),exec:=shell.Exec("AutoHotkey.exe /ErrorStdOut *"),exec.StdIn.Write(Script),exec.StdIn.Close(),started:=A_Now
	v.Running[Name]:=exec
	SetTimer,CheckForError,120
	return
	CheckForError:
	Process,Exist,% exec.ProcessID
	if(!ErrorLevel){
		if(text:=exec.StdERR.ReadAll()){
			if(!v.debug.sc)
				MainWin.DebugWindow()
			tooltip,% A_ThisFunc ":DynaRun: `nScript Exited, ExitCode: " exec.ExitCode "`n" text
		}else
			tooltip,% A_ThisFunc ":DynaRun: Script Exited, ExitCode: "
		SetTimer,CheckForError,Off
		return 1
	}
	; SetStatus(filename " running. Run-Time: " A_Now-started " Seconds",3)
	return
}

;/¯¯¯¯ DynaRun ¯¯ 181029190515 ¯¯ 29.10.2018 19:05:15 ¯¯\
DynaRun(TempScript, pipename=""){

    ; msgbox,18-11-16_13-19 ; to tool
    ; tool __ tool

    if(false && InStr(A_ComputerName,"SL5") )
        ToolTip9sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ") tokden:19-01-16_18-40" ) ; token becouse somtimes lineNumber is wrong

    setTitleMatchMode, 2
    if(false && winActive("ahk_class AutoHotkeyGUI")){
        ; what was the motivation for this attitude? 18-12-29_11-40
        ; which error should that fix?
        ; which difficulty`?
        ; ==> then some script i not usabal with gi. nearly all GUIs ant also AHK_Studio
        if(false && InStr(A_ComputerName,"SL5") )
            feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), "19-01-16_17-53" )
        return false
    }
    if(winExist("fn_functions_global_" A_ThisFunc)){
        if(false && InStr(A_ComputerName,"SL5") ) ; whats this ????
            feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), "19-01-16_17-51" )
        ; sleep,1000
        return false
    }



	; TempScript := "#" . "ErrorStdOut`n" . TempScript
	TempScriptPre := "" . "FileEncoding, UTF-8 `n"

	if(!InStr(TempScript,"aScriptDir :="  )){
    	; TempScriptPre .= "#" . "include " A_ScriptDir "\inc_ahk\functions_global.inc.ahk `n"
    	; TempScriptPre .= "#" . "include " A_ScriptDir "\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk `n"
    	; TempScriptPre .= "#" . "include " A_ScriptDir "\inc_ahk\ToolTipSec.inc.ahk `n"
    }else
        msgbox,% TempScript

	if(!InStr(TempScript,"aScriptDir :="  ))
        TempScriptPre .= "aScriptDir := """ A_ScriptDir """ `n"

    TempScript := TempScriptPre TempScript "`n"
    ;msgbox,% TempScript

		if(0 && InStr(A_ComputerName,"SL5") )
            ToolTip9sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ") 19-01-16_18-41" )

	static _:="uint",@:="Ptr"
	try  ; i dont want disturbing error messages
	{
	;fn := SubStr( jj , 1,3 )
		If pipename =
 			name := "AHK" A_TickCount "ln" A_LineNumber "fn_functions_global_" A_ThisFunc
		Else
			name := pipename
		__PIPE_GA_ := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
		__PIPE_    := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
		if (__PIPE_=-1 or __PIPE_GA_=-1)
			Return 0
	;if(!FileExist(A_AhkPath . "\\.\pipe\" . name))
	;  Return 0
	;IfNotExist, %A_AhkPath% "\\.\pipe\%name%"

    ; https://autohotkey.com/board/topic/103403-ipc-using-named-pipes/
    ; ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )

        try{
          fileAdress = %A_AhkPath% "\\.\pipe\%name%"
            if(0)
            while(!FileExist(fileAdress)){
                Sleep,100
                if(A_Index > 10)
                    return 0
            }
            Run, %fileAdress%,,UseErrorLevel HIDE, PID
       } catch e{
          ;throw Exception("Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line, -1)
          tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
          tooltip, % tip
         TempScript .= "`n#" "Include " A_ScriptDir "\inc_ahk\functions_global.inc.ahk"
         FileAppend, `% TempScript, `% name
       }

		DllCall("ConnectNamedPipe",@,__PIPE_GA_,@,0)
		DllCall("CloseHandle",@,__PIPE_GA_)
		DllCall("ConnectNamedPipe",@,__PIPE_,@,0)
		script := (A_IsUnicode ? chr(0xfeff) : (chr(239) . chr(187) . chr(191))) TempScript
;	clipboard := script
		
		
		if !DllCall("WriteFile",@,__PIPE_,"str",script,_,(StrLen(script)+1)*(A_IsUnicode ? 2 : 1),_ "*",0,@,0)
			Return A_LastError,DllCall("CloseHandle",@,__PIPE_)
		DllCall("CloseHandle",@,__PIPE_)
	}
	catch e  ; Handles the first error/exception raised by the block above.
	{
		tip := "Exception in DynaRun:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
		tooltip, `% tip
		FileAppend, `% TempScript, `% name
	}
	SetTitleMatchMode,1
	if(1 && WinExist(substr(name,1,-5))) ; helps debugging
		FileAppend, `% TempScript, `% name
	
	while(1 && name && WinExist(substr(name,1,-5)) && A_Index < 9)
		WinClose,
	
   ; clipboard := TempScript
	Return PID
}
;>>>>>>>> DynaRun >>>> 180228151009 >>>>

;<<<<<<<< removesSymbolicLinksFromFileAdress <<<< 180305085209 <<<< 05.03.2018 08:52:09 <<<<
removesSymbolicLinksFromFileAdress(actionList){
	pLength := 0
	while(pLength <> StrLen(actionList )){
	; tooltip,`% A_index . "# Line:" . A_LineNumber . " Name:" . A_ScriptName . " "
	pLength := StrLen(actionList )
	actionList := RegExReplace(actionList ,"(\\[^\\]+\\\.\.)+") ; works. removes all symbolic links 24.02.2018  cleanPath
	}
	actionList := RegExReplace(actionList,"\\\.\\")  ; works. removes all symbolic link 24.02.2018 cleanPath
	actionList := RegExReplace(actionList,"^\.\\")  ; works. removes all symbolic link 24.02.2018  cleanPath
	 return actionList
}
;>>>>>>>> removesSymbolicLinksFromFileAdress >>>> 180305085214 >>>> 05.03.2018 08:502:14 >>>>

ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}


; too too

;/¯¯¯¯ json ¯¯ 181122225021 ¯¯ 22.11.2018 22:50:21 ¯¯\
; from: https://stackoverflow.com/questions/33989042/json-parsing-generating-and-beautifiying-formatting-with-autohotkey
json(i){
  ;ENCODE
  if (isobject(i))
  {
    o := "", a := 1, x := 1
    for k,v in i
    {
      if (k!=x)
        a := 0, break
      x += 1
    }
    o .= (a) ? "[" : "{", f := 1
    for k,v in i
      o .= ((f) ? "" : ",")((a) ? "" : """" k """:")((isobject(v)) ? json(v) : ((v+0=v) ? v : """" v """")), f := 0
    return o ((a) ? "]" : "}")
  }
  ;DECODE
  if (regexmatch(i, "s)^__chr(A|W):(.*)", m))
  {
    VarSetCapacity(b, 4, 0), NumPut(m2, b, 0, "int")
    return StrGet(&b, 1, (m1="A") ? "cp28591" : "utf-16")
  }
  if (regexmatch(i, "s)^__str:((\\""|[^""])*)", m))
  {
    str := m1
    for p,r in {b:"`b", f:"`f", n:"`n", 0:"", r:"`r", t:"`t", v:"`v", "'":"'", """":"""", "/":"/"}
      str := regexreplace(str, "\\" p, r)
    while (regexmatch(str, "s)^(.*?)\\x([0-9a-fA-F]{2})(.*)", m))
      str := m1 json("__chrA:0x" m2) m3
    while (regexmatch(str, "s)^(.*?)\\u([0-9a-fA-F]{4})(.*)", m))
      str := m1 json("__chrW:0x" m2) m3
    while (regexmatch(str, "s)^(.*?)\\([0-9]{1,3})(.*)", m))
      str := m1 json("__chrA:" m2) m3
    return regexreplace(str, "\\\\", "\")
  }
  str := [], obj := []
  while (RegExMatch(i, "s)^(.*?[^\\])""((\\""|[^""])*?[^\\]|)""(.*)$", m))
    str.insert(json("__str:" m2)), i := m1 "__str<" str.maxIndex() ">" m4
  while (RegExMatch(RegExReplace(i, "\s+", ""), "s)^(.*?)(\{|\[)([^\{\[\]\}]*?)(\}|\])(.*)$", m))
  {
    a := (m2="{") ? 0 : 1, c := m3, i := m1 "__obj<" ((obj.maxIndex()+1) ? obj.maxIndex()+1 : 1) ">" m5, tmp := []
    while (RegExMatch(c, "^(.*?),(.*)$", m))
      tmp.insert(m1), c := m2
    tmp.insert(c), tmp2 := {}, obj.insert(cobj := {})
    for k,v in tmp
    {
      if (RegExMatch(v, "^(.*?):(.*)$", m))
        tmp2[m1] := m2
      else
        tmp2.insert(v)
    }
    for k,v in tmp2
    {
      for x,y in str
        k := RegExReplace(k, "__str<" x ">", y), v := RegExReplace(v, "__str<" x ">", y)
      for x,y in obj
        v := RegExMatch(v, "^__obj<" x ">$") ? y : v
      cobj[k] := v
    }
  }
  return obj[obj.maxIndex()]
}
;\____ json __ 181122225031 __ 22.11.2018 22:50:31 __/




;/¯¯¯¯ str_repeat ¯¯ 190113091852 ¯¯ 13.01.2019 09:18:52 ¯¯\
str_repeat(vText, vNum){
	if (vNum <= 0)
		return false
	return StrReplace(Format("{:" vNum "}","")," ",vText)
}
;\____ str_repeat __ 190113091855 __ 13.01.2019 09:18:55 __/

; lll(A_LineNumber, "inc_ahk\functions_global.inc.ahk")
#Include *i %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
; lll(A_LineNumber, "inc_ahk\functions_global.inc.ahk")
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
; lll(A_LineNumber, "inc_ahk\functions_global.inc.ahk")


