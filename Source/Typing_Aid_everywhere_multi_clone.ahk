; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
; #ErrorStdOut
#NoTrayIcon

FileEncoding, UTF-8

CoordMode, Caret, Screen
CoordMode, ToolTip, Screen
; CoordMode, Mouse, Screen


;<<<<<<<< g_ignReg <<<< 180224082501 <<<< 24.02.2018 08:25:01 <<<<
if(InStr(A_ComputerName,"SL5")) ; do ignore nothing
global g_ignReg := { feedbackMsgBox:{tit:".^", text:".^"} ,          saveLogFiles: {ln:".^", scriptName:"token1803201013", text:"\b(FileCopy too|FileAppend too)\b"},                    sqlQuery: {ln:".^", scriptName:".^", text:".^"},                    hotKeyStuff: {ln:".^", scriptName:".^", text:".^"},                    runLogFile: {ln:".^", scriptName:".^", text:".^"} } ;;;; regEx ignoreConfigList ;;;;
; this "token1803201013" helps sometimes to debug this list byitself
; please use it like this:     if( 1<RegExMatch(0 . A_ScriptName, g_ignReg["saveLogFiles"]["scriptName"])	|| ......
        ; OR: the regEx .^ never match anything. if you use .^ i recomand using: if( RegExMatch(ln, g_ignReg["saveLogFiles"]["ln"])	|| ......
; https://autohotkey.com/boards/viewtopic.php?f=6&t=44696&p=202322#p202322
lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"hi from " A_LineFile)
;>>>>>>>> g_ignReg >>>> 180224082506 >>>> 24.02.2018 08:25:06 >>>>





;<<<<<<<< IncludeI <<<< 171103161518 <<<< 03.11.2017 16:15:18 <<<<
#Include *i ..\ActionLists\activeClassManipulation.inc.ahk
; ^- obiges funktioniert (weil funktion spï¿½ter ausgefï¿½hrt) bei `normalem` Aufruf. z.B. click von atuoload.ahk und darin ein:
; workingDir := HardDriveLetter . ":\fre\private\HtmlDevelop\AutoHotKey\tools\gi-everywhere-master\"
;  run, Typing_Aid_everywhere_multi_clone.ahk, %workingDir%
; #Include *i ..\ActionLists\activeClassManipulation.inc.ahk
;>>>>>>>> IncludeI >>>> 171103161523 >>>> 03.11.2017 16:15:23 >>>>

global g_doSaveLogFiles := true
global g_doSaveLogFiles := false
g_doRunLogFiles := false


; Menu, Tray, Icon, shell32.dll, 144
 Menu, Tray, Icon, shell32.dll, 107
; Menu, Tray, Icon, shell32.dll, 164
; Menu, Tray, Icon, shell32.dll, 227

;~ Menu, Tray, Icon, shell32.dll, 2 ; a ide or floppy
;~ Menu, Tray, Icon, shell32.dll, 250 ; pretty green stick
;~ Menu, Tray, Icon, shell32.dll, 250 ; pretty black stick

;~ Menu, Tray, Icon, shell32.dll, 240 ; pretty green clock
;~ Menu, Tray, Icon, shell32.dll, 266 ; pretty black clock




dog_lineNumberFeedback:=true
dog_lineNumberFeedback:=False
do_g_tooltipText:=false
do_tooltipReadActionList:=false
do_tooltipReadActionList:=true

g_tooltipText:=""
global g_lineNumberFeedback
g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

; ListGlobalVars() ; doesentn work
; test

;checkCriticalCommand()
SetTimer, checkCriticalCommandLbl, 2000
SetTimer, checkCriticalCommandLbl, Off

SetTimer, tooltipABS, 4000
; SetTimer, tooltipABS, 100
if(False) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
   msg := getWelcomeMsg()
   MsgBox,% msg " from getWelcomeMsg"
} ;
isInternMsgTransportIsClipboard := false ; false. then using fileSystem: readfile, include copyfile
debugIt := true
debugIt := false   ;
; test_getNextLetterName(start,stop); 282+ lines in wavetanzen.eu.login.php.functions.inc.ahk
scriptNameShort := SubStr(A_ScriptName, 1 , - 4)
baseDir := "." ; the same folder not any special folder
sourceDir = %baseDir%
if(!FileExist(sourceDir)){
; thats possible to start more inside.
    baseDir := ""
    sourceDir :=""
}

; too __ cr cre cre

gi_everywhereSourcePath := sourceDir "\Source"
gi_everywhereSourcePath := ""
ActionListDirBase := sourceDir "\..\ActionLists"
if(0 && InStr(A_ComputerName,"SL5")){
    ActionListDirBase := "E:\fre\private\HtmlDevelop\AutoHotKey\tools\TypingAid-master\ActionLists"
    ActionListDirBase := "E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere-Nightly-Build-NEU\ActionLists"
    ; Oops. dieses is irgendiw leer: E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere-Nightly-Build-works-18-10-26_16\ActionLists
}


gi_everywhereAHK := gi_everywhereSourcePath  . "\gi-everywhere.ahk"
gi_everywhereAHK := gi_everywhereSourcePath  . "gi-everywhere.ahk"
; ActionListActive := sourceDir . "\ActionList.txt" ; we dont need it. deprecated 21.03.2018 09:09
ActionListActive := ""
ActionListOLD:=""

checkFilePathExistens1704291222(ActionListDirBase, destinDir, sourceDir, gi_everywhereAHK)

; selfTestLoop1000(1)
; selfPerformanceTest()
; selfPerformanceTest2()

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
activeTitle:=""
;/¯¯¯¯ while ¯¯ 181023091625 ¯¯ 23.10.2018 09:16:25 ¯¯\
while(true) {
; IfWinNotExist,gi-everywhere - Active
	DetectHiddenWindows,On ; if this is off it does not find in tray 27.04.2017
;<<<<<<<< IfWinNotExist <<<< 180323140132 <<<< 23.03.2018 14:01:32 <<<<
	SetTitleMatchMode,2
	IfWinNotExist,gi-everywhere
	{
		if(!FileExist(gi_everywhereAHK)){
			msg = :-( FileNotExist %gi_everywhereAHK% `n 08.07.2017 14:06 17-07-08_14-06
			Msgbox,%msg% `n (%A_LineFile%~%A_LineNumber%)
			ExitApp
		}
    ; tooltip, RunWait %gi_everywhereAHK%
		
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"Debuggging!  NOT Run % gi_everywhereAHK (23.03.2018 14:24)" ) ; 18-01-20_18-56
		
    ; RunWait, % gi_everywhereAHK
    ; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"RunWait, % gi_everywhereAHK")
	}
;>>>>>>>> IfWinNotExist >>>> 180323140141 >>>> 23.03.2018 14:01:41 >>>>
	SetTitleMatchMode,2 ; thats my default. do i need it later ? 08.07.2017 14:12
	
	
	
