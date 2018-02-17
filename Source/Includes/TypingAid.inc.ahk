global g_lineNumberFeedback
global wordlistDirBase
global wordlistActive
global wordlistOLD
global baseDir
global sourceDir
global activeTitleOLD
global activeTitle
global activeClassOLD
global activeClass

Receive_wordlistAddress(CopyOfData){
; Receive_WM_COPYDATA(wParam, lParam) ; deprecated 15.02.2018 10:26
;{
    ;StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
    ;CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
    ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
    ;msgbox, %A_ScriptName%`nReceived:`n%CopyOfData%
    ;RegRead, wordlistActive, HKEY_CURRENT_USER, SOFTWARE\sl5net, CopyOfData

    global wordlistOLD
    global wordlist

;    wordlistNEWarchivePath := CopyOfData
;    wordlistActivePath  := CopyOfData
;    wordlistNEW := CopyOfData

   ;feedbackMsgBox("wordlistOLD <??> CopyOfData",wordlistOLD . " <??> " . CopyOfData . "`n" . A_ScriptName . "(inc)~" . A_LineNumber)
    if( 1 && wordlistOLD <> CopyOfData){
      feedbackMsgBox("wordlistOLD <> CopyOfData",wordlistOLD . " <> " . CopyOfData . "`n" . A_ScriptName . "(inc)~" . A_LineNumber)
       CloseListBox()
       SuspendOn()


    ;feedbackMsgBox("wordlistOLD <> wordlist",wordlistOLD . " <> " . wordlist . "`n" . A_ScriptName . "(inc)~" . A_LineNumber)
         tooltip,LOAD NEW '%wordlist%' = wordlist `n ( %A_ScriptName%(inc)~%A_LineNumber% ) `n
        ;setGlobalWordlist(wordlistActive)
        ;InitializeListBox()
        ;BlockInput, Send ; Send:  The user's keyboard and mouse input is ignored while a Send or SendRaw is in progress
        InitializeHotKeys()
        DisableKeyboardHotKeys()
        SetBatchLines, -1 ;Change the Running performance speed (Priority changed to High in GetIncludedActiveWindow)
        ;feedbackMsgBox("ReadInTheWordList()",wordlist . "`n" . activeTitle . " = activeTitle  `n " .  A_ScriptName . "(inc)~" . A_LineNumber)
        ReadInTheWordList()
        ;prefs_Length := setLength(ParseWordsCount, maxLinesOfCode4length1)
         global wordlist
          wordlist := CopyOfData
        wordlistOLD:=wordlist
        ;MainLoop()
    }
    ; MainLoop()
    ; goto, MainLoopLabel

;InitializeListBox()
;BlockInput, Send ; Send: The user's keyboard and mouse input is ignored while a Send or SendRaw is in progress
;InitializeHotKeys()
;DisableKeyboardHotKeys()
;SetBatchLines, -1 ;Change the Running performance speed (Priority changed to High in GetIncludedActiveWindow)
;ReadInTheWordList()
MainLoop()
    return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}
; 
ReadInTheWordList(){ ;Read in the WordList
   global ParseWordsCount
   global prefs_Length
   ParseWordsCount := ReadWordList()
   prefs_Length := setLength(ParseWordsCount, maxLinesOfCode4length1)
   return
}







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
      IF !( ReturnWinActive() ) 
      {
         Critical, Off
         GetIncludedActiveWindow()
      } else {    
         Critical, Off
      }
   
      ;Get one key at a time 
      Input, InputChar, L1 V I, {BS}%g_TerminatingEndKeys%
   
      Critical
      EndKey := ErrorLevel
   
      ProcessKey(InputChar,EndKey)
   }
}

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
         g_OldCaretY := HCaretY()
         
      if ( g_OldCaretY != HCaretY() ){
         ;Don't do anything if we aren't in the original window and aren't starting a new word
         IfNotEqual, g_LastInput_Id, %g_Active_Id%
            Return
            
         ; add the word if switching lines
         AddWordToList(g_Word,0)
         ClearAllVars(true)
         g_Word := InputChar
         Return         
      } 
   }

   g_OldCaretY := HCaretY()
   g_OldCaretX := HCaretX()
   
   ;Backspace clears last letter 
   ifequal, EndKey, Endkey:BackSpace
   {
      ;Don't do anything if we aren't in the original window and aren't starting a new word
      IfNotEqual, g_LastInput_Id, %g_Active_Id%
         Return
      
      StringLen, len, g_Word
      IfEqual, len, 1   
      {
         ClearAllVars(true)
      } else IfNotEqual, len, 0
      {
         StringTrimRight, g_Word, g_Word, 1
      }
   } else if ( ( EndKey == "Max" ) && !(InStr(g_TerminatingCharactersParsed, InputChar)) ){
      ; If active window has different window ID from the last input,
      ;learn and blank word, then assign number pressed to the word
      IfNotEqual, g_LastInput_Id, %g_Active_Id%
      {
         AddWordToList(g_Word,0)
         ClearAllVars(true)
         g_Word := InputChar
         g_LastInput_Id := g_Active_Id
         Return
      }
   
      if InputChar in %prefs_ForceNewWordCharacters%
      {
         AddWordToList(g_Word,0)
         ClearAllVars(true)
         g_Word := InputChar
      } else if InputChar in %prefs_EndWordCharacters%
      {
         g_Word .= InputChar
         AddWordToList(g_Word, 1)
         ClearAllVars(true)
      } else { 
         g_Word .= InputChar
      }
      
   } else IfNotEqual, g_LastInput_Id, %g_Active_Id%
   {
      ;Don't do anything if we aren't in the original window and aren't starting a new word
      Return
   } else {
      AddWordToList(g_Word,0)
      ClearAllVars(true)
      Return
   }

   ;Wait till minimum letters 
   IF ( true && StrLen(g_Word) < prefs_Length ) ; 04.08.2017 15:17 changed by sly Oops lets see what happens :D
   {
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "g_Word=" . g_Word . " `n`n ==>j CloseListBox()")
global g_doRunLogFiles
 if(g_doRunLogFiles)
