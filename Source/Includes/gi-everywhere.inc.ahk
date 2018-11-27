; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
global g_lineNumberFeedback
global ActionListDirBase
global ActionListActive
global ActionListOLD
global baseDir
global sourceDir
global activeTitleOLD
global activeTitle
global activeClassOLD
global activeClass
global g_StartTime_TickCountMilli := A_TickCount

Receive_ActionListAddress(CopyOfData){
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
    ;RegRead, ActionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net, CopyOfData
	
	global ActionListOLD
	global ActionList
	
;    ActionListNEWarchivePath := CopyOfData
;    ActionListActivePath  := CopyOfData
;    ActionListNEW := CopyOfData
	
; AHKcode = #Include ..\..\Source\incDynAhk\sendDayTimeHello.ahk `n c := RegExReplace( substr(clipboard,1,99) , "^.*?(\w)(\w+).*", "$u1$l2") `n #Include incDynAhk\sendFreundBody.ahk
	
	
	if( 1 && ActionListOLD <> ActionList){
		ToolTip, Received:`n%CopyOfData% `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
		Sleep,2000
		
		ActionList := CopyOfData
		tooltip,'%ActionListNEW%' = ActionListNEW `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
		
		CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
		
		msgbox,% A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") "`n SuspendOn()`n"
		
		SuspendOn()
		
		
    ;feedbackMsgBox("ActionListOLD <> ActionList",ActionListOLD . " <> " . ActionList . "`n" . A_ScriptName . "(inc)~" . A_LineNumber)
		tooltip,LOAD NEW '%ActionList%' = ActionList `n ( %A_LineFile%(inc)~%A_LineNumber% ) `n
        ;setGlobalActionList(ActionListActive)
        ;InitializeListBox()
        ;BlockInput, Send ; Send:  The user's keyboard and mouse input is ignored while a Send or SendRaw is in progress
		InitializeHotKeys()
		DisableKeyboardHotKeys()
        ; SetBatchLines, -1 ;Change the Running performance speed (Priority changed to High in GetIncludedActiveWindow)
        ;feedbackMsgBox("ReadInTheActionList(calledFromStr)",ActionList . "`n" . activeTitle . " = activeTitle  `n " .  A_ScriptName . "(inc)~" . A_LineNumber)
		ReadInTheActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        ;prefs_Length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
		ActionListOLD := ActionList
        ;MainLoop()
		
         ;RebuildMatchList() ; line addet 19.03.2018 20:57
         ;InitializeListBox() ; line addet 19.03.2018 20:57^
		RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; line addet 19.03.2018 21 ... in Receive_ActionListAddress
		
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
;


;/¯¯¯¯ ReadInTheActionList( ¯¯ 181028125821 ¯¯ 28.10.2018 12:58:21 ¯¯\
ReadInTheActionList(calledFromStr){ ;Read in the ActionList
	global ParseWordsCount
	global prefs_Length
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, % A_ThisFunc , % calledFromStr
	Critical,On	
	ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
	Critical,Off
	prefs_Length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
	return ParseWordsCount
}
;\____ ReadInTheActionList( __ 181028125831 __ 28.10.2018 12:58:31 __/







;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
;<<<<<<<< MainLoop <<<< 180208192114 <<<< 08.02.2018 19:21:14 <<<<
MainLoop(){
	
	global g_TerminatingEndKeys
	Loop
	{
		
      ;If the active window has changed, wait for a new one
      ;IF (false && !ReturnWinActive() ) { ; "false &&" addet 18-03-31_13-42 lets try
		IF !( ReturnWinActive() )
		{ ; "false &&" addet 18-03-31_13-42 lets try
			Critical, Off ; on Verhindert, dass der aktuelle Thread von anderen Threads unterbrochen werden kann, oder macht ihn unterbrechbar.
			GetIncludedActiveWindow()
		} else {
			Critical, Off
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
      ; Critical,On ; Wenn der erste Parameter fehlt (oder das Wort On ist), wird der aktuelle Thread als kritisch eingestuft; das heiÃŸt, dass dieser Thread nicht von anderen Threads unterbrochen werden kann. ; If the first parameter is omitted (or the word On), the current thread is made critical, meaning that it cannot be interrupted by another thread.
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
	global prefs_Length
	
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
	
	IfEqual, g_Active_Id, %g_Helper_Id%
	{
		Return
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
			g_Word := InputChar
			Return
		}
	}
	
	g_OldCaretY := CaretYorMouseYfallback()
	g_OldCaretX := CaretXorMouseXfallback()
	
   ;Backspace clears last letter
	ifequal, EndKey, Endkey:BackSpace
	{
      ;Don't do anything if we aren't in the original window and aren't starting a new word
		IfNotEqual, g_LastInput_Id, %g_Active_Id%
		Return
		
		StringLen, len, g_Word
		IfEqual, len, 1
		{
			ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
		} else IfNotEqual, len, 0
		{
			StringTrimRight, g_Word, g_Word, 1
		}
	} else if ( ( EndKey == "Max" ) && !(InStr(g_TerminatingCharactersParsed, InputChar)) ){
      ; If active window has different window ID from the last input,
      ;learn and blank word, then assign number pressed to the word
		IfNotEqual, g_LastInput_Id, %g_Active_Id%
		{
         ;AddWordToList(ByRef rootCmdTypeObj,g_Word,0)
			ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
			g_Word := InputChar
			g_LastInput_Id := g_Active_Id
			Return
		}
		if(1 && InStr(A_ComputerName,"SL5"))
			tooltip,% "str=" NewInput " , chr=" InputChar "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),90,-15
		
		if InputChar in %prefs_ForceNewWordCharacters%
		{
			if(1 && InStr(A_ComputerName,"SL5"))
				tooltip,% "str=" NewInput " , chr=" InputChar "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
         ;AddWordToList(ByRef rootCmdTypeObj,g_Word,0)
			ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
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
	} else {
		if(0 && InStr(A_ComputerName,"SL5"))
			tooltip,% "str=" NewInput " , chr=" InputChar "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
      ;AddWordToList(ByRef rootCmdTypeObj,g_Word,0)
		ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
		Return
	}
	
; ___ ooo asfasfs ooo oo ooo
; tool toolTip2sec(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
; to to
	
   ;Wait till minimum letters
	IF ( 0 && StrLen(g_Word) < prefs_Length ){ ; 04.08.2017 15:17 changed by sl5 Oops lets see what happens :D
		global g_doSaveLogFiles
		
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"g_Word=" . g_Word . " `n`n ==>j CloseListBox(calledFromStr)")
		CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
		Return
	}
	SetTimer, RecomputeMatchesTimer, -1
}
;\____ ProcessKey __ 181027194958 __ 27.10.2018 19:49:58 __/



;<<<<<<<< RecomputeMatches <<<< 180319210937 <<<< 19.03.2018 21:09:37 <<<<
; this version runs in:
; v0.9  aa79a8d blue Mountain
;@sl5net sl5net released this on 13 Oct · 107 commits to master since this release
RecomputeMatchesOFF( ByRef calledFromStr ){
   ; This function will take the given word, and will recompile the list of matches and redisplay the ActionList.
	global g_MatchTotal
	global g_SingleMatch
	global g_SingleMatchDescription
	global g_SingleMatchReplacement
	global g_Word
	global g_ActionListDB
	global ActionList
	global g_ActionListID
	global prefs_ArrowKeyMethod
	global prefs_LearnMode
	global prefs_ListBoxRows
	global prefs_NoBackSpace
	global prefs_ShowLearnedFirst
	global prefs_SuppressMatchingWord




   ;Msgbox,g_Word = %g_Word% (%A_LineFile%~%A_LineNumber%)
	if(!g_Word) ; if g_Word is empty and you run, it shows the complete list. you want it? maybe sometimes its helpful 25.03.2018 19:42 18-03-25_19-42
		Return
	
   ; LoopCount := StrLen(g_Word)
   ; if(LoopCount < 2 ) ; 18-03-31_22-43 addet TOD: proof
      ; return
	
    Critical,On ; 20.11.2018 09:48 i like that



	SavePriorMatchPosition()
	
   ;Match part-word with command
	g_MatchTotal = 0
	
	IfEqual, prefs_ArrowKeyMethod, Off
	{
		IfLess, prefs_ListBoxRows, 10
		LimitTotalMatches := prefs_ListBoxRows
		else LimitTotalMatches = 10
	} else {
			LimitTotalMatches = 200
		}
	
	StringUpper, WordMatchOriginal, g_Word
	
	WordMatch := StrUnmark(WordMatchOriginal)
	
	StringUpper, WordMatch, WordMatch
	
   ; if a user typed an accented character, we should exact match on that accented character
	if (WordMatch != WordMatchOriginal) {
		WordAccentQuery =
		if(!LoopCount) ; ader 18-03-31_22-45
			LoopCount := StrLen(g_Word)
		Loop, %LoopCount%
		{
			Position := A_Index
			SubChar := SubStr(g_Word, Position, 1)
			SubCharNormalized := StrUnmark(SubChar)
			if !(SubCharNormalized == SubChar) {
				StringUpper, SubCharUpper, SubChar
				StringLower, SubCharLower, SubChar
				StringReplace, SubCharUpperEscaped, SubCharUpper, ', '', All
				StringReplace, SubCharLowerEscaped, SubCharLower, ', '', All
				PrefixChars =
				Loop, % Position - 1
				{
					PrefixChars .= "?"
				}
				
            ; Yes, wordindexed is the transformed word that is actually searched upon.
				
            ; because SQLite cannot do case-insensitivity on accented characters using LIKE, we need
            ; to handle it manually, so we need 2 searches for each accented character the user typed.
            ;GLOB is used for consistency with the wordindexed search.
				WordAccentQuery .= " AND (word GLOB '" . PrefixChars . SubCharUpperEscaped . "*' OR word GLOB '" . PrefixChars . SubCharLowerEscaped . "*')"
			}
		}
	} else {
		WordAccentQuery := ""
	}
	
	StringReplace, WordExactEscaped, g_Word, ', '', All
	StringReplace, WordMatchEscaped, WordMatch, ', '', All
	
	IfEqual, prefs_SuppressMatchingWord, On
	{
		IfEqual, prefs_NoBackSpace, Off
		{
			SuppressMatchingWordQuery := " AND word <> '" . WordExactEscaped . "'"
		} else {
               SuppressMatchingWordQuery := " AND wordindexed <> '" . WordMatchEscaped . "'"
		}
	}
	
	;WhereQuery := " WHERE wordindexed GLOB '"  WordMatchEscaped  "*' "  SuppressMatchingWordQuery  WordAccentQuery  " AND ActionListID = '" g_ActionListID "'"
	; ^--- before 20.11.2018 00:05

	WhereQuery := " WHERE wordindexed GLOB '*"  WordMatchEscaped  "*' "  SuppressMatchingWordQuery  WordAccentQuery  " AND ActionListID = '" g_ActionListID "'" ; <==== I LIKE THIE MUCH MORE

	NormalizeTable := g_ActionListDB.Query("SELECT MIN(count) AS normalize FROM Words" . WhereQuery . " AND count IS NOT NULL LIMIT " . LimitTotalMatches . ";")
	
	for each, row in NormalizeTable.Rows
	{
		Normalize := row[1]
	}
	
	IfEqual, Normalize,
	{
		Normalize := 0
	}
;
	
	WordLen := StrLen(g_Word)
	OrderByQuery := " ORDER BY CASE WHEN count IS NULL then "
	IfEqual, prefs_ShowLearnedFirst, On
		OrderByQuery .= "ROWID + 1 else 0"
	else
		OrderByQuery .= "ROWID else 'z'"

	OrderByQuery .= " end, CASE WHEN count IS NOT NULL then ( (count - " . Normalize . ") * ( 1 - ( '0.75' / (LENGTH(word) - " . WordLen . ")))) end DESC, Word"
	
	Matches := g_ActionListDB.Query("SELECT word, worddescription, wordreplacement FROM Words" . WhereQuery . OrderByQuery . " LIMIT " . LimitTotalMatches . ";")

	; box box too box

	g_SingleMatch := Object()
	g_SingleMatchDescription := Object()
	g_SingleMatchReplacement := Object()
	
	for each, row in Matches.Rows
	{
		g_SingleMatch[++g_MatchTotal] := ltrim(row[1]) ; that ltrim was really usfuls!!! since i used glob *...* 20.11.2018 09:52
		g_SingleMatchDescription[g_MatchTotal] := ltrim(row[2]) ; <==== maybe useful 20.11.2018 09:52
		g_SingleMatchReplacement[g_MatchTotal] := ltrim(row[3]) ; <==== maybe useful 20.11.2018 09:52
		
		continue
	}
	
	Critical,Off	
	
   ;If no match then clear Tip
	IfEqual, g_MatchTotal, 0
	{
		ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),true)
		Return
	}
	
	SetupMatchPosition()
	RebuildMatchList()
	ShowListBox()
}
;>>>>>>>> RecomputeMatches >>>> 180319210950 >>>> 19.03.2018 21:09:50 >>>>






;/¯¯¯¯ RecomputeMatches ¯¯ 181025105946 ¯¯ 25.10.2018 10:59:46 ¯¯\
RecomputeMatches( calledFromStr ){
   ; This function will take the given word, and will recompile the list of matches and redisplay the ActionList.
	global g_MatchTotal
	global g_SingleMatch
	global g_SingleMatchDescription
	global g_SingleMatchReplacement
	global g_Word
	global g_ActionListDB
	global ActionList
	global g_ActionListID
	global prefs_ArrowKeyMethod
	global prefs_LearnMode
	global prefs_ListBoxRows
	global prefs_NoBackSpace
	global prefs_ShowLearnedFirst
	global prefs_SuppressMatchingWord


    ; Menu, Tray, Icon, shell32.dll, 266 ; pretty black clock

    ; toot too

	setTrayIcon("RecomputeMatches")
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, RecomputeMatches , % calledFromStr
	if(!g_Word){ ; if g_Word is empty and you run, it shows the complete list. you want it? maybe sometimes its helpful 25.03.2018 19:42 18-03-25_19-42
		setTrayIcon()
		Return
	}
	SavePriorMatchPosition()

	; tooo tooo tool

   ;Match part-word with command
	g_MatchTotal = 0
	
	LimitTotalMatches := 10 ; 25.10.2018 11:08
	StringUpper, WordMatchOriginal, g_Word
	
	WordMatch := StrUnmark(WordMatchOriginal)
	StringUpper, WordMatch, WordMatch
	StringReplace, WordExactEscaped, g_Word, ', '', All
	StringReplace, WordMatchEscaped, WordMatch, ', '', All
	
	SELECT := "SELECT word, worddescription, wordreplacement FROM Words"
            . WhereQuery . OrderByQuery . " LIMIT " LimitTotalMatches ";"
	
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

        loop,6
        {
            o := valueObj[A_Index]
            o["listID"]["len"] := ""
            sql["pre_Where"] := substr( o["sql"], 1 , o["word"]["pos"] - 1 )
            sql["postWhere"] := substr( o["sql"] , o["word"]["pos"] + 1, - 1 + o["listID"]["pos"] - o["word"]["pos"] )
            sql["rest"] := substr( o["sql"] , o["listID"]["pos"] + 1 + o["listID"]["len"] )

            if(o["listID"]["len"])
                SELECT := sql["pre_Where"] g_Word sql["postWhere"] " = " g_ActionListID sql["rest"]
            ELSE
                SELECT := sql["pre_Where"] g_Word sql["postWhere"]

            ; clipboard := SELECT "`n`n`n" o["listID"]["len"]
            ;  msgbox,% SELECT t $ t to

	;SELECT := regExReplace(SELECT,"(``|`%)","``$1")
		try{
			Matches := g_ActionListDB.Query(SELECT)
		} catch e{
			tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
			sqlLastError := SQLite_LastError()
			tip .= "`n sqlLastError=" sqlLastError "`n sql=" SELECT " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
			lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
			tooltip, `% tip
			feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
			Clipboard := tip
			msgbox, % tip
		}
		for each, row in Matches.Rows
		{
; tooltip msgb box box tooltip msgbox tooltip msg box line Line Too
			g_SingleMatch[++g_MatchTotal] := trim(row[1]," `t`r`n") ; rTrim(clipboard," `t`r`n")
			if(!g_SingleMatch[g_MatchTotal]){
			    --g_MatchTotal
				continue
            }
			g_SingleMatchDescription[g_MatchTotal] := trim(row[2]," `t`r`n")
			g_SingleMatchReplacement[g_MatchTotal] := trim(row[3]," `t`r`n")
			if(0 && InStr(A_ComputerName,"SL5"))
				tooltip,% ":-) row[1]=" row[1] ", row[2]=" row[2] " , g_Word=" g_Word  " , g_MatchTotal=" g_MatchTotal " , Normalize=" Normalize "`n" SELECT  "`nRecomputeMatches(calledFromStr):(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1


			global prefs_Length
			if(!prefs_Length)
				msgbox,% SELECT "`n`n :( Oops !prefs_Length (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
    ; check if gui is opening
    ; if(strlen(g_Word)>=3)
			if(!g_reloadIf_ListBox_Id_notExist && StrLen(g_Word) == prefs_Length ){
				if(1 && InStr(A_ComputerName,"SL5") )
					toolTip, % g_Word "(" StrLen(g_Word) ")," prefs_Length "=prefs_Length:" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
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
	;

	; msgbox,% g_MatchTotal "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
	
	; tooltip msg box reg
	
	IfEqual, g_MatchTotal, 0
	{
		Tooltip, no match found
		; MsgBox, % SELECT 
		; Clipboard := SELECT
		ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),false)
		setTrayIcon()
		if(0 && InStr(A_ComputerName,"SL5"))
			tooltip,% " row[1]=" row[1] ", row[2]=" row[2] " , g_Word=" g_Word  " , g_MatchTotal=" g_MatchTotal " , Normalize=" Normalize "`n" ActionList "`n" SELECT  "`nRecomputeMatches(calledFromStr):(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
      ; clipboard := SELECT
		Return
	}
   ;SELECT word, worddescription, wordreplacement FROM Words WHERE wordindexed GLOB 'TOO*'  AND ActionListID = '1' ORDER BY CASE WHEN count IS NULL then ROWID else 'z' end, CASE WHEN count IS NOT NULL then ( (count - 0) * ( 1 - ( '0.75' / (LENGTH(word) - 3)))) end DESC, Word LIMIT 10;
	
	SetupMatchPosition()
	RebuildMatchList()
	ShowListBox()
	setTrayIcon()
}
;\____ RecomputeMatches __ 181025110000 __ 25.10.2018 11:00:00 __/

; t

; SELECT word, worddescription, wordreplacement FROM Words WHERE wordindexed GLOB 'TOO*'  AND ActionListID = '2' ORDER BY CASE WHEN count IS NULL then ROWID else 'z' end, CASE WHEN count IS NOT NULL then ( (count - 0) * ( 1 - ( '0.75' / (LENGTH(word) - 3)))) end DESC, Word LIMIT 10;




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
	
	if (UpdatePosition)
	{
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
;else }}}}} }}}}}}0000000000001230 ToolTip1sec(A_LineNumber   " "   RegExReplace(RegExReplace(A_LineFile,".*\\") , ".*\", "") " " Last_A_This); 75+ lines in Live Edit Live_Edit Pseudo Live Edit for Chrome Firefox PhpStorm.ahk
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






;If a hotkey related to the up/down arrows was pressed
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
		RebuildMatchList()
		ShowListBox()
	}
	Return
}


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