;If (A_TimeIdle < 50 || GetKeyState("ctrl", "P") || GetKeyState("Alt", "P") || GetKeyState("Shift", "P") || GetKeyState("LWin", "P") || GetKeyState("RWin", "P")  || GetKeyState("LButton", "P") ){
	If (true){
		if(GetKeyState("ctrl", "P"))
			KeyWait, ctrl
		
		if(GetKeyState("Alt", "P"))
			KeyWait, Alt
		
		if(GetKeyState("Shift", "P"))
			KeyWait, Shift
		
		if(GetKeyState("LWin", "P"))
			KeyWait, RButton
		
		if(GetKeyState("RWin", "P"))
			KeyWait, RWin
		
		if(GetKeyState("LButton", "P"))
			KeyWait, LButton
		
		if(GetKeyState("RButton", "P"))
			KeyWait, RButton
	}
	
	
	global g_lineNumberFeedback
	g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
	
	
	activeTitleOLD:=activeTitle
	activeClassOLD:=activeClass
	DetectHiddenText,Off
	WinGetActiveTitle, activeTitleREAL ; never manipulated name. 12.08.2017 00:10
	activeTitle := activeTitleREAL ; this will manipulated and reused in many other files and includes 12.08.2017 00:11

	WinGetClass, activeClass, % activeTitle
	activeTitle := RegExReplace(activeTitle, Chr(37) . ".*", "_") ; should be easy to include variable later. some websites have suche long title with the procent in it. dont like it. simplify it. 16.03.2017 18:39

	if(activeTitleREAL && !activeTitle ){
        tooltip, % "ups???? activeTitle is EMPTY. But activeTitleREAL is valid.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		WinWaitNotActive, % activeTitleREAL
		; WinWaitNotActive, % activeTitleREAL
    }
	activeClass := activeClassManipulation(activeClass, activeTitle)
	g_tooltipText =
	filterFileName := "ActionListNameFilter.inc.ahk"
    ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	ActionListFilterPathNEWdir := ActionListDirBase . "\" . ActiveClass . "\"
	ActionListFilterPathNEW := ActionListFilterPathNEWdir . filterFileName
	if( !fileExist(ActionListFilterPathNEWdir) ){
		ActiveClass := "_globalActionListsGenerated"
                ; activeTitle := "_global" ; used till 07.10.2018 10:12 18-10-07_10-12
		activeTitle := "isNotAProject" ; isNotAProject.ahk ; todo: not very pretty silly. 28.10.2018 11:33

		msg = !fileExist(ActionListFilterPathNEWdir === >%ActionListFilterPathNEWdir%<)  `n '%activeTitle%'=activeTitle , '%activeClass%' = activeClass
		lineFileName := RegExReplace(A_LineFile, ".*\\([\w\s\.]+)$", "$1")
		lineFileNameWithoutPATHandEXT := RegExReplace(A_LineFile, ".*\\([\w\s\._]+)\.\w+$", "$1")

		tip=%msg% (%lineFileNameWithoutPATHandEXT%~%A_LineNumber%)
		
		if(InStr(A_ComputerName,"SL5"))
			ToolTip2sec(tip,-1,-40)
                sleep,1500 ; if this is the case slow down ths script a little bit. temporaily
            ; msg=:-O WinExist temp.ahk `n `n %A_LineFile%~%A_LineNumber% ==> continue
            ;feedbackMsgBox("Oops. so lets use global.`n ",msg,1,1) ;
		
		
                ;global g_doSaveLogFiles
                ;g_doSaveLogFiles := true
                ;
                ;lll( A_LineNumber, A_ScriptName, msg . "`n 17-07-29_14-18 ")
		
                ; impotend!!
                ; this line has to be includet into the this global:
                ; create own project dir or this|rr||ahk|WinGetClass,activeClass, A `n activeClass := RegExReplace( activeClass, "[\W_]+", "") `n d1 = %A_ScriptDir%\..\ActionLists\%activeClass% `n  FileCreateDir, %d1% `n run, %d1%
	}else{
        ; ; if(!fileExist(ActionListFilterPathNEW)
        ; dont nee to do anything here. i filter is not inside it will be automatically fixed some lines later :) 09.08.2017 19:59 17-08-09_19-59
        ; so dont be worry about it :) 09.08.2017 19:59 17-08-09_19-59
	}
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
    ;/¯¯¯¯ missionCompleted ¯¯ 181024170958 ¯¯ 24.10.2018 17:09:58 ¯¯\
    ; inside while(true)
	SetTitleMatchMode,1
	temp :="created token=17-08-10_16-17" ; ahk_class #32770"
	if(RegExMatch(activeTitle, temp )){
		
        ;/¯¯¯¯ try_faster_reload_if_created ¯¯ 181025152605 ¯¯ 25.10.2018 15:26:05 ¯¯\
        ; success. that seems working nice. takes about 2 seconds 25.10.2018 15:35
        ; I hope the with this method is reloaded after creating a new list (much faster). 25.10.2018 15:25
		run,Typing_Aid_everywhere_multi_clone.ahk
        ;\____ try_faster_reload_if_created __ 181025153223 __ 25.10.2018 15:32:23 __/
		
		WinClose, % temp
        ; msgbox,closed ???
        ; box has mission completed. it just changed a short time the ActionList. thats all 13.05.2018 19:01
		
                             ; created_token_17-08-10_16-17
        ;tooltip, WinWaitNotActive,ActionListChangedInRegistry  `n (%A_LineFile%~%A_LineNumber%)
		WinWaitNotActive, % temp
		tooltip,
		msg:="mission completed. your menu should change. `n use it in seconds (__ ...)" ; thats all 13.05.2018 19:01
		msg.= "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		
		MsgBox , 64 , mission completed, % msg, 3 ; project created
		continue ;
	}
    ;\____ missionCompleted __ 181024170947 __ 24.10.2018 17:09:47 __/
	
	
	if(RegExMatch(activeTitle,"^\d:.+")){
      ;Clipboard:=activeClass
		tip= %activeTitle% ==> continue `n 17.02.2018 22:03 `n (%A_LineFile%~%A_LineNumber%)
       ; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
    ;Msgbox,`n (%A_LineFile%~%A_LineNumber%)
		continue
	}
	if(RegExMatch(activeTitle,"ActionListChangedInRegistry")){
        ;tooltip, WinWaitNotActive,ActionListChangedInRegistry  `n (%A_LineFile%~%A_LineNumber%)
		WinWaitNotActive,ActionListChangedInRegistry ahk_class AutoHotkeyGUI
		tooltip,
		sleep,500
		continue ;
	}
	if(false && RegExMatch(activeTitle,"Selected Tab")){
        ;msgbox, %activeTitle% `n = activeTitle ==> continue (%A_LineFile%~%A_LineNumber%)
        ;tooltip, WinWaitNotActive,ActionListChangedInRegistry  `n (%A_LineFile%~%A_LineNumber%)
		WinWaitNotActive,Selected Tab
		tooltip,
		continue ;
	}
	
	
	
	if(activeTitleOLD == activeTitle && activeClassOLD == activeClass ){
        ; WinWaitNotActive, %activeTitle% ahk_class %activeClass%
		if(0){
			tip=WinWaitNotActive %activeTitleREAL%`n (%A_LineFile%~%A_LineNumber%)
			ToolTip4sec(tip)
			WinWaitNotActive, %activeTitleREAL%
		}
        ; Sleep, 1000 ; 1 Sekunde
		continue
		FormatTime, timestampHHmmss, %A_now%,HH:mm:ss
		global g_doSaveLogFiles
		
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,regEx . " end of while(true)`n '" . activeTitle . "' = activeTitle `n  time:" . timestampHHmmss)
		Msgbox,%activeTitle% `n`n %activeClass% `n`n  (%A_LineFile%~%A_LineNumber%)
		
;ExitApp
	}
	
	
	ActionListOLD := ActionListNEW
	ActionListDir := ActionListDirBase . "\" . activeClass
	ActionListFilterPath := ActionListDirBase . "\" . filterFileName
	
    ;<<<<<<<<<<<<<<<<< run createIfFileNotExist_ActionListNameFilter_InNewDir <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ;<<<<<<<<<<<<<< createIfFileNotExist_ActionListNameFilter_InNewDir <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ; make sure we get no errors by including %ActionListFilterPath% ... create ActionList inside className folder
	ActionListFilterPathNEW := ActionListDirBase . "\" . ActiveClass . "\" . filterFileName
	ahkCode1 := getAhkCodeInsideFile(ActionListDir , ActionListFilterPathNEW  )
	
	if(0 && InStr(A_ComputerName,"SL5")){
		msg = createIfFileNotExist_ActionListNameFilter_InNewDir( %ActionListDir% , %ActionListFilterPathNEW% ...)
    ; msgBox,% "" msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		ToolTip5sec(msg . " `n`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  )
	}
    ; todo: creating always is useless. please create only if user want create a ActionList explizit
    ; may only do it if _create_own_project.flag is inside....
	fileAddress := ActionListDir "\_create_own_project.flag"
	if(FileExist(fileAddress) && !InStr(FileExist(fileAddress), "D"))
		createIfFileNotExist_ActionListNameFilter_InNewDir(       ActionListDir , ActionListFilterPathNEW , ahkCode1, isInternMsgTransportIsClipboard)
	
	if(debugIt) {
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
		ahkCode2 := getAhkCodeInsideFile(ActionListDirBase . "\FunnyWidgetHuHu" , ActionListDirBase . "\FunnyWidgetHuHu\" . filterFileName  )
		createIfFileNotExist_ActionListNameFilter_InNewDir(ActionListDirBase . "\FunnyWidgetHuHu" , ActionListDirBase . "\FunnyWidgetHuHu\" . filterFileName, ahkCode2, isInternMsgTransportIsClipboard) ; FunnyWidgetHuHu
		if(debugIt)
			MsgBox, '%ahkCode2%' = ahkCode2  `n (line:%A_LineNumber%) `n
		
	}
    ;>>>>>>>>>>>>>>>>> run createIfFileNotExist_ActionListNameFilter_InNewDir >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ;>>>>>>>>>>>>>> createIfFileNotExist_ActionListNameFilter_InNewDir >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	ActionListNEW := activeTitle

    if(!ActionListNEW){
        ;msgbox, % "ERROR activeTitle is EMPTY.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		ActiveClass := "_globalActionListsGenerated"
        ; activeTitle := "_global" ; used till 07.10.2018 10:12 18-10-07_10-12
		ActionListNEW := "isNotAProject" ; isNotAProject.ahk ; todo: not very pretty silly. 28.10.2018 11:33
    }

	if(!ActionListNEW := simplifyNameOfActionListNEWstep1( ActionListNEW ))
	    msgbox,% "ERROR !ActionListNEW (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"

    if(!ActionListNEW)
        msgbox, % "ERROR ActionListNEW is EMPTY.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    ActionListNEW = %ActionListNEW%
    if(!ActionListNEW)
        msgbox, % "ERROR ActionListNEW is EMPTY.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"


;    lll(A_LineNumber, A_LineFile,"ActionListDirBase= " . ActionListDirBase)
;    MsgBox, '%ActionListFilterPath%' = ActionListFilterPath  `n '%ActionListDir%' = ActionListDir `n '%ActionListDirBase%' = ActionListDirBase `n '%A_ScriptDir%' = A_ScriptDir `n (line:%A_LineNumber%) `n      ; thats the global wordlost
	ActionListFilterPath := ActionListDirBase . "\" . filterFileName
	if(1){ ; absolute path
		ActionListFilterPath2 := ActionListDir . "\" . filterFileName
		ActionListFilterPath2Abs := A_ScriptDir . "\" . ActionListFilterPath2
		StringReplace, ActionListFilterPath2Abs, ActionListFilterPath2Abs, \.\ , \
	}else
		ActionListFilterPath2 :=  ActionListDirBase . activeClass . "\" . filterFileName ; todo: doesent work :( 28.03.2017 20:20 17-03-28_20-20
	
; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"ActionListFilterPath2=" . ActionListFilterPath2 . " activeClass=" . activeClass . " filterFileName=" . filterFileName)
	
	if(!ActionListDir) {
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
		msgbox,!ActionListDir exitap (line:`%A_LineNumber`%) `n 17-03-19_14-06
		exitapp
	}
	if(!ActionListNEW)
		if(!activeTitle)
			ActionListNEW=noTitle
	else {
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
		m=!ActionListNEW `n '%activeTitle%' = activeTitle  `n  '%activeClass%' = activeClass `n'%ActionListDir%' = ActionListDir `n==> return (line:`%A_LineNumber`%) `n 17-03-19_14-09
		g_tooltipText:=m
		Msgbox,%m%`n (from: %A_LineFile%~%A_LineNumber%) 17-08-11_23-42
           ; ToolTip5sec(m . " `n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
            ; return ; we are inside a while loop ;) return probably makes now since there ;) 24.03.2017 20:29 17-03-24_20-29
		
		sleepMili := 1000
		msg =
