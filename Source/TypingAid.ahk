; Sleep,2500 ; may typing_ ... needs fist a litle time to put the wordlist at the right place ?????????? 16.11.2017 10:01
; no wrong try 16.11.2017 10:03



global g_sending_is_buggy := true ; 29.07.2017 11:21 inside the adminsistraor account only the |ahk| script feature is working. lets try/test some. number ar not recognazed also SendPlay may have no effect if the script is running as Administrator 29.07.2017 12:34 17-07-29_12-34
global g_sending_is_buggy := false ; Solved: SendPlay. 29.07.2017 11:21 inside the adminsistraor account only the |ahk| script feature is working. lets try/test some. number ar not recognazed also SendPlay may have no effect if the script is running as Administrator 29.07.2017 12:34 17-07-29_12-34

global g_doSaveLogFiles := false
g_doRunLogFiles := false

if(A_UserName == "Administrator"){
    msg =
    (
    SendPlay may have no effect if the script is running as Administrator 29.07.2017 12:34 17-07-29_12-34
    )
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll("`n" . A_LineNumber, A_ScriptName, msg )
    global g_doUseSendPlay := false

    ; 29.07.2017 12:41: i typed regex :
    ; 1SendEvenewStr := RegExReplace("abc", "i)")
    ; 2SendInpnewStr := RegExReplace("abc", "i)")
    ; 4SendRaw = {Shift Down}{Shift Up}{Shift Down}{Shift Up}{}

}



; https://autohotkey.com/board/topic/84671-suppress-could-not-close-previous-instance-of-script/
; https://autohotkey.com/board/topic/80086-could-not-close-the-previous-instance-of-this-script/ 
; it doesnt work. "Could not close the previous instance of this script." 12.07.2017 14:58


temp := "___________________________________`n"
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll("`n" . A_LineNumber, A_ScriptName, temp . " STARTING first lines :) ")


DetectHiddenWindows,On
SetTitleMatchMode,2
; WinShow,TypingAid
; WinWaitActive,keysEveryWhere.ahk
; IfWinActive,keysEveryWhere.ahk
; {
;   ToolTip,keys found :)
;   Sleep,3700
;   ExitApp
;}
scriptDirOfAutoHotKey := RegExReplace( A_ScriptDir, "(\\AutoHotKey).*" , "$1") ; maybe file is started from subfolder. 18.04.2017 12:18


SetTitleMatchMode , 1 ; 1: A window's title must start with the specified WinTitle to be a match.
IfWinExist, AHK1
{
   ; i dont wann hardreboot my laptop becouse of thosends of running AHK script.
   ; i protect hard for that. 20.04.2017 18:14
   ; for e.g. AHK19893606
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "pause becouse of found somthing like: for e.g. AHK19893606")
   Pause
/*
AHK19893606
Script file not found: \\.\pipe\AHK19893606
*/

}

s:=1000
s5:=5000
s10:=10000
s15:=15000
s20:=20000
m:=60*s
m5:=m*5

maxLinesOfCode4length1 := 900

;~ SetTimer, reloadWordlost, %s5%
SetTimer, saveIamAllive, 8000


;~ SetTimer, reloadThis, %m% ; ?? whey ? whats the reason for ?
;~ SetTimer, MaybeUpdateWordlist, %s20%



;  TypingAid
;  http://www.autohotkey.com/board/topic/49517-ahk-11typingaid-v2200-word-autocompletion-utility/
;
;  Press 1 to 0 keys to autocomplete the word upon suggestion 
;  Or use the Up/Down keys to select an item
;  (0 will match suggestion 10) 
;                              Credits:
;                                -Maniac
;                                -Jordi S
;                                -hugov
;                                -kakarukeys
;                                -Asaptrad
;                                -j4hangir
;                                -Theclaw
;___________________________________________ 

; Press 1 to 0 keys to autocomplete the word upon suggestion 
;___________________________________________

;    CONFIGURATIONS 