run,log\%A_ScriptName%.log.txt
      CloseListBox()
      Return
   }
   SetTimer, RecomputeMatchesTimer, -1
}

RecomputeMatches(){
   ; This function will take the given word, and will recompile the list of matches and redisplay the wordlist.
   global g_MatchTotal
   global g_SingleMatch
   global g_SingleMatchDescription
   global g_SingleMatchReplacement
   global g_Word
   global g_WordListDB
   global prefs_ArrowKeyMethod
   global prefs_LearnMode
   global prefs_ListBoxRows
   global prefs_NoBackSpace
   global prefs_ShowLearnedFirst
   global prefs_SuppressMatchingWord
   
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
            ; because SQLite cannot do case-insensitivity on accented characters using LIKE, we need
            ; to handle it manually, so we need 2 searches for each accented character the user typed.
            ;GLOB is used for consistency with the wordindexed search.
            WordAccentQuery .= " AND (word GLOB '" . PrefixChars . SubCharUpperEscaped . "*' OR word GLOB '" . PrefixChars . SubCharLowerEscaped . "*')"
         }         
      }
   } else {
      WordAccentQuery =
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
   
   WhereQuery := " WHERE wordindexed GLOB '" . WordMatchEscaped . "*' " . SuppressMatchingWordQuery . WordAccentQuery
   
   NormalizeTable := g_WordListDB.Query("SELECT MIN(count) AS normalize FROM Words" . WhereQuery . "AND count IS NOT NULL LIMIT " . LimitTotalMatches . ";")
   
   for each, row in NormalizeTable.Rows
   {
      Normalize := row[1]
   }
      
   IfEqual, Normalize,
   {
      Normalize := 0
   }


   WordLen := StrLen(g_Word)
   OrderByQuery := " ORDER BY CASE WHEN count IS NULL then "
   IfEqual, prefs_ShowLearnedFirst, On
   {
      OrderByQuery .= "ROWID + 1 else 0"
   } else {
      OrderByQuery .= "ROWID else 'z'"
   }
   
   OrderByQuery .= " end, CASE WHEN count IS NOT NULL then ( (count - " . Normalize . ") * ( 1 - ( '0.75' / (LENGTH(word) - " . WordLen . ")))) end DESC, Word"
      
   Matches := g_WordListDB.Query("SELECT word, worddescription, wordreplacement FROM Words" . WhereQuery . OrderByQuery . " LIMIT " . LimitTotalMatches . ";")
   
   g_SingleMatch := Object()
   g_SingleMatchDescription := Object()
   g_SingleMatchReplacement := Object()
   
   for each, row in Matches.Rows
   {      
      g_SingleMatch[++g_MatchTotal] := row[1]
      g_SingleMatchDescription[g_MatchTotal] := row[2]
      g_SingleMatchReplacement[g_MatchTotal] := row[3]
      
      continue
   }
   
   ;If no match then clear Tip 
   IfEqual, g_MatchTotal, 0
   {
      ClearAllVars(false)
      Return 
   } 
   
   SetupMatchPosition()
   RebuildMatchList()
   ShowListBox()
}