(
no ActionListNEW and no activeTitle
we are inside a while loop

Sleep,%sleepMili%
if(activeTitleREAL){
tooltip, `% "Wait" A_LineNumber " " RegExReplace(A_LineFile,".*\")
    WinWaitNotActive, %activeTitleREAL%,,15
    }
continue
17-07-29_14-29
)
		global g_doSaveLogFiles
		
		lll( A_LineNumber, A_ScriptName, msg . "`n 17-07-29_14-18 ")
		
		Sleep,%sleepMili%
if(activeTitleREAL)
		WinWaitNotActive, % activeTitleREAL,,15
		continue
	}
	if(false && !activeTitle) {
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
		msgbox,!activeTitle exitap (line:`%A_LineNumber`%) `n 17-03-19_14-19
		exitapp
	}

	if(!activeClass) {
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
		; msgbox,!activeClass exitap (line: %A_LineNumber% > `%A_LineNumber`%) `n 17-03-19_14-15
		tooltip,!activeClass (line: %A_LineNumber% `%A_LineNumber`%) `n 17-03-19_14-15
		sleep,1703
		reload
	}

	;

;<<<<<<<<<<<<< demoData =  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	activeTitle := RegExReplace(activeTitle, "m)\n.*", "") ; title should never is multioline. this proof is hoprefulle redundatnd. 15.02.2018
	ActionListOLD := RegExReplace(ActionListOLD, "m)\n.*", "") ; never is multioline. this proof is hoprefulle redundatnd. 15.02.2018
	demoData =
(
SetTitleMatchMode, 1
activeTitle := RegExReplace`(activeTitle, Chr`(37`) . ".*", ""`) ; delete prozent. should be easy to include variable later. some websites have suche long title with the procent in it. dont like it. simplify it. 16.03.2017
global g_lineNumberFeedback
g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
ActionListDir = %ActionListDir%
activeTitle = %activeTitle%
activeClass = %activeClass%
ActionListNEW = %activeTitle%
)
;>>>>>>>>>>>>>>>  demoData =  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	
	
	ahkSource := ";" . "this file was generated by " . A_ScriptName  . " `n"
	ahkSource .= "g_lineNumberFeedback=" . A_ScriptName . "~" . A_ThisFunc . "~" . A_LineNumber . " token363 `n"
	ahkSource .= "#" . "SingleInstance, force"  . " `n"
	ahkSource .= "#" . "NoTrayIcon" . " `n"
	global g_doSaveLogFiles
	global g_doRunLogFiles
    ;global g_doSaveLogFiles := true
    ;g_doRunLogFiles := false
	
	ahkSource .= "global g_doSaveLogFiles" . " `n"
	ahkSource .= "global g_doRunLogFiles" . " `n"
	
	ahkSource .= "g_doSaveLogFiles := " . g_doSaveLogFiles . " `n"
	ahkSource .= "g_doRunLogFiles := " . g_doRunLogFiles . " `n"
	
	
	ahkSource .= demoData  . " `n"
    ; ahkSource .= "#" . "Include, " . ActionListFilterPath . "  `; thats the subfolder  wordlost inside class `n"
	
	
	ahkSource .= "ActionListFilterPath2 = " . ActionListFilterPath2 . " `n"
	ahkSource .= "ActionListFilterPath2Abs = " . ActionListFilterPath2Abs . " `n"
	ahkSource .= "fileEx := FileExist ( ActionListFilterPath2Abs ) `n"
        ; ahkSource .= "KeyWait Control  `; Wartet darauf, dass sowohl STRG als auch ALT losgelassen wird. `n"
	ahkSource .= "if( !fileEx ) { `n"
	ahkSource .= "message = :(  ``n '%ActionListFilterPath2%'  ``n '%ActionListFilterPath2Abs%'  ``n existiert nicht ( `%fileEx%` = fileEx ) . ``n ``n message with id (1704171514) was copied to the Clipboard. Sor you probably could find this source code little bit easier. ``n (from: %A_LineFile%~%A_LineNumber%) `n "
	ahkSource .= "tooltip, `%message`% , 1,1 `n "
	
	; ahkSource .= "Clipboard = `%message`%  `n "
	; ahkSource .= "Msgbox,4 , :( ActionListNameFilter.inc.ahk not found , `%message`% , 4  `n "
	; ahkSource .= "tooltip,:( ActionListNameFilter.inc.ahk not found : `%message`% , 1,1  `n "

	ahkSource .= "Sleep, 4000 `n"
	ahkSource .= "ExitApp  `n"
	ahkSource .= "} `n"
	ahkSource .= "#" . "Include *i " . ActionListFilterPath2Abs . "  `; thats the subfolder  wordlost inside class `n"
 ;   ahkSource .= "#" . "Include *i " . ActionListFilterPath2 . "  `; thats the subfolder  wordlost inside class `n" 


    if(!ActionListNEW){
        global g_lineNumberFeedback
        g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

        tooltip,exitapp !ActionListNEW exitap (%g_lineNumberFeedback%) `n
        msgbox,exitapp !ActionListNEW exitap (%g_lineNumberFeedback%) `n 111222111
        sleep,8888
        exitapp
    }


	ahkSource .= "varInjects1 := mvarInjects(ActionListDir, ActionListNEW, activeClass, activeTitle) `n"
    ; ahkSource .= "ActionListDir = " . ActionListDir  . " `n"
	ahkSource .= "ActionListOLD = " ActionListOLD  " `n"
	ahkSource .= "gi_everywhereSourcePath = "  gi_everywhereSourcePath  " `n"
	ahkSource .= "ActionListActive  = "  ActionListActive   " `n"
	temp =
(
TargetScriptTitle = gi-everywhere - Active ahk_class AutoHotkey
stringToSend := (InStr(ActionListNEW,"\")) ? ActionListNEW : ActionListDir . "\" . ActionListNEW
; result := Send_WM_COPYDATA`(stringToSend, TargetScriptTitle`)
if(false){  ; temporaly deactivated . for compatibiliti thinks 02.03.2018 17:10
    try{
        y := ComObjActive("{93C04B39-0465-4460-8CA0-7BFFF481FF98}")
        y.callFunction( "Receive_ActionListAddress", stringToSend ) ;will call the function of the other script
    } catch e{
        tip:="Exception:``n" e.What "``n" e.Message "``n" e.File "@" e.Line
        tooltip, `% tip
}}
if(true){  ; old scool. for compatibiliti thinks 02.03.2018 17:10

    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListDir, `%ActionListDir`%
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListActive, `%ActionListActive`%
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListNEW, `%ActionListNEW`%
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListNEWarchivePath, `%ActionListNEWarchivePath`%

    ActionList = `%ActionListDir`%\`%ActionListNEW`%

    ActionList := removesSymbolicLinksFromFileAdress(ActionList)

    if( SubStr( ActionList , -3 ) <> ".ahk" ) ; 07.11.2018 22:05
        ActionList .= ".ahk"


if(0){
    ; ActionList = `%ActionListNEWarchivePath`% ; its not existing here 03.03.2018 19:13
    ; msgbox,`%ActionListNEWarchivePath`%
    pLength := 0
    while(pLength <> StrLen(ActionList )){
        ; tooltip,`% A_index . "# Line:" . A_LineNumber . " Name:" . A_ScriptName . " "
        pLength := StrLen(ActionList )
        ActionList := RegExReplace(ActionList ,"(\\[^\\]+\\\.\.)+") ; works. removes all symbolic links 24.02.2018  cleanPath
    }
    ActionList := RegExReplace(ActionList,"\\\.\\")  ; works. removes all symbolic link 24.02.2018 cleanPath
    ActionList := RegExReplace(ActionList,"^\.\\")  ; works. removes all symbolic link 24.02.2018  cleanPath
}
    ;msgbox,`% ActionList
    FileRead, fileContent, `% ActionList
    ; StringReplace, fileContent, fileContent, ..\ActionLists, .. \
    l1 := StrLen(fileContent)
    fileContent := StrReplace(fileContent, "..\ActionLists\", "..\" ) ; https://ahkde.github.io/docs/commands/StringReplace.htm
l2 := StrLen(fileContent)
if(1 && l1 > l2){ ; proof it test it
    FileSave(fileContent, ActionList )
    if(1 && InStr(A_ComputerName,"SL5"))
        msgbox,`% ActionList " 12is saved (l1 > l2) (%A_LineFile%~%A_LineNumber%) (" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ") ---- " fileContent
    tooltip,`% ActionList " 12is saved (l1 > l2) (%A_LineFile%~%A_LineNumber%) (" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ") ---- " fileContent
}

if(1){
    ; dirty bug fix ._Generated.txt 04.03.2018 10:44

    postFixGenerated := "._Generated.ahk"
    ActionListPostFix  := SubStr(rtrim(ActionList), - StrLen(postFixGenerated) + 1 ) ; That works I've tested it 01.11.2018 14:59
    itsAGeneratedList := ( postFixGenerated == ActionListPostFix )

    If(!itsAGeneratedList && !FileExist( ActionList "._Generated.ahk")) ; dirty bugFix TODO: prettyFy it
    {
      ActionList .= "._Generated.ahk" ; inside the while(true)
    }
  ; msgbox, `% ActionList
}
    if(!RegExMatch(ActionList,"created_token_17-08-10_16-17")) ; todo: whey control here? wrong place. quck dirty 25.03.2018 01:36
        setRegistry_ActionList( ActionList ) ; old scool. for compatibiliti thinks 02.03.2018 17:10)

    RegRead, CreatedDir, HKEY_CURRENT_USER, SOFTWARE\sl5net, CreatedDir
    if(CreatedDir){
        RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, CreatedDir, `% "" ; RegWrite , RegSave , Registry
        ActionListOpen := StrReplace(ActionList, "._Generated.ahk")
        openInEditorFromIntern( ActionListOpen )
    }
#Include,RegWrite181031.ahk
}
) ; endOf temp

;

	ahkSource .= "`n" temp
	
    ; following lines are debrecated
    ; ahkSource .= "ActionListOLDbackup( ActionListDir , ActionListOLD)" . " `n"
    ; ahkSource .= "ActionListOLDdisable( gi_everywhereSourcePath, ActionListActive )" . " `n"
	ahkSource .= "`n ActionListNEWactivate( ActionListDir , ActionListNEW, ActionListActive, gi_everywhereSourcePath, activeClass , activeTitle)" . " `n"
	
	ahkSource .= "varInjects2 := mvarInjects(ActionListDir, ActionListNEW, activeClass, activeTitle) `n"
	if(debugIt)
		ahkSource .= "MsgBox, , debugIt , `% varInjects1 . "" ``n "" . varInjects2 . "" ``n ActionListNEW = '"" . ActionListNEW . ""'  ``n (lineCaller:" . A_LineNumber . ") ``n "" ,9 `n"
	ahkSource .= "ExitApp" . " `n"
	ahkSource .= "#" . "Include, inc_ahk\\Typing_Aid_everywhere_multi_clone.inc.ahk  `; `n"
    ; createGLOBALActionListNameFilterIfNotExist(ActionListDirBase ) ;  its possible to put it out of the loop, but if user delete it we get ugly errors. better gife a chance to ceate it imediatly again 06.03.2017 19:19
    ; ActionListNEW := getActionListNEWfromPluginIfExist(ActionListDir, ActionListNEW, activeClass, activeTitle   ) ; ; thats plugin. you could filter, reduce the complexety of new file names
    ; ToolTip4sec(ActionListNEW . "= ActionListNEW `n " . A_LineNumber ) ;
    ; MsgBox, '%ActionListNEW%' = ActionListNEW  `n (line:%A_LineNumber%) `n
	DetectHiddenWindows,On
	SetTitleMatchMode,1
    ; IfWinNotExist,temp.ahk
    ; IfNotExist,temp.ahk
;~     Tooltip, %ahkSource% `n (from: %A_LineFile%~%A_LineNumber%)
;~     Msgbox,`n (from: %A_LineFile%~%A_LineNumber%)
	
	if(GetKeyState("ctrl", "P"))
		KeyWait, ctrl
	if(GetKeyState("Alt", "P"))
		KeyWait, Alt
	
	IfWinNotExist,temp.ahk
	{
		FileWriteAndRun( ahkSource , "temp.ahk" ) ; TODO: wozu ? 13.08.2017 10:52
        ; DynaRun(ahkSource) ; this line prducing erros. if u use FileWriteAndRun it works.
	} else {
		Tooltip, WinWaitClose   temp.ahk `n (from: %A_LineFile%~%A_LineNumber%)
		WinWaitClose,temp.ahk,,5
		Tooltip,
		IfWinExist,temp.ahk
		{
			msg=:-O WinExist temp.ahk `n `n %A_LineFile%~%A_LineNumber% ==> continue
            SetTitleMatchMode,2
            if !WinExist("Oops ", msg)
			    feedbackMsgBox("Oops ",msg,1,1)
			sleep,5000
			continue
		}
	}
    ; FileDeleteAsyncDynaRun(A_WorkingDir . "\temp.ahk" , 500)
	Sleep,40 ; you need to use it minimum of 3 seconds
	
    ; lll("`n" . A_LineNumber, A_ScriptName, "FileDeleteAsyncDynaRun(temp.ahk , 4000)")
	
	g_tooltipText = WaitNotActive %activeTitle%
    ; WinWaitNotActive [, WinTitle, WinText, Seconds, ExcludeTitle, ExcludeText]
	g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
	
	DetectHiddenText,Off
    ; WinWaitNotActive, ahk_class %activeClass%
	
	global g_nextCriticalCommandString ; checkCriticalCommand()
	g_nextCriticalCommandString := "327:WinWaitNotActive, %activeTitle%" ; checkCriticalCommand()
	
	SetTimer, checkCriticalCommandLbl, On
	WinWaitNotActive, %activeTitle%
	SetTimer, checkCriticalCommandLbl, Off
	
	g_nextCriticalCommandString := ""
	
	
    ; WinWaitNotActive, %activeTitle% ahk_class %activeClass% ; seems not work alway. be careful !! with that :( 29.04.2017 22:13
;    WinWaitNotActive, %activeTitle% %activeClass%
	g_tooltipText = WinWaitNotActive CopyQ
	g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
	
	WinWaitNotActive,CopyQ , , 9
	g_tooltipText = WinWaitNotActive - Everything
	g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
	
	WinWaitNotActive,- Everything , , 9 ; ahk_class EVERYTHING
	
	if( debugIt || 0) {
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
		l = ______________________________________________________________ `n ; %l%
		MsgBox, '%activeTitle%' = activeTitle  `n %l% '%varInjects%' = varInjects  %l% `n (line:%A_LineNumber%) `n  '%ahkSource%' = ahkSource of temp.php `n (line:%A_LineNumber%) `n
	}
	
	rungi_everywhereAHKifNotExist( gi_everywhereAHK )
	
	if(false){
		FormatTime, timestampHHmmss, %A_now%,HH:mm:ss
		global g_doSaveLogFiles
		
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,regEx . " end of while(true)`n '" . activeTitle . "' = activeTitle `n  time:" . timestampHHmmss)
	}
} ; end of while(true)
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;\____ while __ 181023091702 __ 23.10.2018 09:17:02 __/




return  ; probably redundant. its more secure if we do that.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
createGLOBALActionListNameFilterIfNotExist(ActionListDirBase ) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
   isDebuggingOverWriteAlwayUserUpdatesWithThisScript := false
   filterFileName := "ActionListNameFilter.inc.ahk"
 ActionListFilterPath := ActionListDirBase . "\" . filterFileName 
 if( isDebuggingOverWriteAlwayUserUpdatesWithThisScript ) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
   FormatTime, timestamp, %A_now%,yy-MM-dd_HH-mm
    ActionListFilterPathBackup := ActionListDirBase . "\" . timestamp . "_" . filterFileName 


lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,ActionListFilterPath " FileCopy too " ActionListFilterPathBackup)
   FileCopy, % ActionListFilterPath, % ActionListFilterPathBackup
   FileDelete, % ActionListFilterPath
   Sleep,100
} 
 if(!fileExist(ActionListFilterPath)) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
; the following gives no errors

ahkCodeInsideFile =
(
`; GLOBAL FILTER / ROUTING
`; this file was generated %A_Now% by: `n`;  %A_ScriptFullPath% 
`; if you want you could update it by yourself. it will not overwritten by %A_LineFile% 
`; if you delete it it will be generated again.
`; you could use it as a global filter/routing called from your special .../className/%filterFileName%

#SingleInstance, force
`; if you want you could use the follwong global variables fot calculating you new ActionListNEW : ActionListDir, ActionListNEW, activeClass, activeTitle  

if`(A_ScriptName == "ActionListNameFilter.inc.ahk" `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%  ; thats developer mode. this script is not includet. 08.03.2017 09:14
activeClass := "ChromeWidgetWin1" 
activeTitle  = I would like to hire a PHP Developer | Codeigniter | CSS | HTML5 | JSON | PHP - Google Chrome 
activeTitle := ActionListNEW
}


if `(!ActionListNEW `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
    m = ERROR ActionListNEW is EMPTY: ``n ``n '`%ActionListNEW`%' = ActionListNEW  ``n   17-03-05_14-51 ``n ``n '%ActionListFilterPath%' = ActionListFilterPath  ``n `(line:`%A_LineNumber`%`) ``n `%A_ScriptFullPath`% = A_ScriptFullPath   `(line: `%A_LineNumber`%` token50)
   Clipboard := m
    tooltip, ERRORmessage is copied to the >>Clipboard<< `%m`% 
    sleep,5000
    MsgBox, ERRORmessage is copied to the >>Clipboard<< , `%m`% , 7
    exitapp
 } 
if `(!ActionListDir `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
    tooltip, ERROR ActionListDir is EMPTY 17-03-19_11-52
    exitapp
}
;
 if`(activeClass == "SciTEWindow" `) 
   ActionListNEW := "_global"
   else if `( instr`( activeTitle , ".ahk"`)  `) 
      ActionListNEW := "..\SciTEWindow\_global"
 
 else if `( activeClass == "ChromeWidgetWin1" `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
   