; thats sometimes not working : https://autohotkey.com/boards/viewtopic.php?f=5&t=1261&p=144860#p144860
#SingleInstance,Force

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; single instance force sometimes not 100% work. https://autohotkey.com/boards/viewtopic.php?f=5&t=1261&p=144860#p144860
; thats the plan:
; SingleInstance,Force ... but this sometimes not work.
; set NoTrayIcon to make it hidden.
; Search it. hopefully dont find it. if its found, then dont start it again as a second instance.

DetectHiddenWindows,Off
SetTitleMatchMode,1
scriptName := SubStr( A_ScriptName , 1 , Strlen(A_ScriptName)-4)
;IfWinExist, TypingAid - Active ; maybe  work 26.04.2017 15:28
;IfWinExist, % scriptName . " - Active" ; maybe  work 26.04.2017 15:28
;IfWinExist, % g_ScriptTitle 
;IfWinExist, %g_ScriptTitle% - Active ; maybe  work 26.04.2017 15:28
#NoTrayIcon ; make it unvisible #NoTrayIcon ; make it unvisible Wozu???????????? dar�ber kanne es erkennen ob nicht schon eine andere instanz l�uft... es w�rde sonst denken eine andere l�uft schon???? 16.11.2017 09:06 17-11-16_09-06

IfWinExist, %scriptName% - Active ; maybe  work 26.04.2017 15:28
{
 ; Msgbox,%scriptName% ?= %g_ScriptTitle% `n (%A_ScriptName%~%A_LineNumber%) 
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "exit ")
   ExitApp ; this protect hopefully the scipt from building 100drets of instances.
   ; this was happend during looking videos. tv- mediathek oder sometimes youtube.
}
Menu, Tray, Tip, %g_ScriptTitle% - Inactive ; make it visible again
WinShow,%g_ScriptTitle%
DetectHiddenWindows,On ; if this is off it does not find the tool in tray bar 27.04.2017 12:04
SetTitleMatchMode,2  ; if this is 1 it does not find the tool in tray bar 27.04.2017 12:04


IfWinNotExist,Could not close the previous instance of this script_autoCloser.ahk
run,%A_ScriptDir%\Could not close the previous instance of this script_autoCloser.ahk


;WinClose,keysEveryWhere.ahk ahk_class AutoHotkey ; thats working. thats the way you could close ahk running scripts.
;Msgbox,WinClose keysEveryWhere.ahk ahk_class AutoHotkey (%A_ScriptName%~%A_LineNumber%)




WinWait,Typing_Aid_everywhere_multi_clone.ahk ahk_class AutoHotkey
;IfWinNotExist,Typing_Aid
if(false){ ; set to false at 16.07.2017 10:59. script works stable. dont need it anymore.
; und es muss noch in der laage sein. andere script zu erkennen. sonst besser schliesen. damit es nicht wieder ein berg von instanzen gibt
; MsgBox,exitapp now 17-04-27_12-02
; reload 
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, ":-( exit. becouse: IfWinNotExist,Typing_Aid_everywhere_multi_clone.ahk ")
   ExitApp ; this protect hopefully the scipt from building 100drets of instances.
   ; this was happend during looking videos. tv- mediathek oder sometimes youtube.
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




g_nextCriticalCommandString := "104:Suspend, On"
; Disables all hotkeys 
Suspend, On ; wieder (10.07.2017 11:47) auskommentiert weils mir zu oft auf suspand on war. wehr oft wenn ich auf skype gewecheelt habe. hoffe die anderen bugFix haben den Seiteneffekt das ich dieses nicht mehr brauche.
;WinSetTitle, TypingAid - Active, , TypingAid - Active wait4sec
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
f:= "problemHandler104SuspendOn.ahk"
ff := A_ScriptDir . "\" . f
DetectHiddenWindows,On
if( !WinExist(f) )
   run,%ff% 
WinWait,%f% ,,1
if( !WinExist(ff) ){
   Tooltip,%ff% NOTfound => ExitApp `n (from. %A_ScriptName%~%A_LineNumber%) 
   Sleep,3000
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "Sleep,3000")
   ExitApp 
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; IfWinNotExist,% f
; {
;    gosub,couldIfindMyself
;    run,% f
; }
g_nextCriticalCommandString := ""
Gosub, saveIamAllive