CheckForCaretMove(MouseButtonClick, UpdatePosition := false){
   global g_LastInput_Id
   global g_MouseWin_Id
   global g_OldCaretX
   global g_OldCaretY
   global g_Word
   global prefs_DetectMouseClickMove
   
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
         if (( g_OldCaretY != HCaretY() ) || (g_OldCaretX != HCaretX() ))
         {
            ; add the word if switching lines
            AddWordToList(g_Word,0)
            ClearAllVars(true)
         }
      }
   }

   Return
}
   
   
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
      Hotkey, $^+Delete, Off
   } else {
      Hotkey, $^+Delete, Off
      ; We only want Ctrl-Shift-Delete enabled when the listbox is showing.
      g_EnabledKeyboardHotKeys .= "$^+Delete" . g_DelimiterChar
   }
   
   HotKey, $^+c, On

   IfEqual, prefs_ArrowKeyMethod, Off
   {
      Hotkey, $^Enter, Off
      Hotkey, $^Space, Off
      Hotkey, $Tab, Off
      Hotkey, $Right, Off
      Hotkey, $Up, Off
      Hotkey, $Down, Off ; let it OFF. deaktivated from sl5net 15.07.2017 09:43 17-07-15_09-43 . it not helps using google adress bar or so.
      Hotkey, $PgUp, Off
      Hotkey, $PgDn, Off
      HotKey, $Enter, Off
      Hotkey, $NumpadEnter, Off
   } else {
      g_EnabledKeyboardHotKeys .= "$Up" . g_DelimiterChar

      Hotkey, $Down, Off ; 21.11.2017 15:23 17-11-21_15-23 let it OFF. deaktivated from sl5net  . it not helps using google adress bar or so.


global g_doSaveLogFiles
if(g_doSaveLogFiles)
   lll(A_LineNumber, A_ScriptName, " g_EnabledKeyboardHotKeys .= $Down . g_DelimiterChar")
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

EnableKeyboardHotKeys(){
   global g_DelimiterChar
   global g_EnabledKeyboardHotKeys
   Loop, Parse, g_EnabledKeyboardHotKeys, %g_DelimiterChar%
   {
;      lll(A_LineNumber, A_ScriptName, "HotKey, %" . A_LoopField . "%, On")
      HotKey, %A_LoopField%, On
   }
   Return
}

DisableKeyboardHotKeys() {
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "DisableKeyboardHotKeys() { ... 17-07-16_13-31 ")

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

; lll(A_LineNumber, A_ScriptName, "HotKey, %" . A_LoopField . "%, Off")
   }
   Return
}
   


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
   
   StringRight, Key, Key, 1 ;Grab just the number pushed, trim off the "$"
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
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, Key " = Key `n" . WordIndex " = WordIndex `n"  . g_NumKeyMethod . " = g_NumKeyMethod `n " . "`n 17-07-16_14-16" )



; if(g_ListBox_Id) ; addet by sl5net. hopefully a bugfix 16.07.2017 16:31
;    send,{backspace} ; addet by sl5net. hopefully a bugfix 16.07.2017 16:31

if(false){  ; addet by sl5net. hopefully a bugfix 16.07.2017 16:31
    ListBoxEnd() ; addet by sl5net. hopefully a bugfix 16.07.2017 20:54
    DisableKeyboardHotKeys() ; addet by sl5net. hopefully a bugfix 16.07.2017 20:54
    g_SingleMatchReplacement[WordIndex] := true ; so it hopefully sends a backspace later
    SendWord(WordIndex)
}

