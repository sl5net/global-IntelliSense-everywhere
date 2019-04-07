;<<<<<<<< reloadActionList <<<< 180208163147 <<<< 08.02.2018 16:31:47 <<<<
reloadActionList:
; Speak("reload actionList","PROD")
; SoundbeepString2Sound(A_ThisFunc)



Critical, On
ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
Critical, Off
g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
 ;feedbackMsgBox("reloadActionList:",A_LineNumber . " " .  A_LineFile,1,1)



; ToolTipSec(t,x=123,y=321,sec=1000); 75+ lines in Live Edit Live_Edit Pseudo Live Edit for Chrome Firefox PhpStorm.ahk



activeTitleOLD := activeTitle
WinGetActiveTitle, activeTitle
;gi-everywhere Settings ahk_class AutoHotkeyGUI
settitlematchmode,1
;detecthiddenwindows,On
; IfWinExist,gi-everywhere Help
;{
;   Sleep,9000
;   return
;}
;ifwinexist, gi-everywhere Settings ; A window's title must start with the specified WinTitle to be a match.
;{
;   Sleep,% m5
;   return
;}
if(activeTitleOLD && activeTitleOLD <> activeTitle ){
; global g_doSaveLogFiles
	lll( A_ThisFunc ":" A_LineNumber , A_LineFile , "Goto, doReload `n reason for being carefully with reload `;) https://youtu.be/2a_AsYubzvE " )
    ;~ ToolTip, % A_TickCount
}
return
;>>>>>>>> reloadActionList >>>> 180208163153 >>>> 08.02.2018 16:31:53 >>>>

