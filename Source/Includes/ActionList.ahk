﻿; These functions and labels are related maintenance of the ActionList



;/¯¯¯¯ setTrayIcon ¯¯ 181107175114 ¯¯ 07.11.2018 17:51:14 ¯¯\
setTrayIcon(status := "loaded" ){
	if(status == "RecomputeMatches" ){
		Menu, Tray, Icon, shell32.dll, 240 ; pretty green clock
		return
	}
	if(status <> "loaded" ){
		Menu, Tray, Icon, shell32.dll, 266 ; pretty black clock
    ;  Menu, Tray, Icon, shell32.dll, 44 ; star
		return
	}
	ScriptNameLetter2 := SubStr(A_ScriptName, 1 , 2)
	iconAdress=%A_ScriptDir%\icon\abc123\%ScriptNameLetter2%.ico
	Menu, Tray, Icon, %iconAdress%
}
;\____ setTrayIcon __ 181107175118 __ 07.11.2018 17:51:18 __/





;<<<<<<<<<<<<<< ReadActionList <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<< ReadActionList <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<< ReadActionList <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<< ReadActionList <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;/¯¯¯¯ ReadActionList ¯¯ 181028133202 ¯¯ 28.10.2018 13:32:02 ¯¯\
ReadActionList( calledFromStr ){
	global g_LegacyLearnedWords
	global g_ScriptTitle
	global g_ActionListDone
	global g_ActionListDB
	global ActionList
	global g_ActionListID
	global g_ActionListDBfileAdress
	
	global g_config
	
	if(!ActionList)
		return false
	
	postFixGenerated := "._Generated.ahk"
	ActionListPostFix  := SubStr(rtrim(ActionList), - StrLen(postFixGenerated) + 1 ) ; That works I've tested it 01.11.2018 14:59
	itsAGeneratedList := ( postFixGenerated == ActionListPostFix )
	if(!itsAGeneratedList){
		fileEx := FileExist ( ActionList postFixGenerated )
		if(fileEx)
			ActionList .= postFixGenerated ; quick fix 14.11.2018 11:14
		else if(1 && InStr(A_ComputerName,"SL5")){
			Speak(A_LineNumber ": Prima. zwei Listen " ,"PROD") ; bug entecekt ActionList 12.11.2018 11:02 todo:
			ToolTip8sec( ActionList "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
			Sleep, 3000
			return false
		}
	}
	
	
	
	
    ; msgBox,% g_config["FuzzySearch"]["keysMAXperEntry"] "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	
	; global g_config ; ["FuzzySearch"]["enable"]
	
	if(1 && InStr(A_ComputerName,"SL5"))
		speak(A_ThisFunc)
	
    ;/¯¯¯¯ \.ahk ¯¯ 181025172431 ¯¯ 25.10.2018 17:24:31 ¯¯\
	if(	InStr( ActionList, "\.ahk")){ ; without file name is bullshit 25.10.2018 17:18 ; Please check outside
		log =
        (
        Oops: InStr( ActionList, "\.ahk")
        This may happen for example with Java applications. JetBrains IDE Search Window or so.
        A_ThisFunc = %A_ThisFunc%
        Log:
        ActionListNewTemp_withoutExt[30 of 259]: ..\ActionLists\AutoHotkey\.ahk
        ActionListOLD[33 of 63]: ..\ActionLists\noName\Cortana.ahk
        )
		log .= "`n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		if(1 && InStr(A_ComputerName,"SL5"))
			
		feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, log )
            ;msgBox,% log " ==> RETURN `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	}
    ;\____ \.ahk __ 181025172444 __ 25.10.2018 17:24:44 __/
	
	setTrayIcon(status := "isLoading" )
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, % A_ThisFunc , % calledFromStr
	
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
	ParseWordsCount :=0
   ;mark the ActionList as not done
	g_ActionListDone = 0
	
	
	
  ;ActionList = ..\ActionLists\ChromeWidgetWin1\wn654_Piratenpad_Google_Chrome.txt._Generated.txt
	
	FileGetTime, FileGet_ActionListModified, %ActionList%, M
	FormatTime, FileGet_ActionListModified, %FileGet_ActionListModified%, yyyy-MM-dd HH:mm:ss
	if(!FileGet_ActionListModified){
		if(1 && InStr(A_ComputerName,"SL5") && activeTitle == "isNotAProject")
			ToolTip4sec(" Oops  !FileGet_ActionListModified (" A_LineNumber . " " . RegExReplace(A_LineFile, ".*\\", "")  )
		return
	}
	FileGetSize, FileGet_ActionListSize, %ActionList%
	if(!FileGet_ActionListSize){
		if(1 && InStr(A_ComputerName,"SL5") && activeTitle == "isNotAProject")
			ToolTip4sec(" Oops  !FileGet_ActionListSize (" A_LineNumber . " " . RegExReplace(A_LineFile, ".*\\", "")  )
		return
	}
	
	
	g_ActionListID := getActionListID(ActionList) ; 24.03.2018 23:02
	if(!g_ActionListID){ ; fallBack
		
		INSERT_INTO_ActionLists(ActionList, FileGet_ActionListModified, FileGet_ActionListSize )
        ;Msgbox,Oops `n %insert%`n (%A_LineFile%~%A_LineNumber%)
        ;tooltip,g_ActionListID = %g_ActionListID% `n ActionList = %ActionList% `n %insert%`n (%A_LineFile%~%A_LineNumber%)
        ;sleep,2000
		
		g_ActionListID := getActionListID(ActionList) ; 24.03.2018 23:02
		if(!g_ActionListID){
			
			m =
            (
            Modified := (%ActionListModified% ?= %ActionListLastModified%=Last)
            Size        = diffSize (%ActionListSize% ?= %ActionListLastSize%=LastSize)

            ActionList = %ActionList%
            %SELECT%
            )
			if(1 && InStr(A_ComputerName,"SL5"))
				Msgbox,% ":-( Oops `n " m " !g_ActionListID ==> return false `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
			Sleep, 1000
			return false
		}
		isTblWordsEmpty := true
		; ..\ActionLists\_globalActionListsGenerated\_ahk_global.ahk._Generated.ahk._Generated.ahk
	}else
		isTblWordsEmpty := false
	
; toolTip2sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
	
;	ActionList := ActionList
   ; FileReadLine,ActionList  ,ActionList.txt, 1
   ; FileReadLine,activeClass ,ActionList.txt, 2
   ; FileReadLine,activeTitle ,ActionList.txt, 3
	
   ; ActionListFileAdress := RegExReplace("\._Generated.txt\s*$", "")
   ; ActionList = %A_ScriptDir%\%ActionList%
	ActionList = %ActionList%
	ActionListLearnedTXTaddress= %A_ScriptDir%\ActionListLearned.ahk
	
; msgbox,ActionList = %ActionList% `n (%A_LineFile%~%A_LineNumber%)
	
	MaybeFixFileEncoding(ActionList,"UTF-8")
   ; MaybeFixFileEncoding(ActionListLearned,"UTF-8")
	
;msgbox,ActionList = %ActionList% `n (%A_LineFile%~%A_LineNumber%)
	
	
	if (!g_ActionListDB )
		g_ActionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_ActionListDBfileAdress ) ; https://autohotkey.com/board/topic/86457-dba-16-easy-database-access-mysql-sqlite-ado-ms-sql-access/
; END of: Section wait for unsolved error messages. to close them unsolved :D 02.04.2017 14:36 17-04-02_14-36 todo: dirty bugfix
	
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	if (!g_ActionListDB )
	{
		tooltip, Problem opening database '%A_ScriptDir%\ActionListLearned.db' - fatal error...
		lll(A_LineNumber, A_LineFile,Last_A_This . " sleep,15000 ")
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
; FileGetAttrib, OutputVar, g_ActionListDBfileAdress
; clipboard := g_ActionListDB
	if(g_ActionListDB)
		g_ActionListDB.Query("PRAGMA journal_mode = TRUNCATE;")
	else
		msgbox,Oops i am triggered :D 17-04-02_13-47 !g_ActionListDB
	
	DatabaseRebuilt := MaybeConvertDatabase()
	
	if(!FileGet_ActionListSize)
		FileGetSize, FileGet_ActionListSize, %ActionList%
;msgbox,ActionListSize = %ActionListSize% `n (%A_LineFile%~%A_LineNumber%)
	
	if(false && !FileGet_ActionListSize) {
          m = !FileGet_ActionListSize: Oops i am triggered :D 17-04-02_13-52 (from: ActionList.ahk~%A_LineNumber%)
		Sleep,2500
		
 ;lll(A_LineNumber, A_LineFile,Last_A_This . " reload " )
		global g_doRunLogFiles
		if(g_doRunLogFiles)
			run,log\%A_LineFile%.log.txt
		lll(A_LineNumber, A_LineFile,Last_A_This . " reload ")
		Reload
          MsgBox,5 ,!FileGet_ActionListSize ,Oops i am triggered :D 17-04-02_13-52 (from: %A_LineFile%~%A_LineNumber%), 5
          ; that is very seldom triggerend. 18.04.2017 20:17
	}
	if(!isTblWordsEmpty){
		
		if(!FileGet_ActionListModified){
			FileGetTime, FileGet_ActionListModified, %FileGet_ActionList%, M
			FormatTime, FileGet_ActionListModified, %FileGet_ActionListModified%, yyyy-MM-dd HH:mm:ss
		}
       ;tooltip,FileGetTime %FileGet_ActionListModified% %ActionList%, M
		if(!FileGet_ActionListModified){
			msg =
(
%ActionList% = ActionList
%FileGet_ActionListModified% = FileGet_ActionListModified
from: ActionList.ahk~%A_LineNumber%
)
			msgbox,Oops i am triggered :D 17-04-04_17-32 `n `n %msg%
			exitApp
		}
	}
; regex ; __ __
	msg =
	(
	ActionList = %ActionList%
	ActionList = %ActionList%
	)
	
	msg =
	(
	ActionList = %ActionList%
	activeTitle = '%activeTitle%'
	isTblWordsEmpty = %isTblWordsEmpty%
	DatabaseRebuilt = %DatabaseRebuilt%
	)
	if(1 && InStr(A_ComputerName,"SL5") && activeTitle == "isNotAProject")
		ToolTip4sec(msg "`n" A_LineNumber . " " . RegExReplace(A_LineFile, ".*\\", "")  )
	if (!isTblWordsEmpty && !DatabaseRebuilt) {
    ; thats inside ReadActionList(calledFromStr) ---------------------------------------------
		
		
		
		CoordMode, ToolTip,Screen
		
		SELECT := "SELECT ActionListmodified, ActionListsize FROM ActionLists WHERE ActionList = '" ActionList "';"
		if(1 && InStr(A_ComputerName,"SL5") && activeTitle == "isNotAProject")
			ToolTip4sec(msg "`n`n" SELECT "`n" A_LineNumber . " " . RegExReplace(A_LineFile, ".*\\", ""),1,1  )
            ;ifwinactive,ahk_class SunAwtFrame
		LearnedWordsTable := g_ActionListDB.Query(SELECT)
		
		LoadActionList := "Insert"
		
		For each, row in LearnedWordsTable.Rows
		{ ; For each, row in LearnedWordsTable.Rows
			ActionListLastModified := row[1]
			ActionListLastSize := row[2]
			
			diffSize := Abs(FileGet_ActionListSize - ActionListLastSize)
            ;diffModified := Abs(FileGet_ActionListModified - ActionListLastModified) ; <==== acnt diff timestams this way todo:
            ;diffModified := FileGet_ActionListModified - ActionListLastModified ; <==== acnt diff timestams this way todo:
			isModified := (diffSize || FileGet_ActionListModified && ActionListLastModified && (FileGet_ActionListModified <> ActionListLastModified))
			if(0 && InStr(A_ComputerName,"SL5")){
				tip =
                (
                isModified=%isModified%
                := (FileModi=%FileGet_ActionListModified% ?= %ActionListLastModified%=last)
                %ActionList%

                %SELECT%
                )

				; clipboard := SELECT
                lll(A_LineNumber, A_LineFile, tip)

				toolTip2sec(tip "`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This,1,1)
				feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, tip )
				
				
				if(!ActionListLastModified){ ; <== hopefully not happens often
					sqlDELETE := "DELETE from ActionLists WHERE ActionListmodified = '';"
					msgbox,ERROR Database ActionListLastModified is empty `n`n %sqlDELETE% `n`n %ActionList%
					g_ActionListDB.Query(sqlDELETE)
					lll(A_LineNumber, A_LineFile, "if(!ActionListLastModified) <== hopefully not happens often")
					sleep,200 ; maybe if system is little strange. i dont know.
					reload
				}
				
			}
			if(!FileGet_ActionListModified && !ActionListLastModified)
				msgbox,18-10-28_13-43
			if (isTblWordsEmpty || diffSize || isModified) {
				LoadActionList := "Update" ; updated?
            ;Msgbox,%ActionList% = ActionList `n LoadActionList = "%LoadActionList%"`n source TXT has changed. update database next. `n (%A_LineFile%~%A_LineNumber%)
				
				ActionListFileName := RegExReplace(ActionList, ".*\\")
				
				tip =
				(
				LoadActionList = "%LoadActionList%"
				source has changed.
				ActionList = %ActionListFileName%
				isTblWordsEmpty = %isTblWordsEmpty%
				diffSize        = diffSize (%FileGet_ActionListSize% ?= %ActionListLastSize%=LastSize)
				isModified := (%FileGet_ActionListModified% <> %ActionListLastModified%)

				%g_ActionListDBfileAdress%

				%SELECT%
				==> update database next.
				(%A_LineFile%~%A_LineNumber%)
				)
				;tooltip,% tip,1,1
				if(1 && InStr(A_ComputerName,"SL5"))
					ToolTip4sec(tip "`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " ,1,1)
				else
					ToolTip4sec("update database`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " ,1,1)
				lll(A_LineNumber, A_LineFile, tip)
				CleanupActionListAll_ofLittleWordCount() ; i dont konw what for that is. try it without 18-10-06_21-40
			} else {
				
				LoadActionList =
				CleanupActionListAll_ofLittleWordCount(true) ; i dont konw what for that is. try it without 18-10-06_21-40
			}
		} ; endOf: For each, row in LearnedWordsTable.Rows
		
        ; ActionListLastModified := row[1]
        ; ActionListLastSize := row[2]
		if( !ActionListLastModified || !ActionListLastSize ){
			tip =
            (
            something wrong Oops
         %ActionListLastModified% := row[1]
         %ActionListLastSize% := row[2]
            )
			if(1 && InStr(A_ComputerName,"SL5") ){
			    msgbox, %tip% `n(%A_LineFile%~%A_LineNumber%)
		    	feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, tip )
		}
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
            				ActionList = %ActionListFileName%
            				isTblWordsEmpty = %isTblWordsEmpty%
            				isModified := (%FileGet_ActionListModified% <> %ActionListLastModified%)
            				diffSize        = diffSize (%FileGet_ActionListSize% ?= %ActionListLastSize%=LastSize)

            				%g_ActionListDBfileAdress%

            				%SELECT%
            				(%A_LineFile%~%A_LineNumber%)
            				)
		toolTip2sec(LoadActionList "= LoadActionList `n" tip "`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
	}
	
	
	if (LoadActionList) {
      ; Progress, M, Please wait..., Loading ActionList, %g_ScriptTitle%
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		g_ActionListDB.BeginTransaction()
      ;reads list of words from file
		FileRead, ParseWords, %ActionList%
      ; ParseWords := JEE_StrUtf8BytesToText( ParseWords ) ; 26.09.2018 18:40 this function was the reason while ä ü ö was not woring
      ; JEE_StrUtf8BytesToText 26.09.2018 18:40 was the reason why german äüö not was workig :) Now all sources are in UTF8.
		
		ParseWords := addListOpenAction_ifNotAlreadyInTheList(ParseWords,ActionList) ; todo: whats this ?
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)

		if(false && !foundOpenLibLine){
			temp := "___open library|rr||ahk|FileReadLine,ActionListFileAdress, ActionList.txt.status.txt, 1 `n ActionListFileAdress := RegExReplace(ActionListFileAdress, ""\._Generated\.ahk\s*$"", """") `n run,% ActionListFileAdress"
            ; AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, AddWord,ForceCountNewOnly,ForceLearn:= false, ByRef LearnedWordsCount := false) {
			; AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, temp,1,"ForceLearn") ; works but AHK is not succedet :( 12.08.2017 22:28
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
; DynaRun("Tooltip, read ActionList (line:" . A_LineNumber . ") ``n Sleep,2000 ``n Exitapp")
; DynaRun("Tooltip, read ActionList (line:" . A_LineNumber . ") ``n Sleep,2000 ``n Exitapp")
		
		if(false && ParseWordsCount>0)
			Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		
		
		
		; ParseWords := addListOpenAction_ifNotAlreadyInTheList(ParseWords,ActionList)
		Loop_Parse_ParseWords(ParseWords)
		
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		; autoh blum beu auto 
		
		
		if(false && ParseWordsCount>0)
			Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
		
		
		ParseWords =
		g_ActionListDB.EndTransaction()
      ;Progress, Off
		
; tool msg
; msgbox
; msgbox,% isModified
		if (ActionListLastModified && FileGet_ActionListModified && FileGet_ActionListSize && isModified ) {
			UPDATE := "UPDATE ActionLists SET ActionListmodified = '" FileGet_ActionListModified "', ActionListsize = '" FileGet_ActionListSize "' WHERE ActionList = '" ActionList "';"
			; msgbox,% UPDATE "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
			try{
        			g_ActionListDB.Query(UPDATE)
            	} catch e{
            		tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
            		sqlLastError := SQLite_LastError()
            		tip .= "`n sqlLastError=" sqlLastError "`n sql=" UPDATE " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
            		lll(A_LineNumber, A_LineFile, tip)
            		tooltip, `% tip
            		;feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, tip )
            		Clipboard := tip
            		msgbox, % tip
            	}
            ; msgb msgbo tpp tool1 tool tooTip2sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
			; msgbox,% "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
            ;Msgbox, %UPDATE%  (line:%A_LineNumber%)
		} else if (ActionList && FileGet_ActionListModified && FileGet_ActionListSize ) {
         ;g_ActionListDB.Query("INSERT INTO ActionLists (ActionList, ActionListmodified, ActionListsize) VALUES ('"  ActionList "','" FileGet_ActionListModified "','" FileGet_ActionListSize "');")
			
			INSERT_INTO_ActionLists_ifNotExist(ActionList, FileGet_ActionListModified, FileGet_ActionListSize )
			g_ActionListID := getActionListID(ActionList) ; 24.03.2018 23:02
		}else{
			len := strlen( ActionList )
			m =
                (
                ActionList = >%ActionList%< (%len%)
                surprisingly, that happened to me that was the length zero 0 (04.11.2018 10:37) ?????
                FileGet_ActionListModified = %FileGet_ActionListModified%
                FileGet_ActionListSize = %FileGet_ActionListSize%
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
		
		g_ActionListDB.BeginTransaction()
      ;reads list of words from file
		if(InStr(ActionListLearnedTXTaddress,"ActionListLearned.ahk")){
			tip=thats deprecated `n ordlistLearnedTXTaddress = `n %ActionListLearnedTXTaddress% `n (%A_LineFile%~%A_LineNumber%)
			ToolTip3sec(tip "`n" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "")  " " Last_A_This)
			
			setTrayIcon()
			
			
			Return ParseWordsCount
		}else
			FileRead, ParseWords, %ActionListLearnedTXTaddress%
; -- here we are inside ReadActionList(calledFromStr)
		if(InStr(A_ComputerName,"SL5"))
			DynaRun("#" . "NoTrayIcon `n" . "loop,20 `n { `n Tooltip,read ActionListLearnedTXTaddress``n" ActionListLearnedTXTaddress "``n (" RegExReplace(A_LineFile,".*\\") ">" A_LineNumber ") `n Sleep,2000 `n }  ")
		else
			DynaRun("#" . "NoTrayIcon `n" . "loop,20 `n { `n Tooltip,read ActionListLearnedTXTaddress ``n" ActionListLearnedTXTaddress "``n (" RegExReplace(A_LineFile,".*\\") ">" A_LineNumber ") `n Sleep,100 `n }  ")
; Msgbox, n (line:%A_LineNumber%) Msgbox, `n (line:%A_LineNumber%)
;Msgbox, n (line:%A_LineNumber%) ; SciTEWindow\_global.ahk
; SciTEWindow\_global.ahk
		if(false && ParseWordsCount>0)
			Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
		
; ___open library|rr||ahk|FileReadLine,ActionListFileAdress, ActionList.txt.status.txt, 1 `n ActionListFileAdress := RegExReplace(ActionListFileAdress, "\._Generated\.txt\s*$", "") `n run,% ActionListFileAdress
;
        ; inside function ReadActionList
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
		Loop, Parse, ParseWords, `n, `r
		{
		    ; thats the place where actually typed word are addet !!!!!!
		    ; while you are typing every word goes in here: 18-10-02_18-11
			if(1 && InStr(A_ComputerName,"SL5"))
				Msgbox,% "never triggerd. so we could delte it ????(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		    ; ^-- this mesage box never triggerd. so we could delte it.
		    ; käsewurst
			ToolTip4sec(A_LoopField "`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
 			AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, A_LoopField,0,"ForceLearn",LearnedWordsCount)
 			; thats strang   ;  ms msb too
			
		}
		ParseWords =
		g_ActionListDB.EndTransaction()
		
		INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
		
;      Progress, 50, Please wait..., Converting learned words, %g_ScriptTitle%
		
; -- here we are inside ReadActionList(calledFromStr)
		
		
      ;reverse the numbers of the word counts in memory
		ReverseWordNums(LearnedWordsCount)
		
		g_ActionListDB.Query("INSERT INTO LastState VALUES ('tableConverted','1',NULL);")
		
      ;Progress, Off
	}
	if(false && ParseWordsCount>0)
		Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)
	
   ;mark the ActionList as completed
	g_ActionListDone = 1
   ; DynaRun("#" . "NoTrayIcon `n Tooltip,|SL5|`n Sleep,2300")
    ;DynaRun("#" "NoTrayIcon `; `n``n Tooltip,||SL5|| `; `n``n Sleep,2300 `; " A_LineNumber)
   ; tooltip,%ParseWordsCount%`n (from: %A_LineFile%~%A_LineNumber%)
	
	setTrayIcon()
	
	Return ParseWordsCount
}
;\____ ReadActionList __ 181107175022 __ 07.11.2018 17:50:22 __/


;/¯¯¯¯ ObjToStrTrim ¯¯ 181111193648 ¯¯ 11.11.2018 19:36:48 ¯¯\
ObjToStrTrim(o, showEmpty := false){
	ret := ((s:=Trim(ObjToStr(o, showEmpty)," `t`r`n")) ? ">" s "<`n" : "")
    ; msgbox,,% ret,,1
	return ret
}
;\____ ObjToStrTrim __ 181111193651 __ 11.11.2018 19:36:51 __/



;/¯¯¯¯ ObjToStr ¯¯ 181111193656 ¯¯ 11.11.2018 19:36:56 ¯¯\
; https://autohotkey.com/board/topic/66496-object-fromto-file-or-string-data-structures/
ObjToStr(Obj,  showEmpty := false, Rows="`n", Equal=" = ", Indent="`t", Depth=7, CurIndent="") {	; converts object to string
	For k,v in Obj
	{
		if(!showEmpty && !v)
			continue
		ToReturn .= CurIndent . k . (IsObject(v) && depth>1 ? Rows . ObjToStr(v,  showEmpty ,Rows, Equal, Indent, Depth-1, CurIndent . Indent) : Equal . v) . Rows
	}
	return RTrim(ToReturn, Rows)
}	; http://www.autohotkey.com/forum/post-426623.html#426623
;\____ ObjToStr __ 181111193702 __ 11.11.2018 19:37:02 __/

;/¯¯¯¯ ObjSToStrTrim ¯¯ 181113093456 ¯¯ 13.11.2018 09:34:56 ¯¯\
ObjSToStrTrim(ByRef str, o*) {
	; This is interesting for debugging. control to see is actually happening. 18-11-12_18-16
	; fileappend, % "#/¯ contDoObj(" A_LineNumber ")=`n" ObjToStrTrim(contDoObj) , % devTestTxtFile, UTF-8
	For each, param in o
		str .= ObjToStrTrim(param) 
	str .= "\_________________________________/`n" 
}
;\____ ObjSToStrTrim __ 181113093505 __ 13.11.2018 09:35:05 __/



doAsimpleCopyOfLine(ByRef rootCmdTypeObj,infoBox := ""){
	doAsimpleCopy  := ( 	(	!rootCmdTypeObj.is_rr 
				&&	!rootDoObj.collectBlock
				&& 	!rootCmdTypeObj.is_IndexedAhkBlock
				&& 	!rootCmdTypeObj.is_multiline_r
				&& 	!rootCmdTypeObj.is_multiline_rr
				&& 	!rootCmdTypeObj.is_synonym
				&& 	!rootCmdTypeObj.is_without_keywords ) 			
			|| 		rootCmdTypeObj.is_str )
	if(false){
		m =
		(
doAsimpleCopy = >>%doAsimpleCopy%<<
infoBox = >>%infoBox%<<
		)
		ObjSToStrTrim(s:="",rootCmdTypeObj) 
		infoBox .= "`n" m "`n---------------`n" s "("  A_LineNumber ")"
			MsgBox, % infoBox
	}
	return doAsimpleCopy 
}


isWithValueArea(ByRef rootCmdTypeObj,infoBox := ""){
	if(rootCmdTypeObj.is_str)
		hasValueArea  := false
	else
		hasValueArea  := true
	if(infoBox){
		m =
		(
		)
		ObjSToStrTrim(s:="",rootCmdTypeObj) 
		infoBox .= m "`n---------------`n" s "("  A_LineNumber ")"
		MsgBox, % infoBox
	}
	return hasValueArea
}













; https://stackoverflow.com/questions/27157174/autohotkey-source-code-line-break
; Method #1: A line that starts with "and", "or", ||, &&, a comma, or a period is automatically merged with the line directly above it (in v1.0.46+, the same is true for all other expression operators except ++ and --). In the following example, the second line is appended to the first because it begins with a comma:

;/¯¯¯¯ Loop_Parse_ParseWords ¯¯ 181110211433 ¯¯ 10.11.2018 21:14:33 ¯¯\
; thats the place very updates from the file are inserted into the database. this you shuld never delte.
Loop_Parse_ParseWords_LoopField( IsAtEOF
, Aindex, ByRef ALoopField
, ByRef strDebug4insert, ByRef strDebugByRef
, ByRef rootLineObj, ByRef rootCmdTypeObj, ByRef rootCollectObj, ByRef rootDoObj
, ByRef contLineObj, ByRef contCmdTypeObj, ByRef contCollectObj, ByRef contDoObj ){

global g_ignReg
if(1 && InStr(A_ComputerName,"SL5") ){
	g_ignReg["feedbackMsgBox"]["tit"]  := ( Aindex >= 1 ) ? ".^" : "." ; ".^"  means ingnores nothing
	g_ignReg["saveLogFiles"]["scriptName"] := ".^" ; g_ignReg["feedbackMsgBox"]["tit"]
}else{
	g_ignReg["saveLogFiles"]["scriptName"] := "." ; following ".^"  means ingnores nothing
	g_ignReg["feedbackMsgBox"]["tit"]  := "." ; following ".^"  means ingnores nothing
}


if(!Aindex){
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ">ROOT>'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	msgBox, that schould never happens %Aindex% : %ALoopField%
	Return "continue"
}


; here is  the entry point where it always starts. outside of a blog
; since we are not in a block
; feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber,Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
; lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ">ROOT>'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )

if( !rootLineObj.Aindex )
	rootLineObj := { value:ALoopField, Aindex: Aindex }
if( rootLineObj.Aindex == contLineObj.Aindex ){ ; maybe cont is empty thats ok then. 
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ">ROOT>'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	if(1 && InStr(A_ComputerName,"SL5") ){
		ToolTip, % "Oops should not happen 18-11-15_14-10 " rootLineObj.Aindex " == " contLineObj.Aindex
		msgbox, % "Oops should not happen 18-11-15_14-10 " rootLineObj.Aindex " == " contLineObj.Aindex
	}
}

; isCommandType := setCommandTypeS(rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj ) ; <= this has destoid  is_multiline_r
if(!rootDoObj.collectBlock){ ; dont need it it was may done into the content loop. probalby only first time.
	rootLineObj := { value:ALoopField, Aindex: Aindex }
	isCommandType := setCommandTypeS(rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj )
}

doAsimpleCopy := doAsimpleCopyOfLine(rootCmdTypeObj  ) ; ,rootLineObj.value "?=" ALoopField)
if(doAsimpleCopy){
	if(CheckValid( rootLineObj.value )){
		AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, rootLineObj.value , 0,"ForceLearn",LearnedWordsCount, rootCmdTypeObj.is_IndexedAhkBlock)
	}
	Return "break" ; free for everything happens next	
}

if(false){
	; MsgBox, found doAsimpleCopy 670
	cto := rootCmdTypeObj ; For shorter reading			
	if(cto.is_IndexedAhkBlock ){
		newKeywords := getAutoKeywords(temp:="",contLineObj.value)
		feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, " oldKeywords=" oldKeywords "`n"  " newKeywords=" newKeywords "`n" ObjSToStrTrim(s:="", rootCollectObj) s )
		valud2DB := newKeywords "|r|" trimLineInBlock "`n" ; add a replacment or simple sting 13.11.2018 10:26
		AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, valud2DB , 0,"ForceLearn",LearnedWordsCount, rootCmdTypeObj.is_IndexedAhkBlock)
		Pause,On
	}
}

if(isWithValueArea(rootCmdTypeObj)){
	rootLineObj.posBehindKeywords := (p:=instr(rootLineObj.value,"|")) ? p : 1
	rootLineObj.oldKeywords := substr(rootLineObj.value,1, rootLineObj.posBehindKeywords - 1)
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`ncontinue: " Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
}

; we got it and the contant we take during the next loops 18-11-15_15
if( rootDoObj.collectBlock && Aindex == rootLineObj.Aindex ) ; first contact
	Return "continue"




if(!rootDoObj.collectBlock && ( rootCmdTypeObj.is_str || rootCmdTypeObj.is_r)){
	if(rootLineObj.value){
		feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, " oldKeywords=" oldKeywords "`n"  " newKeywords=" newKeywords "`n" ObjSToStrTrim(s:="", rootCollectObj) s )
		valud2DB := rootLineObj.value ; add a replacment or simple sting 13.11.2018 10:26
		AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, valud2DB , 0,"ForceLearn",LearnedWordsCount, rootCmdTypeObj.is_IndexedAhkBlock)
	}
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ">ROOT>'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
	return "break"
}


if( !rootDoObj.collectBlock && !rootDoObj.createKeys && CheckValid(rootLineObj.value) ){
	AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, rootLineObj.value , 0,"ForceLearn",LearnedWordsCount, isIndexedAhkBlock)
	if(g_config["FuzzySearch"]["enable"] && Aindex < g_config["FuzzySearch"]["MAXlines"]){
		addFuzzySearch_in_generatedList(rootLineObj.value, ActionList,Aindex,LearnedWordsCount,g_config["FuzzySearch"]["keysMAXperEntry"],g_config["FuzzySearch"]["minKeysLen"])
	}
	Return "continue"
}

        ;/¯¯¯¯ if(rootDoObj.collectBlock) ¯¯ 181111201107 ¯¯ 11.11.2018 20:11:07 ¯¯\
if(rootDoObj.collectBlock && ( Aindex <> rootLineObj.Aindex ) ){	
	; lets waiting for the end of the Block 18-11-12_20-13
	cto := rootCmdTypeObj ; For shorter reading
	isPrefixMultilineAHK := ( cto.codePrefixChar == "(" || cto.codePrefixChar == "[" )
	strDebugByRef .= "`n  /" ALoopField "≠" rootLineObj.value "└" cto.codePrefixChar "=" rootCmdTypeObj.codePrefixChar "┘  " 
	if(isPrefixMultilineAHK && trim(ALoopField) == ")"){
					; ObjSToStrTrim(strDebugByRef,rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj)
		rootCollectObj.value .= "send,`% it`n"
		valud2DB := rootLineObj.value  "`n" rootCollectObj.value
		AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, valud2DB , 0,"ForceLearn",LearnedWordsCount, isIndexedAhkBlock)
					; if(g_config["FuzzySearch"]["enable"] && Aindex < g_config["FuzzySearch"]["MAXlines"])
					; 	addFuzzySearch_in_generatedList(valud2DB, ActionList,Aindex,LearnedWordsCount,g_config["FuzzySearch"]["keysMAXperEntry"],g_config["FuzzySearch"]["minKeysLen"])
					; break ; <============= debugging
		if(IsAtEOF){
			msgbox,% A_LineNumber   "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
			BreakOrContinue := "break"
		}
		Return "continue"
	}
	
	
	if(RegExMatch( ALoopField , "i)\bGi\s*\:\s*do_indexFollowingLines4search\s*[\:]?=\s*true\b" )) { ; Gi: do_indexFollowingLines4search := true
		rootCmdTypeObj.is_IndexedAhkBlock := true
		Return "continue"
		; comments: https://autohotkey.com/boards/viewtopic.php?f=6&t=45684&p=242652&hilit=do_indexFollowingLines4search#p242652
		; no entry: https://g-intellisense.myjetbrains.com/youtrack/issues?q=project:%20g-IntelliSense%20do_indexFollowingLines4search
	}	
	
	if(contLineObj.Aindex <= rootLineObj.Aindex &&  contLineObj.Aindex){ ; contLineObj.Aindex  is at the beginning empty
		m := contLineObj.Aindex " < " rootLineObj.Aindex	
		if(1 && InStr(A_ComputerName,"SL5") )
			ToolTip, % m " never happens ??? 18-11-15_00" "`n(" ActionList ">" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
	}
	
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ">ROOT>'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	
	; lets waiting for the end of the Block 18-11-12_20-13
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	if(Aindex <> rootLineObj.Aindex ){
		lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
		contLineObj := { value:ALoopField, Aindex: Aindex }
		isCommandType_inBlock := setCommandTypeS(contLineObj, contCmdTypeObj, contCollectObj, contDoObj )
		lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	}
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	;ObjSToStrTrim(strOfAllResultsForAnalysisOrDebugging,contLineObj, contCmdTypeObj, contCollectObj, contDoObj )
;	feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	
	; feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber,Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ">ROOT>'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
	; feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber,Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	; g_ignReg["feedbackMsgBox"]["tit"] := "."
	
	
	; if(isCommandType_inBlock)
	; feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, isCommandType_inBlock "=isCommandType_inBlock , " ObjSToStrTrim(s:="", rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
	
	lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ":'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",contLineObj, contCmdTypeObj, contCollectObj, contDoObj) s )
	
	
	isIndexEqual := ( contLineObj.Aindex <> rootLineObj.Aindex ) 
	isRelavantCommandFound := ( contDoObj.collectBlock ) ; !isIndexEqual && 
	if( isRelavantCommandFound || IsAtEOF){
		if( !contDoObj.collectBlock  )
			rootCollectObj.value .= contLineObj.value "`n"
		if( !rootLineObj.newKeywords 
		&& ( rootDoObj.createKeys || rootCmdTypeObj.is_without_keywords ) ) 
			rootLineObj.newKeywords := getAutoKeywords(rootLineObj.oldKeywords , rootCollectObj.value)
		if(isPrefixMultilineAHK)
			rootCollectObj.value .= ")`nSend,% it"
		if(0 && rootCmdTypeObj.is_without_keywords){
			strDebugByRef .= ">>>>>" rootCmdTypeObj.is_without_keywords
			msgBox, % strDebugByRef "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
		}
		valud2DB := rootLineObj.newKeywords  " " rtrim(rootLineObj.value," `t`r`n") "`n" rootCollectObj.value 
		AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, valud2DB , 0,"ForceLearn",LearnedWordsCount, isIndexedAhkBlock)
		global g_config
		;lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ">ROOT>'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
		if( false 
&& rootCmdTypeObj.is_without_keywords) { ; ; && g_config["FuzzySearch"]["enable"] ; && Aindex < g_config["FuzzySearch"]["MAXlines"]
			lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ">ROOT>'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
			addFuzzySearch_in_generatedList(valud2DB, ActionList,Aindex,LearnedWordsCount
			,g_config["FuzzySearch"]["keysMAXperEntry"],g_config["FuzzySearch"]["minKeysLen"])

; Pause,On
		}
		
		; 
		
		if(IsAtEOF)
			Return "break"
		; Now we can reuse the END as the BEGINNING (copy that):
		feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, ObjSToStrTrim(s:="", rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
		rootLineObj.Aindex := Aindex ; this explicite copy of eache attribute does no speccel effect. dont need it probalby 18-11-14_23-24
		; rootLineObj.Aindex := contLineObj.Aindex
		rootLineObj.Aindex := Aindex ; this explicite copy of eache attribute does no speccel effect. dont need it probalby 18-11-14_23-24
		rootLineObj.value := contLineObj.value
		rootLineObj.oldKeywords := "" ; contCmdTypeObj.oldKeywords
		rootLineObj.newKeywords := "" ; contCmdTypeObj.oldKeywords
		
		rootCmdTypeObj.codePrefixChar := contCmdTypeObj.codePrefixChar
		rootCmdTypeObj.is_ended := contCmdTypeObj.is_ended
		rootCmdTypeObj.is_IndexedAhkBlock := contCmdTypeObj.is_IndexedAhkBlock ; is_
		rootCmdTypeObj.is_multiline_r := contCmdTypeObj.is_multiline_r
		rootCmdTypeObj.is_multiline_rr := contCmdTypeObj.is_multiline_rr
		rootCmdTypeObj.is_r := contCmdTypeObj.is_r
		rootCmdTypeObj.is_rr := contCmdTypeObj.is_rr
		rootCmdTypeObj.is_str := contCmdTypeObj.is_str
		rootCmdTypeObj.is_synonym := contCmdTypeObj.is_synonym
		rootCmdTypeObj.is_without_keywords := contCmdTypeObj.is_without_keywords
		backup := g_ignReg["feedbackMsgBox"]["tit"] ;
		rootCollectObj.value := contCollectObj.value
		rootDoObj.collectBlock := true
		
		; g_ignReg["feedbackMsgBox"]["tit"]  :=  ".^"  means ingnores nothing
		contLineObj.Aindex := 0
		contLineObj.value := ""
		contLineObj.oldKeywords := ""
		contLineObj.newKeywords := ""
		contCmdTypeObj.codePrefixChar := ""
		contCmdTypeObj.is_ended := false
		contCmdTypeObj.is_IndexedAhkBlock := false
		contCmdTypeObj.is_multiline_r := false
		contCmdTypeObj.is_multiline_rr := false
		contCmdTypeObj.is_r := false
		contCmdTypeObj.is_rr := false
		contCmdTypeObj.is_str := false
		contCmdTypeObj.is_synonym := false
		contCmdTypeObj.is_without_keywords := false
		contCollectObj.value := ""
		contDoObj.collectBlock := false
		Return "continue"
	} ; EndOf isCommandType_inBlock  
	
	if( 1 && ALoopField == "|r|"){ 
		lll( A_LineNumber , A_LineFile , A_ThisFunc "`n" Aindex ">ROOT>'" ALoopField "'=ALoopField`n" ObjSToStrTrim(s:="",rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
		msgbox,%A_LineNumber% could never happen 18-11-15_14-52
	}	
	rootCollectObj.value .= ALoopField "`n"  ; there may not be any no content object here
	
	; weeee are inside a block ... 
	backup := g_ignReg["feedbackMsgBox"]["tit"] ;
	g_ignReg["feedbackMsgBox"]["tit"]  :=  backup
	Return "continue"
} ; EndOf: if(rootDoObj.collectBlock)
;\____ if(rootDoObj.collectBlock)
; Return "continue"
if(ALoopField == "|r|"){
	msgbox,%A_LineNumber%: could never happen 18-11-15_14-52
}
Return "break"
}





;/¯¯¯¯ Loop_Parse_ParseWords ¯¯ 181114082712 ¯¯ 14.11.2018 08:27:12 ¯¯\
Loop_Parse_ParseWords(ByRef ParseWords){
	global g_config
	global ActionList
	global doReadThisActionListEverySeconds
	
	global strDebugByRef
	
	
	devTestTxtFile := doReadThisActionListEverySeconds "_temp.txt"
	
	; rootLineObj := { value: "" }
	
	rootLineObj := { value: "", Aindex: 0, oldKeywords:"", newKeywords:"" }
	rootCmdTypeObj :=  { is_str: false , is_r: false , is_rr: false, is_multiline_r: false, is_multiline_rr: false }
	rootCollectObj := { value: "", is_ended: false } ; .value .is_ended
	rootDoObj := { collectBlock: false, createKeys: false}
	
	contLineObj := { value: "", Aindex: 0, oldKeywords:"", newKeywords:"" }
	contCmdTypeObj := { is_str: false , is_r: false , is_rr: false, is_multiline_r: false, is_multiline_rr: false }
	contCollectObj := { value: "", is_ended: false } ; .value .is_ended
	contDoObj := { collectBlock: false, createKeys: false}
	
	strOfAllResultsForAnalysisOrDebugging	:= "" ; ObjSToStrTrim(strOfAllResultsForAnalysisOrDebugging,)
	strDebug4insert	:= "" 
	strDebugByRef	:= "" ; ObjSToStrTrim(strOfAllResultsForAnalysisOrDebugging,)
	
	Aindex := 0
	ALoopField := ""
	IsAtEOF := false
	Loop, Parse, ParseWords , `n, `r
	{
		Aindex := A_Index
		ALoopField := A_LoopField
		ParseWordsSubCount++
		; ALoopField := trim(A_LoopField,"`r`n")
		;ALoopField := trim(A_LoopField,"`r`n")
		
		BreakOrContinue := Loop_Parse_ParseWords_LoopField(IsAtEOF
, Aindex, ALoopField
, strDebug4insert, strDebugByRef
, rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj
, contLineObj, contCmdTypeObj, contCollectObj, contDoObj )
		
		; msgBox, % ALineNumber
		
	}
	; msgBox , % BreakOrContinue 
	if(BreakOrContinue <> "break"){ ; The loop is artificially kept alive one time. so that the event enofOfFile can be responded inside there.
		IsAtEOF := true
		Aindex++
		ALoopField := ""
		; msgBox , % Aindex
		Loop_Parse_ParseWords_LoopField(IsAtEOF ; only this shows that the file is at the end. everything else stays the same
, Aindex, ALoopField ; simulate a longer run.
, strDebug4insert, strDebugByRef
, rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj
, contLineObj, contCmdTypeObj, contCollectObj, contDoObj )
	}
	
	;msgBox, % "strDebugByRef = " strDebugByRef  "`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\")
	
	return strDebug4insert ; strDebugByRef ; interesting its not be changed in this function but it is passed by reference } }}  } } } } } } } } } 
	
	   ; https://autohotkey.com/boards/viewtopic.php?f=6&t=45684&p=242652&hilit=do_indexFollowingLines4search#p242652
        ; if(rootDoObj.collectBlock){
        ; 	if(RegExMatch( A_LoopField , "i)\bGi\s*\:\s*do_indexFollowingLines4search\s*[\:]?=\s*true\b" )) {
        ; 		    ; Gi: do_indexFollowingLines4search := true
        ; 		rootCmdTypeObj.is_IndexedAhkBlock := true
        ; 		rootDoObj.collectBlock := false
        ; }	}
	
	
        ; ALoopField  := RegExReplace(ALoopField, "^\s+" , "" ) ; like ltrim or the same? 06.11.2017 18:28
        ;	if(RegExMatch( ALoopField , "i)^([^; ]*[^\n]+\|rr\|[ ]*$",  m )){
        ;		; if(0 && InStr(A_ComputerName,"SL5"))
        ;		speak("Synonym found","PROD")
	
        ; regIs_r_synonym := "^([^\|\n]+?)\|r\|[ ]*$"
        ; if(RegExMatch( ALoopField , regIs_r_synonym ,  m )){
        ;	rX := {key:m1, rr:"r", send:"", lang:"" ,code:""}
            ; create a working synonym:
        ;	ALoopField := rX["key"] "|rr||ahk|"
		;\____ Loop __ 181109170852 __ 09.11.2018 17:08:52 __/
        ; } until (File.AtEOF)
	
}











;/¯¯¯¯ setCommandTypeS ¯¯ 181110182307 ¯¯ 10.11.2018 18:23:07 ¯¯\
;/¯¯¯¯ setCommandTypeS ¯¯ 181110182307 ¯¯ 10.11.2018 18:23:07 ¯¯\
;/¯¯¯¯ setCommandTypeS ¯¯ 181110182307 ¯¯ 10.11.2018 18:23:07 ¯¯\
;/¯¯¯¯ setCommandTypeS ¯¯ 181110182307 ¯¯ 10.11.2018 18:23:07 ¯¯\
;/¯¯¯¯ setCommandTypeS ¯¯ 181110182307 ¯¯ 10.11.2018 18:23:07 ¯¯\
; Whether you pass an object as ByRef or not ByRef, any changes to the object are permanent. Does whether a parameter is ByRef or not have any effect on objects? Are there performance advantages/disadvantages, or other consequences? https://autohotkey.com/boards/viewtopic.php?t=46310
setCommandTypeS(rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj ){
		; .is_str .is_r .is_rr .is_multiline_r .is_multiline_rr .codePrefixChar
		; .value .is_ended
    ; rootCmdTypeObj := { is_str: ...
    ; rootCollectObj := { value: value, is_ended: is_ended }
    ; Speak( A_ThisFunc, "PROD" )
	if(trim(!rootLineObj.value)){
		return false
	}
	regIs_r  := "^([^\|\n]+?)\|r\|.+"
	if(RegExMatch( rootLineObj.value , regIs_r ,  m )){
		rootDoObj.collectBlock := false
		rootCmdTypeObj.is_r := true
	}else{
		rootCmdTypeObj.is_r := false
	}
	
	regIs_multiline_r  := "^([^\|\n]+?)\|r\|([ ]*?)$"
	if(RegExMatch( rootLineObj.value , regIs_multiline_r ,  m )){
		rootDoObj.collectBlock := true
		rootCmdTypeObj.is_multiline_r := true
		rootCollectObj.value := ALoopField
	}
	
	if(0){
	   ; deprecated since 22.10.2018 12:13
		if(InStr(A_ComputerName,"SL5"))
			msgBox,% ALoopField "??? deprecated since 22.10.2018 12:13(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		regIs_r_synonym := "^([^\|\n]+?)\|r\|[ ]*$"
		if(RegExMatch( ALoopField , regIs_r_synonym ,  m )){
			rX := {key:m1, rr:"r", send:"", lang:"" ,code:""}
                                ; create a working synonym:
			ALoopField := rX["key"] "|rr||ahk|"
                                ; msgBox,% ALoopField "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		}
	}
	
	if(RegExMatch( rootLineObj.value , "i)^([^; ]*[^\n]+\|rr\|[ ]*$",  m )){
		rootCmdTypeObj.is_rr := true
		rootCmdTypeObj.is_synonym := true
		if(1 && InStr(A_ComputerName,"SL5")){
			; speak("Synonym found","PROD")
			tooltip,% ALoopField "`nSynonym found :)`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ,% ":)`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
			msgbox,% ALoopField "`nSynonym found :)`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ,% ":)`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		}
	}else
		rootCmdTypeObj.is_rr := false
	
	if(RegExMatch( rootLineObj.value , "i)^([^; ]*[^\n]+\|ahk\|)[^\s]{2,}+",  m )){
		rootCmdTypeObj.is_rr := true
		rootCmdTypeObj.is_IndexedAhkBlock := false ; maybe its set in next line
	}
	
	
	if(RegExMatch( rootLineObj.value , "i)^([^; ]*[^\n]+\|ahk\|)([^\s]?)[ ]*$",  m )){
		rootCmdTypeObj.is_rr := true
		rootCmdTypeObj.is_IndexedAhkBlock := false ; maybe its set in next line
		if(m2){
			if(m2 == "(" || m2 == "["){
				if(m2 == "[")
					rootCmdTypeObj.is_IndexedAhkBlock := true
				rootCmdTypeObj.codePrefixChar := m2
				m2 := "`it =`n(`n"
                ; MsgBox,% codePrefixChar "=codePrefixChar(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
				rootDoObj.collectBlock := true ; may not  unnecessary action
				rootCmdTypeObj.is_multiline_rr := true ; may not  unnecessary action
			}
			; rootCollectObj.value := m1 m2
			rootCollectObj.value := m2 
		}
        ; msgbox,% rootCollectObj.value
	}
	
	
	if(RegExMatch( rootLineObj.value , "i)^([^; ]*[^\n]+\|rr\|)(ahk\|)[ ]*$",  m )){
		speak("Maybe an ERROR?","PROD")
		sleep,2000
		probablyTried := (m2) ? m1 "|ahk|" : m1 "|ahk|"
		rootCmdTypeObj.is_rr := true
		rootLineObj.value := ""
    					;MsgBox,262208,% "Maybe an ERROR?",% ALoopField "`n is recognized as a simple text.`n Or do you actually want : `n`n" probablyTried "`n`n ? Thats what you want? :)`n`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	}
	
	rootCmdTypeObj.is_multiline_rr := false ; todo: thats a dirty bugfix . 10.11.2018 23:19
	if(RegExMatch( rootLineObj.value , "i)^([^;\n ]*[^\n]+\|ahk\|)([^\s\n]?)[ ]*$",  m )){
		rootCmdTypeObj.is_multiline_rr := true
		rootDoObj.collectBlock := true
	}
	
    ;/¯¯¯¯ collectBlock ¯¯ 181111082347 ¯¯ 11.11.2018 08:23:47 ¯¯\
	regIs_without_keywords  := "^\|(r|rr)\|"
	if(RegExMatch( rootLineObj.value , regIs_without_keywords, m )){
		if(m1=="r"){
			; rootLineObj.value := "" A_ThisFunc A_LineNumber " " rootLineObj.value ; for testing during deevlopment 06.11.2018 11:15
			;rootCmdTypeObj.is_r := true
			rootCmdTypeObj.is_multiline_r := true
		}if(m1=="rr"){
			;rootCmdTypeObj.is_rr := true
			rootCmdTypeObj.is_multiline_rr := true
		}
		rootCmdTypeObj.is_without_keywords := true 
		; rootCollectObj.value := "" 
		rootDoObj.createKeys := true ; https://g-intellisense.myjetbrains.com/youtrack/issues?q=project:%20g-IntelliSense#issueId=GIS-65
		rootDoObj.collectBlock := true
		 ; feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, ObjSToStrTrim(s:="", rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj) s )
	} 
    ;\____ collectBlock __ 181111082353 __ 11.11.2018 08:23:53 __/
	
	
	if(rootDoObj.collectBlock){
		if(!rootCmdTypeObj.codePrefixChar)
			rootCollectObj.value := "" ; initialice so later you could use .=
	}
	
	; now plausibility checks. proof of programer does Bullshit or was lazy 10.11.2018 09:47
	o := rootCmdTypeObj ; https://autohotkey.com/boards/viewtopic.php?f=76&t=58979&p=248157#p248157
	
	if(!o.is_multiline_rr){
		rootCmdTypeObj.is_IndexedAhkBlock := false
		rootCmdTypeObj.codePrefixChar := ""
	}
	if(o.is_multiline_rr){
		rootCmdTypeObj.is_str := false
		o.is_r := false
		o.is_rr := false
		o.is_multiline_r := false
        ; o.is_multiline_rr := false
		
		
	}else if(o.is_multiline_r){
		rootCmdTypeObj.is_str := false
		o.is_r := false
		o.is_rr := false
        ;o.is_multiline_r := false
		o.is_multiline_rr := false
	}else if(o.is_rr){
		
	    ; rootDoObj.collectBlock ; o.is_rootCollectObj: = false
		
		o.is_str := false
		o.is_r := false
        ; o.is_rr := false
        ;o.is_multiline_r := false
        ;o.is_multiline_rr := false
	}else if(o.is_r){
		
		    ; rootDoObj.collectBlock ; o.is_rootCollectObj: = false
		
		o.is_str := false
        ; o.is_r := false
		o.is_rr := false
        ;o.is_multiline_r := false
        ;o.is_multiline_rr := false
	}else if(!o.is_r && !o.is_rr && !o.is_multiline_r && !o.is_multiline_rr ){
		
	    ; rootDoObj.collectBlock ; o.is_rootCollectObj: = false
	   	; feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, ObjSToStrTrim(s,rootLineObj) s )
		o.is_str := true
	}
	if(o.is_str){
		o.is_r := false
		rootDoObj.collectBlock := false
		rootDoObj.createKeys := false 		
        ; o.is_multiline_r := false
        ; o.is_multiline_rr := false
	   	; feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, ObjSToStrTrim(s,rootLineObj) s )
		
		return false
	}
	return true
}
;\____ ReadActionList __ 181107175022 __ 07.11.2018 17:50:22 __/







;/¯¯¯¯ addListOpenAction_ifNotAlreadyInTheList ¯¯ 181107004221 ¯¯ 07.11.2018 00:42:21 ¯¯\
addListOpenAction_ifNotAlreadyInTheList(contentActionList,ActionList){
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
; thats a way how you could add ActionList lines vocabularies inside onlive 12.08.2017 23:24
; if you may destroy your path to your config file, thats a way to find it again.
;                        foundOpenLibLine := 0
	
	regEx__ := "m)^\s*__+[^`n]*\|rr\|\|ahk\|"
	
;                        foundOpenLibLine  := RegExMatch(A_LoopField, regEx__ )
	contentActionList_first432lines := SubSTr( contentActionList , 1 , 432 ) ; we dont wann search the complete file. takes to much time :) 12.08.2017 23:02 17-08-12_23-02
	
; adds a ___open library if not into the ActionList
	
	postFixGenerated := "._Generated.ahk"
	ActionListPostFix  := SubStr(ActionList, - StrLen(postFixGenerated) + 1 )
	itsAGeneratedList := ( postFixGenerated == ActionListPostFix )
        ; MsgBox,% msg "its a " postFixGenerated "`n ==> leave it hidden (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	if(!itsAGeneratedList && !RegExMatch(contentActionList_first432lines, regEx__ ) ){
		ToolTip,% ActionList "`n`n " A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")   " "   A_thisFunc
		SplitPath, ActionList, , , , OutNameNoExt
		temp := "___open " OutNameNoExt "(ActionList.ahk~" A_LineNumber "|rr||ahk|openInEditor," OutNameNoExt ".ahk"
		
		if(true){
			AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, temp,0,"ForceLearn",LearnedWordsCount)   ; springt dann in zeile 490 ungefähr
		}else{
			
            ; ; work but now we use the database direcly 18-10-03_21-51 OR???? ; work but now we use the database direcly 18-10-03_21-51 todo: need to be discussed. not importend
            ; or: regPatt := "^[^\n]*?([^\.\\\n]+)[^\\\n]*$"
            ; temp := RegExReplace(temp, "\._Generated\.txt\s*$", "")
			contentActionList .= "`n" . temp  ; thats not performantly. :/ but works 12.08.2017 22:31 sl5.net todo:
            ; info := SubSTr( contentActionList , 1 , 150 ) ;     tooltip,%info% ... `n (%A_LineFile%~%A_LineNumber%) `
                        ; Msgbox,% temp "`n into `n`n" ActionList "`(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
		}
	}
	return contentActionList
}
;\____ addListOpenAction_ifNotAlreadyInTheList __ 181107004230 __ 07.11.2018 00:42:30 __/







;/¯¯¯¯ addFuzzySearch_in_generatedList ¯¯ 181107004148 ¯¯ 07.11.2018 00:41:48 ¯¯\
; addFuzzySearch_in_generatedList(ALoopField)
addFuzzySearch_in_generatedList(ActionStr, ActionList, lineNr, ByRef LearnedWordsCount, addKeysMAX := 7, minKeysLen := 4, doValueCopy := true){
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
    ; || !instr(ActionList,"Generated.ahk")
	if( !lineNr ){
		Msgbox,% lineNr " `n= lineNr ActionList=" ActionList "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		return false
	}
	
	if( !ActionStr ){ ;_ahk_global.ahk._Generated.ahk
        ; examples log 02.10.2018 19:56: ..\ActionLists\_globalActionLists\pfade.ahk(378 ActionList.ahk)
	    ; Msgbox,% ActionList "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		if(0 && instr(ActionList,"Notepad_Administrator"))
			Msgbox,% ActionList " `nlast=" substr(ActionStr ,0) "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		return false
	}
	
	
    ;Msgbox,% ActionStr " `nlast=" substr(ActionStr ,0) "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	if( substr(ActionStr,0) == "|" ){
		if(0 && instr(ActionList,"Notepad_Administrator"))
			Msgbox,% ActionStr " `nlast=" substr(ActionStr ,0) "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		return false ; dont create synonyms from synonyms
	}
	pattern := "i)^[ ]*[^#_;\n]+\w"
	if( !RegExMatch(ActionStr, pattern ) ){
	    ; Msgbox,% ActionStr "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		return false
	}
	
    ; synonymValue|rr|     ; synonymValue|rr||ahk|q=keyValue
    ; Msgbox,% "ActionStr= " ActionStr "`n " `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    ;tooltip,% value " `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	
	if(pos1 := InStr( ActionStr , "|" )){
		ActionStrKey := substr(ActionStr  ,1, pos1 - 1 )
		ActionStrVal := substr(ActionStr , pos1 )
		; Msgbox,% ActionStr "`n`nk= " ActionStrKey ", v= " ActionStrVal "`n `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	}else{
		ActionStrKey := ActionStr
		ActionStrVal := ""
	}
	
	
    ; asdlkasdlf alsdk aösldkf aösldkfjasdölfkj
	
	camelCaseOr := "([^A-Z])[A-Z][a-z]+"
	normalOr := "([\W_-])[a-z]+"
	regEx := "(?:(" camelCaseOr "|" normalOr "))"
	StartingPosition  := 2
	addedKeysCounter := 0
	while(foundPos := RegexMatch( " " ActionStrKey, "O)" regEx, Match, StartingPosition - 1 )){
		StartingPosition := Match.Pos(1) + Match.Len(1)
		
		if(addedKeysCounter >= addKeysMAX)
			break
		if(a_index == 1) ; the first is stored into the complete ActionList
			continue
		preCar1 := Match.Value(2)
		preCar2 := Match.Value(3)
		;if(preCar1=="|" || preCar2=="|")
		;	break
		keyTemp := Match.Value(1)
		if(0 && instr(ActionList,"Notepad_Administrator"))
			MsgBox,% keyTemp "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		if(strlen(keyTemp)-1 < minKeysLen ){
			if(0 && instr(ActionList,"Notepad_Administrator"))
				MsgBox,% keyTemp "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
			continue
		}
		key := SubStr(   keyTemp  , 2)
		; MsgBox,% key " , " keyTemp "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		
        ; global g_config := { FuzzySearch:{ enable: true, keysMAXperEntry : 6, doValueCopy : false } } ; difficult to implement symlink copy for not rr lines doValueCopy. todo: issue . doValueCopy : false  is not fully implemented
		if(ActionStrVal){
			
			; MsgBox,% substr(ActionStrVal,1,4) "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
			
			
			msg =
			(
			>>%key%<<
			>>%ActionStrKey%<<
			>>%ActionStrVal%<<
			)
			; MsgBox,% msg  "`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
			
			if(substr(ActionStrVal,1,3)=="|r|")
				newListSynonym := key "" ActionStrVal
			else if(substr(ActionStrVal,1,4)=="|rr|"){
				newListSynonym := key "" ActionStrVal ; <=== eigentlich sollte es ja so gehen
			}else
				newListSynonym := key "|rr|ahk|" ActionStrVal ; <=== eigentlich sollte es ja so gehen
			; newListSynonym := key "|rr|ahk|" ActionStr ; <=== eigentlich sollte es ja so gehen
		;	newListSynonym := key ActionStrVal
		}else{
			newListSynonym := key "|r|" ActionStr
			; MsgBox,% newListSynonym "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		}
        ; newListSynonym := key "|rr|" ; <=== eigentlich sollte es ja so gehen
		
        ; Msgbox,% a_index ":`n" newListSynonym "`n ^- newListSynonym`n" newListSynonym "`n`n`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        ; Msgbox,% a_index ":`n" ActionStr "`n ^-ActionStr`n" newListSynonym "`n`n`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		if(0)
			msg =
		(
%ActionStr%

v= %ActionStrVal%
k= %ActionStrKey%

new = %newListSynonym%
		)
		msg .= "`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		if(0 && instr(ActionList,"Notepad_Administrator")){
            ; feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, msg )
			tooltip,% msg , 1 ,1
            ;MsgBox,% msg
			sleep,3000
		}
		; AddWordToList(strDebug4insert,strDebugByRef,A_LineNumber,Aindex, newListSynonym ,0,"ForceLearn") ; <==== NOT WORKING !!!
		AddWordToList(strDebug4insert,strDebugByRef,lineNr, newListSynonym ,0,"ForceLearn",LearnedWordsCount)   ; springt dann in zeile 490 ungefähr
		addedKeysCounter++
		; tooltip,% newListSynonym " `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	} ; endOf while
	return
} ; endIf addFuzzySearch_in_generatedList
;\____ addFuzzySearch_in_generatedList __ 181106192805 __ 06.11.2018 19:28:05 __/








;/¯¯¯¯ ReverseWordNums ¯¯ 181116123236 ¯¯ 16.11.2018 12:32:36 ¯¯\
ReverseWordNums(LearnedWordsCount){
   ; This function will reverse the read numbers since now we know the total number of words
	global prefs_LearnCount
	global g_ActionListDB
	global ActionList
	global g_ActionListID
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	LearnedWordsCount+= (prefs_LearnCount - 1)
	
	sql := "SELECT word FROM Words WHERE count IS NOT NULL ActionList = '" ActionList "';"
	LearnedWordsTable := g_ActionListDB.Query(sql)
	msgbox,%sql% 18-03-25_06-03
   ; LearnedWordsTable := g_ActionListDB.Query("SELECT word FROM Words WHERE count IS NOT NULL;")
	
	g_ActionListDB.BeginTransaction()
	For each, row in LearnedWordsTable.Rows
	{
		SearchValue := row[1]
		StringReplace, SearchValueEscaped, SearchValue, ', '', All
		WhereQuery := "WHERE word = '" SearchValueEscaped "' AND ActionListID = '" g_ActionListID "'"
		g_ActionListDB.Query("UPDATE words SET count = (SELECT " . LearnedWordsCount . " - count FROM words " . WhereQuery . ") " . WhereQuery . ";")
	}
	g_ActionListDB.EndTransaction()
	; too ti t ms lui tip uu
	Return
}
;\____ ReverseWordNums __ 181116123242 __ 16.11.2018 12:32:42 __/




;/¯¯¯¯ getAutoKeywords ¯¯ 181106121229 ¯¯ 06.11.2018 12:12:29 ¯¯\
getAutoKeywords(ByRef oldKeywords, ByRef words){
    ; AddWord rootDoObj.createKeys https://g-intellisense.myjetbrains.com/youtrack/issues?q=project:%20g-IntelliSense#issueId=GIS-65
	
	newKeyWords := oldKeywords " " words
	
	firstWord := "" ; backup if founds nothing
	
	addKeysMAX := 4
	minLength := 4
	
	camelCaseOr := "(?:[^A-Z]?)([A-Z][a-z]+)"
	normalOr := "()([\W_-][a-z]+)"
	regEx := "(?:(" camelCaseOr "|" normalOr "))"
	StartingPosition  := 2
	addedKeysCounter := 0
	
	Array := [] ; or Array := Array()
	while(foundPos := RegexMatch( " " newKeyWords, "O)" regEx, Match, StartingPosition - 1 )){
		StartingPosition := Match.Pos(1) + Match.Len(1)
		
		if(addedKeysCounter >= addKeysMAX)
			break
		preCar1 := Match.Value(2)
		preCar2 := Match.Value(3)
    		;if(preCar1=="|" || preCar2=="|")
    		;	break
		if(Match.Value(4))
			keyTemp := Match.Value(4)
		else if(Match.Value(3))
			keyTemp := Match.Value(3)
		else if(Match.Value(2))
			keyTemp := Match.Value(2)
		
		
		s:= ""
		loop,4
			s .= A_Index ":" Match.Value(A_Index) "#"
    	; MsgBox,% s "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		
		trim_keyTemp := trim(keyTemp," `t`r`n")
		if(0)
			MsgBox,% ">" trim_keyTemp "<  (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		if(!HasVal(Array,trim_keyTemp)){
			if(!firstWord)
				firstWord := trim_keyTemp
			if(minLength <= strlen(trim_keyTemp))
				Array.Push(trim_keyTemp) ; Append this line to the array.
			ArrayCount++
		}
		
    	; MsgBox,% keyTemp
	}
	newKeyWords := ""
	Loop % ArrayCount
	{
        ; element := Array%A_Index%
		element := Array[A_Index]
        ; MsgBox % "Element number " . A_Index . " is " . Array%A_Index%
		newKeyWords .= element " "
	}
	if(!newKeyWords := rTrim(newKeyWords))
		if(!newKeyWords := firstWord)
			newKeyWords := "without keywords"
        ; MsgBox % "Element number " . A_Index . " is " . Array%A_Index%
	if(0 && InStr(A_ComputerName,"SL5"))
		feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, "newKeyWords=" newKeyWords )
	return newKeyWords
}
;\____ getAutoKeywords __ 181106121233 __ 06.11.2018 12:12:33 __/


HasVal(haystack, needle) { ; return index
	if !(IsObject(haystack)) || (haystack.Length() = 0)
	 	return 0
	for index, value in haystack
	{
		if (value = needle)
			return index
	}
	return 0
}



;/¯¯¯¯ AddWordToList(strDebug4insert,strDebugByRef, ¯¯ 181106113409 ¯¯ 06.11.2018 11:34:09 ¯¯\
AddWordToList(ByRef strDebug4insert, ByRef strDebugByRef,fromLine,lineNr, AddWord,ForceCountNewOnly,ForceLearn:= false, ByRef LearnedWordsCount := false, is_IndexedAhkBlock := false) {
	
   ;AddWord = Word to add to the list
   ;ForceCountNewOnly = force this word to be permanently learned even if learnmode is off
   ;ForceLearn = disables some checks in CheckValid
   ;LearnedWordsCount = if this is a stored learned word, this will only have a value when LearnedWords are read in from the ActionList
	global prefs_DoNotLearnStrings
	global prefs_ForceNewWordCharacters
	global prefs_LearnCount
	global prefs_LearnLength
	global prefs_LearnMode
	global g_ActionListDone
	global g_ActionListDB
	global ActionList
;  foundPos := RegExMatch( "str" , "i)" )
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
;     Msgbox,% insert " = insert(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
	
	strDebugByRef .= "_____(" fromLine ">" A_LineNumber ")________________`n" ; interesting for debugging
	strDebugByRef .= Trim(AddWord," `t`r`n") "`n" ; interesting for debugging
	strDebug4insert   .= Trim(AddWord," `t`r`n") "`n"  ; interesting for debugging
	
	
	
   ;AddWord = Word to add to the list
	if(0 && AddWord)
		tooltip, % "AddWord = " AddWord  "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
   ;
	
	if !(LearnedWordsCount) {
		StringSplit, SplitAddWord,  AddWord, | ; old method 17.03.2017 17:54 17-03-17_17-54
         ; SplitAddWord := StrSplit(AddWord, "|")
         ; Tooltip,%A_LineNumber%: %AddWord%  ; show others its loading all this vocabularies 17.03.2017 19:44 17-03-17_19-44
		if(false){
         ;MsgBox,4 ,MaxIndex, % SplitAddWord.MaxIndex(), 5
			if( SplitAddWord.MaxIndex() > 3 )
				MsgBox, ,MaxIndex, % SplitAddWord.MaxIndex() . "`n" . AddWord ; z.B. 4 elements: eins|r|zwei|drei
			if(SplitAddWord2)
				tooltip, '%SplitAddWord2%' = SplitAddWord2 `n '%SplitAddWord3%' = SplitAddWord3 `n (line:%A_LineNumber%)
			if(SplitAddWord3)
				tooltip, '%SplitAddWord3%' = SplitAddWord3 `n (line:%A_LineNumber%) `n
			if(SplitAddWord4)
				tooltip, '%SplitAddWord4%' = SplitAddWord4  `n (line:%A_LineNumber%) `n
		}
		
		IfEqual, SplitAddWord2, D
		{
			AddWordDescription := SplitAddWord3
			AddWord := SplitAddWord1
			IfEqual, SplitAddWord4, R
			{
				AddWordReplacement := SplitAddWord5
			}
		} else IfEqual, SplitAddword2, R
		{
			AddWordReplacement := SplitAddWord3
			AddWord := SplitAddWord1
			IfEqual, SplitAddWord4, D
			{
				AddWordDescription := SplitAddWord5
			}
		}
	}
	
	if(!CheckValid(AddWord,ForceLearn, is_IndexedAhkBlock)){
        ; msgbox,% ">>" AddWord "<<`n is NOT valid(" A_LineNumber ": " A_ThisFunc " " RegExReplace(A_LineFile, ".*\\") ")"
		if(0 && InStr(A_ComputerName,"SL5"))
			Speak(A_LineNumber ":" rootLineObj.value ,"PROD")
		return false
	}
        ; msgBox,% "is valid: " AddWord "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
   ; TransformWord normalizes the word, converting it to uppercase and removing certain accented characters.
	TransformWord(AddWord, AddWordReplacement, AddWordDescription, AddWordTransformed, AddWordIndexTransformed, AddWordReplacementTransformed, AddWordDescriptionTransformed)
	
	
	
	
	IfEqual, g_ActionListDone, 0 ;if this is read from the ActionList
	{
		IfNotEqual,LearnedWordsCount,  ;if this is a stored learned word, this will only have a value when LearnedWords are read in from the ActionList
		{
         ; must update wordreplacement since SQLLite3 considers nulls unique
			INSERT_INTO_words := "INSERT INTO words (wordindexed, word, count, wordreplacement, ActionListID, lineNr) VALUES ('" AddWordIndexTransformed "', '" AddWordTransformed "', " LearnedWordsCount++ ", " g_ActionListID ", " lineNr ");"
			
        ; msgbox,% INSERT_INTO_words "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
			
			if(1 && InStr(A_ComputerName,"SL5")){
				Speak(A_LineNumber ":" INSERT_INTO_words ,"PROD")
				msgbox,% "never used ? 18-11-12_18-4" INSERT_INTO_words "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
			}
			
			try{
				g_ActionListDB.Query(INSERT_INTO_words)
			} catch e{
				tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
				sqlLastError := SQLite_LastError()
				tip .= "`n sqlLastError=" sqlLastError "`n sql=" INSERT_INTO_words " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
				lll(A_LineNumber, A_LineFile, tip)
				tooltip, `% tip
				feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, tip )
				Clipboard := tip
				msgbox, % tip
			}
			
			
		} else {
			if (AddWordReplacement)
			{
				WordReplacementQuery := "'" . AddWordReplacementTransformed . "'"
			} else {
				WordReplacementQuery := "''"
			}
			
			if (AddWordDescription)
			{
				WordDescriptionQuery := "'" . AddWordDescriptionTransformed . "'"
			} else {
				WordDescriptionQuery := "NULL"
			}
			INSERT_INTO_words := "INSERT INTO words (wordindexed, word, worddescription, wordreplacement, ActionListID, lineNr) VALUES ('"  AddWordIndexTransformed  "','"  AddWordTransformed . "',"  WordDescriptionQuery  ","  WordReplacementQuery  "," g_ActionListID ", " lineNr ");"
			
			
			
        ; msgbox,% INSERT_INTO_words "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
			
			try{
				g_ActionListDB.Query(INSERT_INTO_words)
				
				
			; ############ here it runs :) 18-11-12_18-46
				if(0 && InStr(A_ComputerName,"SL5")){
                    ;if(1 && instr(rootLineObj.value,"nasenbar")){
					Speak(A_LineNumber "" ,"PROD")
					msgbox,% "never used???? 18-11-12_18-41" INSERT_INTO_words "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
                    ;}
				}
				
				
			} catch e{
				tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
				sqlLastError := SQLite_LastError()
				tip .= "`n sqlLastError=" sqlLastError "`n sql=" INSERT_INTO_words " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
				lll(A_LineNumber, A_LineFile, tip)
				tooltip, `% tip
				feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, tip )
				Clipboard := tip
				msgbox, % tip
			}
			
			
			
		}
      ; Yes, wordindexed is the transformed word that is actually searched upon.
		
	} else if (prefs_LearnMode = "On" || ForceCountNewOnly == 1)
	{
      ; If this is an on-the-fly learned word
		AddWordInList := g_ActionListDB.Query("SELECT * FROM wordsre WHERE word = '" . AddWordTransformed . "';")
        if(1 && InStr(A_ComputerName,"SL5"))
            msgbox,% AddWordTransformed  " was ist das????`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

		IF !( AddWordInList.Count() > 0 ) ; if the word is not in the list
		{
			
			IfNotEqual, ForceCountNewOnly, 1
			{
				
			    ;/¯¯¯¯ return ¯¯  181110065558 ?? 10.11.2018 06:55:58 ??\
				IF (StrLen(AddWord) < prefs_LearnLength) ; don't add the word if it's not longer than the minimum length for learning if we aren't force learning it
					return false
				
				if AddWord contains %prefs_ForceNewWordCharacters%
					return false
				
				if AddWord contains %prefs_DoNotLearnStrings%
					return false
                ;\____ return __ 181110065602 __ 10.11.2018 06:56:02 __/
				
				CountValue = 1
				
			} else {
				CountValue := prefs_LearnCount ;set the count to LearnCount so it gets written to the file
			}
			
         ; must update wordreplacement since SQLLite3 considers nulls unique
			INSERT_INTO_words := "INSERT INTO words (wordindexed, word, count, wordreplacement, ActionListID, lineNr) VALUES ('" AddWordIndexTransformed "','"  AddWordTransformed  "','"  CountValue  "', " g_ActionListID ", " lineNr ");"
			
			msgbox,% INSERT_INTO_words "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
			
			try{
				g_ActionListDB.Query(INSERT_INTO_words)
				
				if(1 && InStr(A_ComputerName,"SL5")){
					Speak(A_LineNumber ":" INSERT_INTO_words ,"PROD")
					msgbox,% "never used????" INSERT_INTO_words "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
				}
				
			} catch e{
				tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
				sqlLastError := SQLite_LastError()
				tip .= "`n sqlLastError=" sqlLastError "`n sql=" INSERT_INTO_words " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
				lll(A_LineNumber, A_LineFile, tip)
				tooltip, `% tip
				feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, tip )
				Clipboard := tip
				msgbox, % tip
			}
			
			
		} else IfEqual, prefs_LearnMode, On
		{
			IfEqual, ForceCountNewOnly, 1
			{
				For each, row in AddWordInList.Rows
				{
					CountValue := row[3]
					break
				}
				
				IF ( CountValue < prefs_LearnCount )
				{
					g_ActionListDB.QUERY("UPDATE words SET count = ('" prefs_LearnCount "') WHERE word = '"  AddWordTransformed "' AND ActionListID = '" . g_ActionListID . "';")
				}
			} else {
				UpdateWordCount(AddWord,0) ;Increment the word count if it's already in the list and we aren't forcing it on
			}
		}
	}
	
	Return true
}
;\____ AddWordToList __ 181106193901 __ 06.11.2018 19:39:01 __/





;/¯¯¯¯ CheckValid ¯¯ 181106193909 ¯¯ 06.11.2018 19:39:09 ¯¯\
CheckValid(Word,ForceLearn:= false, is_IndexedAhkBlock := false){
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
	Ifequal, Word,  ;If we have no word to add, skip out.
	{
		lll( A_LineNumber , A_LineFile , A_ThisFunc  )
		
		Return
	}
	
	if Word is space ;If Word is only whitespace, skip out.
	{
		lll( A_LineNumber , A_LineFile , A_ThisFunc  )
		Return
	}
	
	if(is_IndexedAhkBlock){
		if(!RegExMatch( Word , "\S" )) ; search a nonspace in it
		{
			lll( A_LineNumber , A_LineFile , A_ThisFunc  )
			
			return
		}
	}else{
		if ( Substr(Word,1,1) = ";" ) ;If first char is ";", clear word and skip out.
		{
			lll( A_LineNumber , A_LineFile , A_ThisFunc  )
			
			Return
		}
		
    ;	if ( Substr(Word,1,1) = " " ) ; If first char is " ", clear word and skip out. spaces now have a special meaning. with spaces is not a kay. with spaces it could be eventually a value of a block
    ;		Return
        ; ALoopField  := RegExReplace(ALoopField, "^\s+" , "" ) ; anfangs leerzeichen raus 06.11.2017 18:28
		
		
		IF ( StrLen(Word) <= prefs_Length ){ ; don't add the word if it's not longer than the minimum length
			lll( A_LineNumber , A_LineFile , A_ThisFunc  )
			
			Return
		}
	}
	
   ;Anything below this line should not be checked if we want to Force Learning the word (Ctrl-Shift-C or coming from ActionList . txt)
	If ForceLearn
		Return, 1
	
   ;if Word does not contain at least one alpha character, skip out.
	IfEqual, A_IsUnicode, 1
	{
		if ( RegExMatch(Word, "S)\pL") = 0 )
		{
			
			lll( A_LineNumber , A_LineFile , A_ThisFunc  )
			return
		}
	} else if ( RegExMatch(Word, "S)[a-zA-ZÃ -Ã¶Ã¸-Ã¿Ã€-Ã–Ã˜-ÃŸ]") = 0 )
	{
		
		lll( A_LineNumber , A_LineFile , A_ThisFunc  )
		Return
	}
	
	Return, 1
}
;\____ CheckValid __ 181106193917 __ 06.11.2018 19:39:17 __/






;/¯¯¯¯ TransformWord ¯¯ 181106193925 ¯¯ 06.11.2018 19:39:25 ¯¯\
TransformWord(AddWord, AddWordReplacement, AddWordDescription, ByRef AddWordTransformed, ByRef AddWordIndexTransformed, ByRef AddWordReplacementTransformed, ByRef AddWordDescriptionTransformed) {
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
    ; TransformWord normalizes the word, converting it to uppercase and removing certain accented characters.
	
	AddWordIndex := AddWord
	
   ; normalize accented characters
	AddWordIndex := StrUnmark(AddWordIndex)
	
	StringUpper, AddWordIndex, AddWordIndex
	
	StringReplace, AddWordTransformed, AddWord, ', '', All
	StringReplace, AddWordIndexTransformed, AddWordIndex, ', '', All
	if (AddWordReplacement) {
		StringReplace, AddWordReplacementTransformed, AddWordReplacement, ', '', All
	}
	if (AddWordDescription) {
		StringReplace, AddWordDescriptionTransformed, AddWordDescription, ', '', All
	}
}
;\____ TransformWord __ 181106193931 __ 06.11.2018 19:39:31 __/




;/¯¯¯¯ DeleteWordFromList ¯¯ 181106193941 ¯¯ 06.11.2018 19:39:41 ¯¯\
DeleteWordFromList(DeleteWord){
	
	
	global prefs_LearnMode
	global g_ActionListDB
	global ActionList
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	Ifequal, DeleteWord,  ;If we have no word to delete, skip out.
	Return
	
	if DeleteWord is space ;If DeleteWord is only whitespace, skip out.
		Return
	
	IfNotEqual, prefs_LearnMode, On
	Return
	
	StringReplace, DeleteWordEscaped, DeleteWord, ', '', All
   ; g_ActionListDB.Query("DELETE FROM words WHERE word = '" . DeleteWordEscaped . "';")
	g_ActionListDB.Query("DELETE FROM words WHERE word = '" . DeleteWordEscaped . "' AND ActionListID = '" . g_ActionListID . "';")
	
	Return
}
;\____ DeleteWordFromList __ 181106193948 __ 06.11.2018 19:39:48 __/



;/¯¯¯¯ UpdateWordCount ¯¯ 181106193956 ¯¯ 06.11.2018 19:39:56 ¯¯\
UpdateWordCount(word,SortOnly){
	global prefs_LearnMode
	global g_ActionListDB
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
   ;Word = Word to increment count for
   ;SortOnly = Only sort the words, don't increment the count
	
   ;Should only be called when LearnMode is on
	IfEqual, prefs_LearnMode, Off
	Return
	
	IfEqual, SortOnly,
	Return
	
	StringReplace, wordEscaped, word, ', '', All
	g_ActionListDB.Query("UPDATE words SET count = count + 1 WHERE word = '" . wordEscaped . "';")
	
	Return
}
;\____ UpdateWordCount __ 181106194005 __ 06.11.2018 19:40:05 __/



;/¯¯¯¯ CleanupActionListOfThisActionList ¯¯ 181106194013 ¯¯ 06.11.2018 19:40:13 ¯¯\
CleanupActionListOfThisActionList(ActionList){
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
   ;Function cleans up all words from given ActionList
	Msgbox,not yet implemented `n (%A_LineFile%~%A_LineNumber%)
	g_ActionListDB.Query("DELETE FROM Words WHERE ActionListID = '" . g_ActionListID . "';")
}
;\____ CleanupActionListOfThisActionList __ 181106194018 __ 06.11.2018 19:40:18 __/




;/¯¯¯¯ CleanupActionListAll_ofLittleWordCount ¯¯ 181106194030 ¯¯ 06.11.2018 19:40:30 ¯¯\
CleanupActionListAll_ofLittleWordCount(LearnedWordsOnly := false){
	
   ;Function cleans up all words that are less than the LearnCount threshold or have a NULL for count
   ;(NULL in count represents a 'ActionList . txt' word, as opposed to a learned word)
	global g_ScriptTitle
	global g_ActionListDB
	global ActionList
	global prefs_LearnCount
;   Progress, M, Please wait..., Cleaning ActionList, %g_ScriptTitle%
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	if (LearnedWordsOnly) {
		g_ActionListDB.Query("DELETE FROM Words WHERE count < " . prefs_LearnCount . " AND count IS NOT NULL AND ActionListID = '" . g_ActionListID . "';")
	} else {
		g_ActionListDB.Query("DELETE FROM Words WHERE (count < " . prefs_LearnCount . " OR count IS NULL) AND ActionListID = '" . g_ActionListID . "';")
	}
   ;Progress, Off
}
;\____ CleanupActionListAll_ofLittleWordCount __ 181106194042 __ 06.11.2018 19:40:42 __/



;/¯¯¯¯ MaybeUpdateActionList ¯¯ 181106194051 ¯¯ 06.11.2018 19:40:51 ¯¯\
MaybeUpdateActionList(){
	return ; learnd words. dont need 07.02.2018 17:10
	global g_LegacyLearnedWords
	global g_ActionListDB
	global ActionList
	global g_ActionListID
	global g_ActionListDone
	global prefs_LearnCount
	
   ; Update the Learned Words
	IfEqual, g_ActionListDone, 1
	{
    ;
		SELECT := "SELECT Word FROM Words WHERE count >= " . prefs_LearnCount . " AND count IS NOT NULL AND ActionListID = '" . g_ActionListID . "' ORDER BY count DESC; "
		msgbox,% SELECT " 18-03-25_06-05"
        ;Clipboard := SELECT
		SortActionList := g_ActionListDB.Query(SELECT)
		
		for each, row in SortActionList.Rows
		{
			TempActionList .= row[1] . "`r`n"
		}
		
		If ( SortActionList.Count() > 0 )
		{
			StringTrimRight, TempActionList, TempActionList, 2
			
			FileDelete, %A_ScriptDir%\Temp_ActionListLearned.ahk
			FileAppendDispatch(TempActionList, A_ScriptDir . "\Temp_ActionListLearned.ahk")
			FileCopy, %A_ScriptDir%\Temp_ActionListLearned.ahk, %A_ScriptDir%\ActionListLearned.ahk, 1
			FileDelete, %A_ScriptDir%\Temp_ActionListLearned.ahk
			
         ; Convert the Old ActionList file to not have ;LEARNEDWORDS;
			IfEqual, g_LegacyLearnedWords, 1
			{
				TempActionList =
				FileRead, ParseWords, %A_ScriptDir%\%ActionList%
				LearnedWordsPos := InStr(ParseWords, "`;LEARNEDWORDS`;",true,1) ;Check for Learned Words
				TempActionList := SubStr(ParseWords, 1, LearnedwordsPos - 1) ;Grab all non-learned words out of list
				ParseWords =
				FileDelete, %A_ScriptDir%\Temp_ActionList.ahk
				FileAppendDispatch(TempActionList, A_ScriptDir . "\Temp_ActionList.ahk")
;            FileCopy, %A_ScriptDir%\Temp_ActionList.txt, %A_ScriptDir%\ActionList.txt, 1
				FileCopy, %A_ScriptDir%\Temp_ActionList.ahk, %ActionList%, 1 ; 02.03.2018 12:37 18-03-02_12-37
				FileDelete, %A_ScriptDir%\Temp_ActionList.ahk
			}
		}
	} ; __ __
	
	g_ActionListDB.Close(),
	
} ; EndOf: MaybeUpdateActionList
;\____ MaybeUpdateActionList __ 181106194100 __ 06.11.2018 19:41:00 __/





;/¯¯¯¯ StrUnmark ¯¯ 181106194109 ¯¯ 06.11.2018 19:41:09 ¯¯\
; Removes marks from letters.  Requires Windows Vista or later.
; Code by Lexikos, based on MS documentation
StrUnmark(string) {
	
	global g_OSVersion
	global g_NormalizationKD
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	if (g_OSVersion < 6.0)
	{
		return string
	}
	
    ;return string ; todo disabling has no sideEffects ?
    ;MsgBox,% "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	
	
	len := DllCall("Normaliz.dll\NormalizeString", "int", g_NormalizationKD, "wstr", string, "int", StrLen(string), "ptr", 0, "int", 0)  ; Get *estimated* required buffer size.
	Loop {
		VarSetCapacity(buf, len * 2)
		len := DllCall("Normaliz.dll\NormalizeString", "int", g_NormalizationKD, "wstr", string, "int", StrLen(string), "ptr", &buf, "int", len)
		if len >= 0
			break
		if (A_LastError != 122) ; ERROR_INSUFFICIENT_BUFFER
			return string
		len *= -1  ; This is the new estimate.
	}
   ; Remove combining marks and return result.
	string := RegExReplace(StrGet(&buf, len, "UTF-16"), "\pM")
	
	if(false){
		StringReplace, string, string, ?, ae, All
		StringReplace, string, string, ?, AE, All
		StringReplace, string, string, ?, oe, All
		StringReplace, string, string, ?, OE, All
		StringReplace, string, string, ?, ss, All
	}
	
	return, string
}
;\____ StrUnmark __ 181106194133 __ 06.11.2018 19:41:33 __/




;/¯¯¯¯ getActionListID ¯¯ 181106194141 ¯¯ 06.11.2018 19:41:41 ¯¯\
getActionListID(ActionList){
	
	global g_ActionListDB
	global g_ActionListDBfileAdress
	global g_ActionList_UsedByUser_since_midnight
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	if(!g_ActionListDB)
		g_ActionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_ActionListDBfileAdress ) ;
	if(!g_ActionListDB){
		msgbox,% "!g_ActionListDB`n `n (" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") ")"
	}
	sqlGetWLid =
    (
SELECT id, lastUsedByUser_since_midnight FROM ActionLists WHERE
ActionList = '%ActionList%' ;
    )
	try{
		result := g_ActionListDB.Query(sqlGetWLid)
		For each, row in result.Rows
		{
			g_ActionListID := row[1]
			g_ActionList_UsedByUser_since_midnight[g_ActionListID] := row[2]
			return g_ActionListID
		}
	} catch e{
		tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
		lll(A_LineNumber, A_LineFile, tip)
		tooltip, `% tip
		; feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, tip )
		; Clipboard := tip
		
		
		sqlLastError := SQLite_LastError()
		if( instr(sqlLastError, "no such column") || instr(sqlLastError, "no such table") ){
			RebuildDatabase()
			tooltip,% "  RebuildDatabase() ==> (" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
			sleep,5000
			reload
		}
		
	}
	
	size := 1 ; FIRST TIME EVER schuuld be done by reading the ActionList in other function
	modified := "1111-11-11" ; FIRST TIME EVER  ; schuuld be done by reading the ActionList in other function
        ; FileGetSize, ActionListSize, % ActionList
        ; FileGetTime, ActionListModified, % ActionList, M
        ; FormatTime, ActionListModified, % ActionListModified, yyyy-MM-dd HH:mm:ss
	
        ;INSERT_INTO_ActionLists_ifNotExist(ActionList, modified, size )
	try{
		result := g_ActionListDB.Query(sqlGetWLid)
	} catch e{
		tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
		sqlLastError := SQLite_LastError()
		tip .= "`n sqlLastError=" sqlLastError " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
		lll(A_LineNumber, A_LineFile, tip)
		tooltip, `% tip
		feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, tip )
		Clipboard := tip
	}
	For each, row in result.Rows
	{
		g_ActionListID := row[1]
		g_ActionList_UsedByUser_since_midnight[g_ActionListID] := row[2]
		return g_ActionListID
	}
	msg := sql . "`n" . sqlGetWLid
	sqlLastError := trim( SQLite_LastError() )
	msg .= "`n sqlLastError=" sqlLastError "`n `n (" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") ")"
	if(!g_ActionListID && sqlLastError){
          ; lll(A_LineNumber, A_LineFile, msg)
          ; clipboard := msg
          ; feedbackMsgBox("clipboard:=sql", msg)
          ; msgbox,% msg
          ; 
		if(  instr(sqlLastError, "no such table") ){
            ;if(A_TickCount < 1000){
			tip := "`n sqlLastError=" sqlLastError "`n g_ActionListDB=" g_ActionListDB " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
			tooltip, % tip
			RebuildDatabase() ; works ? 22.10.2018 05:23 todo:
			sleep,10
			return getActionListID(ActionList)
                ; return ; probalby enough only to wait 22.10.2018 04:56
            ;}
		}
		else if( instr(sqlLastError, "no such column") ){
			RebuildDatabase()
			msgbox,% "done: RebuildDatabase()`n `n " msg " (" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") ")"
			tooltip,% "  RebuildDatabase() ==> (" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
			sleep,5000
			reload
		}else{
			lll(A_LineNumber, A_LineFile, msg)
			msgbox,% sqlLastError "`n `n (" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") ")"
            ; inside: getActionListID
		}
		exitapp
	}
	
	if(A_TickCount - g_StartTime_TickCountMilli > 900 ){ ; its ok if happens at the very beginning
		m =
    (
    ERROR: this line should never visited

    ActionList = %ActionList%
    ActionListID = %ActionListID%
    sqlLastError = %sqlLastError%

    %sqlGetWLid%
    )
		
		
		tooltip,% m "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		lll(A_LineNumber, A_LineFile, m)
		msgbox,% m "`n `n (" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") ")"
	}
	; g_ActionList_UsedByUser_since_midnight[g_ActionListID] := lastUsedByUser_since_midnight
    ; g_ActionListDB.Query("UPDATE ActionList SET lastUsedByUser_since_midnight = " g_ActionList_UsedByUser_since_midnight[g_ActionListID] " WHERE id = " g_ActionListID ";")
	return ActionListID
}
;\____ getActionListID __ 181025115249 __ 25.10.2018 11:52:49 __/



;/¯¯¯¯ INSERT_INTO_ActionLists_ifNotExist ¯¯ 181106194154 ¯¯ 06.11.2018 19:41:54 ¯¯\
INSERT_INTO_ActionLists_ifNotExist(ActionList, ActionListModified, ActionListSize ){
	
	global g_ActionListDB
	global g_ActionListDBfileAdress
	if(!g_ActionListDB)
		g_ActionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_ActionListDBfileAdress ) ;
	ActionListID := getActionListID(ActionList) ; 24.03.2018 23:02
	if(ActionListID){
		tip=Oops ActionListID already exist `n ActionListID = %ActionListID% `n ActionList=%ActionList% `n  27.03.2018 22:37
		lll(A_LineNumber, A_LineFile, tip)
		return
	}
	INSERT_INTO_ActionLists(ActionList, FileGet_ActionListModified, FileGet_ActionListSize )
}
INSERT_INTO_ActionLists(ActionList, ActionListModified, ActionListSize ){
	
	global g_ActionListDB
	global g_ActionListDBfileAdress
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	if(!ActionListModified){
		msg := "Error`n !ActionListModified `n sql=" sql "`n" ActionList "`n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
		tooltip,% msg,1,1
		return false
	}
	sql := "INSERT INTO ActionLists "
	sql .= " (id, ActionList, ActionListmodified, ActionListsize) VALUES "
	sql .= " (null, '" ActionList "', '" ActionListModified "', '" ActionListSize "' );"
	if(!g_ActionListDB)
		g_ActionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_ActionListDBfileAdress ) ;
	try{
		g_ActionListDB.Query(sql)
	} catch e{
		tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
		sqlLastError := SQLite_LastError()
		tip .= "`n sqlLastError=" sqlLastError "`n sql=" sql " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
		lll(A_LineNumber, A_LineFile, tip)
		tooltip, `% tip
		feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, tip )
		Clipboard := tip
		msgbox, % tip
	}
}
;\____ INSERT_INTO_ActionLists_ifNotExist __ 181106194157 __ 06.11.2018 19:41:57 __/