`;   I would like to hire a PHP Developer | Codeigniter | CSS | HTML5 | JSON | PHP - Google Chrome ahk_class Chrome_WidgetWin_1 
   
 if `( instr`( activeTitle , "Benachrichtigung:"`)  &&  RegExMatch`( activeTitle , "Gmail"`)   `) 
      ActionListNEW := "Benachrichtigung_Google_Chrome"
   
 else if `(  RegExMatch`( activeTitle , "\bGmail\b"`) `) 
      ActionListNEW := "Gmail_Google_Chrome"
    
   else if `( RegExMatch`( activeTitle , "`(Messenger|facebook`)"  `)    `)    
      ActionListNEW := "Facebook_Google_Chrome"

   else if `( RegExMatch`( activeTitle , "i`)`(Zimmer|Wohnung`)"  `)    `)    
      ActionListNEW := "Zimmer_Wohnung_Google_Chrome"

   else if `( ! RegExMatch`( activeTitle , "`(Threema Web`)"  `)    `)    
      ActionListNEW :=
   } else
 {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
 ActionListNEW := RegExReplace`( ActionListNEW, "`(SciTE4AutoHotkey|PhpStorm`)\.+" , ""`)  
 }
ActionListNEW := RegExReplace`( ActionListNEW, ".`(ahk|txt|htm|pdf`)\.+" , ""`)  
 ActionListNEW := RegExReplace`( ActionListNEW, "i`)[^\w\d_-]+" , "_"`)  
 ActionListNEW := RegExReplace`( ActionListNEW, "[_-]{2,}" , "_"`)  
 ActionListNEW := RegExReplace`( ActionListNEW, "^[_-]+" , ""`)  
 ActionListNEW := RegExReplace`( ActionListNEW, "[_-]+$" , ""`)  

 if`( SubStr`( ActionListNEW , -3 `) <> ".ahk" `)
   ActionListNEW .= ".ahk"
 