if(!g_ListBox_Id){ ; lines addet to reenable numbers without special functions. normal numers. 17.07.2017 02:42 from sl5net
    ;SendWord(Key)
    SetKeyDelay, 0, -1

foundPos := RegExMatch( Key , "\d" )
if(foundPos)
    Suspend,On ; 01.08.2017 04:28 17-08-01_04-28 with this effect, the first number is normal litle slow, but number later are fast again.


; // adsdf2131234567896541234565498 12345678965412365445612345654 ____
    ;SendPlay, >%Key%<  ; 1239876541231231234567899874561231234567478912387654321321321123654987123 11222
; //SendRaw,>>%Key%<<  ; 1239876541231231234567899874561231234567478912387654321321321123654987123 11222
if(A_UserName == "Administrator")
    SendInput,%Key%
else
    Send,%Key%  ; 1239876541231231234567899874561231234567478912387654321321321123654987123


global g_sending_is_buggy
if( g_sending_is_buggy )
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "Send,%Key% `n 17-07-29_11-58")

    return
    }

           msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,msg )





;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if(true){
SendWord(WordIndex) ; if it put this at the biginning of tnis function its working. i found it at the end of this function. this is a ugly bugFix. 16.07.2017 15:34
 return
 }
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

   IfEqual, g_NumKeyMethod, Off ; deaktivated sl5net 16.07.2017 14:15
   {
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, Key " = Key `n" . WordIndex " = WordIndex `n"  . g_NumKeyMethod . " = g_NumKeyMethod `n " . "`n 17-07-16_14-16" )
      SendCompatible(Key,0)
      ProcessKey(Key,"")
      Return
   }
   
   IfEqual, prefs_NumPresses, 2
   {
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . prefs_NumPresses . " = prefs_NumPresses `n " . "`n 17-07-16_14-16" )

;      lll(A_LineNumber, A_ScriptName, "SuspendOn()")
      SuspendOn()
  }

   ; If active window has different window ID from before the input, blank word 
   ; (well, assign the number pressed to the word) 
   if !(ReturnWinActive())
   { 
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

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
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

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
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

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
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

      SendCompatible(Key,0)
      ProcessKey(Key,"")
      IfEqual, prefs_NumPresses, 2
         SuspendOff()
      Return 
   }
           msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,msg )


   if ( ( (WordIndex + 1 - MatchStart) > prefs_ListBoxRows) || ( g_Match = "" ) || (g_SingleMatch[WordIndex] = "") )   ; only continue g_SingleMatch is not empty 
   { 
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

      SendCompatible(Key,0)
      ProcessKey(Key,"")
      IfEqual, prefs_NumPresses, 2
         SuspendOff()
      Return 
   }
       msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,msg )


   IfEqual, prefs_NumPresses, 2
   {
      Input, KeyAgain, L1 I T0.5, 1234567890
      
      ; If there is a timeout, abort replacement, send key and return
      IfEqual, ErrorLevel, Timeout
      {
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

         SendCompatible(Key,0)
         ProcessKey(Key,"")
         SuspendOff()
         Return
      }
       msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,msg )


      ; Make sure it's an EndKey, otherwise abort replacement, send key and return
      IfNotInString, ErrorLevel, EndKey:
      {
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

         SendCompatible(Key . KeyAgain,0)
         ProcessKey(Key,"")
         ProcessKey(KeyAgain,"")
         SuspendOff()
         Return
      }