; gosub,couldIfindMyself


#NoEnv
ListLines Off

g_OSVersion := GetOSVersion()

;Set the Coordinate Modes before any threads can be executed
CoordMode, Caret, Screen
CoordMode, Mouse, Screen

EvaluateScriptPathAndTitle()

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; next line is useless sice 16.07.2017 11:51 . i have daktivated it.
SetTimer, checkActiveTitleChanged, 50 ; 31.07.2017 20:57
;
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



;disable hotkeys until setup is complete
g_nextCriticalCommandString := "120:SuspendOn()"
g_nextCriticalCommandTimeIdle := A_TimeIdle
SuspendOn()  ; wieder (10.07.2017 11:51) auskommentiert weils mir zu oft auf suspand on war. wehr oft wenn ich auf skype gewecheelt habe. hoffe die anderen bugFix haben den Seiteneffekt das ich dieses nicht mehr brauche.
g_nextCriticalCommandString := ""

Gosub, setWordlistFileUpdatedTime ; 29.04.2017 14:03


BuildTrayMenu()      


OnExit, SaveScript

;Change the setup performance speed
SetBatchLines, 20ms
;read in the preferences file
ReadPreferences()


SetTitleMatchMode, 2

;set windows constants
g_EVENT_SYSTEM_FOREGROUND := 0x0003
g_EVENT_SYSTEM_SCROLLINGSTART := 0x0012
g_EVENT_SYSTEM_SCROLLINGEND := 0x0013
g_GCLP_HCURSOR := -12
g_IDC_HAND := 32649
g_IDC_HELP := 32651
g_IMAGE_CURSOR := 2
g_LR_SHARED := 0x8000
g_NormalizationKD := 0x6
g_NULL := 0
g_Process_DPI_Unaware := 0
g_Process_System_DPI_Aware  := 1
g_Process_Per_Monitor_DPI_Aware := 2
g_PROCESS_QUERY_INFORMATION := 0x0400
g_PROCESS_QUERY_LIMITED_INFORMATION := 0x1000
g_SB_VERT := 0x1
g_SIF_POS := 0x4
g_SM_CMONITORS := 80
g_SM_CXVSCROLL := 2
g_SM_CXFOCUSBORDER := 83
g_WINEVENT_SKIPOWNPROCESS := 0x0002
g_WM_LBUTTONUP := 0x202
g_WM_LBUTTONDBLCLK := 0x203
g_WM_MOUSEMOVE := 0x200
g_WM_SETCURSOR := 0x20

;setup code
g_DpiScalingFactor := A_ScreenDPI/96
g_Helper_Id = 
g_HelperManual = 
g_DelimiterChar := Chr(2)
g_cursor_hand := DllCall( "LoadImage", "Ptr", g_NULL, "Uint", g_IDC_HAND , "Uint", g_IMAGE_CURSOR, "int", g_NULL, "int", g_NULL, "Uint", g_LR_SHARED ) 
if (A_PtrSize == 8) {
   g_SetClassLongFunction := "SetClassLongPtr"
} else {
   g_SetClassLongFunction := "SetClassLong"
}
g_PID := DllCall("GetCurrentProcessId")
AutoTrim, Off 

InitializeListBox()

BlockInput, Send

global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "InitializeHotKeys()")
InitializeHotKeys()

global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "DisableKeyboardHotKeys()")
DisableKeyboardHotKeys()

;Change the Running performance speed (Priority changed to High in GetIncludedActiveWindow)
SetBatchLines, -1

;Read in the WordList
ParseWordsCount := ReadWordList()
prefs_Length := setLength(ParseWordsCount, maxLinesOfCode4length1)


g_WinChangedCallback := RegisterCallback("WinChanged")
g_ListBoxScrollCallback := RegisterCallback("ListBoxScroll")

if !(g_WinChangedCallback)
{
   MsgBox, Failed to register callback function
   ExitApp
}

if !(g_ListBoxScrollCallback)
{
   MsgBox, Failed to register ListBox Scroll callback function
   ExitApp
}
   