`; Clipboard := ActionListNEW `;  we dont transport usually inside this global file via clipboard 06.03.2017 19:41

`;  MsgBox,  '`%ActionListNEW`%' = ActionListNEW  ``n  17-03-06_18-48 ``n ``n `( line: `%A_LineNumber`%`) 


if`(A_ScriptName == "ActionListNameFilter.inc.ahk" `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%   ; thats developer mode. this script is not includet. 08.03.2017 09:14
; Clipboard := ActionListNEW ;  we dont transport usually inside this global file via clipboard 06.03.2017 19:41
 MsgBox,  '`%ActionListNEW`%' = ActionListNEW  ``n `%activeClass`% = activeClass ``n  17-03-06_18-48 ``n ``n `( line: `%A_LineNumber`%`)
}
)
 ; MsgBox, % RegExReplace( " -- - -___ _ _ _ __", "[_\s]{2,}" , "_"`)  
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"FileAppend too " ActionListFilterPath)
;msgbox, % ActionListFilterPath " asdf77778"
tooltip,% "FileAppend (" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\") ")"
if(1 && InStr(A_ComputerName,"SL5") )
 RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
FileAppend,  % ahkCodeInsideFile , % ActionListFilterPath ; ActionListNameFilter.inc.ahk
} 
return 
}