;     tooltip,'%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
        msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,msg )


      ; If the 2nd key is NOT the same 1st trigger key, abort replacement and send keys   
      IfNotInString, ErrorLevel, %Key%
      {
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

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
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

         SendCompatible(Key . KeyAgain,0)
         ProcessKey(Key,"")
         ProcessKey(KeyAgain,"")
         SuspendOff()
         Return 
      } 
   msg='%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,msg )

  ; msgbox,'%g_ListBox_Id%' = g_ListBox_Id `n '%Key%' = Key  n (line:%A_LineNumber%) `n
   ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   ; something with mouse. we dont use the mouse 16.07.2017 15:40
   if(false){
      if ReturnLineWrong() ;Make sure we are still on the same line
    {

    ; , '%ASC%' = ASC   n (line:%A_LineNumber%)  6n  , '%nnnnn%' = nnnnn   n (line:%A_LineNumber%)  N
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

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
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,"SuspendOn()`n" . Key " = Key `n" . WordIndex " = WordIndex `n"  . "  `n " . "`n 17-07-16_15-26" )

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
      ClearAllVars(false)
      Return
   }

   if ReturnLineWrong()
   {
      SendKey(Key)
      ClearAllVars(true)
      Return
   }   
   
   IfEqual, g_Word, ; only continue if word is not empty
   {
      SendKey(Key)
      ClearAllVars(false)
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

ReturnLineWrong(){
   global g_OldCaretY
   global prefs_DetectMouseClickMove
   ; Return false if we are using DetectMouseClickMove
   IfEqual, prefs_DetectMouseClickMove, On
      Return
      
   Return, ( g_OldCaretY != HCaretY() )
}

AddSelectedWordToList(){
disableCopyQ() ; enableCopyQ() ;
   ClipboardSave := ClipboardAll
   Clipboard =
   Sleep, 100
   SendCompatible("^c",0)
   ClipWait, 0
   IfNotEqual, Clipboard, 
   {
      AddWordToList(Clipboard,1,"ForceLearn")
   }
   Clipboard = %ClipboardSave%
   enableCopyQ() ;
}

DeleteSelectedWordFromList(){
   global g_MatchPos
   global g_SingleMatch
   
   if !(g_SingleMatch[g_MatchPos] = ""){ ;only continue if g_SingleMatch is not empty

      DeleteWordFromList(g_SingleMatch[g_MatchPos])
      RecomputeMatches()
      Return
   }
   
}


EvaluateScriptPathAndTitle(){
   ;relaunches to 64 bit or sets script title
   global g_ScriptTitle

   SplitPath, A_ScriptName,,,ScriptExtension,ScriptNoExtension,

   If A_Is64bitOS
   {
      IF (A_PtrSize = 4)
      {
         IF A_IsCompiled
         {
         ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.
            ScriptPath64 := A_ScriptDir . "\" . ScriptNoExtension . "64." . ScriptExtension

            IfExist, %ScriptPath64%
            {
               ; gosub,couldIfindMyself
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "Run, %" . ScriptPath64 . "%, %" . A_WorkingDir . "%")
               Run, %ScriptPath64%, %A_WorkingDir%
                feedbackMsgBox(ExitApp , A_LineNumber . " TypingAid.inc.ahk")
                ExitApp
               
            }
         }
      }
   }

   if (SubStr(ScriptNoExtension, StrLen(ScriptNoExtension)-1, 2) == "64" )
   {
      StringTrimRight, g_ScriptTitle, ScriptNoExtension, 2
   } else {
      g_ScriptTitle := ScriptNoExtension
   }

   if (InStr(g_ScriptTitle, "TypingAid"))
   {
      g_ScriptTitle = TypingAid
   }
   
   return
}


InactivateAll(){
   ;Force unload of Keyboard Hook and WinEventHook
   Input
   SuspendOn()
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "CloseListBox()")
global g_doRunLogFiles
 if(g_doRunLogFiles)
run,log\%A_ScriptName%.log.txt

   CloseListBox()
   MaybeSaveHelperWindowPos()
   DisableWinHook()
}

SuspendOn(){
   global g_ScriptTitle
   ; Suspend, On  ; deaktivated now. for testing reasons 16.07.2017 11:34 17-07-16_11-34
   Menu, Tray, Tip, %g_ScriptTitle% - Inactive
   If A_IsCompiled
   {
            ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.

      ; Menu, tray, Icon, %A_ScriptFullPath%,3,1
   } else
   {
      ;Menu, tray, Icon, %A_ScriptDir%\%g_ScriptTitle% - Inactive.ico, ,1
   }
}

SuspendOff(){
   global g_ScriptTitle
   Suspend, Off
   Menu, Tray, Tip, %g_ScriptTitle% - Active
   If A_IsCompiled
   {
            ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.

      Menu, tray, Icon, %A_ScriptFullPath%,1,1
   } else
   {
      ; Menu, tray, Icon, %A_ScriptDir%\%g_ScriptTitle% - Active.ico, ,1
; we dont need it. sometimes it could not be loadet. so forget it. 03.05.2017 16:31
   }
   DynaRun("#" . "NoTrayIcon `n Tooltip,||SL5||`n Sleep,2300")
}


BuildTrayMenu(){
;feedbackMsgBox("BuildTrayMenu test 17-11-22_13-52","test 17-11-22_13-52",1,1)

   Menu, Tray, DeleteAll
   Menu, Tray, NoStandard
   ; Menu, Tray, add, Settings, Configuration
   Menu, Tray, add, Pause, PauseResumeScript
   IF (A_IsCompiled) ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.
   {
      Menu, Tray, add, Exit, ExitScript
   } else {
      Menu, Tray, Standard
   }
   ; Menu, Tray, Default, Settings
   ;Initialize Tray Icon
   Menu, Tray, Icon
}