;Find the ID of the window we are using
GetIncludedActiveWindow()

MainLoop()

; END

MainLoop()
{
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
         
      if ( g_OldCaretY != HCaretY() )
      {
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
   } else if ( ( EndKey == "Max" ) && !(InStr(g_TerminatingCharactersParsed, InputChar)) )
   {
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

RecomputeMatchesTimer:

   Thread, NoTimers
   RecomputeMatches()
   Return

RecomputeMatches()
{
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

;------------------------------------------------------------------------

~LButton:: 
CheckForCaretMove("LButton","UpdatePosition")
return
   

;------------------------------------------------------------------------

~RButton:: 
CheckForCaretMove("RButton","UpdatePosition")
Return

;------------------------------------------------------------------------

CheckForCaretMove(MouseButtonClick, UpdatePosition := false)
{
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
   
   
;------------------------------------------------------------------------

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
      HotKey, %A_LoopField%, Off
   ; lll(A_LineNumber, A_ScriptName, "HotKey, %" . A_LoopField . "%, Off")
   }
   Return
}
   

   
;------------------------------------------------------------------------

#MaxThreadsPerHotkey 1 
    
;~ $1::
;~ $!::
$Numpad1::
CheckWord("$1")
return
;~ $2::
;~ $":: ; this is working
; VK07:: ; this is not working 21.04.2017 12:12
; maybe helful for you: http://www.kbdedit.com/manual/low_level_vk_list.html
; VK_OEM_7::

$Numpad2::
CheckWord("$2")
return

;~ $3::
; $§:: ; problem with the paragraph sign. probably becouse of the document format. i dont need it so much. lets deactivate it. 21.04.2017 12:02
$Numpad3::
CheckWord("$3")
return
;~ $4::
;~ $$::
$Numpad4::
CheckWord("$4")
return
;~ $5::
$Numpad5::
CheckWord("$5")
return
;~ $6::
;~ $&::
$Numpad6::
CheckWord("$6")
return
;~ $7::
;~ $/::
;~ ${::
$Numpad7::
CheckWord("$7")
return
;~ $8::
;~ $(::
;~ $[::
$Numpad8::
CheckWord("$8")
return
;~ $9::
;~ $)::
;~ $]::
$Numpad9::
CheckWord("$9")
return
;$0::
;~ $=::
;~ $}::
$Numpad0::
CheckWord("$0")
; CheckWord(A_ThisHotkey)
Return


$^Enter::
$^Space::
$Tab::
$Up::
$Down::
$PgUp::
$PgDn::
$Right::
$Enter::
$NumpadEnter::
EvaluateUpDown(A_ThisHotKey)
Return

$^+h::
MaybeOpenOrCloseHelperWindowManual()
Return

$^+c:: 
AddSelectedWordToList()
Return

$^+Delete::
DeleteSelectedWordFromList()
Return

;------------------------------------------------------------------------

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

;------------------------------------------------------------------------

;If a hotkey related to the up/down arrows was pressed
EvaluateUpDown(Key)
{
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

;------------------------------------------------------------------------

ReturnLineWrong(){
   global g_OldCaretY
   global prefs_DetectMouseClickMove
   ; Return false if we are using DetectMouseClickMove
   IfEqual, prefs_DetectMouseClickMove, On
      Return
      
   Return, ( g_OldCaretY != HCaretY() )
}

;------------------------------------------------------------------------

AddSelectedWordToList()
{
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

DeleteSelectedWordFromList()
{
   global g_MatchPos
   global g_SingleMatch
   
   if !(g_SingleMatch[g_MatchPos] = "") ;only continue if g_SingleMatch is not empty
   {
      
      DeleteWordFromList(g_SingleMatch[g_MatchPos])
      RecomputeMatches()
      Return
   }
   
}

;------------------------------------------------------------------------

EvaluateScriptPathAndTitle()
{
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

;------------------------------------------------------------------------

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

      Menu, tray, Icon, %A_ScriptFullPath%,3,1
   } else
   {
      Menu, tray, Icon, %A_ScriptDir%\%g_ScriptTitle%-Inactive.ico, ,1
   }
}

SuspendOff()
{
   global g_ScriptTitle
   Suspend, Off
   Menu, Tray, Tip, %g_ScriptTitle% - Active
   If A_IsCompiled
   {
            ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.

      Menu, tray, Icon, %A_ScriptFullPath%,1,1
   } else
   {
      Menu, tray, Icon, %A_ScriptDir%\%g_ScriptTitle%-Active.ico, ,1
; we dont need it. sometimes it could not be loadet. so forget it. 03.05.2017 16:31
   }
}   

;------------------------------------------------------------------------

BuildTrayMenu()
{
;feedbackMsgBox("BuildTrayMenu test 17-11-22_13-52","test 17-11-22_13-52",1,1)

   Menu, Tray, DeleteAll
   Menu, Tray, NoStandard
   Menu, Tray, add, Settings, Configuration
   Menu, Tray, add, Pause, PauseResumeScript
   IF (A_IsCompiled) ; A_IsCompiled	Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.
   {
      Menu, Tray, add, Exit, ExitScript
   } else {
      Menu, Tray, Standard
   }
   Menu, Tray, Default, Settings
   ;Initialize Tray Icon
   Menu, Tray, Icon
}

;------------------------------------------------------------------------

; This is to blank all vars related to matches, ListBox and (optionally) word 
ClearAllVars(ClearWord)
{
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

;------------------------------------------------------------------------

FileAppendDispatch(Text,FileName,ForceEncoding=0)
{
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

MaybeFixFileEncoding(File,Encoding)
{
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

;------------------------------------------------------------------------

GetOSVersion()
{
   return ((r := DllCall("GetVersion") & 0xFFFF) & 0xFF) "." (r >> 8)
}

;------------------------------------------------------------------------

MaybeCoInitializeEx()
{
   global g_NULL
   global g_ScrollEventHook
   global g_WinChangedEventHook
   
   if (!g_WinChangedEventHook && !g_ScrollEventHook)
   {
      DllCall("CoInitializeEx", "Ptr", g_NULL, "Uint", g_NULL)
   }
   
}


MaybeCoUninitialize()
{
   global g_WinChangedEventHook
   global g_ScrollEventHook
   if (!g_WinChangedEventHook && !g_ScrollEventHook)
   {
      DllCall("CoUninitialize")
   }
}

;------------------------------------------------------------------------

Configuration:
GoSub, LaunchSettings
Return

PauseResumeScript:
if (g_PauseState == "Paused")
{
   g_PauseState =
   Pause, Off
   EnableWinHook()
   Menu, tray, Uncheck, Pause
} else {
   g_PauseState = Paused
   DisableWinHook()
   SuspendOn()
   Menu, tray, Check, Pause
   Pause, On, 1
}
Return

ExitScript:
ExitApp
Return

SaveScript:
; Close the ListBox if it's open
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "OnExit => SaveScript => CloseListBox()")

CloseListBox()
SuspendOn()
;Change the cleanup performance speed
SetBatchLines, 20ms
Process, Priority,,Normal

;Grab the Helper Window Position if open
MaybeSaveHelperWindowPos()

;Write the Helper Window Position to the Preferences File
MaybeWriteHelperWindowPos()

; Update the Learned Words
MaybeUpdateWordlist()

ExitApp

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

MaybeUpdateWordlist:
MaybeUpdateWordlist()
return

reloadWordlost:
; Update the Learned Words
;~ MaybeUpdateWordlist()
;ReadWordList() ; prefs_Length
ParseWordsCount := ReadWordList()
prefs_Length := setLength(ParseWordsCount, maxLinesOfCode4length1)


ActiveTitleOLD := ActiveTitle
WinGetActiveTitle, ActiveTitle
;TypingAid Settings ahk_class AutoHotkeyGUI 
settitlematchmode,1
;detecthiddenwindows,On
; IfWinExist,TypingAid Help
;{
;   Sleep,9000
;   return
;}
;ifwinexist, TypingAid Settings ; A window's title must start with the specified WinTitle to be a match.
;{
;   Sleep,% m5
;   return
;}
if(ActiveTitleOLD && ActiveTitleOLD <> ActiveTitle ){
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName,  "Goto, doReload `n reason for being carefully with reload `;) https://youtu.be/2a_AsYubzvE " )
 Goto, doReload
;~ ToolTip, % A_TickCount
}
return



reloadThis:
;~ ReadWordList()
;~ ToolTip, % A_TickCount
; Update the Learned Words
MaybeUpdateWordlist()


settitlematchmode,1
IfWinExist,TypingAid Help
   return
ifwinexist,TypingAid Settings ; A window's title must start with the specified WinTitle to be a match.
   return

global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "Goto, doReload")
Goto, doReload

return

;
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
doReload:

return ; reload is deaktivated today :D 29.07.2017 14:51 17-07-29_14-51 . i using it from the Administrator user

if(A_TimeIdle < 2000)
    return
SetTitleMatchMode, 2
DetectHiddenText, Off
DetectHiddenWindows, Off


if( A_TimeIdle > 500 && !WinExist("Open library? (id=1703171452)") && !WinExist("TypingAid Help") && !WinExist("TypingAid Settings") ){
   global g_ListBox_Id
   ; Msgbox, '%g_ListBox_Id%' = g_ListBox_Id  n (line:%A_LineNumber%) `n  (line:%A_LineNumber%)
   IfEqual, g_ListBox_Id, ; if g_ListBox_Id is empty listBox is not open, we could reload. else we will wait. 17-03-17_17-10 17.03.2017 17:10
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "Reload")
global g_doRunLogFiles
 if(g_doRunLogFiles)
run,log\%A_ScriptName%.log.txt
   Reload
}

return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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

; # Include inc_ahk\functions_global.inc.ahk

;SetWorkingDir, %scriptDirOfAutoHotKey% ; A_ScriptDir
;MsgBox, %A_ScriptDir% = A_ScriptDir


; # Include inc_ahk\functions_global.inc.ahk
; # Include *i inc_ahk\UPDATEDSCRIPT_global.inc.ahk
; # Include inc_ahk\functions_global_dateiende.inc.ahk ; A_ScriptDir
; # Include inc_ahk\Typing_Aid_everywhere_multi_clone.inc.ahk





setWordlistFileUpdatedTime:
; lets do this only first time for initializing 29.04.2017 13:40
   WordlistFileName = wordlist.txt
   Wordlist = %A_ScriptDir%\%WordlistFileName%
   WordlistOLD := Wordlist

   if( !FileExist(Wordlist) || InStr(FileExist(Wordlist), "D") ){
        Msgbox,:(  '%Wordlist%' = Wordlist  `n Wordlist is not a file  (%A_ScriptName%~%A_LineNumber%)
        return
    }
    FileGetTime, WordlistModiTime, %Wordlist%, M
    WordlistModiTime_OLD:=WordlistModiTime
return

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


ifWordlistFileWasUpdatedChanged:
    FileGetTime, WordlistModiTime, %Wordlist%, M
    if(WordlistModiTime_OLD <> WordlistModiTime){
        SetTimer, ifWordlistFileWasUpdatedChanged, Off
        SetTimer, ifWordlistFileWasUpdatedChanged, 1500 ; one second is really slow. this line is a little obsulete. but better let it be. 31.07.2017 22:45
        WordlistOLD := Wordlist
        ParseWordsCount := ReadWordList()
        prefs_Length := setLength(ParseWordsCount, maxLinesOfCode4length1)
        ;GoSub, reloadWordlost
        WinGetActiveTitle, ActiveTitle
        if(ActiveTitleOLD <> ActiveTitle )
            ActiveTitleOLD := ActiveTitle
    }else{
        ; sometimes it stacks at line 105 105: Suspend,On (573.41)
        ;~ it needs then reloaded 29.04.2017 13:35
        WinGetActiveTitle, ActiveTitle
        if(ActiveTitleOLD && ActiveTitleOLD <> ActiveTitle && WordlistOLD == Wordlist ){
         
            WordlistModiTime_OLD:=WordlistModiTime
            i := 0
            isActuallyWrittenToLog := false
            while(WordlistModiTime_OLD == WordlistModiTime && i++ < 25){
               ; lets wait a little for new given/copied wordlist 16.07.2017 02:01
               Sleep,100
               if(!isActuallyWrittenToLog){
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "Title changed, Wordlist(modiTime) NOT changed so fast ... ups `n Wordlist=>" . Wordlist . "< `n Sleep,100")
                  isActuallyWrittenToLog := true
               }
               FileGetTime, WordlistModiTime, %Wordlist%, M
            }
         
            msg = %ActiveTitleOLD%  <> `n%ActiveTitle%
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "`n Sleep,100 `n" . msg . "`n ==> Goto, doReload")
            GoSub, doReload
         }
    }
    ;Msgbox, wordlist was changed (%A_ScriptName%~%A_LineNumber%)
    WordlistModiTime_OLD:=WordlistModiTime

   ; lll(A_LineNumber, A_ScriptName, "doReloadIfScriptDontMoveThisLine()")

    doReloadIfScriptDontMoveThisLine()

Return

saveIamAllive:
   FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
   FormatTime, timestampyyMMddHHmmssPretty, %A_now%,yy:MM:dd HH:mm:ss
   FileDelete, TypingAid_programmCounter_LineAndTime.txt
   FileAppend,117_%timestampyyMMddHHmmssPretty%_line_%timestampyyMMddHHmmss% , TypingAid_programmCounter_LineAndTime.txt
return

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
couldIfindMyself:
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "couldIfindMyself cant find scripts running in tray. so its useless :( deprevated. return from function :( now.")

; but BTW it works with oter windows (probably the proble is a changed window name???) . for e.x. this works: IfWinNotExist,Could not close the previous instance of this script_autoCloser.ahk
; 12.07.2017 17:49
return



; IfWinNotActive,TypingAid.ahk - SciTE4AutoHotkey



DetectHiddenWindows,On
if(!FOUNDmyselfCounter)
   FOUNDmyselfCounter := 1
SetTitleMatchMode,1 
scriptNameWithoutAHK := RegExReplace( A_ScriptName, "\.ahk") . " - "

WinMaximize,% scriptNameWithoutAHK 
; WinShow,% scriptNameWithoutAHK ; is without effect 12.07.2017 17:01

pId := DllCall("GetCurrentProcessId") ; thats possible, thats works to get a process id 12.07.2017 17:05
ScriptHwnd := WinExist("ahk_class AutoHotkey ahk_pid " DllCall("GetCurrentProcessId"))

if(false){
IfWinNotExist,% scriptNameWithoutAHK 
{
   ; this time tray icon apps could not be found from autohotkey scripts. you may need a shuffle app for parse information inside the titele bar or so. 16.07.2017 02:16
   ToolTip,LineNumber = %A_LineNumber% : `n `n i cant find myself `n (`nScriptHwnd = %ScriptHwnd% `npId = %pId%`n '%scriptNameWithoutAHK%' ) `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n (programmed at 11.07.2017 15:12)
   ; thats a totally stupid situation, but it happen often.
   ; not always but often.
   ; then i think no autohotkey scrpt should start oter scripts. 
   ; its to dangerous that a stack overflow happens.
   ; may one good workaround could be, wait a lang time and then try it again or pause the script for ever..... and ever ...
   suspend,On 
   min := 60 * 1000
   ; sleep, % 9 * min 
   ; reload 
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "ExitApp")
   Sleep, 3000
   ExitApp
   Pause
}
}
FOUNDmyselfCounter += 1
if(false){
ToolTip, i FOUND :-) myself yeaah `n not a totally idiot :) `n ( %scriptNameWithoutAHK% )  `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n  (programmed at 11.07.2017 20:26)
}
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

checkActiveTitleChanged:
WinGetActiveTitle, ActiveTitle
if(ActiveTitleOLD <> ActiveTitle){
    ActiveTitleOLD := ActiveTitle
    ; sleep,120 ; it needs a little time to copy the files 31.07.2017 21:30
    SetTimer, ifWordlistFileWasUpdatedChanged, 100
}
return


#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk


