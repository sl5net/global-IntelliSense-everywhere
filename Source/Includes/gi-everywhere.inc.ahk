
; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
global g_lineNumberFeedback
global actionListDirBase
global actionListActive
global actionListOLD
global baseDir
global sourceDir
global activeTitleOLD
global activeTitle
global activeClassOLD
global activeClass
global g_StartTime_TickCountMilli := A_TickCount


;/¯¯¯¯ Receive_actionListAddress ¯¯ 181231134228 ¯¯ 31.12.2018 13:42:28 ¯¯\
Receive_actionListAddress(CopyOfData){
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
	msgbox, Received:`n%CopyOfData% `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
	msgbox, Received:`n%CopyOfData% `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
	msgbox, Received:`n%CopyOfData% `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
	msgbox, Received:`n%CopyOfData% `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
	msgbox, Received:`n%CopyOfData% `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
; Receive_WM_COPYDATA(wParam, lParam) ; deprecated 15.02.2018 10:26
;{
    ;StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
    ;CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
    ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
	msgbox, %A_LineFile%`nReceived:`n%CopyOfData%
    ;RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, CopyOfData
	
	global actionListOLD
	global actionList
	
;    actionListNEWarchivePath := CopyOfData
;    actionListActivePath  := CopyOfData
;    actionListNEW := CopyOfData
	
; AHKcode = #Include ..\..\Source\incDynAhk\sendDayTimeHello.ahk `n c := RegExReplace( substr(clipboard,1,99) , "^.*?(\w)(\w+).*", "$u1$l2") `n #Include incDynAhk\sendFreundBody.ahk
	
	
	if( 1 && actionListOLD <> actionList){
		ToolTip, Received:`n%CopyOfData% `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
		Sleep,2000
		
		actionList := CopyOfData
		tooltip,'%actionListNEW%' = actionListNEW `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
		
		CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
		
		msgbox,% A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") "`n SuspendOn()`n"
		
		SuspendOn()
		
		
    ;feedbackMsgBox("actionListOLD <> actionList",actionListOLD . " <> " . actionList . "`n" . A_ScriptName . "(inc)~" . A_LineNumber)
		tooltip,LOAD NEW '%actionList%' = actionList `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
        ;setGlobalActionList(actionListActive)
        ;InitializeListBox()
        ;BlockInput, Send ; Send:  The user's keyboard and mouse input is ignored while a Send or SendRaw is in progress
		InitializeHotKeys()
		DisableKeyboardHotKeys()
        ; SetBatchLines, -1 ;Change the Running performance speed (Priority changed to High in GetIncludedActiveWindow)
        ;feedbackMsgBox("ReadInTheActionList(calledFromStr)",actionList . "`n" . activeTitle . " = activeTitle  `n " .  A_ScriptName . "(inc)~" . A_LineNumber)
		ReadInTheActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        ;g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
		actionListOLD := actionList
        ;MainLoop()
		
         ;RebuildMatchList() ; line addet 19.03.2018 20:57
         ;InitializeListBox() ; line addet 19.03.2018 20:57^
		RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; line addet 19.03.2018 21 ... in Receive_actionListAddress
		
		SuspendOff()
	}
    ; MainLoop()
    ; goto, MainLoopLabel
	
;InitializeListBox()
;BlockInput, Send ; Send: The user's keyboard and mouse input is ignored while a Send or SendRaw is in progress
;InitializeHotKeys()
;DisableKeyboardHotKeys()
;SetBatchLines, -1 ;Change the Running performance speed (Priority changed to High in GetIncludedActiveWindow)
;ReadInTheActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
	
	
	
	MainLoop()
	return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}
;\____ Receive_actionListAddress __ 181231134235 __ 31.12.2018 13:42:35 __/





;/¯¯¯¯ ReadInTheActionList( ¯¯ 181028125821 ¯¯ 28.10.2018 12:58:21 ¯¯\
ReadInTheActionList(calledFromStr){ ;Read in the actionList
	global ParseWordsCount
	global g_min_searchWord_length
	; Speak(A_lineNumber,"PROD")
	
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, % A_ThisFunc , % calledFromStr
	Critical, On
	ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
	Critical, Off ; if i switch critical off it not ends reading , maybe it could not read from filesystem?
	g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
	return ParseWordsCount
}
;\____ ReadInTheActionList( __ 181028125831 __ 28.10.2018 12:58:31 __/



; too tooltip 5 toolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
; oooltip tip ToolTip4sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
; MsgBox,262208,% ":)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"



;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
MainLoop(){
	; tooltip E:\fre\private\HtmlDevelop\Human-Connection\WebApp\
	; msgbox tool tooltip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
	; box msgbox,% "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
	global g_TerminatingEndKeys
	global g_isListBoxDisabled
	Loop
	{
		if(g_isListBoxDisabled){
			sleep,500
			continue
		}
		; tooltip 5 tlkjk to to ttt t t to totolsotolsotlsolilkj
		
      ;If the active window has changed, wait for a new one
      ;IF (false && !ReturnWinActive() ) { ; "false &&" addet 18-03-31_13-42 lets try
		IF !( ReturnWinActive() )
		{ ; "false &&" addet 18-03-31_13-42 lets try
			; Critical, Off ; on Verhindert, dass der aktuelle Thread von anderen Threads unterbrochen werden kann, oder macht ihn unterbrechbar.
			GetIncludedActiveWindow()
		} else {
			; Critical, Off
		}
		
      ;Get one key at a time ; Waits for the user to type a string.
		Input, InputChar, L1 V I, {BS}%g_TerminatingEndKeys%
		
       ;/¯¯¯¯ Critical, ¯¯ 181021220521 ¯¯ 21.10.2018 22:05:21 ¯¯\
       ; toolTip2sec(msg " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
       ; eventually this was the point of this longlifing bug: https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-1
       ; ???????????????????
       ; ???????????????????
       ; todo: test it. may it helps to do somthing with GetIncludedActiveWindow ??? call it ??
       ; ???????????????????
       ; ???????????????????
       ; ???????????????????
       ; ???????????????????
      ; Critical, On ; Wenn der erste Parameter fehlt (oder das Wort On ist), wird der aktuelle Thread als kritisch eingestuft; das heiÃŸt, dass dieser Thread nicht von anderen Threads unterbrochen werden kann. ; If the first parameter is omitted (or the word On), the current thread is made critical, meaning that it cannot be interrupted by another thread.
		EndKey := ErrorLevel
    ;\____ Critical, __ 181021220525 __ 21.10.2018 22:05:25 __/
		
		
        ; ToolTip,%g_ListBox_Id% = g_ListBox_Id `n %g_ListBoxTitle% = g_ListBoxTitle `n %g_ListBoxTitle_firstTimeInMilli% = g_ListBoxTitle_firstTimeInMilli `n,,1
		ProcessKey(InputChar,EndKey)
	}
}






;/¯¯¯¯ ProcessKey ¯¯ 181027194941 ¯¯ 27.10.2018 19:49:41 ¯¯\
ProcessKey(InputChar,EndKey) {
	global g_Active_Id
	global g_Helper_Id
	global g_IgnoreSend
	global g_LastInput_Id
	global g_OldCaretX
	global g_OldCaretY
	global g_TerminatingCharactersParsed
	global g_Word
	global prefs_DetectMouseClickMove
	global prefs_EndWordCharacters
	global prefs_ForceNewWordCharacters
	global g_min_searchWord_length
	
	IfEqual, g_IgnoreSend, 1
	{
		g_IgnoreSend =
		Return
	}
	
	IfEqual, EndKey,
	{
		EndKey = Max
	}
	
	IfEqual, EndKey, NewInput
	Return
	
	IfEqual, EndKey, Endkey:Tab
	If ( GetKeyState("Alt") =1 || GetKeyState("LWin") =1 || GetKeyState("RWin") =1 )
		Return
	
   ;If we have no window activated for typing, we don't want to do anything with the typed character
	IfEqual, g_Active_Id,
	{
		if (!GetIncludedActiveWindow())
		{
			Return
		}
	}
	
	
	IF !( ReturnWinActive() )
	{
		if (!GetIncludedActiveWindow())
		{
			Return
		}
	}
	
   ;If we haven't typed anywhere, set this as the last window typed in
	IfEqual, g_LastInput_Id,
	g_LastInput_Id = %g_Active_Id%
	
	IfNotEqual, prefs_DetectMouseClickMove, On
	{
		ifequal, g_OldCaretY,
		g_OldCaretY := CaretYorMouseYfallback()
		
		if ( g_OldCaretY != CaretYorMouseYfallback() ){
         ;Don't do anything if we aren't in the original window and aren't starting a new word
			IfNotEqual, g_LastInput_Id, %g_Active_Id%
			Return
			
         ; add the word if switching lines
         ;AddWordToList(ByRef rootCmdTypeObj,g_Word,0)
			ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
			
			if(1 && InStr(A_ComputerName,"SL5"))
				msgbox,`n(%A_LineFile%~%A_LineNumber%)
			g_Word := InputChar
			Return
		}
	}
	
	g_OldCaretY := CaretYorMouseYfallback()
	g_OldCaretX := CaretXorMouseXfallback()
	
   ;Backspace clears last letter
	;if(EndKey == "Endkey:BackSpace" ) { ; || EndKey == "BackSpace"){
	if(instr(EndKey,"Endkey:BackSpace")){
      ;Don't do anything if we aren't in the original window and aren't starting a new word
		; IfNotEqual, g_LastInput_Id, %g_Active_Id%
		; Return
		; msgbox,% g_Word "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
		
		StringLen, len, g_Word
		If(len <= 1)
			ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
		else {
			g_Word := SubStr(g_Word , 1 , len - 1)
			RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
			return
		}
	} else if ( ( EndKey == "Max" ) && !(InStr(g_TerminatingCharactersParsed, InputChar)) ){
      ; If active window has different window ID from the last input,
      ;learn and blank word, then assign number pressed to the word
		IfNotEqual, g_LastInput_Id, %g_Active_Id%
		{
         ;AddWordToList(ByRef rootCmdTypeObj,g_Word,0)
			ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
			if(0 && InStr(A_ComputerName,"SL5"))
				tooltip,% "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber " 19-01-16_20-12)",1

			g_Word := InputChar
			g_LastInput_Id := g_Active_Id
			Return
		}
		if(0 && InStr(A_ComputerName,"SL5"))
			tooltip,% "str=" NewInput " , chr=" InputChar "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),90,-15
		
		if InputChar in %prefs_ForceNewWordCharacters%
		{
			if(1 && InStr(A_ComputerName,"SL5"))
				tooltip,% "str=" NewInput " , chr=" InputChar "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
         ;AddWordToList(ByRef rootCmdTypeObj,g_Word,0)
			ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
			if(1 && InStr(A_ComputerName,"SL5"))
				msgbox,`n(%A_LineFile%~%A_LineNumber%)
			g_Word := InputChar
		} else if InputChar in %prefs_EndWordCharacters%
		{
			g_Word .= InputChar
         ;AddWordToList(ByRef rootCmdTypeObj,g_Word, 1)
			ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
		} else {
			g_Word .= InputChar
		}
		
	} else IfNotEqual, g_LastInput_Id, %g_Active_Id%
	{
		if(1 && InStr(A_ComputerName,"SL5"))
			tooltip,% "str=" NewInput " , chr=" InputChar "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
      ;Don't do anything if we aren't in the original window and aren't starting a new word
		Return
	} else { ; for exampe space was typed
		if(0 && InStr(A_ComputerName,"SL5"))
			tooltip,% "str=" NewInput " , chr=" InputChar "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
      ;AddWordToList(ByRef rootCmdTypeObj,g_Word,0)
		if(false){
			clipboard .= "`nKey = >" Key "<`n"
			clipboard .= "`nInputChar = >" InputChar "<`n"
			clipboard .= "`nEndKey = >" EndKey "<`n"
		}
 		ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
		if(0 && InStr(A_ComputerName,"SL5"))
			ToolTip9sec(InputChar "`n" EndKey "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
		Return
	}
	
	; tooltip tooltip settitle setmatch too too too too tooltip tooltip
	
; ___ ooo asfasfs ooo oo ooo
; tool toolTip2sec(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
; to to
	
   ;Wait till minimum letters
	IF ( 0 && StrLen(g_Word) < g_min_searchWord_length ){ ; 04.08.2017 15:17 changed by sl5 Oops lets see what happens :D
		global g_doSaveLogFiles
		
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"g_Word=" . g_Word . " `n`n ==>j CloseListBox(calledFromStr)")
		CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
		Return
	}
	SetTimer, RecomputeMatchesTimer, -1
}
;\____ ProcessKey __ 181027194958 __ 27.10.2018 19:49:58 __/



;/¯¯¯¯ RecomputeMatches ¯¯ 181025105946 ¯¯ 25.10.2018 10:59:46 ¯¯\
RecomputeMatches( calledFromStr, is_Recursion := false ){
   ; This function will take the given word, and will recompile the list of matches and redisplay the actionList.
	global g_MatchTotal
	global g_SingleMatch
	global g_SingleMatchDescription
	global g_SingleMatchReplacement
	global g_Word
	global g_actionListDB
	global actionList
	global g_actionListID
	global prefs_ArrowKeyMethod
	global prefs_LearnMode
	global prefs_ListBoxRows
	global prefs_NoBackSpace
	global prefs_ShowLearnedFirst
	global prefs_SuppressMatchingWord
	
	global g_min_searchWord_length
	global g_min_searchWord_length_2
	
	global g_ListBoxPosX
	global g_ListBoxPosY

    global g_listSELECT_FROM_WinTitle ; addet 19-01-09_11-51
    global g_permanentSELECT ; addet 19-01-09_11-51
    global g_permanentSELECT_type ; addet 19-01-09_11-51

    global g_config ; addet 19-01-11_21-47


    ;if( g_listSELECT_FROM_WinTitle && WinActive(g_listSELECT_FROM_WinTitle))
    ; do_SELECT_actionList_FROM_actionLists_NotLike_isNotAProject := true

    ; msgbox,% g_min_searchWord_length_2 "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    ; Menu, Tray, Icon, shell32.dll, 266 ; pretty black clock
	
	setTrayIcon("RecomputeMatches")
	if(1 && InStr(A_ComputerName,"SL5"))
	    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, RecomputeMatches , % calledFromStr


; ..\actionLists\_globalActionListsGenerated\_ahk_global.ahk._Generated

; selECT actionList FROM actionLists WHERE actionList not Like '%isNotAProject.ahk%' order by actionList;

	; g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
	
	if(g_isListBoxDisabled
	 || ( !g_Word && g_min_searchWord_length )) { ; if g_Word is empty and you run, it shows the complete list. you want it? maybe sometimes its helpful 25.03.2018 19:42 18-03-25_19-42
		setTrayIcon()
		Return
	}
	SavePriorMatchPosition()
	
	; tooo tooo tool t to  toolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
	; t kada  4 test  sdasdf tset tool tool too
	
   ;Match part-word with command
	g_MatchTotal = 0

	LimitTotalMatches := 10 ; 25.10.2018 11:08

	StringUpper, WordMatchOriginal, g_Word
	
	WordMatch := StrUnmark(WordMatchOriginal)
	StringUpper, WordMatch, WordMatch
	StringReplace, WordExactEscaped, g_Word, ', '', All
	StringReplace, WordMatchEscaped, WordMatch, ', '', All
	
	SELECT := "SELECT word, worddescription, wordreplacement FROM Words"
            . WhereQuery OrderByQuery " LIMIT " LimitTotalMatches ";"
	
; ttoolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
; msg sm msgbox test msgb msgbox MsgBox
	
	SetTimer, show_ListBox_Id, 600 ; setinterval ; 28.10.2018 02:39: fallback bugfix workaround help todo:
	if(!Sql_Temp.valueObj)
		tooltip,% " ERROR !Sql_Temp.valueObj `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" , 50,50
	valueObj := Sql_Temp.valueObj ; Sql_Temp
	
    ; t
	
	sql := Array()
	g_SingleMatch := Object()
	g_SingleMatchDescription := Object()
	g_SingleMatchReplacement := Object()

    ; gibtsnicht test mail
    ; test mai
    temp =
    (
SELECT actionList FROM actionLists WHERE actionList Like 'g_Word' AND actionList NOT Like 'isNotAProject.ahk' order by actionList.ahk ahk_class AutoHotkeyGUI ; mouseWindowTitle=0xc01d88  ;
     WinMove,SELECT actionList FROM actionLists WHERE actionList Like 'g_Word' AND actionList NOT Like 'isNotAProject.ahk' order by actionList.ahk ahk_class AutoHotkeyGUI ,, 879,421, 412,152

    )

    ; ToolTip2sec(g_min_searchWord_length_2 "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
	StrLen_g_Word := StrLen(g_Word)
	loop,7
	{
	    ;/¯¯¯¯ special ¯¯ 190109101246 ¯¯ 09.01.2019 10:12:46 ¯¯\
        ; special cases:
        ; if(do_SELECT_actionList_FROM_actionLists_NotLike_isNotAProject){
        if(g_permanentSELECT){
            if(A_Index > 1)
                break
                ; Like '%g_Word%'
                SELECT := StrReplace(g_permanentSELECT, "g_Word", "%" g_Word "%" )

            ; clipboard  := g_listSELECT_FROM_WinTitle
            ; tooltip,%SELECT%`n(%A_LineFile%~%A_LineNumber%),550,201,4
            ; g_permanentSELECT
            ; "SELECT actionList FROM actionLists WHERE actionList Like '%" g_Word "%' AND actionList NOT Like '%isNotAProject.ahk%' order by actionList;"
            ; test
            ; SELECT  actionList FROM actionLists WHERE actionList  Like '%g_Word%' AND actionList NOT  Like '%isNotAProject.ahk%' order by actionList
            ;\____ special __ 190110072759 __ 10.01.2019 07:27:59 __/
        }else if(g_permanentSELECT ) {
            if(A_Index == 1)
                SELECT := StrReplace(g_permanentSELECT, "g_Word", "%" g_Word "%" )
            ; else
            ;    break
        }else{

        if(A_Index == 2 && instr(actionList, "isNotAProject" ))
            break ; if isNotAProject is used only use commands from actionList isNotAProject. now hopefully the __ are sorted as first entry 19-01-07_22-09
        ;\____ special __ 190109101250 __ 09.01.2019 10:12:50 __/

		sqlFilePrefix := A_Index-1
            ; becouse of performance reasons. thats optional. dont need 02.12.2018 09:25
		if(sqlFilePrefix >= 2
                && StrLen_g_Word < g_min_searchWord_length_2 )
			break
		
		o := valueObj[A_Index]

		if(!o){
			; Msgbox,:( Oops >%A_Index%<(%A_LineFile%~%A_LineNumber%)
			toolTip, % "Oops no SQL-Template `nNr." sqlFilePrefix "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
			continue
		}
		if(!o["word"]["pos"]){
			tip := "Oops ERROR in SQL-Template `nNr.>" sqlFilePrefix "<`n`n Could not be found: `n o[word][pos]`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
			toolTip,% tip ,1 ,1
        		Msgbox,:( Oops `n %tip%(%A_LineFile%~%A_LineNumber%)
			continue
		}
		
        ; o["listID"]["len"] := 0 ; dont to this ! it changes the data object! its referene !
		sql["pre_Where"] := substr( o["sql"], 1 , o["word"]["pos"] - 1 )
		sql["postWhere"] := substr( o["sql"] , o["word"]["pos"] + 1, - 1 + o["listID"]["pos"] - o["word"]["pos"] )
		sql["rest"] := substr( o["sql"] , o["listID"]["pos"] + 1 + o["listID"]["len"] )

		if(A_Index == 1 && substr(g_Word,1,1)=="_"){  ; An underscore ("_") in the LIKE pattern matches any single character in the string.
		    g_WordSQL := StrReplace(g_Word, "_", "~_" ) ; like ... ESCAPE '\'
		    ; https://stackoverflow.com/questions/7323162/sqlite-like-and
        } else g_WordSQL := g_Word
		if(o["listID"]["len"])
			SELECT := sql["pre_Where"] g_WordSQL sql["postWhere"] "= " g_actionListID " " sql["rest"] ; ; <== dirty bugfix
		ELSE{
		    if(0 && InStr(A_ComputerName,"SL5")) ; was a bug no fixed. 11.01.2019 22:43
		        Msgbox,never happens ??? `n 11.01.2019 22:28 (%A_LineFile%~%A_LineNumber%)
			SELECT := sql["pre_Where"] g_WordSQL sql["postWhere"]
        }

        ;     g_config["sql"]["select"]["ignIfWhereIsWithoutListID"] &&
        if(false && InStr(A_ComputerName,"SL5")){
            ; msgbox,% g_config["sql"]["select"]["ignIfWhereIsWithoutListID"] "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
            toolTip, % o["listID"]["len"] "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
        }
		if( !(o["listID"]["len"]) && g_config["sql"]["select"]["ignIfWhereIsWithoutListID"] ){
			    ; toolTip, % "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
			    if(1 && InStr(A_ComputerName,"SL5"))
                Msgbox,% A_Index ": " SELECT "`n`n`nlistIDpos=" o["listID"]["pos"] "`nignIfWhereIsWithoutListID =" g_config["sql"]["select"]["ignIfWhereIsWithoutListID"]
                break ; 11.01.2019 22:54
		}

        if(0 && InStr(A_ComputerName,"SL5")){

            tip =
            (
            %SELECT%

            '%actionListNEW%' = actionListNEW
            '%actionListNEW%' = actionListNEW
            '%actionList%' = actionList
            )
            tooltip,%tip%`n(%A_LineFile%~%A_LineNumber%),550,201,4
        }
        } ; end of else NOT special cases 19-01-09_10-14

		 ; if(1 && InStr(A_ComputerName,"SL5") )
		if(0 && A_Index == 1 && InStr(A_ComputerName,"SL5") ){
               clipboard := SELECT "`n`n`n-- len=" o["listID"]["len"] "`n`n-- g_actionListID=" g_actionListID
                ; clipboard := SELECT
           ; msgbox,% SELECT t $ t to
            ; to
            ; t b box
        }

		;SELECT := regExReplace(SELECT,"(``|`%)","``$1")
		try{
			Matches := g_actionListDB.Query(SELECT)
		} catch e{
			tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
			sqlLastError := SQLite_LastError()
			tip .= "`n sqlLastError=" sqlLastError "`n sql=" SELECT " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
			lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
			tooltip, % tip
			feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
			Clipboard := tip
			msgbox, % tip
		}

		
		for each, row in Matches.Rows
		{
            manipulate_Matches_ByRef(row,sqlFilePrefix)

		    ; tooltip msgb box box tooltip msgbox tooltip msg box line Line Too
		    ; doSetSelectFirstValue2registry := false
		    if(g_permanentSELECT_type == "SELECT actionList")
		        doSetSelectFirstValue2registry := true

			if( InStr(A_ComputerName,"SL5") && doSetSelectFirstValue2registry )
				ToolTip, % doSetSelectFirstValue2registry "`n = doSetSelectFirstValue2registry `n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")", 500,1,5

			if(doSetSelectFirstValue2registry){ ; !row[2] &&
			    msgbox,% "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"

                actionListNewTemp_withoutExt := SubStr( row[1] ,1 , -4 )
                ; rep := "RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, " listAddress
                rep := "RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, " actionListNewTemp_withoutExt "`n"
                ; rep .= "RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionListNEW, " actionListNewTemp_withoutExt
			    g_SingleMatch[++g_MatchTotal] := actionListNewTemp_withoutExt "|rr||ahk|" rep
			}else
 			    g_SingleMatch[++g_MatchTotal] := trim(row[1]," `t`r`n") ; rTrim(clipboard," `t`r`n")
			if( !g_SingleMatch[g_MatchTotal] ){
				--g_MatchTotal
				continue
			}

            g_SingleMatchDescription[g_MatchTotal] := trim(row[2]," `t`r`n")
			g_SingleMatchReplacement[g_MatchTotal] := trim(row[3]," `t`r`n")
			if(0 && InStr(A_ComputerName,"SL5"))
				tooltip,% ":-) row[1]=" row[1] ", row[2]=" row[2] " , g_Word=" g_Word  " , g_MatchTotal=" g_MatchTotal " , Normalize=" Normalize "`n" SELECT  "`nRecomputeMatches(calledFromStr):(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
			
            ;/¯¯¯¯ topseudoDistinct ¯¯ 181209155652 ¯¯ 09.12.2018 15:56:52 ¯¯\
            ; pseudoDistinct experimental ? todo: without any effect ??? yes it works: 18-12-09_16-22
			if( A_index == 1 ){ ; first result from this new select
                ; do distinct proof
                ; ceck if last result of last select has the same reult
				if( g_SingleMatch[g_MatchTotal] == g_SingleMatch[g_MatchTotal-1]
                    && g_SingleMatchDescription[g_MatchTotal] == g_SingleMatchDescription[g_MatchTotal-1]
                    && g_SingleMatchReplacement[g_MatchTotal] == g_SingleMatchReplacement[g_MatchTotal-1] ){
					tip := "already collected: `n `nt=>" g_SingleMatch[g_MatchTotal] "< `nd=>" g_SingleMatchDescription[g_MatchTotal] "< `nr=>" g_SingleMatchReplacement[g_MatchTotal] "< "
					tip .= "`n `nt=>" strlen(g_SingleMatch[g_MatchTotal]) "< `nd=>" strlen(g_SingleMatchDescription[g_MatchTotal]) "< `nr=>" strlen(g_SingleMatchReplacement[g_MatchTotal]) "< "
					tip .= "`n" strSingleMatch ""
                    ;ToolTip4sec( tip "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
                    ;Clipboard := tip
					--g_MatchTotal
        			; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
					continue
				}
			}
; to seba test msgbox box tt
            ;\____ pseudoDistinct __ 181209155658 __ 09.12.2018 15:56:58 __/
			
; tes
			
			
			global g_min_searchWord_length
			; if(!g_min_searchWord_length)
			; 	msgbox,% SELECT "`n`n :( Oops !g_min_searchWord_length (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
			;
		    ; it shows the complete list. you want it? maybe sometimes its helpful 25.03.2018 19:42 18-03-25_19-42
			
			
    ; check if gui is opening
    ; if(strlen(g_Word)>=3)
			if(!g_reloadIf_ListBox_Id_notExist && StrLen(g_Word) == g_min_searchWord_length ){
				if(0 && InStr(A_ComputerName,"SL5") )
					toolTip, % g_Word "(" StrLen(g_Word) ")," g_min_searchWord_length "=g_min_searchWord_length:" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
        ; reload_IfNotExist_ListBoxGui()
        ;Sleep,100
				g_reloadIf_ListBox_Id_notExist := true
        ; msgbox,% "g_reloadIf_ListBox_Id_notExist:= true(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
			}
			if(g_MatchTotal == 10)
				break
		} ; end or forech
		; IfNotEqual, g_MatchTotal, 0
		;    break
		if(g_MatchTotal == 10)
			break
	}
	
	
        ; STMM MB ess box mess
        ; RM RM RM
	
        ; Featue: tipe only the upper letters. search in indexes
        ; todo: test it if it really works: 09.12.2018 18:48
    IfEqual, g_MatchTotal, 0
    	    {
                ; Featue: tipe only the upper letters. search in indexes
                ; todo: test it if it really works: 09.12.2018 18:48
                ; stmm STMM STM
                ; example: STMM = setTitleMatchMode
		if(StrLen_g_Word >= 2){
			SELECT := "SELECT distinct word, worddescription, wordreplacement FROM Words w `n"
			loop, % StrLen_g_Word
			{
				s := substr(g_Word , A_index , 1)
				StringUpper, s1, s ; proor if its really uppercase
                            ; Determines whether string comparisons are case sensitive (default is "not case sensitive").
				if(s1 <> s){
                                ; msgbox,%s1% <> %s% `n(%A_LineFile%~%A_LineNumber%)
					break ; only active if all from the beginning is uppper case
                                ; msb st stmm cmode
				}
                            ; msgbox,%s1% == %s% `n(%A_LineFile%~%A_LineNumber%)
				if(a_index==1)
					SELECT .= " WHERE w.wordindexed GLOB '" s1 "*' `n"
				else
					SELECT .= " AND w.wordindexed GLOB '* " s1 "*' `n"
			}
			SELECT .= " AND actionListID = " g_actionListID " `n"
			SELECT .= " order by ROWID desc `n"
			SELECT .= " LIMIT 9 " "`;"
            ; tooltip,%SELECT% `n(%A_LineFile%~%A_LineNumber%)


			try{
				Matches := g_actionListDB.Query(SELECT)
			} catch e{
				tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
				sqlLastError := SQLite_LastError()
				tip .= "`n sqlLastError=" sqlLastError "`n sql=" SELECT " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
				lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
				tooltip, % tip
				feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
				Clipboard := tip
				msgbox, % tip
			}
			for each, row in Matches.Rows
			{
				manipulate_Matches_ByRef(row,sqlFilePrefix)

                ; tooltip msgb box box tooltip msgbox tooltip msg box line Line Too
				g_SingleMatch[++g_MatchTotal] := trim(row[1]," `t`r`n") ; rTrim(clipboard," `t`r`n")
				if(!g_SingleMatch[g_MatchTotal]){
					--g_MatchTotal
					continue
				}


				g_SingleMatchDescription[g_MatchTotal] := trim(row[2]," `t`r`n")
				g_SingleMatchReplacement[g_MatchTotal] := trim(row[3]," `t`r`n")
			}
                        ; IfEqual, g_MatchTotal, 0
                        ;     Clipboard := SELECT "-- from huihuihuihuihui"
		}
	}
; tooo tool tool tool tool too


	; msgbox,% g_MatchTotal "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
	; tooltip msg bxox reg tsk ekejskj kjk jjk binat bi bzui tooo bigf fsd asd nnn nnnn nnnvcxcfggdfgvfdfvxcvfdfvvdfdfggbbvms dscxxcdfvx sfvdfvdfss sfd
	; dsfdsfdfdsafd adfsfd sdffadf dfafds
; tool too too
	; msgbox,% "1: "g_ListBoxPosX " 2:" g_ListBoxX asxsdcxsdsa
	; r tol tolb tolb tp tp tp tp tp tp tp ool to olti tp tolp tolp ess msg esg box too
	; tolp olb oltip ifu ifu win winpos
	; winpo win Winpos win winpos winpos winpos winpos winpos winpos winpo winpo
	; winpos winpos
	; winpos
	if(is_Recursion)
		return
    if(g_MatchTotal == 0 && !do_SELECT_actionList_FROM_actionLists_NotLike_isNotAProject ) ; 	IfEqual, g_MatchTotal, 0
	{
        ;/¯¯¯¯ StrLen_g_Word > ¯¯ 181202164223 ¯¯ 02.12.2018 16:42:23 ¯¯\
		if(!is_Recursion && StrLen_g_Word >= 3){
			is_Recursion := true
			count_Recursions := 0
			g_Word_backup := g_Word
			loop, % StrLen_g_Word
			{
				count_Recursions++
				s1 := substr(g_Word_backup , 1 , count_Recursions  )
				s2 := substr(g_Word_backup , count_Recursions + 1 )
                ; Word2 := s1 "%" s2
                ;RecomputeMatches( calledFromStr, is_Recursion )
                ; winp winp
                ; winp wi winpowinp winpos Winp ToTip totip winpos contrcl mbox msmul
				
				
				SELECT =
                (
SELECT distinct word, worddescription, wordreplacement
FROM Words w
WHERE w.word like '`%%s1%`%'
and w.word like '`%%s2%`%'
order by ROWID desc
LIMIT 9
                )
                ;tooltip,% SELECT
                ; clipboard := SELECT
                ; winp
				try{
					Matches := g_actionListDB.Query(SELECT)
				} catch e{
					tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
					sqlLastError := SQLite_LastError()
					tip .= "`n sqlLastError=" sqlLastError "`n sql=" SELECT " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
					lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
					tooltip, % tip
					feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
					Clipboard := tip
					msgbox, % tip
				}
				for each, row in Matches.Rows
				{
                    manipulate_Matches_ByRef(row,sqlFilePrefix)

                    ; tooltip msgb box box tooltip msgbox tooltip msg box line Line Too
					g_SingleMatch[++g_MatchTotal] := trim(row[1]," `t`r`n") ; rTrim(clipboard," `t`r`n")
					if(!g_SingleMatch[g_MatchTotal]){
						--g_MatchTotal
						continue
					}

					g_SingleMatchDescription[g_MatchTotal] := trim(row[2]," `t`r`n")
					g_SingleMatchReplacement[g_MatchTotal] := trim(row[3]," `t`r`n")
				}
				
				if(g_MatchTotal > 0)
					break
			}
		}
        ;\____ if StrLen_g_Word >
	}

; tooltest hall test
	
    ;/¯¯¯¯ nothingFound ¯¯ 181209180913 ¯¯ 09.12.2018 18:09:13 ¯¯\
    if(g_MatchTotal == 0 && !do_SELECT_actionList_FROM_actionLists_NotLike_isNotAProject ) ; 	IfEqual, g_MatchTotal, 0
	{
		; Tooltip, % g_Word " not found", % g_ListBoxX + 20 , % g_ListBoxY + 10
		; only show a small peace. may sombody typed passwort in? not want show it for everybody... 18-12-10_12-52
		; MsgBox, % SELECT
		; Clipboard := SELECT
		if(0 && !is_Recursion){
			Tooltip, % ((StrLen_g_Word >=3 ) ? substr( g_Word,1,3 ) ".." : g_Word ) " not found", % g_ListBoxX + 20 , % g_ListBoxY + 10
			ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),false)
			setTrayIcon()
		}
		if(0 && InStr(A_ComputerName,"SL5"))
			tooltip,% " row[1]=" row[1] ", row[2]=" row[2] " , g_Word=" g_Word  " , g_MatchTotal=" g_MatchTotal " , Normalize=" Normalize "`n" actionList "`n" SELECT  "`nRecomputeMatches(calledFromStr):(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
		
      ; clipboard := SELECT
		
		Return
	}
	;\____ nothingFound __ 181209180921 __ 09.12.2018 18:09:21 __/


; tool too too too too tooo tool tool
; tool too toooltip
;       msgbox,% g_MatchTotal "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"

    ; thats the way how you could add last list entry, if something is found
    ; g_SingleMatch[++g_MatchTotal] := "TEESSTT "

   if(g_config["listBoxGui"]["tipps"]["show"]){
       isInIn := (instr(actionList,short_RegReadActionList_DebugInfo) || instr(RegReadActionList_DebugInfo,short_actionList) )
        ; tooltip,% "RecomputeMatchesTimer: " g_Word "(" StrLen(g_Word) ") (" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\") ")" ((!isInIn) ? "Oops: al=" RegExReplace(actionList,".*\\") "<> reg=" RegExReplace(RegReadActionList_DebugInfo,".*\\") : RegExReplace(actionList,".*\\") ) ,1,-20
        ; sleep,1000 ; time for reading tooltip
        if(false && "showAsGUIBoxFooter"){
          g_SingleMatch[++g_MatchTotal] := "CTRL+Nr. single left click to move, right click to open:" ; rightclick
            g_SingleMatch[++g_MatchTotal] := substr(actionList,1,19) " .. " RegExReplace(   actionList,".*\\")
        }else{

            global g_ListBoxX
            global g_ListBoxY
            ListBoxPosX := (g_ListBoxX) ? g_ListBoxX : CaretXorMouseXfallback()
            tooltipPosY := (g_ListBoxY) ? g_ListBoxY : CaretYorMouseYfallback()

if(false){
            ; i got problems with CaretYorMouseYfallback(). workaround: 03.01.2019 20:13
            title := "Action List Appears Here"
            WinGetPos, x ,tooltipPosY, w, h ,% title ; tooltipPosY := ListBoxPosY
            if(g_ListBoY){
                ; ListBoxPosY -= 39 ; then its not in caret mode 03.01.2019 20:16
            }else
                tooltipPosY += 5

}
global g_ListBoxActualSizeH_maxFound ; this variable is empty after a fres start of the scripet 04.01.2019 11:14, 19-01-04_11-14
; clipboard := g_ListBoxActualSizeH_maxFound ;

; msgbox,% g_ListBoxActualSizeH_maxFound "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
; remember: ListBoxPosY := CaretYorMouseYfallback() - ListBoxActualSizeH
    tooltipPosY += (g_ListBoxActualSizeH_maxFound) ? g_ListBoxActualSizeH_maxFound : 164 ; found: 164. is maybe a good value. nearly correct 04.01.2019 11:16
    tooltipPosY += 29 ; of some reasons seems to be necasary Oops ??? 04.01.2019 11:29
    ; tool tool toool tool tool tool tool toolt toolt toolt toolt toolt toolt toolt toolt tool toolt toolt
    ;  toolt toolt too tool
            tip := ""
            tip .= g_Word "(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")`n" ; planed to set this behind the box
            tip .= "`n"
            tip .= "CTRL+Nr., single click: move, "
            if( actionList && !instr(actionList, "isNotAProject" ))
                tip .= "rightClick opens: " substr(actionList,1,19) " .. " RegExReplace(   actionList,".*\\") "(" g_actionListID ")`n"

            nr := ( Mod(round(A_Sec/20), 2) == 0) ; toggles every 20 seconds beetween 0 1
            if(nr && actionList && !instr(actionList, "isNotAProject" ))
                tip .= "doubleCtrl+C selection to actionsList, more see TrayMenu`n" ; doubleCtrlC
            else{
                if(instr(actionList, "isNotAProject" )){
                    tip .= "create a new actionList by`n"
                    tip .= "typing: create_own_project OR __`n"
                }else
                    tip .= "doubleCtrl: On/Off Listbox, double-click: follows caret"
            }
            ; ToolTip9sec(tip,ListBoxPosX, tooltipPosY, 2 ) ; 13px pe line
            ; ToolTipSec(t,x,y,9000, layer1to20)
            ToolTipSec(tip,ListBoxPosX, tooltipPosY, g_config["listBoxGui"]["tipps"]["durationMilliseconds"] , 2 )
            winmove,% tip, ,% ListBoxPosX, % tooltipPosY ; needet if tootop is beetween monitio or out of moinitor bouds 04.01.2019 13:07
        }



        ; plausibilty-check (18-12-28_08-03):
        ; WinGetActiveTitle,at
        if( 0 && instr(at, ".ahk") && instr(actionList, "isNotAProject" ))
            tooltip,% "ERROR: wrong list: " actionList "(" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\"),1,20,9
}


;  tes too
   ;SELECT word, worddescription, wordreplacement FROM Words WHERE wordindexed GLOB 'TOO*'  AND actionListID = '1' ORDER BY CASE WHEN count IS NULL then ROWID else 'z' end, CASE WHEN count IS NOT NULL then ( (count - 0) * ( 1 - ( '0.75' / (LENGTH(word) - 3)))) end DESC, Word LIMIT 10;
	
	SetupMatchPosition()
	RebuildMatchList()
	ShowListBox()
	setTrayIcon()
}
;\____ RecomputeMatches __ 181025110000 __ 25.10.2018 11:00:00 __/

;

; SELECT word, worddescription, wordreplacement FROM Words WHERE wordindexed GLOB 'TOO*'  AND actionListID = '2' ORDER BY CASE WHEN count IS NULL then ROWID else 'z' end, CASE WHEN count IS NOT NULL then ( (count - 0) * ( 1 - ( '0.75' / (LENGTH(word) - 3)))) end DESC, Word LIMIT 10;


; too tool too tool tool too tool tool tool tool tool tool too too too  tool tool
; tooo too tooo tool ...too too...6 ......6  too too tooo tooo tool too
; too too too tooo ll too too tool tooo too too too too to toolo toool tool too too too tooll tooo tool tool tooltooo tooo

;/¯¯¯¯ manipulate_Matches ¯¯ 190113094014 ¯¯ 13.01.2019 09:40:14 ¯¯\
manipulate_Matches_ByRef(ByRef row, filePrefix){
    if(!g_config["sql"]["select"]["showFilePrefix"])
        return

    ;

    if(false){
        if(filePrefix==1)
            n := 185
        if(filePrefix==2)
            n := 178 ; http://nt-schulze.de/services/gut-zu-wissen/sonderzeichen-und-ascii-codes/
        if(filePrefix==3)
            n := 179
        if(filePrefix==4)
            n := 9674
        if(filePrefix==5)
            n := 9824
        if(filePrefix==6)
            n := 9830
        if(filePrefix==7)
            n := 179
        s := ""
        loop,50
        {
            n := filePrefix * 80 + A_index
            s .= n Chr(n)
        }
    }
    n := 10020 + filePrefix
    c := Chr(n)
    loop,3
    {
        ; row[A_Index] := c
        ; continue


        ; String := Chr(14 + filePrefix) ; horizontaler balken
        ; String := Chr(140 + filePrefix)
        ; String := "{U+" (214 + filePrefix) "}"
        ; row[A_Index] := str_repeat(".", filePrefix) String trim(row[A_Index]," `t`r`n")
        row[A_Index] := c filePrefix c trim(row[A_Index]," `t`r`n")

        return
    }
}
;\____ manipulate_Matches __ 190113094017 __ 13.01.2019 09:40:17 __/


; too too tool tool too tool tool tes


;/¯¯¯¯ CheckForCaretMove ¯¯ 181027205017 ¯¯ 27.10.2018 20:50:17 ¯¯\
CheckForCaretMove(MouseButtonClick, UpdatePosition := false){
	
	global g_LastInput_Id
	global g_MouseWin_Id
	global g_OldCaretX
	global g_OldCaretY
	global g_Word
	global prefs_DetectMouseClickMove
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
   ;If we aren't using the DetectMouseClickMoveScheme, skip out
	IfNotEqual, prefs_DetectMouseClickMove, On
	Return
	
	if (UpdatePosition){
      ; Update last click position in case Caret is not detectable
      ;  and update the Last Window Clicked in
		MouseGetPos, MouseX, MouseY, g_MouseWin_Id
		WinGetPos, ,TempY, , , ahk_id %g_MouseWin_Id%
	}
	
	IfEqual, MouseButtonClick, LButton
	{
		KeyWait, LButton, U    
	} else KeyWait, RButton, U
		
	IfNotEqual, g_LastInput_Id, %g_MouseWin_Id%
	{
		Return
	}
	
	SysGet, SM_CYCAPTION, 4
	SysGet, SM_CYSIZEFRAME, 33
	
	TempY += SM_CYSIZEFRAME
	IF ( ( MouseY >= TempY ) && (MouseY < (TempY + SM_CYCAPTION) ) )
	{
		Return
	}
	
   ; If we have a g_Word and an g_OldCaretX, check to see if the Caret moved
	IfNotEqual, g_OldCaretX, 
	{
		IfNotEqual, g_Word, 
		{
			if (( g_OldCaretY != CaretYorMouseYfallback() ) || (g_OldCaretX != CaretXorMouseXfallback() ))
			{
            ; add the word if switching lines
            ;AddWordToList(ByRef rootCmdTypeObj,g_Word,0)
				ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
			}
		}
	}
	
	Return
}
;\____ CheckForCaretMove __ 181027205042 __ 27.10.2018 20:50:42 __/




;/¯¯¯¯ InitializeHotKeys ¯¯ 181027205107 ¯¯ 27.10.2018 20:51:07 ¯¯\
InitializeHotKeys() {
	global g_DelimiterChar
	global g_EnabledKeyboardHotKeys
	global prefs_ArrowKeyMethod
	global prefs_DisabledAutoCompleteKeys
	global prefs_LearnMode  
	
	g_EnabledKeyboardHotKeys =
	
   ;Setup toggle-able hotkeys
	
   ;Can't disable mouse buttons as we need to check to see if we have clicked the ListBox window
	
	
   ; If we disable the number keys they never get to the input for some reason,
   ; so we need to keep them enabled as hotkeys
	
	IfNotEqual, prefs_LearnMode, On
	{
      ; Hotkey, $^+Delete, Off ; 25.03.2018 15:59 18-03-25_15-59
	} else {
      ; Hotkey, $^+Delete, Off ; 25.03.2018 15:59 18-03-25_15-59
      ; We only want Ctrl-Shift-Delete enabled when the listbox is showing.
      ; g_EnabledKeyboardHotKeys .= "$^+Delete" . g_DelimiterChar ; 25.03.2018 15:59 18-03-25_15-59
	}
	
   ; HotKey, $^+c, On
	
   ;HotKey, $1, Off ; too Tooltip, `n (from: %A_LineFile%~%A_LineNumber%)
   ; too too ; 75+ lines in Live Edit Live_Edit Pseudo Live Edit for Chrome Firefox PhpStorm.ahk
	
	
   ; Msgbox,%prefs_ArrowKeyMethod% = prefs_ArrowKeyMethod`n (%A_LineFile%~%A_LineNumber%)
	If(1 || prefs_ArrowKeyMethod == "Off") { ; switched to always do by SL5 21.03.2018 19:04
      ; Hotkey, $^Enter, Off
      ; Hotkey, $^Space, Off
      ; Hotkey, $Tab, Off
      ; Hotkey, $Right, Off
      ; Hotkey, $Up, Off
      ; Hotkey, $Down, Off ; let it OFF. deaktivated from sl5net 15.07.2017 09:43 17-07-15_09-43 . it not helps using google adress bar or so.
      ; Hotkey, $PgUp, Off
      ; Hotkey, $PgDn, Off
      ; HotKey, $Enter, Off
      ; Hotkey, $NumpadEnter, Off
	} else {
      ; g_EnabledKeyboardHotKeys .= "$Up" . g_DelimiterChar
		
      ; Hotkey, $Down, Off ; 21.11.2017 15:23 17-11-21_15-23 let it OFF. deaktivated from sl5net  . it not helps using google adress bar or so.
		
		
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ," g_EnabledKeyboardHotKeys .= $Down . g_DelimiterChar")
		g_EnabledKeyboardHotKeys .= "$Down" . g_DelimiterChar
    ;Hotkey, $Down, Off ; let it OFF. deaktivated from sl5net 15.07.2017 09:43 17-07-15_09-43 . it not helps using google adress bar or so.
		
		g_EnabledKeyboardHotKeys .= "$PgUp" . g_DelimiterChar
		g_EnabledKeyboardHotKeys .= "$PgDn" . g_DelimiterChar
		If prefs_DisabledAutoCompleteKeys contains E
			Hotkey, $^Enter, Off
		else g_EnabledKeyboardHotKeys .= "$^Enter" . g_DelimiterChar
			If prefs_DisabledAutoCompleteKeys contains S
				HotKey, $^Space, Off
		else g_EnabledKeyboardHotKeys .= "$^Space" . g_DelimiterChar
			If prefs_DisabledAutoCompleteKeys contains T
				HotKey, $Tab, Off
		else g_EnabledKeyboardHotKeys .= "$Tab" . g_DelimiterChar
			If prefs_DisabledAutoCompleteKeys contains R
				HotKey, $Right, Off
		else g_EnabledKeyboardHotKeys .= "$Right" . g_DelimiterChar
			If prefs_DisabledAutoCompleteKeys contains U
				HotKey, $Enter, Off
		else g_EnabledKeyboardHotKeys .= "$Enter" . g_DelimiterChar
			If prefs_DisabledAutoCompleteKeys contains M
				HotKey, $NumpadEnter, Off
		else g_EnabledKeyboardHotKeys .= "$NumpadEnter" . g_DelimiterChar
	}
	
   ; remove last ascii 2
	StringTrimRight, g_EnabledKeyboardHotKeys, g_EnabledKeyboardHotKeys, 1
	
}
;\____ InitializeHotKeys __ 181027205124 __ 27.10.2018 20:51:24 __/