; This is to blank all vars related to matches, ListBox and (optionally) word 
ClearAllVars(ClearWord){
   global
       ; lll(A_LineNumber, A_ScriptName, "CloseListBox()")
       ; run,log\%A_ScriptName%.log.txt ; this line woks :) but to often ;) may we dont need any more to check it ;) 04.08.2017 15:20

   CloseListBox()
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


FileAppendDispatch(Text,FileName,ForceEncoding=0){
   IfEqual, A_IsUnicode, 1
   {
      IfNotEqual, ForceEncoding, 0
      {
         FileAppend, %Text%, %FileName%, %ForceEncoding%
      } else
      {
         FileAppend, %Text%, %FileName%, UTF-8
      }
   } else {
            FileAppend, %Text%, %FileName%
         }
   Return
}

MaybeFixFileEncoding(File,Encoding){
   IfGreaterOrEqual, A_AhkVersion, 1.0.90.0
   {
      
      IfExist, %File%
      {    
         IfNotEqual, A_IsUnicode, 1
         {
            Encoding =
         }
         
         
         EncodingCheck := FileOpen(File,"r")
         
         If EncodingCheck
         {
            If Encoding
            {
               IF !(EncodingCheck.Encoding = Encoding)
                  WriteFile = 1
            } else
            {
               IF (SubStr(EncodingCheck.Encoding, 1, 3) = "UTF")
                  WriteFile = 1
            }
         
            IF WriteFile
            {
               Contents := EncodingCheck.Read()
               EncodingCheck.Close()
               EncodingCheck =
               FileCopy, %File%, %File%.preconv.bak
               FileDelete, %File%
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

MaybeCoInitializeEx(){
   global g_NULL
   global g_ScrollEventHook
   global g_WinChangedEventHook
   
   if (!g_WinChangedEventHook && !g_ScrollEventHook)
   {
      DllCall("CoInitializeEx", "Ptr", g_NULL, "Uint", g_NULL)
   }
   
}


MaybeCoUninitialize(){
   global g_WinChangedEventHook
   global g_ScrollEventHook
   if (!g_WinChangedEventHook && !g_ScrollEventHook)
   {
      DllCall("CoUninitialize")
   }
}


setLength(ParseWordsCount, maxLinesOfCode4length1){
       if( ParseWordsCount > 0 ){
;~           Tooltip,%ParseWordsCount% = ParseWordsCount(`from: %A_ScriptName%~%A_LineNumber%) `
    global prefs_Length
          if(ParseWordsCount <= maxLinesOfCode4length1){ ; 16 for 16 lines
            prefs_Length = 1 ; 27.03.2017 10:25 17-03-27_10-25 sl5.net
            ; Msgbox,%prefs_Length% = prefs_Length`n (from: %A_ScriptName%~%A_LineNumber%)
          } else
            prefs_Length = 2 ; 27.03.2017 10:25 17-03-27_10-25 sl5.net
      }
      ; prefs_Length = 1 ; has effekt at this position 27.03.2017 20:48 17-03-27_20-48 sl5.net

   return prefs_Length
}

doReloadIfScriptDontMoveThisLine(sec := 5){
if(0){ ; check if this is arrived 30.04.2017 09:43
    Msgbox,n (%A_ScriptName%~%A_LineNumber%) :-)
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
if(g_doSaveLogFiles){
lll(A_LineNumber, A_ScriptName, "Reload")
run,log\%A_ScriptName%.log.txt
}
            Reload
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

#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk

#Include %A_ScriptDir%\Includes\Conversions.ahk
#Include %A_ScriptDir%\Includes\Helper.ahk
#Include %A_ScriptDir%\Includes\ListBox.ahk
#Include %A_ScriptDir%\Includes\Preferences File.ahk
#Include %A_ScriptDir%\Includes\Sending.ahk
#Include %A_ScriptDir%\Includes\Settings.ahk
#Include %A_ScriptDir%\Includes\Window.ahk
#Include %A_ScriptDir%\Includes\Wordlist.ahk
#Include <DBA>
#Include <_Struct>