;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
getActionListNEWfromPluginIfExist(ActionListDir, ActionListNEW, activeClass, activeTitle   ) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
   m = '%ActionListNEW%' = ActionListNEW  `n '%ActionListDir%' = ActionListDir  `n  '%activeTitle%' = activeTitle  `n 
global g_doSaveLogFiles

lll(A_LineNumber, RegExReplace(A_LineFile,".*\\") ,m)

   lineB := "<<<<<<<<<<<<<<<<<<<<<<`n"
   lineE := ";>>>>>>>>>>>>>>>>>>>>>>`n"

 ActionListFilterPath := ActionListDir . "\ActionListNameFilter.inc.ahk"
 if(!fileExist(ActionListFilterPath)) {
   ahkCodeInsideFile := getAhkCodeInsideFile(ActionListDir, ActionListFilterPath )
tooltip,% "FileAppend (" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\") ")"
		    if(1 && InStr(A_ComputerName,"SL5") )
   RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
FileAppend,  % ahkCodeInsideFile , % ActionListFilterPath ; ActionListNameFilter.inc.ahk

lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"FileAppend too " ActionListFilterPath)
   if(!FileExist(ActionListFilterPath))
      MsgBox, :-( `n !FileExist(ActionListFilterPath)) `n  (line:%A_LineNumber%)  '%ActionListFilterPath%' = ActionListFilterPath  `n (line:%A_LineNumber%) `n 
} else
   FileRead, ahkCodeInsideFile, % ActionListFilterPath