;/¯¯¯¯ EnableKeyboardHotKeys ¯¯ 181027205145 ¯¯ 27.10.2018 20:51:45 ¯¯\
EnableKeyboardHotKeys(){
	global g_DelimiterChar
	global g_EnabledKeyboardHotKeys
	Loop, Parse, g_EnabledKeyboardHotKeys, %g_DelimiterChar%
	{
;      lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"HotKey, %" . A_LoopField . "%, On")
		HotKey, %A_LoopField%, On
	}
	g_isEnabledKeyboardHotKeys := true
	Return
}
;\____ EnableKeyboardHotKeys __ 181027205226 __ 27.10.2018 20:52:26 __/





;/¯¯¯¯ DisableKeyboardHotKeys ¯¯ 181027205321 ¯¯ 27.10.2018 20:53:21 ¯¯\
DisableKeyboardHotKeys() {
	global g_doSaveLogFiles
	global g_isEnabledKeyboardHotKeys
	
	lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"DisableKeyboardHotKeys() { ... 17-07-16_13-31 ")
	
	global g_DelimiterChar
	global g_EnabledKeyboardHotKeys
	Loop, Parse, g_EnabledKeyboardHotKeys, %g_DelimiterChar%
	{
		try{
			HotKey, %A_LoopField%, Off
		} catch e{
         ;throw Exception("Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line, -1)
			tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
			tooltip, % tip
		}
		
; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"HotKey, %" . A_LoopField . "%, Off")
	}
	g_isEnabledKeyboardHotKeys := true
	Return
}
;\____ DisableKeyboardHotKeys __ 181027205339 __ 27.10.2018 20:53:39 __/




