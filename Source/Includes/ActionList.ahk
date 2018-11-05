; These functions and labels are related maintenance of the ActionList


;

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
;

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
			Msgbox,% ":-( Oops `n " m " !g_ActionListID ==> return false `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
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
		{
			ActionListLastModified := row[1]
			ActionListLastSize := row[2]

            diffSize := Abs(FileGet_ActionListSize - ActionListLastSize)
            ;diffModified := Abs(FileGet_ActionListModified - ActionListLastModified) ; <==== acnt diff timestams this way todo:
            ;diffModified := FileGet_ActionListModified - ActionListLastModified ; <==== acnt diff timestams this way todo:
            isModified := (diffSize || FileGet_ActionListModified && ActionListLastModified && (FileGet_ActionListModified <> ActionListLastModified))
            if(1 && InStr(A_ComputerName,"SL5")){
                tip =
                (
                isModified=%isModified%
                := (FileModi=%FileGet_ActionListModified% ?= %ActionListLastModified%=last)
                %ActionList%

                %SELECT%
                )
                clipboard := SELECT
                toolTip2sec(tip "`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This,1,1)



                if(!ActionListLastModified){
                    sqlDELETE := "DELETE from ActionLists WHERE ActionListmodified = '';"
                    msgbox,ERROR Database ActionListLastModified is empty `n`n %sqlDELETE% `n`n %ActionList%
                    g_ActionListDB.Query(sqlDELETE)
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
				tooltip,% tip,1,1
				lll(A_LineNumber, A_LineFile, tip)
				CleanupActionListAll_ofLittleWordCount() ; i dont konw what for that is. try it without 18-10-06_21-40
			} else {

				LoadActionList =
				CleanupActionListAll_ofLittleWordCount(true) ; i dont konw what for that is. try it without 18-10-06_21-40
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

		ParseWords := addListOpenAction_ifNotAlreadyInTheList(ParseWords,ActionList)

      INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)

		if(false){ ; todo: braucht man für die aktualliserung der listen niht. gerade getestet. gerade was hinzugefügt
			foundOpenLibLine := 0
			Loop, Parse, ParseWords, `n, `r
			{
				ParseWordsCount++
				if(false && !foundOpenLibLine){
					pattern := "^\s*__+open[^`n]*\|rr\|\|ahk\|"
					foundOpenLibLine  := RegExMatch(A_LoopField, pattern )
					if( foundOpenLibLine ){
						Tooltip, %A_LoopField% `n found :) `n (from: %A_LineFile%~%A_LineNumber%)
					}
				}
			} ; end of loop
		} ; endOf if(false)


		if(false && !foundOpenLibLine){
			temp := "___open library|rr||ahk|FileReadLine,ActionListFileAdress, ActionList.txt.status.txt, 1 `n ActionListFileAdress := RegExReplace(ActionListFileAdress, ""\._Generated\.ahk\s*$"", """") `n run,% ActionListFileAdress"
            ; AddWordToList(AddWord,ForceCountNewOnly,ForceLearn:= false, ByRef LearnedWordsCount := false) {
			; AddWordToList(temp,1,"ForceLearn") ; works but AHK is not succedet :( 12.08.2017 22:28
			; ^- is oben sowieso false
		}
		DynaRun("#" . "NoTrayIcon `n  Tooltip,.SL5. `n Sleep,2300")
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

        isIndexedAhkBlock := false
        doCollectAhkBlock := false
        codePrefixChar := ""
		Loop, Parse, ParseWords, `n, `r1
		{
		    ; thats the place very updates from the file are inserted into the database. this you shuld never delte.
		    ; Das ist der Ort, an dem sehr Updates aus der Datei in die Datenbank eingefügt werden. Das sollte man nie löschen.
		    ; 02.10.2018 19:21 18-10-02_19-21
            ; Tooltip,%A_LoopField% `n (from: %A_LineFile%~%A_LineNumber%)
            ; ToolTip4sec(A_LoopField "`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
			ParseWordsSubCount++
         ;ProgressPercent := Round(ParseWordsSubCount/ParseWordsCount * 100)
			if (ProgressPercent <> OldProgressPercent){
            ;~ Progress, %ProgressPercent%
				OldProgressPercent := ProgressPercent
			}
			IfEqual, A_LoopField, `;LEARNEDWORDS`;
			{
                MsgBox,% "never uses if Block? delete if block??? 27.10.2018 : " A_LoopField "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"


                if(1 && InStr(A_ComputerName,"SL5"))
                    msgBox,% "never visited??? " ALoopField "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
				if (DatabaseRebuilt)
				{
					LearnedWordsCount=0
					g_LegacyLearnedWords=1 ; Set Flag that we need to convert ActionList file
				} else {
					break
				}
			} else {


                if(doCollectAhkBlock){
                   if(RegExMatch( A_LoopField , "i)\bGi\s*\:\s*do_indexFollowingLines4search\s*[\:]?=\s*true\b" )) { ; do_indexFollowingLines4search
                        ; Gi: do_indexFollowingLines4search := true
    				    ; AddWordToList(AddWordBlock,0,"ForceLearn",LearnedWordsCount) ;
    				    doCollectAhkBlock := false
    				    isIndexedAhkBlock := true
    				    ; MsgBox,% ":-) found: " A_LoopField "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")" ; __
				}  }
               ;if( isIndexedAhkBlock )  ; do_indexFollowingLines4search
               ;     AddWordToList(ALoopField,0,"ForceLearn",LearnedWordsCount) ; ^- line above does the same

				ALoopField := A_LoopField


                if(!doCollectAhkBlock){
                    is_multiline_r := false
                    doCollectAhkBlock := false
                    ALoopField  := RegExReplace(ALoopField, "^\s+" , "" ) ; like ltrim or the same? 06.11.2017 18:28
                }else{
                    if(is_multiline_r){
                        if(RegExMatch( ALoopField , "i)^([^; ]*[^\n]+\|(r|rr)\|)",  m )){
                            is_multiline_r := false
                            doCollectAhkBlock := false
                            AddWordToList(rtrim(AddWordBlock),0,"ForceLearn",LearnedWordsCount, isIndexedAhkBlock)
                            if(g_config["FuzzySearch"]["enable"] && a_index < g_config["FuzzySearch"]["MAXlines"])
                                addFuzzySearch_in_generatedList(trim(AddWordBlock), ActionList,LearnedWordsCount,g_config["FuzzySearch"]["keysMAXperEntry"],g_config["FuzzySearch"]["minKeysLen"])
                            AddWordBlock := ""
                        }else{
                            if(isIndexedAhkBlock)
                                AddWordToList(ALoopField,0,"ForceLearn",LearnedWordsCount, isIndexedAhkBlock)
                            AddWordBlock := AddWordBlock ALoopField "`r`n"
                            ; ALoopFieldLast := ALoopField
                            continue
                        }
                    }else if(trim(ALoopField)){
                        AddWordBlock := AddWordBlock "`n" ALoopField
                        ALoopFieldLast := ALoopField
                        if(isIndexedAhkBlock)
                            AddWordToList(ALoopField,0,"ForceLearn",LearnedWordsCount, isIndexedAhkBlock)
                        continue
                    }else{
                        doCollectAhkBlock := false
                        if(codePrefixChar == "(" || codePrefixChar == "["){
                            ; AddWordBlock .= "`nsend,`% it`n"
                            if(trim(ALoopFieldLast) == ")"){
                                AddWordBlock .= "`nsend,`% it`n"
                                ; MsgBox, % ">" codePrefixChar "<== codePrefixChar `n" ALoopField "`n" AddWordBlock "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                        }
                        }
                        ALoopField := AddWordBlock
                        ; MsgBox, % ">" codePrefixChar "<== codePrefixChar `n" ALoopField "`n" AddWordBlock "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                        ; tooltip,% "AddWordBlock = `n >" AddWordBlock "< (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                    }
                }

                if(RegExMatch( ALoopField , "i)^([^; ]*[^\n]+\|ahk\|)([^\s]?)[ ]*$",  m )){
                    doCollectAhkBlock := true
                    if(1 && InStr(A_ComputerName,"SL5") )
                        ToolTip2sec(doCollectAhkBlock= "=doCollectAhkBlock (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
                    isIndexedAhkBlock := false ; maybe its set in next line
                    if(m2){
                        if(m2 == "(" || m2 == "["){
                            if(m2 == "[")
                                isIndexedAhkBlock := true
                            codePrefixChar := m2
                            m2 := "`nit = `n("
                            ; MsgBox,% codePrefixChar "=codePrefixChar(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                        }
                    }
                    AddWordBlock := m1 m2
                    ; MsgBox,% codePrefixChar "=m1 , " ALoopField "`n" AddWordBlock "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                    continue
                }else{

                    if(1){
                		 regIs_multiline_r  := "^([^\|\n]+?)\|r\|([ ]*?)$"
                        ; regIs_multiline_r := "i)^([^; ]*\w[^\n]+\|(r|rr)\|)([^\s]+)[ ]*$"
                        if(RegExMatch( ALoopField , regIs_multiline_r ,  m )){
                            doCollectAhkBlock := true
                            is_multiline_r := true
                            AddWordBlock := rtrim(ALoopField)
                            ; msgBox,% AddWordBlock  "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"

                            continue
                            ; rX := {key:m1, rr:"r", send:"", lang:"" ,code:""}
                            ; create a working synonym:
                            ; ALoopField := rX["key"] "|rr||ahk|"
                            ; msgBox,% ALoopField "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                        }


                    }else{
                        ; deprecated since 22.10.2018 12:13
                        regIs_r_synonym := "^([^\|\n]+?)\|r\|[ ]*$"
                        if(RegExMatch( ALoopField , regIs_r_synonym ,  m )){
                            rX := {key:m1, rr:"r", send:"", lang:"" ,code:""}
                            ; create a working synonym:
                            ALoopField := rX["key"] "|rr||ahk|"
                            ; msgBox,% ALoopField "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                        }
                    }
                }


                ; MsgBox,262208,% "found:" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ,% ":-) found: " A_LoopField "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")" ; info icon, always on top

				if(!AddWordToList(ALoopField,0,"ForceLearn",LearnedWordsCount, isIndexedAhkBlock)){
				    ; set to defaults:
                    doCollectAhkBlock := false
                    isIndexedAhkBlock := false
				}

                ; msgBox,% ALoopField "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
				; LearnedWordsCount := addFuzzySearch_in_generatedList(ALoopField , ActionList,LearnedWordsCount,g_config["FuzzySearch"]["keysMAXperEntry"],g_config["FuzzySearch"]["minKeysLen"])
				if(!CheckValid(ALoopField))
				    continue
                ; msgBox,% "Valid:" ALoopField "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
				if(g_config["FuzzySearch"]["enable"] && a_index < g_config["FuzzySearch"]["MAXlines"])
					addFuzzySearch_in_generatedList(ALoopField, ActionList,LearnedWordsCount,g_config["FuzzySearch"]["keysMAXperEntry"],g_config["FuzzySearch"]["minKeysLen"])
				;     AddWordToList("rübennase" A_now,1,"ForceLearn", g_config["FuzzySearch"]["keysMAXperEntry"],g_config["FuzzySearch"]["minKeysLen"], g_config["FuzzySearch"]["doValueCopy"])

			} ; EndOf ELSE-Block massive used

            ; msgBox,% " inside loop :" ALoopField " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		} ; ENDof Loop
        if(doCollectAhkBlock && is_multiline_r){
            doCollectAhkBlock := false
            is_multiline_r := false
            AddWordToList(AddWordBlock,0,"ForceLearn",LearnedWordsCount, isIndexedAhkBlock)
            AddWordBlock := ""
        }


      INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)



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
            		feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" . A_LineNumber, tip )
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
			Msgbox,% "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		    ; ^-- this mesage box never triggerd. so we could delte it.
		    ; käsewurst
			ToolTip4sec(A_LoopField "`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
 			AddWordToList(A_LoopField,0,"ForceLearn",LearnedWordsCount)
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
;>>>>>>>>>>>>>>>>>>  ReadActionList >>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
;------------------------------------------------------------------------

addListOpenAction_ifNotAlreadyInTheList(contentActionList,ActionList){
    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)

; thats a way how you could add ActionList lines vocabularies inside onlive 12.08.2017 23:24
; if you may destroy your path to your config file, thats a way to find it again.
;                        foundOpenLibLine := 0
	pattern := "m)^\s*__+[^`n]*\|rr\|\|ahk\|"
;                        foundOpenLibLine  := RegExMatch(A_LoopField, pattern )
	contentActionList432indes := SubSTr( contentActionList , 1 , 432 ) ; we dont wann search the complete file. takes to much time :) 12.08.2017 23:02 17-08-12_23-02

; adds a ___open library if not into the ActionList

    postFixGenerated := "._Generated.ahk"
    ActionListPostFix  := SubStr(ActionList, - StrLen(postFixGenerated) + 1 )
    itsAGeneratedList := ( postFixGenerated == ActionListPostFix )
        ; MsgBox,% msg "its a " postFixGenerated "`n ==> leave it hidden (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	if(!itsAGeneratedList && !RegExMatch(contentActionList432indes, pattern ) ){
		ToolTip,% ActionList "`n`n " A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")   " "   Last_A_This
		SplitPath, ActionList, , , , OutNameNoExt
		temp := "___open " OutNameNoExt "(ActionList.ahk~" A_LineNumber "|rr||ahk|openInEditor," OutNameNoExt ".ahk"

        if(true){
            AddWordToList(temp,0,"ForceLearn",LearnedWordsCount)   ; springt dann in zeile 490 ungefähr
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


; addFuzzySearch_in_generatedList(ALoopField)
addFuzzySearch_in_generatedList(ActionStr, ActionList, ByRef LearnedWordsCount, addKeysMAX := 7, minKeysLen := 4, doValueCopy := true){

    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)

    ; || !instr(ActionList,"Generated.ahk")
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


		    if(substr(ActionStrVal,1,4)=="|rr|")
			    newListSynonym := key "" ActionStrVal ; <=== eigentlich sollte es ja so gehen
			else
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
		; AddWordToList(newListSynonym ,0,"ForceLearn") ; <==== NOT WORKING !!!
        AddWordToList(newListSynonym ,0,"ForceLearn",LearnedWordsCount)   ; springt dann in zeile 490 ungefähr
		addedKeysCounter++
		; tooltip,% newListSynonym " `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
	} ; endOf while
	return
} ; endIf addFuzzySearch_in_generatedList









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

	Return
}

;------------------------------------------------------------------------

AddWordToList(AddWord,ForceCountNewOnly,ForceLearn:= false, ByRef LearnedWordsCount := false, isIndexedAhkBlock := false) {


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

    if(!CheckValid(AddWord,ForceLearn, isIndexedAhkBlock)){
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
			insert := "INSERT INTO words (wordindexed, word, count, wordreplacement, ActionListID) VALUES ('" AddWordIndexTransformed "','" AddWordTransformed "','" LearnedWordsCount++ "','','" . g_ActionListID . "');"
			g_ActionListDB.Query(insert)
			; Msgbox,% insert " = insert(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
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
			INSERT := "INSERT INTO words (wordindexed, word, worddescription, wordreplacement, ActionListID) VALUES ('" . AddWordIndexTransformed . "','" . AddWordTransformed . "'," . WordDescriptionQuery . "," . WordReplacementQuery . ",'" . g_ActionListID . "');"
			g_ActionListDB.Query(INSERT)


		}
      ; Yes, wordindexed is the transformed word that is actually searched upon.

	} else if (prefs_LearnMode = "On" || ForceCountNewOnly == 1)
	{
      ; If this is an on-the-fly learned word
		AddWordInList := g_ActionListDB.Query("SELECT * FROM wordsre WHERE word = '" . AddWordTransformed . "';")

		IF !( AddWordInList.Count() > 0 ) ; if the word is not in the list
		{

			IfNotEqual, ForceCountNewOnly, 1
			{
				IF (StrLen(AddWord) < prefs_LearnLength) ; don't add the word if it's not longer than the minimum length for learning if we aren't force learning it
					return false

				if AddWord contains %prefs_ForceNewWordCharacters%
					return false

				if AddWord contains %prefs_DoNotLearnStrings%
					return false

				CountValue = 1

			} else {
				CountValue := prefs_LearnCount ;set the count to LearnCount so it gets written to the file
			}

         ; must update wordreplacement since SQLLite3 considers nulls unique
			g_ActionListDB.Query("INSERT INTO words (wordindexed, word, count, wordreplacement, ActionListID) VALUES ('" . AddWordIndexTransformed . "','" . AddWordTransformed . "','" . CountValue . "','','" . g_ActionListID . "');")
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




CheckValid(Word,ForceLearn:= false, isIndexedAhkBlock := false){

    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)

	Ifequal, Word,  ;If we have no word to add, skip out.
	    Return

	if Word is space ;If Word is only whitespace, skip out.
		Return

	if(isIndexedAhkBlock){
	    if(!RegExMatch( Word , "\S" )) ; search a nonspace in it
	        return
	}else{
        if ( Substr(Word,1,1) = ";" ) ;If first char is ";", clear word and skip out.
            Return

    ;	if ( Substr(Word,1,1) = " " ) ; If first char is " ", clear word and skip out. spaces now have a special meaning. with spaces is not a kay. with spaces it could be eventually a value of a block
    ;		Return
        ; ALoopField  := RegExReplace(ALoopField, "^\s+" , "" ) ; anfangs leerzeichen raus 06.11.2017 18:28


        IF ( StrLen(Word) <= prefs_Length ){ ; don't add the word if it's not longer than the minimum length
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
			return
		}
	} else if ( RegExMatch(Word, "S)[a-zA-ZÃ -Ã¶Ã¸-Ã¿Ã€-Ã–Ã˜-ÃŸ]") = 0 )
	{
		Return
	}

	Return, 1
}

;<<<<<<<< TransformWord <<<< 180319190854 <<<< 19.03.2018 19:08:54 <<<<
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
;>>>>>>>> TransformWord >>>> 180319190900 >>>> 19.03.2018 19:09:00 >>>>


;<<<<<<<< DeleteWordFromList <<<< 180319190926 <<<< 19.03.2018 19:09:26 <<<<
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
;>>><>>>> DeleteWordFromList >>>> 180319190934 >>>> 19.03.2018 19:09:34 >>>>
;------------------------------------------------------------------------

UpdateWordCount(word,SortOnly)
{


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

;------------------------------------------------------------------------

;<<<<<<<< CleanupActionListOfThisActionList <<<<
CleanupActionListOfThisActionList(ActionList){

    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)

   ;Function cleans up all words from given ActionList
	Msgbox,not yet implemented `n (%A_LineFile%~%A_LineNumber%)
	g_ActionListDB.Query("DELETE FROM Words WHERE ActionListID = '" . g_ActionListID . "';")
}
;>>>>>>>> CleanupActionListOfThisActionList >>>>

;<<<<<<<< CleanupActionListAll_ofLittleWordCount <<<< 180319192431 <<<< 19.03.2018 19:24:31 <<<<
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
;>>>>>>>> CleanupActionListAll_ofLittleWordCount >>>> 180319192436 >>>> 19.03.2018 19:24:36 >>>>

;------------------------------------------------------------------------

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

;------------------------------------------------------------------------

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
        StringReplace, string, string, ï¿½, ae, All
        StringReplace, string, string, ï¿½, AE, All
        StringReplace, string, string, ï¿½, oe, All
        StringReplace, string, string, ï¿½, OE, All
        StringReplace, string, string, ï¿½, ss, All
	}

	return, string

}

;<<<<<<<< getActionListID <<<< 180324230510 <<<< 24.03.2018 23:05:10 <<<<
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