; ahkCode := encodeAHKchars(ahkCode)
varInjects := mvarInjects(ActionListDir, ActionListNEW, activeClass, activeTitle)
ahkCode := RegExReplace( ahkCodeInsideFile , "`;\s*dontDeleteThisPlaceholder" , varInjects )  ; dontDeleteThisPlaceholder is definde since 17-03-06_10-25 inside the global filter

 ClipboardBackup = 17-03-05_17-17
 ; ClipboardBackup = %Clipboard% ; old destrois eventually bin clipboards
 ClipboardBackup := ClipboardAll
 if(ClipboardBackup  == "17-03-05_17-17")
   MsgBox, :(  (line:%A_LineNumber%)  17-04-02_14-52
   
   m = '%ActionListNEW%' = ActionListNEW  `n '%activeTitle%' = activeTitle  `n 
global g_doSaveLogFiles

lll(A_LineNumber, RegExReplace(A_LineFile,".*\\") , "`n" . m)
if(!ActionListNEW := DynaRunGetClipboard(ahkCode))
    msgbox,% "ERROR !ActionListNEW (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"

   m = '%ActionListNEW%' = ActionListNEW  `n '%activeTitle%' = activeTitle  `n 
global g_doSaveLogFiles

lll(A_LineNumber, RegExReplace(A_LineFile,".*\\") , "`n" . m)

worlistExtension := SubStr(ActionListNEW, -3)
if( worlistExtension  <> ".ahk" ) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
   m = '%ActionListNEW%' = ActionListNEW  `n 
      ToolTip5sec(A_LineNumber . "THATS VERY QUICK AND DIRTY AND MAYBEEEE IT HALPS NOT!!!! " . RegExReplace(A_LineFile,".*\\")  . " " . m) ;
; return,  "superSimple.txt"
      ; ################################################
      ; ################################################
      ; ################################################
      ; ################################################

   ClipboardBackup1703052115 = %Clipboard%
   ;~ clipboard := ActionListFilterPath
   disableCopyQ() ; enableCopyQ() ;
   clipboard := varInjects
   
   msg = a bug in your  `n %ActionListFilterPath%  `n this path is now copied to your Clipboard (line:%A_LineNumber%) `n ? `n '%ClipboardBackup%' = ClipboardBackup  `n 
   if( ClipboardBackup == ActionListNEW)
      m2 = ClipboardBackup == ActionListNEW == '%ActionListNEW%'  <=== thats bad :-( `n 
   m3 := " StrLen(ActionListNEW)=" . StrLen(ActionListNEW) . "`n"
   MsgBox, :-( ERROR: (line:%A_LineNumber%)  `n%m2% %m3% worlistExtension != .ahk ='%worlistExtension%' `n ActionListNEW='%ActionListNEW%'   `n`ncode=`n %lineB%%ahkCode% `n%lineE%  `n  %msg% `n (line:%A_LineNumber%)
   Clipboard = %ClipboardBackup1703052115%
   enableCopyQ() ; enableCopyQ() ;
}

if(false)
Loop,20
 {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
Clipboard = %ClipboardBackup%
cExtension := SubStr(Clipboard, -3)
if( worlistExtension  <> ".ahk" )
   break
if( Clipboard == ClipboardBackup )
   break
Sleep,50
}



; Clipboard := ActionListFilterPath
; MsgBox, '%ahkCode%' = ahkCode  `n  `n '%ahkCodeInsideFile%' = ahkCodeInsideFile  `n  `n  '%ActionListNEW%' = ActionListNEW  `n (line:%A_LineNumber%) `n 
; MsgBox, '%ahkCode%' = ahkCode  `n  `n '%ahkCodeInsideFile%' = ahkCodeInsideFile  `n  `n  '%ActionListNEW%' = ActionListNEW  `n (line:%A_LineNumber%) `n 
;~ ToolTip, %ahkCode% , 10,10
;~ Sleep,1000
return ActionListNEW
}



;/¯¯¯¯ createIfFileNotExist_ActionListNameFilter_InNewDir ¯¯ 181023081846 ¯¯ 23.10.2018 08:18:46 ¯¯\
createIfFileNotExist_ActionListNameFilter_InNewDir(ActionListDir, ActionListFilterPath,ahkCode, isInternMsgTransportIsClipboard){
    global g_lineNumberFeedback
    if(FileExist( ActionListFilterPath ) )
        return true
    g_lineNumberFeedback  := "(" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\") ")"
    if(!FileExist(ActionListDir)){
        global g_lineNumberFeedback
        g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
        FileCreateDir, % ActionListDir
        ;~ FileAppend, , % ActionListFilterPath
    }
    g_lineNumberFeedback  := "(" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\") ")"
    if(1 && InStr(A_ComputerName,"SL5"))
        tooltip,% "FileAppend " g_lineNumberFeedback
        		    if(1 && InStr(A_ComputerName,"SL5") )
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
FileAppend, % ahkCode , % ActionListFilterPath
return true
}
;\____ createIfFileNotExist_ActionListNameFilter_InNewDir __ 181023081850 __ 23.10.2018 08:18:50 __/



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<




tooltipABS:
; IfGreater, A_TimeIdle, 300000, Reload  ; MsgBox, The last keyboard or mouse activity was at least 5 minutes ago.
;    Reload ; todo: quick and dirty ... script sometimes hangs 22.03.2017 11:42 17-03-22_11-42
; IfGreater, A_TimeIdle, 600000, MsgBox, The last keyboard or mouse activity was at least 10 minutes ago.
if(!do_g_tooltipText)
    return
    if(!g_tooltipText)
      Return
    if(dog_lineNumberFeedback)
        tooltip, % "X " g_tooltipText "`n" g_lineNumberFeedback , 110 , 122
    else
        tooltip, % "X " . g_tooltipText , 110 , 122

    if(!Xtooltip) {
        SetTitleMatchMode, 2
;~         IfWinActive, % A_ScriptName
            WinGetPos, Xtooltip, Ytooltip, W, H, ahk_class tooltips_class32
    }
    else
        WinMove, ahk_class tooltips_class32, , % abs(Xtooltip), % abs(Ytooltip) ; thats the only chance to move tooltip to absolute sceen position.

~LButton::
 ; tooltip close by clicking
    WinGetPos, X, Y, W, H, ahk_class tooltips_class32
    MouseGetPos, mX, mY
    if (mX >= X && mX <= (X+W)) && (mY >= Y && mY <= (Y+H)){
        g_tooltipText:=
		ToolTip
    }
    return

Return

;

#IfWinActive,
; Ctrl+Shift+Pause
^+p:: ; pause
    tooltip,pause `n (from: %A_LineFile%~%A_LineNumber%)
    ; msgbox,pause `n (from: %A_LineFile%~%A_LineNumber%)
    pause
return