;/¯¯¯¯ CheckWord ¯¯ 181231130818 ¯¯ 31.12.2018 13:08:18 ¯¯\
; If hotkey was pressed, check wether there's a match going on and send it, otherwise send the number(s) typed 
CheckWord(Key) {
	
	global g_ListBox_Id
	global g_Match
	global g_MatchStart
	global g_NumKeyMethod
	global g_SingleMatch
	global g_Word
	global prefs_ListBoxRows
	global prefs_NumPresses
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
   ; 0000123
   ; StringRight, Key, Key, 1 ;Grab just the number pushed, trim off the "$"
	Key := SubStr(Key, 2)
	keyBackup := key ; CheckWord("$Numpad0")
	lenKey := StrLen(key)
	if(lenKey>3)
		key := RegExReplace(key, "i)^Numpad","")
	
   ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   ; convert numpad number to simple numer 21.04.2017 11:40 http://SL5.net
	
   ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	IfEqual, Key, 0
	{
		WordIndex := g_MatchStart + 9
	} else {
		WordIndex := g_MatchStart - 1 + Key
	}
	
      ;  tooltip,'%g_ListBox_Id%' = >g_ListBox_Id< `n '%Key%' = >Key<  `n (line:%A_LineNumber%) `n
	
	global g_doSaveLogFiles
	
	lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,Key " = Key `n" . WordIndex " = WordIndex `n"  . g_NumKeyMethod . " = g_NumKeyMethod `n " )
	
	
	
; if(g_ListBox_Id) ; addet by sl5net. hopefully a bugfix 16.07.2017 16:31
;    send,{backspace} ; addet by sl5net. hopefully a bugfix 16.07.2017 16:31
	
	if(0){  ; addet by sl5net. hopefully a bugfix 16.07.2017 16:31
		ListBoxEnd() ; addet by sl5net. hopefully a bugfix 16.07.2017 20:54
		DisableKeyboardHotKeys() ; addet by sl5net. hopefully a bugfix 16.07.2017 20:54
		g_SingleMatchReplacement[WordIndex] := true ; so it hopefully sends a backspace later
		SendWord(WordIndex)
	}
	
	if(!g_ListBox_Id){ ; lines addet to reenable numbers without special functions. normal numers. 17.07.2017 02:42 from sl5net
    ;SendWord(Key)
		SetKeyDelay, 0, -1
		
		foundPos := RegExMatch( Key , "\d" )
		if(foundPos){
        ;Suspend,On ; 01.08.2017 04:28 17-08-01_04-28 with this effect, the first number is normal litle slow, but number later are fast again.
       ;msgbox,% A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") "`n SuspendOn()`n"
		}
		
		
; // adsdf2131234567896541234565498 12345678965412365445612345654 ____
    ;SendPlay, >%Key%<  ; 1239876541231231234567899874561231234567478912387654321321321123654987123 11222
; //SendRaw,>>%Key%<<  ; 1239876541231231234567899874561231234567478912387654321321321123654987123 11222
;if(key==0)
; Tooltip, `n (from: %A_LineFile%~%A_LineNumber%) }} } }456789
		
; if(A_UserName == "Administrator")
;    SendInput,%Key%
;else }}}}} }}}}}}0000000000001230 ToolTip1sec(A_LineNumber   " "   RegExReplace(A_LineFile,".*\\") " " Last_A_This); 75+ lines in Live Edit Live_Edit Pseudo Live Edit for Chrome Firefox PhpStorm.ahk
		if(lenKey>3){
    ;ToolTip3sec(Key "`n`n" A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
			send,{%keyBackup%}
		}else{
    ;ToolTip3sec(Key "`n" keyBackup "`n" A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
			SendRaw,%Key%
		}
; 000   0  0 1234567890000000000
		
		
		global g_sending_is_buggy 
		if( g_sending_is_buggy ){
			lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"Send,%Key% `n`n 17-07-29_11-58")
			global g_doSaveLogFiles
		}
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"Send,%Key% `n 17-07-29_11-58")
		
		return
	}
	
	msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
	global g_doSaveLogFiles
	
	lll(A_LineNumber, A_LineFile,msg )
	
	
	
	
	
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	if(true){
		SendWord(WordIndex) ; if it put this at the biginning of tnis function its working. i found it at the end of this function. this is a ugly bugFix. 16.07.2017 15:34
		return
	}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	IfEqual, g_NumKeyMethod, Off ; deaktivated sl5net 16.07.2017 14:15
	{
		global g_doSaveLogFiles
		
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,Key " = Key `n" . WordIndex " = WordIndex `n"  . g_NumKeyMethod . " = g_NumKeyMethod `n " . "`n 17-07-16_14-16" )
		SendCompatible(Key,0)
		ProcessKey(Key,"")
		Return
	}
	
	IfEqual, prefs_NumPresses, 2
	{
		global g_doSaveLogFiles
		
		lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . prefs_NumPresses . " = prefs_NumPresses `n " . "`n 17-07-16_14-16" )
		