;/Â¯Â¯Â¯Â¯ ReadInTheActionList(sql_template_dir,  Â¯Â¯ 181028125821 Â¯Â¯ 28.10.2018 12:58:21 Â¯Â¯\
ReadInTheActionList(sql_template_dir, calledFromStr){ ;Read in the actionList
	global ParseWordsCount
	global g_min_searchWord_length
	; Speak(A_lineNumber,"PROD")
	
	if(1 && InStr(A_ComputerName,"SL5"))
		RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, % A_ThisFunc , % calledFromStr
	
	Critical, On
	ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
	Critical, Off ; if i switch critical off it not ends reading , maybe it could not read from filesystem?
	g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
	return ParseWordsCount
}
;\____ ReadInTheActionList(sql_template_dir,  __ 181028125831 __ 28.10.2018 12:58:31 __/






;/Â¯Â¯Â¯Â¯ ReadActionList Â¯Â¯ 181028133202 Â¯Â¯ 28.10.2018 13:32:02 Â¯Â¯\
/*
	reads from file or database
	into variables
	snipets to remember whats maybe happens later:
;    FileRead, ParseWords, %actionList%
	its using vars for exampele:
	if (isTblWordsEmpty || diffSize || isModified)
*/
ReadActionList( calledFromStr ){
	global g_LegacyLearnedWords
	global g_ScriptTitle
	global g_actionListDone
	global g_actionListDB
	global actionList
	global g_actionListID
	global g_actionListDBfileAdress
	
	global g_config
	
	if(1 && InStr(A_ComputerName,"SL5"))
		Speak("ReadActionList sucessful started","PROD")
    	; Speak( A_lineNumber ,"PROD")
	
	
	
	if(0 && inStr(actionList, "playground" )){
		RegRead, ALinfoOnley, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
		ToolTip5sec( "RegRead=.........  " ALinfoOnley "`n" actionList "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")", 10,300 )
		Sleep, 1000
		
		WinGetActiveTitle,wintit ;  Retrieves the title of the active window.
		feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), actionList, closeInSeconds )
		sleep,500
		winactivateTry(wintit,9)
		sleep,3500
		return false
	}
	
	
	
	if(!actionList){
		if(1 && InStr(A_ComputerName,"SL5")){
			Speak(A_lineNumber,"PROD")
			; MsgBox,262160,% ":(`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":(`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		}
		return false
	}
	
	extension := SubStr( actionList , -3 )
	if(extension <> ".ahk"){ ; dirty bugfix 19-01-17_19-54
		actionList .= ".ahk"
	}
	
	
    ;/Â¯Â¯Â¯Â¯ itsAGeneratedList Â¯Â¯ 190118203542 Â¯Â¯ 18.01.2019 20:35:42 Â¯Â¯\
    ; G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\actionLists\ChromeWidgetWin1\Turek_Gmail.ahk._Generated.ahk
    ; \actionLists\ChromeWidgetWin1\Turek_Gmail.ahk._Generated.ahk
	postFixGenerated := "._Generated.ahk"
	actionListPostFix  := SubStr(rtrim(actionList), - StrLen(postFixGenerated) + 1 ) ; That works I've tested it 01.11.2018 14:59
	itsAGeneratedList := ( postFixGenerated == actionListPostFix )
	
	
	if(itsAGeneratedList){ ; 19-03-22_05-10 ; ToDo: 19-03-22_05-10
        ; tooltip,% "5555" actionList, 200, 100,5
		postFixGenerated_DIRTY_BUGFIX := ".ahk._Generated.ahk._Generated.ahk"
		thisPostFix_DIRTY_BUGFIX := SubStr(rtrim(actionList), - StrLen(postFixGenerated_DIRTY_BUGFIX) + 1 )
		itsAGeneratedList_DIRTY_BUGFIX := ( postFixGenerated_DIRTY_BUGFIX == thisPostFix_DIRTY_BUGFIX )
		if(itsAGeneratedList_DIRTY_BUGFIX){
			actionList := substr( actionList, 1 , strlen(actionList) -StrLen(postFixGenerated_DIRTY_BUGFIX) )
			actionList .= ".ahk._Generated.ahk"
			if(1 && InStr(A_ComputerName,"SL5")){
				ToolTip2sec( "Oops : " postFixGenerated_DIRTY_BUGFIX "`n`n" actionList "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
				sleep,9000
			}
            ; msgbox, % actionList " 19-03-22_05-07"
		}
		
	}
	
	if(!itsAGeneratedList){
		if(0 && InStr(A_ComputerName,"SL5"))
			Speak(A_LineNumber ": Not a Generated List" ,"PROD") ; bug entecekt actionList 12.11.2018 11:02 todo:
		fileEx := FileExist( actionList postFixGenerated ) ; If no file is found, an empty string is returned.
		; found a bug in Autohotkey version: v1.1.30.01 - November 11, 2018 https://www.autohotkey.com/boards/viewtopic.php?f=14&t=60288&p=254653#p254653
		; already reported heere: https://autohotkey.com/board/topic/89401-ahk-syntax-for-function-call-drives-me-crazy/
		if(fileEx){
			actionList .= postFixGenerated ; quick fix 14.11.2018 11:14
			if(0 && InStr(A_ComputerName,"SL5") && !InStr(actionList,"isNotAProject")){
				Speak(A_LineNumber ": Not a Generated List but Generated List exist" ,"PROD") ; bug entecekt actionList 12.11.2018 11:02 todo:
			    ; clipboard := actionList " `n fileEx= " fileEx "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
				msg =
			    (
			    g_activeClassOLD = %g_activeClassOLD%
			    actionList = %actionList%
			    fileEx = %fileEx%
			    )
				ToolTip8sec( msg "`n`n`n Sleep 3000`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
				Sleep, 3000
				
    			; ..\actionLists\ChromeWidgetWin1\playground_Piratenpad_Google_Chrome.ahk._Generated.ahk
    			; ..\actionLists\ChromeWidgetWin1\playground_Piratenpad_Google_Chrome.ahk._Generated.ahk
				
				
    			; ..\actionLists\ChromeWidgetWin1\PRIVATE_Turek_Gmail.ahk._Generated
			}
		}else if(1 && InStr(A_ComputerName,"SL5")){
			m =
			(
			! FileExist( actionList postFixGenerated )
			! FileExist( %actionList%%postFixGenerated% )
			)
			Speak(A_LineNumber ":" RegExReplace(actionList,".*\\")  ": is without includes, becouse not generated found" ,"PROD") ; bug entecekt actionList 12.11.2018 11:02 todo:
			
			; ToolTip8sec( actionList "`n = actionList`n`n" calledFromStr "`n= calledFromStr`n`n Sleep 2000`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")", 1,1 )
			Sleep, 5000
			ToolTip,
			; MsgBox,262160,% ":(`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% actionList "=actionList `n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
			; return false ; <==== if enabled the isNotA .. project file not works !! dankor!! some files dont need includes!!! 19-01-19_14-51
		}
	}
	;\____ itsAGeneratedList __ 190118203552 __ 18.01.2019 20:35:52 __/
	
	
	if(1 && InStr(A_ComputerName,"SL5"))
		Speak(A_LineNumber " " regExReplace(actionList,".*\\") ,"PROD")
    ; clipboard := actionList
	
	
	
    ; msgBox,% g_config["FuzzySearch"]["keysMAXperEntry"] "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	
	; global g_config ; ["FuzzySearch"]["enable"]
	
	if(1 && InStr(A_ComputerName,"SL5"))
		speak(A_ThisFunc)
	
    ;/Â¯Â¯Â¯Â¯ \.ahk Â¯Â¯ 181025172431 Â¯Â¯ 25.10.2018 17:24:31 Â¯Â¯\
	if(false && !InStr( actionList, "\.ahk")){ ; without file name is bullshit 25.10.2018 17:18 ; Please check outside
		log =
        (
        Oops: InStr( actionList, "\.ahk")
        This may happen for example with Java applications. JetBrains IDE Search Window or so.
        A_ThisFunc = %A_ThisFunc%
        Log:
        actionListNewTemp_withoutExt[30 of 259]: ..\actionLists\AutoHotkey\.ahk
        actionListOLD[33 of 63]: ..\actionLists\noName\Cortana.ahk
        )
		log .= "`n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		log .= "`n 19-01-16_18-88"
		if(1 && InStr(A_ComputerName,"SL5"))
			feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), log )
            ;msgBox,% log " ==> RETURN `n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	}
    ;\____ \.ahk __ 181025172444 __ 25.10.2018 17:24:44 __/
	
	setTrayIcon(status := "isLoading" )
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, % A_ThisFunc , % calledFromStr
	
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
	ParseWordsCount :=0
   ;mark the actionList as not done
	g_actionListDone = 0
	
	
	
  ;actionList = ..\actionLists\ChromeWidgetWin1\wn654_Piratenpad_Google_Chrome.txt._Generated.txt
	
	FileGetTime, FileGet_actionListModified, %actionList%, M
	FormatTime, FileGet_actionListModified, %FileGet_actionListModified%, yyyy-MM-dd HH:mm:ss
	if(!FileGet_actionListModified){
		if(1 && InStr(A_ComputerName,"SL5") && activeTitle == "isNotAProject")
			ToolTip4sec(" Oops  !FileGet_actionListModified (" A_LineNumber . " " . RegExReplace(A_LineFile, ".*\\", "")  )
; SELECT distinct replace(actionList, rtrim(actionList, replace(actionList, '\', '')), '') || '|rr|' || '|ahk|RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, ' || substr(actionList, 1, length(actionList)-4) || ' `nRegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_permanentSELECT, `nMsgBox, , OK  :-) actionList was set, to a permanent list. valid as long as this window exists , 2' FROM actionLists WHERE actionList Like '%g_Word%' Limit 10  ; 		return
	}
	FileGetSize, FileGet_actionListSize, %actionList%
	if(!FileGet_actionListSize){
		if(1 && InStr(A_ComputerName,"SL5") && activeTitle == "isNotAProject")
			ToolTip4sec(" Oops  !FileGet_actionListSize (" A_LineNumber . " " . RegExReplace(A_LineFile, ".*\\", "")  )
		
		if(1 && InStr(A_ComputerName,"SL5"))
			Speak("Return in " A_LineNumber , "PROD" )
		
		return
	}
	
	
	g_actionListID := getActionListID(g_config["sql"]["template"]["dir"], actionList) ; 24.03.2018 23:02
	if(!g_actionListID){ ; fallBack
		
		INSERT_INTO_actionLists(actionList, FileGet_actionListModified, FileGet_actionListSize )
        ;Msgbox,Oops `n %insert%`n (%A_LineFile%~%A_LineNumber%)
        ;tooltip,g_actionListID = %g_actionListID% `n actionList = %actionList% `n %insert%`n (%A_LineFile%~%A_LineNumber%)
        ;sleep,2000
		if(!g_config["sql"]["template"]["dir"]){
			msgbox,% "!sql_template_dir`n `n (" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") ")"
		}
		
		g_actionListID := getActionListID(g_config["sql"]["template"]["dir"], actionList) ; 24.03.2018 23:02
		; ^- insidee ReadInTheActionList(sql_template_dir, calledFromStr){ ;Read in the actionList ...
		
		if(!g_actionListID){
			winWaitNotactive,at
			m =
            (
            Modified := (%actionListModified% ?= %actionListLastModified%=Last)
            Size        = diffSize (%actionListSize% ?= %actionListLastSize%=LastSize)

            actionList = %actionList%
            at = %at%
            %SELECT%
            )
			if(1 && InStr(A_ComputerName,"SL5")){
				toolTip2sec( "ups !g_actionListID `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
				; Msgbox,% ":-( Oops `n " m " !g_actionListID ==> return false `n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
			}
			Sleep, 1000
			return false
		}
		isTblWordsEmpty := true
		; ..\actionLists\_globalActionListsGenerated\_ahk_global.ahk._Generated.ahk._Generated.ahk
	}else
		isTblWordsEmpty := false
	
; toolTip2sec(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
	
;	actionList := actionList
   ; FileReadLine,actionList  ,actionList.txt, 1
   ; FileReadLine,activeClass ,actionList.txt, 2
   ; FileReadLine,activeTitle ,actionList.txt, 3
	
   ; actionListFileAdress := RegExReplace("\._Generated.txt\s*$", "")
   ; actionList = %A_ScriptDir%\%actionList%
	actionList = %actionList%
	actionListLearnedTXTaddress= %A_ScriptDir%\actionListLearned.ahk
	
; msgbox,actionList = %actionList% `n (%A_LineFile%~%A_LineNumber%)
	
	MaybeFixFileEncoding(actionList,"UTF-8")
   ; MaybeFixFileEncoding(actionListLearned,"UTF-8")
	
;msgbox,actionList = %actionList% `n (%A_LineFile%~%A_LineNumber%)
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
	if(!doUseNewMethodStartOfImplementing22march2019 && !g_actionListDB ){
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		g_actionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_actionListDBfileAdress ) ; https://autohotkey.com/board/topic/86457-dba-16-easy-database-access-mysql-sqlite-ado-ms-sql-access/
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
; END of: Section wait for unsolved error messages. to close them unsolved :D 02.04.2017 14:36 17-04-02_14-36 todo: dirty bugfix
	}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	if(!doUseNewMethodStartOfImplementing22march2019 && !g_actionListDB ){
		tooltip, Problem opening database '%A_ScriptDir%\actionListLearned.db' - fatal error...
		lll(A_LineNumber, A_LineFile,Last_A_This . " sleep,15000 ")
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		sleep,15000
      ; exitapp
		lll(A_LineNumber, A_LineFile,Last_A_This . " reload ")
		reload ; 02.04.2017 12:47 17-04-02_12-47 Http://SL5.net
	}
	errorLog =
(
02.04.2017 13:43 17-04-02_13-43
PRAGMAjournal_mode := "TRUNCATE"
Child Exception:
SQLite_Exec
ERROR: Invalid database handle 10222256 Return Code: 1

02.04.2017 14:06 , 17-04-02_14-06
Cannot Create Words Table - fatal error: 5 - database is locked
OK
==> there was two gi-everywhere runniing. how could thats be?
)
	
; How to test if file is_writable and not locked by another program ??
; FileGetAttrib, OutputVar, g_actionListDBfileAdress
; clipboard := g_actionListDB
	if(!doUseNewMethodStartOfImplementing22march2019)
		if(g_actionListDB )
			g_actionListDB.Query("PRAGMA journal_mode = TRUNCATE;")
	else
		msgbox,Oops i am triggered :D 17-04-02_13-47 !g_actionListDB
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	DatabaseRebuilt := MaybeConvertDatabase()
	
	
	if(!FileGet_actionListSize)
		FileGetSize, FileGet_actionListSize, %actionList%
;msgbox,actionListSize = %actionListSize% `n (%A_LineFile%~%A_LineNumber%)
	
	if(false && !FileGet_actionListSize) {
          m = !FileGet_actionListSize: Oops i am triggered :D 17-04-02_13-52 (from: actionList.ahk~%A_LineNumber%)
		Sleep,2500
		
 ;lll(A_LineNumber, A_LineFile,Last_A_This . " reload " )
		global g_doRunLogFiles
		if(g_doRunLogFiles) ; ReadActionList
			run,log\%A_LineFile%.log.txt
		lll(A_LineNumber, A_LineFile,Last_A_This . " reload ")
		Reload
          MsgBox,5 ,!FileGet_actionListSize ,Oops i am triggered :D 17-04-02_13-52 (from: %A_LineFile%~%A_LineNumber%), 5
          ; that is very seldom triggerend. 18.04.2017 20:17
	}
	if(!isTblWordsEmpty){
		
		if(!FileGet_actionListModified){
			FileGetTime, FileGet_actionListModified, %FileGet_actionList%, M
			FormatTime, FileGet_actionListModified, %FileGet_actionListModified%, yyyy-MM-dd HH:mm:ss
		}
       ;tooltip,FileGetTime %FileGet_actionListModified% %actionList%, M
		if(!FileGet_actionListModified){
			msg =
(
%actionList% = actionList
%FileGet_actionListModified% = FileGet_actionListModified
from: actionList.ahk~%A_LineNumber%
)
			msgbox,Oops i am triggered :D 17-04-04_17-32 `n `n %msg%
			exitApp
		}
	}
; regex ; __ __
	msg =
	(
	actionList = %actionList%
	actionList = %actionList%
	)
	
	msg =
	(
	actionList = %actionList%
	activeTitle = '%activeTitle%'
	isTblWordsEmpty = %isTblWordsEmpty%
	DatabaseRebuilt = %DatabaseRebuilt%
	)
	if(1 && InStr(A_ComputerName,"SL5") && activeTitle == "isNotAProject")
		ToolTip4sec(msg "`n" A_LineNumber . " " . RegExReplace(A_LineFile, ".*\\", "")  )
	
	if(0 && inStr(actionList, "playground" )){
		WinGetActiveTitle,wintit ;  Retrieves the title of the active window.
		feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), actionList, closeInSeconds )
		sleep,500
		winactivateTry(wintit,9)
		sleep,3500
		return false
	}
	
	
	
	if (!isTblWordsEmpty && !DatabaseRebuilt) {
    ; thats inside ReadActionList(calledFromStr) ---------------------------------------------
		
;
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		SELECT := "SELECT actionListmodified, actionListsize FROM actionLists WHERE actionList = '" actionList "';"
		if(1 && InStr(A_ComputerName,"SL5") && activeTitle == "isNotAProject")
			ToolTip4sec(msg "`n`n" SELECT "`n" A_LineNumber . " " . RegExReplace(A_LineFile, ".*\\", ""),1,1  )
            ;ifwinactive,ahk_class SunAwtFrame
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		
		
		
		if(doUseNewMethodStartOfImplementing22march2019){
			If !DB.GetTable(SELECT, LearnedWordsTable ){
				if(!DB.HasKey("SQL")){
					tip := "ups !DB.HasKey(""SQL"") `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
					toolTip2sec( tip  )
					return false
					MsgBox, 16, % tip , % tip
				}else
					MsgBox, 16, % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% tip "`n" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			}
		}else{
			LearnedWordsTable := g_actionListDB.Query(SELECT)
		}
		
		
		LoadActionList := "Insert"
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		For each, row in LearnedWordsTable.Rows
		{ ; For each, row in LearnedWordsTable.Rows
			actionListLastModified := row[1]
			actionListLastSize := row[2]
			
			diffSize := Abs(FileGet_actionListSize - actionListLastSize)
            ;diffModified := Abs(FileGet_actionListModified - actionListLastModified) ; <==== acnt diff timestams this way todo:
            ;diffModified := FileGet_actionListModified - actionListLastModified ; <==== acnt diff timestams this way todo:
			isModified := (diffSize || FileGet_actionListModified && actionListLastModified && (FileGet_actionListModified <> actionListLastModified))
			
			tip =
(
FileGetTime, FileGet_actionListModified, %actionList%, M
FileGetTime, %FileGet_actionListModified%, %actionList%, M


%FileGet_actionListModified% ## %actionListLastModified%
%FileGet_actionListModified% ## %actionListLastModified%
)
			ToolTip9sec( FileGet_actionListModified " ## " actionListLastModified "`n" actionList "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
			
			
			if(0 && InStr(actionList, "Turek") && InStr(A_ComputerName,"SL5"))
				MsgBox,262160,% isModified "= isModified`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% actionList "=actionList `n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
			
;/Â¯Â¯Â¯Â¯ plausibilty Â¯Â¯ 190117203319 Â¯Â¯ 17.01.2019 20:33:19 Â¯Â¯\
; extra plausibilty check
; is generated much older then not generated? then its wrong...
	; if(itsAGeneratedList){ ; stup / todo 19-01-17_20-42
		;postFixGenerated := "._Generated.ahk"
	; }
;\____ plausibilty __ 190117203325 __ 17.01.2019 20:33:25 __/
			
			if(0 && InStr(A_ComputerName,"SL5")){
				tip =
                (
                isModified=%isModified%
                := (FileModi=%FileGet_actionListModified% ?= %actionListLastModified%=last)
                %actionList%

                %SELECT%
                )
				
				; clipboard := SELECT
				lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
				
				toolTip2sec(tip "`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This,1,1)
				feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
				
				
				if(!actionListLastModified){ ; <== hopefully not happens often
					sqlDELETE := "DELETE from actionLists WHERE actionListmodified = '';"
					msgbox,ERROR Database actionListLastModified is empty `n`n %sqlDELETE% `n`n %actionList%
					g_actionListDB.Query(sqlDELETE)
					lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"if(!actionListLastModified) <== hopefully not happens often")
					sleep,200 ; maybe if system is little strange. i dont know.
					reload
				}
				
			}
			
			
			if(!FileGet_actionListModified && !actionListLastModified)
				msgbox,18-10-28_13-43
			if (isTblWordsEmpty || isModified) {
				LoadActionList := "Update" ; updated?
            ;Msgbox,%actionList% = actionList `n LoadActionList = "%LoadActionList%"`n source TXT has changed. update database next. `n (%A_LineFile%~%A_LineNumber%)
				
				actionListFileName := RegExReplace(actionList, ".*\\")
				
				
				
				tip =
				(
				LoadActionList = "%LoadActionList%"
				source has changed.
				actionList = %actionListFileName%
				isTblWordsEmpty = %isTblWordsEmpty%
				diffSize        = diffSize (%FileGet_actionListSize% ?= %actionListLastSize%=LastSize)
				isModified := (%FileGet_actionListModified% <> %actionListLastModified%)

				%g_actionListDBfileAdress%

				%SELECT%
				==> update database next.
				(%A_LineFile%~%A_LineNumber%)
				)
				; i like to hava a smaler version of this:
				tip =
				(
				changed "%actionListFileName%" (%A_LineFile%~%A_LineNumber%)
				)
				;tooltip,% tip,1,1
				if(1 && InStr(A_ComputerName,"SL5"))
					ToolTip4sec(tip "`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " ,1,1)
				else
					ToolTip4sec("update database`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " ,1,1)
				lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
				CleanupActionListAll_ofLittleWordCount() ; i dont konw what for that is. try it without 18-10-06_21-40
			} else {
				
				LoadActionList =
				CleanupActionListAll_ofLittleWordCount(true) ; i dont konw what for that is. try it without 18-10-06_21-40
			}
		} ; endOf: For each, row in LearnedWordsTable.Rows
		
        ; actionListLastModified := row[1]
        ; actionListLastSize := row[2]
		if( !actionListLastModified || !actionListLastSize ){
			if(!actionList)
				tip =
            (
            Oops from ReadActionList( %calledFromStr% = calledFromStr )
            actionList = %actionList%
         actionListLastModified = %actionListLastModified% = row[1]
         actionListLastSize = %actionListLastSize% = row[2]

            i found this message after restarting my laptop 08.01.2019 07:30, 19-01-08_07-30
            )
			if(!actionList)
				tip =
            (
            Oops from ReadActionList( %calledFromStr% = calledFromStr )
actionList = >>>>>%actionList%<<<<
g_ScriptTitle = %g_ScriptTitle%
g_actionListID = %g_actionListID%
            )
			if(1 && InStr(A_ComputerName,"SL5") ){
				; msgbox, %tip% `n(%A_LineFile%~%A_LineNumber%)
				closeInSeconds := 5
				ToolTip5sec( tip "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
				
				
				feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip, 1,1, closeInSeconds )
			}
			if(!actionList)
				return false ; inside ReadActionList( calledFromStr )
		}
		
		
		
	} else {
		LoadActionList := "Insert"
	}
; tool tool tool tooltip
	
; msgbox,% LoadActionList "= LoadActionList(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
	if(0 && InStr(A_ComputerName,"SL5")){
		tip =
            				(
            				LoadActionList = "%LoadActionList%"
            				actionList = %actionListFileName%
            				isTblWordsEmpty = %isTblWordsEmpty%
            				isModified := (%FileGet_actionListModified% <> %actionListLastModified%)
            				diffSize        = diffSize (%FileGet_actionListSize% ?= %actionListLastSize%=LastSize)

            				%g_actionListDBfileAdress%

            				%SELECT%
            				(%A_LineFile%~%A_LineNumber%)
            				)
		toolTip2sec(LoadActionList "= LoadActionList `n" tip "`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
	}
	
	
	if (LoadActionList) {
      ; Progress, M, Please wait..., Loading actionList, %g_ScriptTitle%
		
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		g_actionListDB.BeginTransaction()
      ;reads list of words from file
		
        ; was visited 19-04-06_20-37
      	toolTipGui("FileRead, ParseWords (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,-50,"\_",A_LineNumber,"yellow")
		FileRead, ParseWords, %actionList% ; Reads a file's contents into a variable. ok great
      ; ParseWords := JEE_StrUtf8BytesToText( ParseWords ) ; 26.09.2018 18:40 this function was the reason while Ã¤ Ã¼ Ã¶ was not woring
      ; JEE_StrUtf8BytesToText 26.09.2018 18:40 was the reason why german Ã¤Ã¼Ã¶ not was workig :) Now all sources are in UTF8.
		
		if(0 && InStr(A_ComputerName,"SL5"))
			msgbox, % A_ThisFunc ":" A_LineNumber  "does this happens`?? 18-11-17_09-41 ==> yes it does: 18-11-17"
		if(addListOpenAction_ifNotAlreadyInTheList(ParseWords,actionList)){
			;/Â¯Â¯Â¯Â¯ beginnings Â¯Â¯ 181117101035 Â¯Â¯ 17.11.2018 10:10:35 Â¯Â¯\
; only in first lines is searched !!!
; so please put open dialog at beginnings
			contentActionList_first432lines := SubSTr( contentActionList , 1 , 123 ) ; we dont wann search the complete file.
;\____ beginnings __ 181117101038 __ 17.11.2018 10:10:38 __/
			
			temp := "was addet: ___open ...|rr||ahk|openInEditor,....ahk"
			; lll( A_ThisFunc ":" A_LineNumber , A_LineFile , temp )
		}
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		if(false && !foundOpenLibLine){
			temp := "___open library|rr||ahk|FileReadLine,actionListFileAdress, actionList.txt.status.txt, 1 `n actionListFileAdress := RegExReplace(actionListFileAdress, ""\._Generated\.ahk\s*$"", """") `n run,% actionListFileAdress"
            ; AddWordToList(rootCmdTypeObj,strDebug4insert,strDebugByRef,A_LineNumber,Aindex, AddWord,ForceCountNewOnly,ForceLearn:= false, ByRef LearnedWordsCount := false) {
			; AddWordToList(rootCmdTypeObj,strDebug4insert,strDebugByRef,A_LineNumber,Aindex, temp,1,"ForceLearn") ; works but AHK is not succedet :( 12.08.2017 22:28
			; ^- is oben sowieso false
		}
;		DynaRun("#" . "NoTrayIcon `n  Tooltip,.SL5. `n Sleep,2300")
      ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		;
		
		if(false && ParseWordsCount>0)
			Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
		
; DynaRun("msgbox, (line:" . A_LineNumber . ") `n Sleep,2000  ")
		global do_tooltipReadActionList
		if(do_tooltipReadActionList)
			DynaRun("#" . "NoTrayIcon `n" . "loop,20 `n { `n Tooltip,read (line:" . A_LineNumber . ") `n Sleep,100 `n }  ")
; DynaRun("Tooltip, read actionList (line:" . A_LineNumber . ") ``n Sleep,2000 ``n Exitapp")
; DynaRun("Tooltip, read actionList (line:" . A_LineNumber . ") ``n Sleep,2000 ``n Exitapp")
		
		if(false && ParseWordsCount>0)
			Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		
		
		
		Thread, NoTimers , False ; Prevents interruptions from any timers.
		
		
		
		SetTimer,checkInRegistryChangedActionListAddress,off ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
		
; SetTimer,checkInRegistryChangedActionListAddress,off ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
		SetTimer,checkActionListAHKfile_sizeAndModiTime, off
		SetTimer,checkWinChangedTitle,off
		
		Critical, On
		
		if(!g_isListBoxDisabled)
			DestroyListBox()
		if(0 && InStr(A_ComputerName,"SL5"))
			ToolTip9sec( "DestroyListBox() `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
            ; ToolTip9sec( "CloseListBox `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
		; ParseWords := addListOpenAction_ifNotAlreadyInTheList(ParseWords,actionList)
		CleanupEntriesOfThisActionList(g_actionListID)
		Loop_Parse_ParseWords(ParseWords)
		; Critical, Off
		if(!g_isListBoxDisabled)
			InitializeListBox()
		
		
		
		
		
		
		
		
		
		
		
		
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		; autoh blum beu auto
		
		
		if(false && ParseWordsCount>0)
			Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
		
		
		ParseWords =
		g_actionListDB.EndTransaction()
		
		
		; Critical, Off
		; in: ReadActionList(
		; SetTimer,checkInRegistryChangedActionListAddress,On ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; SetTimer,checkInRegistryChangedActionListAddress,off ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
		SetTimer,checkActionListAHKfile_sizeAndModiTime, On
		SetTimer,checkWinChangedTitle,On
		
		
		
      ;Progress, Off
		
; tool msg
; msgbox
; msgbox,% isModified
		if (actionListLastModified && FileGet_actionListModified && FileGet_actionListSize && isModified ) {
			UPDATE := "UPDATE actionLists SET actionListmodified = '" FileGet_actionListModified "', actionListsize = '" FileGet_actionListSize "' WHERE actionList = '" actionList "';"
			if(0 && InStr(A_ComputerName,"SL5") )
				feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), "Query(UPDATE): " UPDATE )
			try{
				;g_actionListDB.Query(UPDATE)
				
				if(!doUseNewMethodStartOfImplementing22march2019)
					g_actionListDB.Query(UPDATE)
				else{
					if(!DB.Exec(UPDATE)){
						if(!DB.HasKey("SQL")){
							MsgBox, 16, % "ups !DB.HasKey(""SQL"") `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
						}
						clipboard := UPDATE
						MsgBox, 16, SQLite Error: GetTable, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode "`n`n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
					}
				}
				
				
			} catch e{
				tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
				
									; sqlLastError := SQLite_LastError()
				if oFunc := Func("SQLite_LastError") ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=63186&p=270178#p270178
					sqlLastError := %oFunc%()
				else
					toolTip2sec( SQLite_LastError " :( not found`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
				
				tip .= "`n sqlLastError=" sqlLastError "`n sql=" UPDATE " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
				lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
				tooltip, `% tip
            		;feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
				Clipboard := tip
				msgbox, % tip
			}
            ; msgb msgbo tpp tool1 tool tooTip2sec(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
			; msgbox,% "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
            ;Msgbox, %UPDATE%  (line:%A_LineNumber%)
		} else if (actionList && FileGet_actionListModified && FileGet_actionListSize ) {
         ;g_actionListDB.Query("INSERT INTO actionLists (actionList, actionListmodified, actionListsize) VALUES ('"  actionList "','" FileGet_actionListModified "','" FileGet_actionListSize "');")
			
 			INSERT_INTO_actionLists_ifNotExist(g_config["sql"]["template"]["dir"], actionList, FileGet_actionListModified, FileGet_actionListSize )
			g_actionListID := getActionListID(g_config["sql"]["template"]["dir"], actionList) ; 24.03.2018 23:02
			; ^in ReadActionList(
		}else{
			len := strlen( actionList )
			m =
                (
                actionList = >%actionList%< (%len%)
                surprisingly, that happened to me that was the length zero 0 (04.11.2018 10:37) ?????
                FileGet_actionListModified = %FileGet_actionListModified%
                FileGet_actionListSize = %FileGet_actionListSize%
                )
			if(InStr(A_ComputerName,"SL5"))
				tooltip,% "Problem Oops `n" m "`n (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
			return false
		}
	}
	if(false && ParseWordsCount>0)
		Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
	
	if (DatabaseRebuilt)
	{
   ;   Progress, M, Please wait..., Converting learned words, %g_ScriptTitle%
    ;
		
		
      ;Force LearnedWordsCount to 0 if not already set as we are now processing Learned Words
		IfEqual, LearnedWordsCount,
		{
			LearnedWordsCount=0
		}
      ; Msgbox, n  n n 17-04-27_22-08 (line:%A_LineNumber%)
		
		g_actionListDB.BeginTransaction()
      ;reads list of words from file
		if(InStr(actionListLearnedTXTaddress,"actionListLearned.ahk")){
			tip=thats deprecated `n ordlistLearnedTXTaddress = `n %actionListLearnedTXTaddress% `n (%A_LineFile%~%A_LineNumber%)
			ToolTip1sec(tip "`n" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "")  " " Last_A_This, 1, 1)
			
			setTrayIcon()
			
			
			Return ParseWordsCount
		}else{
			toolTipGui("FileRead, ParseWords (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,-50,"\_",A_LineNumber,"blue")
			FileRead, ParseWords, %actionListLearnedTXTaddress%
		}
; -- here we are inside ReadActionList(calledFromStr)
		
		if(InStr(A_ComputerName,"SL5"))
			DynaRun("#" . "NoTrayIcon `n" . "loop,20 `n { `n Tooltip,read actionListLearnedTXTaddress``n" actionListLearnedTXTaddress "``n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ") `n Sleep,2000 `n }  ")
		else
			DynaRun("#" . "NoTrayIcon `n" . "loop,20 `n { `n Tooltip,read actionListLearnedTXTaddress ``n" actionListLearnedTXTaddress "``n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ") `n Sleep,100 `n }  ")
; Msgbox, n (line:%A_LineNumber%) Msgbox, `n (line:%A_LineNumber%)
;Msgbox, n (line:%A_LineNumber%) ; SciTEWindow\_global.ahk
; SciTEWindow\_global.ahk
		if(false && ParseWordsCount>0)
			Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
		
; ___open library|rr||ahk|FileReadLine,actionListFileAdress, actionList.txt.status.txt, 1 `n actionListFileAdress := RegExReplace(actionListFileAdress, "\._Generated\.txt\s*$", "") `n run,% actionListFileAdress
;
        ; inside function ReadActionList
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
; deleteThisBlo ¯¯ 190406201036 ¯¯ 06.04.2019 20:10:36 ¯¯\
; deleteThisBlo ????
		Loop, Parse, ParseWords, `n, `r
		{
		    ; thats the place where actually typed word are addet !!!!!!
		    ; while you are typing every word goes in here: 18-10-02_18-11
			if(1 && InStr(A_ComputerName,"SL5"))
				Msgbox,% "never triggerd. so we could delte it ????(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		    ; ^-- this mesage box never triggerd. so we could delte it.
		    ; kÃ¤sewurst
			ToolTip4sec(A_LoopField "`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
			AddWordToList(rootCmdTypeObj,strDebug4insert,strDebugByRef,A_LineNumber,Aindex, A_LoopField,0,"ForceLearn",LearnedWordsCount)
 			; thats strang   ;  ms msb too
			
		}
		ParseWords =
		g_actionListDB.EndTransaction()
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
;      Progress, 50, Please wait..., Converting learned words, %g_ScriptTitle%
		
; -- here we are inside ReadActionList(calledFromStr)
		
		
      ;reverse the numbers of the word counts in memory
		ReverseWordNums(LearnedWordsCount)
		
		g_actionListDB.Query("INSERT INTO LastState VALUES ('tableConverted','1',NULL);")
		
      ;Progress, Off
	}
	if(false && ParseWordsCount>0)
		Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
	
   ;mark the actionList as completed
	g_actionListDone = 1
   ; DynaRun("#" . "NoTrayIcon `n Tooltip,|SL5|`n Sleep,2300")
    ;DynaRun("#" "NoTrayIcon `; `n``n Tooltip,||SL5|| `; `n``n Sleep,2300 `; " A_LineNumber)
   ; tooltip,%ParseWordsCount%`n (from: %A_LineFile%~%A_LineNumber%)
	
	setTrayIcon()
	
	Return ParseWordsCount
}
;\____ ReadActionList __ 181107175022 __ 07.11.2018 17:50:22 __/