AbsolutePath(AbsolutPath, RelativePath, s="\") {
    ; its actually not used inside of this script 24.03.2017 05:27 ,
    return
    len := InStr(AbsolutPath, s, "", InStr(AbsolutPath, s . s) + 2) - 1   ;get server or drive string length
    pr := SubStr(AbsolutPath, 1, len)                                     ;get server or drive name
    AbsolutPath := SubStr(AbsolutPath, len + 1)                           ;remove server or drive from AbsolutPath
    If InStr(AbsolutPath, s, "", 0) = StrLen(AbsolutPath)                 ;remove last \ from AbsolutPath if any
        StringTrimRight, AbsolutPath, AbsolutPath, 1
    If InStr(RelativePath, s, "", 0) = StrLen(RelativePath)               ;remove last \ from RelativePath if any
        StringTrimRight, RelativePath, RelativePath, 1
    If InStr(RelativePath, s) = 1                                         ;when first char is \ go to AbsolutPath of server or drive
        AbsolutPath := "", RelativePath := SubStr(RelativePath, 2)            ;set AbsolutPath to nothing and remove one char from RelativePath
    Else If InStr(RelativePath,"." s) = 1                                 ;when first two chars are .\ add to current AbsolutPath directory
        RelativePath := SubStr(RelativePath, 3)                               ;remove two chars from RelativePath
    Else {                                                                ;otherwise
        StringReplace, RelativePath, RelativePath, ..%s%, , UseErrorLevel     ;remove all ..\ from RelativePath
        Loop, %ErrorLevel%                                                    ;for all ..\
            AbsolutPath := SubStr(AbsolutPath, 1, InStr(AbsolutPath, s, "", 0) - 1)  ;remove one folder from AbsolutPath
      }
    Return, pr . AbsolutPath . s . RelativePath                             ;concatenate server + AbsolutPath + separator + RelativePath
  }


  ListGlobalVars()  {
        ; its actually not used inside of this script 24.03.2017 05:27 ,
    return

      static hwndEdit, pSFW, pSW, bkpSFW, bkpSW
; https://autohotkey.com/board/topic/20925-listvars/#entry156570
      if !hwndEdit
      {
          dhw := A_DetectHiddenWindows
          DetectHiddenWindows, On
          Process, Exist
          ControlGet, hwndEdit, Hwnd,, Edit1, ahk_class AutoHotkey ahk_pid %ErrorLevel%
          DetectHiddenWindows, %dhw%

          astr := A_IsUnicode ? "astr":"str"
          ptr := A_PtrSize=8 ? "ptr":"uint"
          hmod := DllCall("GetModuleHandle", "str", "user32.dll", ptr)
          pSFW := DllCall("GetProcAddress", ptr, hmod, astr, "SetForegroundWindow", ptr)
          pSW := DllCall("GetProcAddress", ptr, hmod, astr, "ShowWindow", ptr)
          DllCall("VirtualProtect", ptr, pSFW, ptr, 8, "uint", 0x40, "uint*", 0)
          DllCall("VirtualProtect", ptr, pSW, ptr, 8, "uint", 0x40, "uint*", 0)
          bkpSFW := NumGet(pSFW+0, 0, "int64")
          bkpSW := NumGet(pSW+0, 0, "int64")
      }

      if (A_PtrSize=8) {
          NumPut(0x0000C300000001B8, pSFW+0, 0, "int64")  ; return TRUE
          NumPut(0x0000C300000001B8, pSW+0, 0, "int64")   ; return TRUE
      } else {
          NumPut(0x0004C200000001B8, pSFW+0, 0, "int64")  ; return TRUE
          NumPut(0x0008C200000001B8, pSW+0, 0, "int64")   ; return TRUE
      }

      ListVars

      NumPut(bkpSFW, pSFW+0, 0, "int64")
      NumPut(bkpSW, pSW+0, 0, "int64")

      ControlGetText, text,, ahk_id %hwndEdit%

      RegExMatch(text, "sm)(?<=^Global Variables \(alphabetical\)`r`n-{50}`r`n).*", text)
      return text
  }

checkCriticalCommandLbl:
    checkCriticalCommand()
Return

checkCriticalCommand(sec := 2 ){
;return

global g_nextCriticalCommandString
;        g_nextCriticalCommandString :="327:WinWaitNotActive, %activeTitle%" ; checkCriticalCommand()
        global g_nextCriticalCommandTimeIdle ; checkCriticalCommand() WinWaitNotActive, %activeTitle% %activeClass%

if(0){ ; check if this is arrived 30.04.2017 09:43
    Msgbox,n (%A_LineFile%~%A_LineNumber%) :-)
    ExitApp
}
    ; is this function triggerd evver onee time? i dont know if setinterval works if the script stucks. may we cant do anything then from inside the script. needs temp ahk. 30.04.2017 09:25
    global g_nextCriticalCommandString ; checkCriticalCommand()
    global g_nextCriticalCommandTimeIdle ; checkCriticalCommand()
    ; g_nextCriticalCommandString := "104:SuspendOn()"

    if(g_nextCriticalCommandString == "327:WinWaitNotActive, %activeTitle%"){
        if(!g_nextCriticalCommandTimeIdle || g_nextCriticalCommandTimeIdle < 1)
            g_nextCriticalCommandTimeIdle := A_TimeIdle
        else if (g_nextCriticalCommandTimeIdle * 1000 > sec)
        {
             global activeTitleOLD
             global activeTitle
             global activeClassOLD
             global activeClass


             if( activeTitle == activeTitleOLD && activeClass <> activeClassOLD ){
                 ; if this ever happend ? of is this function ovsolete? 30.04.2017 09:59 :D i dont knew
                 ; Msgbox, title is the same but class differs. a new ActionList shod be used. (%A_LineFile%~%A_LineNumber%)

                 if ( 0) {
                 ; yeeeaaahhh now it happens first time 30.04.2017 10:54 :)
                 ; for testing i created this code:
                     WinSetTitle,main.ts.txt - Editor,, main.ts
                     WinSetTitle,main.ts.txt - WordPad,, main.ts

lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"ExitApp")
                     ExitApp

                     happendLog =
(
ActiveClass: 32770
activeClassOLD: ChromeWidgetWin1
activeTitle: H:\download
activeTitleOLD: H:\download
)
                 }

tip =
(
activeClass: %activeClass%
activeClassOLD: %activeClassOLD%
activeTitle: %activeTitle%
activeTitleOLD: %activeTitleOLD%
 (%A_LineFile%~%A_LineNumber%)
)

lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip "reload 17-08-04_14-42")
                tooltip, =>Reload  `n  `n (%A_LineFile%~%A_LineNumber%)
CoordMode, Caret, Screen
ToolTip1sec(tip A_LineNumber " " RegExReplace(A_LineFile,".*\\") , 1 , 1 )
                 sleep,3500
                 return
             }
             if( 0 ) ; fo debugging really useful.
            tooltip,%activeTitle%`n ?= `n%activeTitleOLD% `n `n  %g_nextCriticalCommandTimeIdle% = g_nextCriticalCommandTimeIdle `n (%A_LineFile%~%A_LineNumber%)
        }
    } else
        g_nextCriticalCommandTimeIdle := 0
    return

; g_nextCriticalCommandString := "120:SuspendOn()"
; g_nextCriticalCommandTimeIdle := A_TimeIdle
} ; checkCriticalCommand
;>>>>>>>> checkCriticalCommand >>>> 180312173924 >>>> 12.03.2018 17:39:24 >>>>







  
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk ; A_ScriptDir
#Include %A_ScriptDir%\inc_ahk\Typing_Aid_everywhere_multi_clone.inc.ahk


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
couldIfindMyself:
DetectHiddenWindows,On
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