;      lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"SuspendOn()")
		msgbox,% A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") "`n SuspendOn()`n"
		SuspendOn()
	}
	
   ; If active window has different window ID from before the input, blank word 
   ; (well, assign the number pressed to the word) 
	if !(ReturnWinActive())
	{ 
		global g_doSaveLogFiles
		
		lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
		
		SendCompatible(Key,0)
		ProcessKey(Key,"")
		IfEqual, prefs_NumPresses, 2
		SuspendOff()
		Return 
	} 
	
   ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   ; some with mouse. we dont use mouse. 16.07.2017 15:44
   ; if(false)
	if ReturnLineWrong()
	{ ;Make sure we are still on the same line
		global g_doSaveLogFiles
		
		lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
		
		SendCompatible(Key,0)
		ProcessKey(Key,"") 
		IfEqual, prefs_NumPresses, 2
		SuspendOff()
		Return 
	}
   ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	IfNotEqual, g_Match, 
	{
		ifequal, g_ListBox_Id,        ; only continue if match is not empty and list is showing
		{ 
			global g_doSaveLogFiles
			
			lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
			
			SendCompatible(Key,0)
			ProcessKey(Key,"")
			IfEqual, prefs_NumPresses, 2
			SuspendOff()
			Return 
		}
	}
	
	
	
	ifequal, g_Word,        ; only continue if g_word is not empty 
	{ 
		global g_doSaveLogFiles
		
		lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
		
		SendCompatible(Key,0)
		ProcessKey(Key,"")
		IfEqual, prefs_NumPresses, 2
		SuspendOff()
		Return 
	}
	msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
	global g_doSaveLogFiles
	
	lll(A_LineNumber, A_LineFile,msg )
	
	
	if ( ( (WordIndex + 1 - MatchStart) > prefs_ListBoxRows) || ( g_Match = "" ) || (g_SingleMatch[WordIndex] = "") )   ; only continue g_SingleMatch is not empty 
	{ 
		global g_doSaveLogFiles
		
		lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
		
		SendCompatible(Key,0)
		ProcessKey(Key,"")
		IfEqual, prefs_NumPresses, 2
		SuspendOff()
		Return 
	}
	msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
	global g_doSaveLogFiles
	
	lll(A_LineNumber, A_LineFile,msg )
	
	
	IfEqual, prefs_NumPresses, 2
	{
		Input, KeyAgain, L1 I T0.5, 1234567890
		
      ; If there is a timeout, abort replacement, send key and return
		IfEqual, ErrorLevel, Timeout
		{
			global g_doSaveLogFiles
			
			lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
			
			SendCompatible(Key,0)
			ProcessKey(Key,"")
			SuspendOff()
			Return
		}
		msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
		global g_doSaveLogFiles
		
		lll(A_LineNumber, A_LineFile,msg )
		
		
      ; Make sure it's an EndKey, otherwise abort replacement, send key and return
		IfNotInString, ErrorLevel, EndKey:
		{
			global g_doSaveLogFiles
			
			lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
			
			SendCompatible(Key . KeyAgain,0)
			ProcessKey(Key,"")
			ProcessKey(KeyAgain,"")
			SuspendOff()
			Return
		}
;     tooltip,'%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
		msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
		global g_doSaveLogFiles
		
		lll(A_LineNumber, A_LineFile,msg )
		
		
      ; If the 2nd key is NOT the same 1st trigger key, abort replacement and send keys   
		IfNotInString, ErrorLevel, %Key%
		{
			global g_doSaveLogFiles
			
			lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
			
			StringTrimLeft, KeyAgain, ErrorLevel, 7
			SendCompatible(Key . KeyAgain,0)
			ProcessKey(Key,"")
			ProcessKey(KeyAgain,"")
			SuspendOff()
			Return
		}
		tooltip,'%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
		
      ; If active window has different window ID from before the input, blank word 
      ; (well, assign the number pressed to the word) 
		if !(ReturnWinActive())
		{ 
			global g_doSaveLogFiles
			
			lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
			
			SendCompatible(Key . KeyAgain,0)
			ProcessKey(Key,"")
			ProcessKey(KeyAgain,"")
			SuspendOff()
			Return 
		} 
		msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
		global g_doSaveLogFiles
		
		lll(A_LineNumber, A_LineFile,msg )
		
  ; msgbox,'%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
   ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   ; something with mouse. we dont use the mouse 16.07.2017 15:40
		if(false){
			if ReturnLineWrong() ;Make sure we are still on the same line
			{
				
    ; , '%ASC%' = ASC   n (line:%A_LineNumber%)  6n  , '%nnnnn%' = nnnnn   n (line:%A_LineNumber%)  N
				global g_doSaveLogFiles
				
				lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
				
				SendCompatible(Key . KeyAgain,0)
				ProcessKey(Key,"")
				ProcessKey(KeyAgain,"")
				SuspendOff()
				Return 
			}
    ; something with mouse. we dont use the mouse 16.07.2017 15:40
      ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>
	}}
	
	global g_doSaveLogFiles
	
	lll(A_LineNumber, A_LineFile,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )
	
	SendWord(WordIndex)
	IfEqual, prefs_NumPresses, 2
	SuspendOff()
	Return 
}
;\____ CheckWord __ 181231130827 __ 31.12.2018 13:08:27 __/