;/¯¯¯¯ BuildTrayMenu ¯¯ 181024140140 ¯¯ 24.10.2018 14:01:40 ¯¯\
BuildTrayMenu(){
    ; https://autohotkey.com/docs/commands/Menu.htm

;feedbackMsgBox("BuildTrayMenu test 17-11-22_13-52","test 17-11-22_13-52",1,1)
	Menu, Tray, DeleteAll ; DeleteAll: Deletes all custom menu items from the menu.
	Menu, Tray, NoStandard ; NoStandard: Removes all standard menu items from the menu. https://autohotkey.com/docs/commands/Menu.htm#NoDefault
	Menu, Tray, NoDefault ; Reverses setting a user-defined default menu item.
   ; Menu, Tray, add, Settings, Configuration
	; Menu, Tray, add, Pause, PauseResumeScript
	Menu, Tray, add, Help Gi-Features online, lbl_HelpOnline_features
	Menu, Tray, add, Help Gi-Shortcuts online, lbl_HelpOnline_shortcut
	Menu, Tray, add, open issues online, lbl_HelpOnline_issues_open
    Menu, Tray, add, Help AutoHotkey online, lbl_Help_AutoHotkey_online

	IF (A_IsCompiled) ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.
	{
		; Menu, Tray, add, Exit, ExitScript
		msgbox,% "not implemented jet `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
	} else {
		; Menu, Tray, Standard
	}

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
ClearAllVars( calledFromStr , ClearWord ){
	
	global
	
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, % A_ThisFunc , % calledFromStr
	
; too
	
	INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
       ; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"CloseListBox(calledFromStr)")
       ; run,log\%A_LineFile%.log.txt ; this line woks :) but to often ;) may we dont need any more to check it ;) 04.08.2017 15:20
	
	CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
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
				RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			FileAppend, %Text%, %FileName%, %ForceEncoding%
		} else
		{
			if(1 && InStr(A_ComputerName,"SL5") )
				RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			FileAppend, %Text%, %FileName%, UTF-8
		}
	} else {
		if(1 && InStr(A_ComputerName,"SL5") )
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
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
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
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
						RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
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
	global prefs_Length
	prefs_Length = 2 ; 27.03.2017 10:25 17-03-27_10-25 sl5.net
	if( ParseWordsCount > 0 ){
            ;~           Tooltip,%ParseWordsCount% = ParseWordsCount(`from: %A_LineFile%~%A_LineNumber%) `
		if(ParseWordsCount <= maxLinesOfCode4length1) ; 16 for 16 lines
			prefs_Length = 1 ; 27.03.2017 10:25 17-03-27_10-25 sl5.net
		Msgbox,%prefs_Length% = prefs_Length`n (from: %A_LineFile%~%A_LineNumber%)
	}
        ;else
         ;   Msgbox,%prefs_Length% = prefs_Length`n (from: %A_LineFile%~%A_LineNumber%)
	
        ; prefs_Length = 1 ; has effekt at this position 27.03.2017 20:48 17-03-27_20-48 sl5.net
	
	return prefs_Length
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
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, Reload , % A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
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
#Include %A_ScriptDir%\Includes\ActionList.ahk
#Include <DBA>
#Include <_Struct>