;If a hotkey related to the up/down arrows was pressed
;/¯¯¯¯ EvaluateUpDown ¯¯ 181231130742 ¯¯ 31.12.2018 13:07:42 ¯¯\
EvaluateUpDown(Key){
	
	global g_ListBox_Id
	global g_Match
	global g_MatchPos
	global g_MatchStart
	global g_MatchTotal
	global g_OriginalMatchStart
	global g_SingleMatch
	global g_Word
	global prefs_ArrowKeyMethod
	global prefs_DisabledAutoCompleteKeys
	global prefs_ListBoxRows
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
	IfEqual, prefs_ArrowKeyMethod, Off
	{
		if (Key != "$LButton")
		{
			SendKey(Key)
			Return
		}
	}
	
	IfEqual, g_Match,
	{
		SendKey(Key)
		Return
	}
	
	IfEqual, g_ListBox_Id,
	{
		SendKey(Key)
		Return
	}
	
	if !(ReturnWinActive())
	{
		SendKey(Key)
		ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),false)
		Return
	}
	
	if ReturnLineWrong()
	{
		SendKey(Key)
		ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
		Return
	}   
	
	IfEqual, g_Word, ; only continue if word is not empty
	{
		SendKey(Key)
		ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),false)
		Return
	}
	
	if ( ( Key = "$^Enter" ) || ( Key = "$Tab" ) || ( Key = "$^Space" ) || ( Key = "$Right") || ( Key = "$Enter") || ( Key = "$LButton") || ( Key = "$NumpadEnter") )
	{
		IfEqual, Key, $^Enter
		{
			KeyTest = E
		} else IfEqual, Key, $Tab
		{
			KeyTest = T
		} else IfEqual, Key, $^Space
		{   
			KeyTest = S 
		} else IfEqual, Key, $Right
		{
			KeyTest = R
		} else IfEqual, Key, $Enter
		{
			KeyTest = U
		} else IfEqual, Key, $LButton
		{
			KeyTest = L
		} else IfEqual, Key, $NumpadEnter
		{
			KeyTest = M
		}
		
		if (KeyTest == "L") {
         ;when hitting LButton, we've already handled this condition         
		} else if prefs_DisabledAutoCompleteKeys contains %KeyTest%
		{
			SendKey(Key)
			Return     
		}
		
		if (g_SingleMatch[g_MatchPos] = "") ;only continue if g_SingleMatch is not empty
		{
			SendKey(Key)
			g_MatchPos := g_MatchTotal
			RebuildMatchList()
			ShowListBox()
			Return
		}
		
		
      ; thats the place youu will walk trou, wenn word is selected 17.03.2017 18:20 17-03-17_18-20
      ; Msgbox, '%g_MatchPos%' = g_MatchPos  n (line:%A_LineNumber%) n  (line:%A_LineNumber%)
		SendWord(g_MatchPos)
		Return
		
	}
	
	PreviousMatchStart := g_OriginalMatchStart
	
	IfEqual, Key, $Up
	{   
		g_MatchPos--
		
		IfLess, g_MatchPos, 1
		{
			g_MatchStart := g_MatchTotal - (prefs_ListBoxRows - 1)
			IfLess, g_MatchStart, 1
			g_MatchStart = 1
			g_MatchPos := g_MatchTotal
		} else IfLess, g_MatchPos, %g_MatchStart%
		{
			g_MatchStart --
		}      
	} else IfEqual, Key, $Down
	{
		g_MatchPos++
		IfGreater, g_MatchPos, %g_MatchTotal%
		{
			g_MatchStart =1
			g_MatchPos =1
		} Else If ( g_MatchPos > ( g_MatchStart + (prefs_ListBoxRows - 1) ) )
		{
			g_MatchStart ++
		}            
	} else IfEqual, Key, $PgUp
	{
		IfEqual, g_MatchPos, 1
		{
			g_MatchPos := g_MatchTotal - (prefs_ListBoxRows - 1)
			g_MatchStart := g_MatchTotal - (prefs_ListBoxRows - 1)
		} Else {
			g_MatchPos-=prefs_ListBoxRows   
			g_MatchStart-=prefs_ListBoxRows
		}
		
		IfLess, g_MatchPos, 1
		g_MatchPos = 1
		IfLess, g_MatchStart, 1
		g_MatchStart = 1
		
	} else IfEqual, Key, $PgDn
	{
		IfEqual, g_MatchPos, %g_MatchTotal%
		{
			g_MatchPos := prefs_ListBoxRows
			g_MatchStart := 1
		} else {
			g_MatchPos+=prefs_ListBoxRows
			g_MatchStart+=prefs_ListBoxRows
		}
		
		IfGreater, g_MatchPos, %g_MatchTotal%
		g_MatchPos := g_MatchTotal
		
		If ( g_MatchStart > ( g_MatchTotal - (prefs_ListBoxRows - 1) ) )
		{
			g_MatchStart := g_MatchTotal - (prefs_ListBoxRows - 1)   
			IfLess, g_MatchStart, 1
			g_MatchStart = 1
		}
	}
	
	IfEqual, g_MatchStart, %PreviousMatchStart%
	{
		Rows := GetRows()
		IfNotEqual, g_MatchPos,
		{
			ListBoxChooseItem(Rows)
		}
	} else {
		RebuildMatchList() ; EvaluateUpDown
		ShowListBox() ; EvaluateUpDown
	}
	Return
}
;\____ EvaluateUpDown __ 181231130753 __ 31.12.2018 13:07:53 __/





;/¯¯¯¯ ReturnLineWrong ¯¯ 181028100039 ¯¯ 28.10.2018 10:00:39 ¯¯\
ReturnLineWrong(){
	global g_OldCaretY
	global prefs_DetectMouseClickMove
   ; Return false if we are using DetectMouseClickMove
	IfEqual, prefs_DetectMouseClickMove, On
	Return
	
	Return, ( g_OldCaretY != CaretYorMouseYfallback() )
}
;\____ ReturnLineWrong __ 181028100102 __ 28.10.2018 10:01:02 __/



;/¯¯¯¯ AddSelectedWordToList ¯¯ 181028100159 ¯¯ 28.10.2018 10:01:59 ¯¯\
AddSelectedWordToList(){
	msgbox,% "probaly never happens? neever used this line??? 28.10.2018 10:03 ("A_ThisFunc " " A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
	disableCopyQ() ; enableCopyQ() ;
	ClipboardSave := ClipboardAll
	Clipboard =
	Sleep, 100
	SendCompatible("^c",0)
	ClipWait, 0
	IfNotEqual, Clipboard, 
	{
      ;AddWordToList(ByRef rootCmdTypeObj,Clipboard,1,"ForceLearn")
	}
	Clipboard = %ClipboardSave%
	enableCopyQ() ;
}
;\____ AddSelectedWordToList __ 181028100205 __ 28.10.2018 10:02:05 __/




;/¯¯¯¯ DeleteSelectedWordFromList ¯¯ 181027193211 ¯¯ 27.10.2018 19:32:11 ¯¯\
DeleteSelectedWordFromList(){
	global g_MatchPos
	global g_SingleMatch
	msgbox,% "probaly never happens? neever used this line??? 28.10.2018 10:03 ("A_ThisFunc " " A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
	if !(g_SingleMatch[g_MatchPos] = "") ; only continue if g_SingleMatch is not empty
	{
		
		if(0 && InStr(A_ComputerName,"SL5"))
			msgbox,18-10-27_19-29 in DeleteSelectedWordFromList()
		
		DeleteWordFromList(g_SingleMatch[g_MatchPos])
		RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; in DeleteSelectedWordFromList()
		Return
	}
}
;\____ DeleteSelectedWordFromList __ 181027193215 __ 27.10.2018 19:32:15 __/





;/¯¯¯¯ EvaluateScriptPathAndTitle ¯¯ 181027193233 ¯¯ 27.10.2018 19:32:33 ¯¯\
EvaluateScriptPathAndTitle(){
   ;relaunches to 64 bit or sets script title
	global g_ScriptTitle
	
	SplitPath, A_ScriptName,,,ScriptExtension,ScriptNoExtension,
	
	ahkIs64version := (A_PtrSize=8 ? "64-bit" : "32-bit")
	if(!ahkIs64version)
		MsgBox,% "Error: AHK Version (32-bit) not match to Sqlite Version (64 bit). Please update your ahk-Version or choose another Sqlite Version"
   ; https://stackoverflow.com/questions/52803477/getting-cant-load-sqlite3-dll-not-found-error-with-autohotkey/
	
	If(A_Is64bitOS){
		IF(A_PtrSize == 4){
			IF(A_IsCompiled){
         ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.
				ScriptPath64 := A_ScriptDir "\" ScriptNoExtension "64." ScriptExtension
				
				If(FileExist(ScriptPath64)){
               ; gosub,couldIfindMyself
					global g_doSaveLogFiles
					
					lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"Run, %" . ScriptPath64 . "%, %" . A_WorkingDir . "%")
					Run, %ScriptPath64%, %A_WorkingDir%
					feedbackMsgBox(ExitApp , A_LineNumber . " gi-everywhere.inc.ahk")
					ExitApp
	}  }  }  }
	
	if (SubStr(ScriptNoExtension, StrLen(ScriptNoExtension)-1, 2) == "64" )
	{
		StringTrimRight, g_ScriptTitle, ScriptNoExtension, 2
	} else {
		g_ScriptTitle := ScriptNoExtension
	}
	
	if (InStr(g_ScriptTitle, "gi-everywhere"))
	{
		g_ScriptTitle = gi-everywhere
	}
	
	return
}
;\____ EvaluateScriptPathAndTitle __ 181027193258 __ 27.10.2018 19:32:58 __/





;/¯¯¯¯ InactivateAll_Suspend_ListBox_WinHook ¯¯ 181028100506 ¯¯ 28.10.2018 10:05:06 ¯¯\
InactivateAll_Suspend_ListBox_WinHook(){
   ;Force unload of Keyboard Hook and WinEventHook
	Input
	SuspendOn()
	lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"CloseListBox(calledFromStr)")
	CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
   ;MaybeSaveHelperWindowPos()
	DisableWinHook()
   ;msgbox,done: DisableWinHook()  (%A_LineFile%~%A_LineNumber%) :-)
}
;\____ InactivateAll_Suspend_ListBox_WinHook __ 181028100510 __ 28.10.2018 10:05:10 __/




;/¯¯¯¯ SuspendOn ¯¯ 181024140026 ¯¯ 24.10.2018 14:00:26 ¯¯\
SuspendOn(){
	global g_ScriptTitle
   ;ToolTip2sec("Suspend deaktivad TEST " A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
   ;Suspend, On  ; deaktivated now. for testing reasons 16.07.2017 11:34 17-07-16_11-34
	; Menu, Tray, Tip, %g_ScriptTitle% - Inactive
	If A_IsCompiled
	{
            ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.
		
      ; Menu, tray, Icon, %A_ScriptFullPath%,3,1
	} else {
      ;Menu, tray, Icon, %A_ScriptDir%\%g_ScriptTitle% - Inactive.ico, ,1
	}
}
;\____ SuspendOn __ 181024140031 __ 24.10.2018 14:00:31 __/

;/¯¯¯¯ SuspendOff ¯¯ 181024140102 ¯¯ 24.10.2018 14:01:02 ¯¯\
SuspendOff(){
	global g_ScriptTitle
	Suspend, Off
	; Menu, Tray, Tip, %g_ScriptTitle% - Active
	If A_IsCompiled
	{
            ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.
		
		Menu, tray, Icon, %A_ScriptFullPath%,1,1
	} else
	{
      ; Menu, tray, Icon, %A_ScriptDir%\%g_ScriptTitle% - Active.ico, ,1
; we dont need it. sometimes it could not be loadet. so forget it. 03.05.2017 16:31
	}
   ;DynaRun("#" "NoTrayIcon `; `n``n Tooltip,||SL5|| `; `n``n Sleep,2300 `; " A_LineNumber)
}
;\____ SuspendOff __ 181024140111 __ 24.10.2018 14:01:11 __/

; ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )

;/¯¯¯¯ BuildTrayMenu ¯¯ 181024140140 ¯¯ 24.10.2018 14:01:40 ¯¯\
BuildTrayMenu(){
    ; https://autohotkey.com/docs/commands/Menu.htm
	
;feedbackMsgBox("BuildTrayMenu test 17-11-22_13-52","test 17-11-22_13-52",1,1)
	if(1 || !InStr(A_ComputerName,"SL5") )
		Menu, Tray, DeleteAll ; DeleteAll: Deletes all custom menu items from the menu.
	if(0 || !InStr(A_ComputerName,"SL5") )
		Menu, Tray, NoStandard ; NoStandard: Removes all standard menu items from the menu. https://autohotkey.com/docs/commands/Menu.htm#NoDefault
	if(1 || !InStr(A_ComputerName,"SL5") )
		Menu, Tray, NoDefault ; Reverses setting a user-defined default menu item.
	
   ; Menu, Tray, add, Settings, Configuration
	; Menu, Tray, add, Pause, PauseResumeScript
	
	
	Menu, Tray, add
	
	; Menu, Tray, add, toggle tipps , lbl_g_ListBoxGui_tippsTOGGLE ; g_config["listBoxGui"]["tipps"]["show"]
	; Menu, Tray, add, set g_doSound TRUE (experimental feature), lbl_g_doSoundTRUE
	; Menu, Tray, add, set g_doSound FALSE (experimental feature), lbl_g_doSoundFALSE

	Menu, Tray, add, config, lbl_open_config_file

	Menu, Tray, add

	Menu, Tray, add, set a permanent ActionList (experimental feature), lbl_set_permanent_ActionList

	Menu, Tray, add

;

	; Menu, Tray, add, set g_min_searchWord_length := 0 (it stays open`, experimental feature), lbl_g_min_searchWord_length_0
	; Menu, Tray, add, set g_min_searchWord_length := 1, lbl_g_min_searchWord_length_1
	
	Menu, Tray, add
	Menu, Tray, add, tipps:,lbl_noOp
	Menu, Tray, add, see \Source\shortcuts\listbox_shortcutStyle_... for trigger an action (noOp),lbl_noOp
	Menu, Tray, add, use double Ctrl to toggle Listbox (noOp),lbl_noOp
	Menu, Tray, add
	
	Menu, Tray, add, Help Gi-Edit/Create actionList online, lbl_HelpOnline_EditCreate_actionList
	Menu, Tray, add, Help Gi-Search Keywords online, lbl_HelpOnline_Search_Keywords
	Menu, Tray, add, Help Gi-Features online, lbl_HelpOnline_features
	Menu, Tray, add, Help Gi-Shortcuts online, lbl_HelpOnline_shortcut
	Menu, Tray, add, open issues online, lbl_HelpOnline_issues_open
	; Menu, Tray, add
	Menu, Tray, add, _______________________________,lbl_noOp
	Menu, Tray, add, Help AutoHotkey online, lbl_Help_AutoHotkey_online
	
	IF (A_IsCompiled) ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.
	{
		; Menu, Tray, add, Exit, ExitScript
		msgbox,% "not implemented jet `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
	} else {
		; Menu, Tray, Standard
	}
	
	Menu, Tray, add, Edit This Script, lblEditThisScript
	Menu, Tray, add, Exit, ExitScript
	
   ; Menu, Tray, Default, Settings
   ;Initialize Tray Icon
   ; Menu, Tray, Tip , % Chr(8203) ; i dont want text there. The tray icon's tooltip is displayed when the mouse hovers over it.
   ; Menu, Tray, Tip , % Chr(8203) ; works but then i could not find it winSeach. i dont want text there. The tray icon's tooltip is displayed when the mouse hovers over it.
	Menu, Tray, Tip , gi ; i dont want text there. The tray icon's tooltip is displayed when the mouse hovers over it.
   ; Menu, Tray, Tip ,  ; works not . i dont want text there. The tray icon's tooltip is displayed when the mouse hovers over it.
	; Menu, Tray, Delete, Open ; dont work: erro nonexistend menu item
	; Menu, Tray, Rename, Help, AHK Help ; dont work: erro nonexistend menu item
	Menu, Tray, Icon
}
;\____ BuildTrayMenu __ 181024140152 __ 24.10.2018 14:01:52 __/


;/¯¯¯¯ ClearAllVars ¯¯ 181024140212 ¯¯ 24.10.2018 14:02:12 ¯¯\
; This is to blank all vars related to matches, ListBox and (optionally) word 
ClearAllVars( ByRef calledFromStr , ClearWord ){


	global
	
	; Msgbox,% calledFromStr "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    ;if( !RegExMatch( calledFromStr, "\b(1614|321|734)\b" )	)
	if(false && !instr(calledFromStr,"1614"))
		if(true && InStr(A_ComputerName,"SL5")){
			tooltip, %calledFromStr% `n (from: %A_LineFile%~%A_LineNumber%) , 1,200
			clipboard .= "`n" calledFromStr
			if(true || !RegExMatch( calledFromStr, "\b(1614|321|734|2112|316|687)\b" )	){
            ; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), calledFromStr ,1,1 )
				RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, % A_ThisFunc , % calledFromStr
		}}
	; boxmsgbxo
	; modesettitl  too
	; modesettit boxmst moxmsg
; too tooltip setmatcht ma
; setmodtitle setm , modesettitlm
; modematcht settot
; setTitleMatchMode modematchtitleset settitlematchmode matchsetmode tit
; titlematchsetmatchtestmatchsettitlesetmatch
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
       ; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"CloseListBox(calledFromStr)")
       ; run,log\%A_LineFile%.log.txt ; this line woks :) but to often ;) may we dont need any more to check it ;) 04.08.2017 15:20
	
	CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
	if(0 && InStr(A_ComputerName,"SL5"))
		ToolTip9sec(calledFromStr "`nClearWord(1|0)=" ClearWord "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
	; too too too too too tooltip tooltip tooltip tooolipasdfasdf tooltip
	; settitle settitlematch too
	Ifequal,ClearWord,1
	{
		g_Word =
		g_OldCaretY=
		g_OldCaretX=
		g_LastInput_id=
		g_ListBoxFlipped=
		g_ListBoxMaxWordHeight=
	}
	
	g_SingleMatch =
	g_SingleMatchDescription =
	g_SingleMatchReplacement =
	g_Match= 
	g_MatchPos=
	g_MatchStart= 
	g_OriginalMatchStart=
	Return
}
;\____ ClearAllVars __ 181024140219 __ 24.10.2018 14:02:19 __/


FileAppendDispatch(Text,FileName,ForceEncoding=0){
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	
	IfEqual, A_IsUnicode, 1
	{
		IfNotEqual, ForceEncoding, 0
		{
			if(1 && InStr(A_ComputerName,"SL5") )
				RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			FileAppend, %Text%, %FileName%, %ForceEncoding%
		} else
		{
			if(1 && InStr(A_ComputerName,"SL5") )
				RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			FileAppend, %Text%, %FileName%, UTF-8
		}
	} else {
		if(1 && InStr(A_ComputerName,"SL5") )
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		FileAppend, %Text%, %FileName%
	}
	Return
}

MaybeFixFileEncoding(File,Encoding){
	return
	log =
(
i got a problem with this today.
it become  in a harmless endless loop.
The correction changed the file date.
We don't need the function probably anyway because we have everything utf-8.
05.11.2018 13:13
)
	
   ; doWriteInAnyCasese := true ;
	if( RegExMatch(File,"Bewerbung") ){
		
		FileCopy, %File%, %File%.preconv.bak
		FileRead, Contents, %File%
		Contents := getCorrectedStringUAOSS( Contents )
		if(!Contents)
			return
		
		if(instr(Contents,"Ã¶")){
			Msgbox,% ":( your file is corrupted propably. Ã¶ is found `n`n" File "`n______________`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			return
		}
		
    ; if(instr(Contents,"�")){ ; L�sungen
		if( foundPos := RegExMatch(Contents,"i)[a-z]�[a-z]") ){
			
			lineNr := 0
			StartingPosition  := 2
			while(RegexMatch( m, "Om)(\n)", Match, StartingPosition )){
				StartingPosition := Match.Pos(1) + Match.Len(1)
				lineNr ++
			}
			
			Msgbox,% ":( your file is corrupted propably. � is found in line " lineNr " `n`n..." corruptedContend "`n`n" File "`n______________`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
         ;Msgbox,% ":( your file is corrupted propably. `n`n...>" corruptedContend "<...`n  `n" nW "`n is found `n`n" File "`n______________`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			return
		}
		
    ;
		
    ; nW := "[^{}öüäß\w\s\n\t\r\.!-_|]+" ; no word z.b. ?
		if((0 && InStr(A_ComputerName,"SL5")) && Contents && foundPos := RegExMatch(Contents,"i)[a-z]{3,}" nW "[a-z]{3,}") ){
			
        ; startPos := (foundPos<7) ? 1 : foundPos - 5 ; todo: quick and dirty 03.10.2018 00:27
			
        ; corruptedContend := substr(Contents, startPos , 45)
			
        ; https://autohotkey.com/board/topic/13335-tip-use-of-ternary-operator-in-concatenation/
         ; Msgbox,% ":( your file is corrupted propably. `n`n...>" corruptedContend "<...`n`n" nW "`n is found `n`n" File "`n______________`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
        ; return
		}
		
		FileCopy, %File%, %File%.preconvB.bak
		FileDelete, %File%
		if(1 && InStr(A_ComputerName,"SL5") )
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		FileAppend, %Contents%, %File%, %Encoding%
   ; tooltip,% File " was saved backup you find here: `n" %File%.preconvB.bak "`n______________`n"  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		Return
	}
	IfGreaterOrEqual, A_AhkVersion, 1.0.90.0
	{
		If(FileExist(File)){
			If(A_IsUnicode <> 1)
				Encoding =
			EncodingCheck := FileOpen(File,"r")
			
			If(EncodingCheck){
				If(Encoding){
					IF !(EncodingCheck.Encoding = Encoding)
						WriteFile = 1
				} else
				{
					IF (SubStr(EncodingCheck.Encoding, 1, 3) = "UTF")
						WriteFile = 1
				}
				IF(WriteFile){
					Contents := EncodingCheck.Read()
               ;Contents := getCorrectedStringUAOSS( Contents )
					
					EncodingCheck.Close()
					EncodingCheck =
					FileCopy, %File%, %File%.preconv.bak
					FileDelete, %File%
					if(1 && InStr(A_ComputerName,"SL5") )
						RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
					FileAppend, %Contents%, %File%, %Encoding%
					
					Contents =
					
				} else
				{
					EncodingCheck.Close()
					EncodingCheck =
				}
			}
		}
	}
}


GetOSVersion(){
	return ((r := DllCall("GetVersion") & 0xFFFF) & 0xFF) "." (r >> 8)
}

;/¯¯¯¯ MaybeCoInitializeEx ¯¯ 181024135038 ¯¯ 24.10.2018 13:50:38 ¯¯\
MaybeCoInitializeEx(){
	global g_NULL
	global g_ScrollEventHook
	global g_WinChangedEventHook
	
	if (!g_WinChangedEventHook && !g_ScrollEventHook){
		DllCall("CoInitializeEx", "Ptr", g_NULL, "Uint", g_NULL)
	}
}
;\____ MaybeCoInitializeEx __ 181024135044 __ 24.10.2018 13:50:44 __/


;/¯¯¯¯ MaybeCoUninitialize ¯¯ 181024135055 ¯¯ 24.10.2018 13:50:55 ¯¯\
MaybeCoUninitialize(){
	global g_WinChangedEventHook
	global g_ScrollEventHook
	if (!g_WinChangedEventHook && !g_ScrollEventHook){
		DllCall("CoUninitialize")
	}
}
;\____ MaybeCoUninitialize __ 181024135059 __ 24.10.2018 13:50:59 __/


; too too  t

;/¯¯¯¯ getMinLength_Needetthat_ListBecomesVisible( ¯¯ 181028024531 ¯¯ 28.10.2018 02:45:31 ¯¯\
getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1) {
	global g_min_searchWord_length
	if(g_min_searchWord_length == 0){ ; possibly wanted to show it always
		return g_min_searchWord_length
	}
	g_min_searchWord_length = 2 ; 27.03.2017 10:25 17-03-27_10-25 sl5.net
	if( ParseWordsCount > 0 ){
            ;~           Tooltip,%ParseWordsCount% = ParseWordsCount(`from: %A_LineFile%~%A_LineNumber%) `
		if(ParseWordsCount <= maxLinesOfCode4length1) ; 16 for 16 lines
			g_min_searchWord_length = 1 ; 27.03.2017 10:25 17-03-27_10-25 sl5.net
		Msgbox,%g_min_searchWord_length% = g_min_searchWord_length`n (from: %A_LineFile%~%A_LineNumber%)
	}
        ;else
         ;   Msgbox,%g_min_searchWord_length% = g_min_searchWord_length`n (from: %A_LineFile%~%A_LineNumber%)
	
        ; g_min_searchWord_length = 1 ; has effekt at this position 27.03.2017 20:48 17-03-27_20-48 sl5.net
	
	return g_min_searchWord_length
}
;\____ getMinLength_Needetthat_ListBecomesVisible( __ 181028024549 __ 28.10.2018 02:45:49 __/


;

doReloadIfScriptDontMoveThisLine(sec := 5){
	if(0){ ; check if this is arrived 30.04.2017 09:43
		Msgbox,n (%A_LineFile%~%A_LineNumber%) :-)
		ExitApp
	}
    ; is this function triggerd evver onee time? i dont know if setinterval works if the script stucks. may we cant do anything then from inside the script. needs temp ahk. 30.04.2017 09:25
	global g_nextCriticalCommandString
	global g_nextCriticalCommandTimeIdle
    ; g_nextCriticalCommandString := "104:SuspendOn()"
	
	if(g_nextCriticalCommandString == "120:SuspendOn()" || g_nextCriticalCommandString == "104:Suspend, On"){
		if(!g_nextCriticalCommandTimeIdle || g_nextCriticalCommandTimeIdle < 1)
			g_nextCriticalCommandTimeIdle := A_TimeIdle
		else if (g_nextCriticalCommandTimeIdle * 1000 > sec)
		{
        ; that takes to long. to much time
			msgbox,'%g_nextCriticalCommandString%'g_nextCriticalCommandString'%g_nextCriticalCommandString%':`n`n '%g_nextCriticalCommandTimeIdle%' = g_nextCriticalCommandTimeIdle  `n`n (line:%A_LineNumber%) n  := , '%A_TimeIdle%' = A_TimeIdle  n (line:%A_LineNumber%) n
			global g_doSaveLogFiles
			{
				lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"Reload")
				run,log\%A_LineFile%.log.txt
			}
        ;if(1 && InStr(A_ComputerName,"SL5") )
            ;msgbox,,reload (%A_LineNumber%), % "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")",,1
            ; ^--- goood for debugging maybe
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, Reload , % A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			Reload  ; [^;\n]*[ ]*\breload\b\n <= cactive reloads 18-10-28_11-47
		}
		tooltip, %g_nextCriticalCommandTimeIdle% = g_nextCriticalCommandTimeIdle (1667)
	} else
		g_nextCriticalCommandTimeIdle := 0
	return
	
   ; g_nextCriticalCommandString := "120:SuspendOn()"
   ; g_nextCriticalCommandTimeIdle := A_TimeIdle
}

#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
#Include %A_ScriptDir%\inc_ahk\openInEditor_actionList.inc.ahk

#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk

#Include %A_ScriptDir%\Includes\Conversions.ahk
#Include %A_ScriptDir%\Includes\Helper.ahk
#Include %A_ScriptDir%\Includes\ListBox.ahk
#Include %A_ScriptDir%\Includes\Preferences File.ahk
#Include %A_ScriptDir%\Includes\Sending.ahk
#Include %A_ScriptDir%\Includes\Settings.ahk
#Include %A_ScriptDir%\Includes\Window.ahk
#Include %A_ScriptDir%\Includes\actionList.ahk
#Include <DBA>
#Include <_Struct>
