; These functions and labels are related maintenance of the wordlist


;<<<<<<<<<<<<<< ReadWordList <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
ReadWordList() {
global g_LegacyLearnedWords
   global g_ScriptTitle
   global g_WordListDone
   global g_WordListDB
   ParseWordsCount :=0
   ;mark the wordlist as not done
   g_WordListDone = 0


  WordlistFileName = wordlist.txt
   ; FileReadLine,WordlistFileName  ,wordlist.txt, 1
   ; FileReadLine,activeClass ,wordlist.txt, 2
   ; FileReadLine,activeTitle ,wordlist.txt, 3

   ; WordlistFileAdress := RegExReplace("\._Generated.txt\s*$", "")
   Wordlist = %A_ScriptDir%\%WordlistFileName%
   WordlistLearned = %A_ScriptDir%\WordlistLearned.txt
   
   MaybeFixFileEncoding(Wordlist,"UTF-8")
   MaybeFixFileEncoding(WordlistLearned,"UTF-8")


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; Section wait for unsolved error messages. to close them unsolved :D 02.04.2017 14:36 17-04-02_14-36 todo: dirty bugfix
ahkCloseERRERmsg =
(
SetTitleMatchMode, 2
WinWait,TypingAid.ahk,database is locked,1
;MsgBox, found Invalid database handle
IfWinNotExist,TypingAid.ahk,database is locked
    ExitApp
WinClose,TypingAid.ahk,database is locked
DetectHiddenWindows, On
; WinClose,TypingAid ahk_class AutoHotkey
; WinWaitClose,TypingAid ahk_class AutoHotkey,,1
; TitleMatchMode=slow
ifWinNotExist,TypingAid
{
    if(FileExist("%A_WorkingDir%\TypingAid.ahk")) {
        lll(A_LineNumber, "Wordlist.ahk", "39: Run, %A_WorkingDir%\TypingAid.ahk 17-08-04_15-47 inside ahkCloseERRERmsg")


        run, %A_WorkingDir%\log\Wordlist.ahk.log.txt

        run , %A_WorkingDir%\TypingAid.ahk , %A_WorkingDir% ; is not working : source is twice:  %A_WorkingDir%\Source\TypingAid.ahk, , min
        ; lll doesent work becouse som inc are not includet here :( 20.04.2017 19:23
    } else{
        ;gosub,couldIfindMyself
        lll(A_LineNumber, "Wordlist.ahk", "Run, %A_WorkingDir%\Source\TypingAid.ahk 17-08-04_16-08  inside ahkCloseERRERmsg")
        run, %A_WorkingDir%\log\Wordlist.ahk.log.txt
        run, %A_WorkingDir%\Source\TypingAid.ahk , %A_WorkingDir%\Source ; is not working : source is
        ; lll(A_LineNumber, "Wordlist.ahk", "Run, %A_WorkingDir%\Source\TypingAid.ahk")
        ; lll doesent work becouse som inc are not includet here :( 20.04.2017 19:23
     }
    }
)

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if(! FileExist( A_WorkingDir . "\inc_ahk\copy2clipBoard.functions.inc.ahk" ) ) {
    lll(A_LineNumber, "Wordlist.ahk", "52 :-( if(!fileExist(A_WorkingDir . \inc_ahk\copy2clipBoard.functions.inc.ahk)) ==> exitApp 17-07-18_20-24")
     msg=NOT Exist %A_WorkingDir% . "\inc_ahk\copy2clipBoard.functions.inc.ahk" ) ==> exitapp `n (%A_ScriptName%~%A_LineNumber%)
     feedbackMsgBox(msg,msg,1,1)
    exitApp
}
ahkCloseERRERmsg .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\copy2clipBoard.functions.inc.ahk"
ahkCloseERRERmsg .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\functions_global.inc.ahk"
ahkCloseERRERmsg .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk"
ahkCloseERRERmsg .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\ToolTipSec.inc.ahk"
ahkCloseERRERmsg .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\functions_global_dateiende.inc.ahk"
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ahkCloseERRERmsg2 =
(
SetTitleMatchMode, 2
WinWait,TypingAid.ahk,Invalid database handle,1
;MsgBox, found Invalid database handle
IfWinNotExist,TypingAid.ahk,Invalid database handle
    ExitApp
WinClose,TypingAid.ahk,Invalid database handle
DetectHiddenWindows, On
WinClose,TypingAid ahk_class AutoHotkey
WinWaitClose,TypingAid ahk_class AutoHotkey,,1
ifWinNotExist,TypingAid
{
if(FileExist("%A_WorkingDir%\TypingAid.ahk")){
   lll(A_LineNumber, "Wordlist.ahk", "65: Run, %A_WorkingDir%\TypingAid.ahk 17-08-04_15-47")
    run , %A_WorkingDir%\TypingAid.ahk ; is not working : source is twice:  %A_WorkingDir%\Source\TypingAid.ahk
}else{
        lll(A_LineNumber, "Wordlist.ahk", "Run, %A_WorkingDir%\Source\TypingAid.ahk")
global g_doRunLogFiles
 if(g_doRunLogFiles)
run,log\Wordlist.ahk.log.txt

    run , %A_WorkingDir%\Source\TypingAid.ahk ; is not working : source is twice:  %A_WorkingDir%\Source\TypingAid.ahk
}
    ; its strange. sometimes the error toggles. so i need both path to run it. 04.04.2017 17:57 17-04-04_17-57
}
)
ahkCloseERRERmsg2 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\copy2clipBoard.functions.inc.ahk"
ahkCloseERRERmsg2 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\functions_global.inc.ahk"
ahkCloseERRERmsg2 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk"
ahkCloseERRERmsg2 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\ToolTipSec.inc.ahk"
ahkCloseERRERmsg2 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\functions_global_dateiende.inc.ahk"



; OK Cannot Create Words Table - fatal error: 1 - table Words already exists
ahkCloseERRERmsg3 =
(
SetTitleMatchMode, 2
WinWait,TypingAid.ahk,Cannot Create Words Table - fatal error, 2
;MsgBox, found Invalid database handle
IfWinNotExist,TypingAid.ahk,Cannot Create Words Table - fatal error
    ExitApp
WinClose,TypingAid.ahk,Cannot Create Words Table - fatal error
DetectHiddenWindows, On
WinClose,TypingAid ahk_class AutoHotkey
WinWaitClose,TypingAid ahk_class AutoHotkey,, 2
ifWinNotExist,TypingAid
{
   if(FileExist("%A_WorkingDir%\TypingAid.ahk")){
              lll(A_LineNumber, "Wordlist.ahk", "Run, %A_WorkingDir%\Source\TypingAid.ahk 17-08-04_15-46")
global g_doRunLogFiles
 if(g_doRunLogFiles)
run,log\Wordlist.ahk.log.txt

       run , %A_WorkingDir%\TypingAid.ahk ; is not working : source is twice:  %A_WorkingDir%\Source\TypingAid.ahk, , min
   } else{
           lll(A_LineNumber, "Wordlist.ahk", "Run, %A_WorkingDir%\Source\TypingAid.ahk")
global g_doRunLogFiles
 if(g_doRunLogFiles)
run,log\Wordlist.ahk.log.txt

       run , %A_WorkingDir%\Source\TypingAid.ahk ; is not working : source is twice:  %A_WorkingDir%\Source\TypingAid.ahk, , min
   }
       ; its strange. sometimes the error toggles. so i need both path to run it. 04.04.2017 17:57 17-04-04_17-57
}
)
ahkCloseERRERmsg3 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\copy2clipBoard.functions.inc.ahk"
ahkCloseERRERmsg3 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\functions_global.inc.ahk"
ahkCloseERRERmsg3 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk"
ahkCloseERRERmsg3 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\ToolTipSec.inc.ahk"
ahkCloseERRERmsg3 .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\functions_global_dateiende.inc.ahk"


ahkReStartOnClose =
(
sleep,1000
SetTitleMatchMode, 2
DetectHiddenWindows, On
WinWaitClose,Typing_Aid_everywhere_multi_clone.ahk , , 1
ifWinNotExist , Typing_Aid_everywhere_multi_clone.ahk
{
   fexist := FileExist ("%A_WorkingDir%\Typing_Aid_everywhere_multi_clone.ahk" )
   if( !fexist ){
        lll(A_LineNumber, "Wordlist.ahk", "Run, %A_WorkingDir%\Source\TypingAid.ahk 17-08-04_15-46")
global g_doRunLogFiles
 if(g_doRunLogFiles)
run,log\Wordlist.ahk.log.txt
       run , %A_WorkingDir%\Typing_Aid_everywhere_multi_clone.ahk , %A_WorkingDir%
   }
}

)
ahkReStartOnClose .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\copy2clipBoard.functions.inc.ahk"
ahkReStartOnClose .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\functions_global.inc.ahk"
ahkReStartOnClose .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk"
ahkReStartOnClose .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\ToolTipSec.inc.ahk"
ahkReStartOnClose .= "`n#" . "Include " .  A_WorkingDir . "\inc_ahk\functions_global_dateiende.inc.ahk"

DynaRun("#" . "NoTrayIcon `n" . ahkCloseERRERmsg) ; cant fix this error. so fix the error message :D 02.04.2017 14:35 17-04-02_14-35 http://SL5.net
DynaRun("#" . "NoTrayIcon `n" . ahkCloseERRERmsg2) ; cant fix this error. so fix the error message :D 18.04.2017 15:53 http://SL5.net
DynaRun("#" . "NoTrayIcon `n" . ahkCloseERRERmsg3) ; cant fix this error. 18.04.2017 17:39 http://SL5.net
DynaRun("#" . "NoTrayIcon `n" . ahkReStartOnClose) ; cant fix this error. so fix the error message :D 18.04.2017 17:00 http://SL5.net
g_WordListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", A_ScriptDir . "\WordlistLearned.db" ) ; https://autohotkey.com/board/topic/86457-dba-16-easy-database-access-mysql-sqlite-ado-ms-sql-access/
; END of: Section wait for unsolved error messages. to close them unsolved :D 02.04.2017 14:36 17-04-02_14-36 todo: dirty bugfix

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   if (!g_WordListDB )
   {
      tooltip, Problem opening database '%A_ScriptDir%\WordlistLearned.db' - fatal error...
      lll(A_LineNumber, "Wordlist.ahk",Last_A_This . " sleep,15000 ")
      sleep,15000
      ; exitapp
      lll(A_LineNumber, "Wordlist.ahk",Last_A_This . " reload ")
      reload ; 02.04.2017 12:47 17-04-02_12-47 Http://SL5.net
   }
errorLog =
(
02.04.2017 13:43 17-04-02_13-43
PRAGMAjournal_mode := "TRUNCATE;"
Child Exception:
SQLite_Exec
ERROR: Invalid database handle 10222256 Return Code: 1

02.04.2017 14:06 , 17-04-02_14-06
Cannot Create Words Table - fatal error: 5 - database is locked
OK
==> there was two TypingAid runniing. how could thats be?
)

; How to test if file is_writable and not locked by another program ??
; FileGetAttrib, OutputVar, A_ScriptDir . "\WordlistLearned.db"
; clipboard := g_WordListDB
    if(g_WordListDB)
        g_WordListDB.Query("PRAGMA journal_mode = TRUNCATE;")
   else
       msgbox,Oops i am triggered :D 17-04-02_13-47 !g_WordListDB
   
   DatabaseRebuilt := MaybeConvertDatabase()
         
   FileGetSize, WordlistSize, %Wordlist%

   if(false && !WordlistSize) {
          m = !WordlistSize: Oops i am triggered :D 17-04-02_13-52 (from: Wordlist.ahk~%A_LineNumber%)
        Sleep,2500

 ;lll(A_LineNumber, "Wordlist.ahk",Last_A_This . " reload " )
global g_doRunLogFiles
 if(g_doRunLogFiles)
run,log\%A_ScriptName%.log.txt
        lll(A_LineNumber, "Wordlist.ahk",Last_A_This . " reload ")
        Reload
          MsgBox,5 ,!WordlistSize ,Oops i am triggered :D 17-04-02_13-52 (from: %A_ScriptName%~%A_LineNumber%), 5
          ; that is very seldom triggerend. 18.04.2017 20:17
   }
   FileGetTime, WordlistModified, %Wordlist%, M
   FormatTime, WordlistModified, %WordlistModified%, yyyy-MM-dd HH:mm:ss
   ;tooltip,FileGetTime %WordlistModified% %Wordlist%, M
   if(!WordlistModified){
        msg =
(
%Wordlist% = Wordlist
%WordlistModified% = WordlistModified

from: Wordlist.ahk~%A_LineNumber%
)
        msgbox,Oops i am triggered :D 17-04-04_17-32 `n `n %msg%
        exitApp
  }
; regex
   if (!DatabaseRebuilt) {
      ; LearnedWordsTable := g_WordListDB.Query("SELECT wordlistmodified, wordlistsize FROM Wordlists WHERE wordlist = 'wordlist.txt';")
      LearnedWordsTable := g_WordListDB.Query("SELECT wordlistmodified, wordlistsize FROM Wordlists WHERE wordlist = '" . WordlistFileName . "';")

      LoadWordlist := "Insert"
      
      For each, row in LearnedWordsTable.Rows
      {
         WordlistLastModified := row[1]
         WordlistLastSize := row[2]
         
         if (WordlistSize != WordlistLastSize || WordlistModified != WordlistLastModified) {
            LoadWordlist := "Update"
            CleanupWordList()
         } else {
            LoadWordlist =
            CleanupWordList(true)
         }
      }
   } else {
      LoadWordlist := "Insert"
   }


   if (LoadWordlist) {
      ; Progress, M, Please wait..., Loading wordlist, %g_ScriptTitle%
      g_WordListDB.BeginTransaction()
      ;reads list of words from file 
      FileRead, ParseWords, %Wordlist%

;<<<<<<<<<<<<<<<<< library open ADD <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; thats a way how you could add wordlist lines vocabularies inside onlive 12.08.2017 23:24
; if you may destroy your path to your config file, thats a way to find it again.
;                        foundOpenLibLine := 0
                        pattern := "m)^\s*__+[^`n]*open[^`n]*\|rr\|\|ahk\|"
;                        foundOpenLibLine  := RegExMatch(A_LoopField, pattern )
                        ParseWords432indes := SubSTr( ParseWords , 1 , 432 ) ; we dont wann search the complete file. takes to much time :) 12.08.2017 23:02 17-08-12_23-02
                        if( !RegExMatch(ParseWords432indes, pattern ) ){
temp := "___open library (Wordlist.ahk~" . A_LineNumber . "|rr||ahk|FileReadLine,WordlistFileAdress, wordlist.txt.status.txt, 1 ``n WordlistFileAdress := RegExReplace(WordlistFileAdress, ""\._Generated\.txt\s*$"", """") ``n run,% WordlistFileAdress"
    ParseWords .= "`n" . temp ; thats not performantly. :/ but works 12.08.2017 22:31 sl5.net todo:

; info := SubSTr( ParseWords , 1 , 150 ) ;     tooltip,%info% ... `n (%A_ScriptName%~%A_LineNumber%) `
}
;>>>>>>>>>>>>>>>>> library open ADD >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

      len:=Strlen(ParseWords)
      foundOpenLibLine := 0
      Loop, Parse, ParseWords, `n, `r
      {
         ParseWordsCount++


         if(false && !foundOpenLibLine){
                  pattern := "^\s*__+open[^`n]*\|rr\|\|ahk\|"
                  foundOpenLibLine  := RegExMatch(A_LoopField, pattern )
                  if( foundOpenLibLine ){
                      Tooltip, %A_LoopField% `n found :) `n (from: %A_ScriptName%~%A_LineNumber%)
                  }
          }

      } ; end of loop
      if(false && !foundOpenLibLine){
            temp := "___open library|rr||ahk|FileReadLine,WordlistFileAdress, wordlist.txt.status.txt, 1 `n WordlistFileAdress := RegExReplace(WordlistFileAdress, ""\._Generated\.txt\s*$"", """") `n run,% WordlistFileAdress"
            ; AddWordToList(AddWord,ForceCountNewOnly,ForceLearn:= false, ByRef LearnedWordsCount := false) {
            AddWordToList(temp,1,"ForceLearn") ; works but AHK is not succedet :( 12.08.2017 22:28
        }
      DynaRun("#" . "NoTrayIcon `n  Tooltip,.SL5. `n Sleep,2300")
      ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


if(false && ParseWordsCount>0)
    Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)

; DynaRun("msgbox, (line:" . A_LineNumber . ") `n Sleep,2000  ")
global do_tooltipReadWordList
      if(do_tooltipReadWordList)
          DynaRun("#" . "NoTrayIcon `n" . "loop,20 `n { `n Tooltip,read (line:" . A_LineNumber . ") `n Sleep,100 `n }  ")
; DynaRun("Tooltip, read Wordlist (line:" . A_LineNumber . ") ``n Sleep,2000 ``n Exitapp")
; DynaRun("Tooltip, read Wordlist (line:" . A_LineNumber . ") ``n Sleep,2000 ``n Exitapp")

    if(false && ParseWordsCount>0)
        Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)

      Loop, Parse, ParseWords, `n, `r1
      {

         ; Tooltip,%A_LoopField% `n (from: %A_ScriptName%~%A_LineNumber%)
         ParseWordsSubCount++
         ProgressPercent := Round(ParseWordsSubCount/ParseWordsCount * 100)
         if (ProgressPercent <> OldProgressPercent)
         {
            ;~ Progress, %ProgressPercent%
            OldProgressPercent := ProgressPercent
         }
         IfEqual, A_LoopField, `;LEARNEDWORDS`;
         {
            if (DatabaseRebuilt)
            {
               LearnedWordsCount=0
               g_LegacyLearnedWords=1 ; Set Flag that we need to convert wordlist file
            } else {
               break
            }
         } else {
                 ;Parse  := RegExReplace(pattern, "^\s+" , "" ) ; anfangs leerzeichen raus 06.11.2017 18:28

                 ALoopField := A_LoopField
                 ALoopField  := RegExReplace(ALoopField, "^\s+" , "" ) ; anfangs leerzeichen raus 06.11.2017 18:28
                ; msgbox, %ALoopField% 06.11.2017 18:34

            AddWordToList(ALoopField,0,"ForceLearn",LearnedWordsCount)
         }
      }
    if(false && ParseWordsCount>0)
          Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)

      ParseWords =
      g_WordListDB.EndTransaction()
      Progress, Off
      
      if (LoadWordlist == "Update") {
         g_WordListDB.Query("UPDATE wordlists SET wordlistmodified = '" . WordlistModified . "', wordlistsize = '" . WordlistSize . "' WHERE wordlist = '" . WordlistFileName . "';")
      } else {
         g_WordListDB.Query("INSERT INTO Wordlists (wordlist, wordlistmodified, wordlistsize) VALUES ('" . WordlistFileName . "','" . WordlistModified . "','" . WordlistSize . "');")
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

      g_WordListDB.BeginTransaction()
      ;reads list of words from file 
      FileRead, ParseWords, %WordlistLearned%
      global do_tooltipReadWordList
;      if(do_tooltipReadWordList)
;          Tooltip, read WordlistLearned(line:%A_LineNumber%)
      DynaRun("#" . "NoTrayIcon `n" . "loop,20 `n { `n Tooltip,read WordlistLearned (line:" . A_LineNumber . ") `n Sleep,100 `n }  ")
; Msgbox, n (line:%A_LineNumber%) Msgbox, `n (line:%A_LineNumber%)
;Msgbox, n (line:%A_LineNumber%) ; SciTEWindow\_global.txt
; SciTEWindow\_global.txt
if(false && ParseWordsCount>0)
    Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)

; ___open library|rr||ahk|FileReadLine,WordlistFileAdress, wordlist.txt.status.txt, 1 `n WordlistFileAdress := RegExReplace(WordlistFileAdress, "\._Generated\.txt\s*$", "") `n run,% WordlistFileAdress
      Loop, Parse, ParseWords, `n, `r
      {
         AddWordToList(A_LoopField,0,"ForceLearn",LearnedWordsCount)
      }
      ParseWords =
      g_WordListDB.EndTransaction()
      
;      Progress, 50, Please wait..., Converting learned words, %g_ScriptTitle%

      ;reverse the numbers of the word counts in memory
      ReverseWordNums(LearnedWordsCount)
      
      g_WordListDB.Query("INSERT INTO LastState VALUES ('tableConverted','1',NULL);")
      
      Progress, Off
   }
    if(false && ParseWordsCount>0)
        Msgbox, %ParseWordsCount%  (line:%A_LineNumber%)

   ;mark the wordlist as completed
   g_WordlistDone = 1
   DynaRun("#" . "NoTrayIcon `n Tooltip,|SL5|`n Sleep,2300")
   ; tooltip,%ParseWordsCount%`n (from: %A_ScriptName%~%A_LineNumber%)
   Return ParseWordsCount
}
;>>>>>>>>>>>>>>>>>>  ReadWordList >>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
;------------------------------------------------------------------------

ReverseWordNums(LearnedWordsCount)
{
   ; This function will reverse the read numbers since now we know the total number of words
   global prefs_LearnCount
   global g_WordListDB

   LearnedWordsCount+= (prefs_LearnCount - 1)

   LearnedWordsTable := g_WordListDB.Query("SELECT word FROM Words WHERE count IS NOT NULL;")

   g_WordListDB.BeginTransaction()
   For each, row in LearnedWordsTable.Rows
   {
      SearchValue := row[1]
      StringReplace, SearchValueEscaped, SearchValue, ', '', All
      WhereQuery := "WHERE word = '" . SearchValueEscaped . "'"
      g_WordListDB.Query("UPDATE words SET count = (SELECT " . LearnedWordsCount . " - count FROM words " . WhereQuery . ") " . WhereQuery . ";")
   }
   g_WordListDB.EndTransaction()

   Return
   
}

;------------------------------------------------------------------------

AddWordToList(AddWord,ForceCountNewOnly,ForceLearn:= false, ByRef LearnedWordsCount := false) {
   ;AddWord = Word to add to the list
   ;ForceCountNewOnly = force this word to be permanently learned even if learnmode is off
   ;ForceLearn = disables some checks in CheckValid
   ;LearnedWordsCount = if this is a stored learned word, this will only have a value when LearnedWords are read in from the wordlist
   global prefs_DoNotLearnStrings
   global prefs_ForceNewWordCharacters
   global prefs_LearnCount
   global prefs_LearnLength
   global prefs_LearnMode
   global g_WordListDone
   global g_WordListDB
;SciTEWindow\_global.txt
; SciTEWindow\_global.txt
; zwei
;  foundPos := RegExMatch( "str" , "i)" )
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
         
   if !(CheckValid(AddWord,ForceLearn))
      return
   
   TransformWord(AddWord, AddWordReplacement, AddWordDescription, AddWordTransformed, AddWordIndexTransformed, AddWordReplacementTransformed, AddWordDescriptionTransformed)

   IfEqual, g_WordListDone, 0 ;if this is read from the wordlist
   {
      IfNotEqual,LearnedWordsCount,  ;if this is a stored learned word, this will only have a value when LearnedWords are read in from the wordlist
      {
         ; must update wordreplacement since SQLLite3 considers nulls unique
         g_WordListDB.Query("INSERT INTO words (wordindexed, word, count, wordreplacement) VALUES ('" . AddWordIndexTransformed . "','" . AddWordTransformed . "','" . LearnedWordsCount++ . "','');")
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
         g_WordListDB.Query("INSERT INTO words (wordindexed, word, worddescription, wordreplacement) VALUES ('" . AddWordIndexTransformed . "','" . AddWordTransformed . "'," . WordDescriptionQuery . "," . WordReplacementQuery . ");")
      }
      
   } else if (prefs_LearnMode = "On" || ForceCountNewOnly == 1)
   { 
      ; If this is an on-the-fly learned word
      AddWordInList := g_WordListDB.Query("SELECT * FROM wordsre WHERE word = '" . AddWordTransformed . "';")
      
      IF !( AddWordInList.Count() > 0 ) ; if the word is not in the list
      {
      
         IfNotEqual, ForceCountNewOnly, 1
         {
            IF (StrLen(AddWord) < prefs_LearnLength) ; don't add the word if it's not longer than the minimum length for learning if we aren't force learning it
               Return
            
            if AddWord contains %prefs_ForceNewWordCharacters%
               Return
                  
            if AddWord contains %prefs_DoNotLearnStrings%
               Return
                  
            CountValue = 1
                  
         } else {
            CountValue := prefs_LearnCount ;set the count to LearnCount so it gets written to the file
         }
         
         ; must update wordreplacement since SQLLite3 considers nulls unique
         g_WordListDB.Query("INSERT INTO words (wordindexed, word, count, wordreplacement) VALUES ('" . AddWordIndexTransformed . "','" . AddWordTransformed . "','" . CountValue . "','');")
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
               g_WordListDB.QUERY("UPDATE words SET count = ('" . prefs_LearnCount . "') WHERE word = '" . AddWordTransformed . "');")
            }
         } else {
            UpdateWordCount(AddWord,0) ;Increment the word count if it's already in the list and we aren't forcing it on
         }
      }
   }
   
   Return
}

CheckValid(Word,ForceLearn:= false)
{
   
   Ifequal, Word,  ;If we have no word to add, skip out.
      Return
            
   if Word is space ;If Word is only whitespace, skip out.
      Return
   
   if ( Substr(Word,1,1) = ";" ) ;If first char is ";", clear word and skip out.
   {
      Return
   }
   
   IF ( StrLen(Word) <= prefs_Length ) ; don't add the word if it's not longer than the minimum length
   {
      Return
   }
   
   ;Anything below this line should not be checked if we want to Force Learning the word (Ctrl-Shift-C or coming from wordlist.txt)
   If ForceLearn
      Return, 1
   
   ;if Word does not contain at least one alpha character, skip out.
   IfEqual, A_IsUnicode, 1
   {
      if ( RegExMatch(Word, "S)\pL") = 0 )  
      {
         return
      }
   } else if ( RegExMatch(Word, "S)[a-zA-Z�-��-��-��-�]") = 0 )
   {
      Return
   }
   
   Return, 1
}

TransformWord(AddWord, AddWordReplacement, AddWordDescription, ByRef AddWordTransformed, ByRef AddWordIndexTransformed, ByRef AddWordReplacementTransformed, ByRef AddWordDescriptionTransformed)
{
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

DeleteWordFromList(DeleteWord)
{
   global prefs_LearnMode
   global g_WordListDB
   
   Ifequal, DeleteWord,  ;If we have no word to delete, skip out.
      Return
            
   if DeleteWord is space ;If DeleteWord is only whitespace, skip out.
      Return
   
   IfNotEqual, prefs_LearnMode, On
      Return
   
   StringReplace, DeleteWordEscaped, DeleteWord, ', '', All
   g_WordListDB.Query("DELETE FROM words WHERE word = '" . DeleteWordEscaped . "';")
      
   Return   
}

;------------------------------------------------------------------------

UpdateWordCount(word,SortOnly)
{
   global prefs_LearnMode
   global g_WordListDB
   ;Word = Word to increment count for
   ;SortOnly = Only sort the words, don't increment the count
   
   ;Should only be called when LearnMode is on  
   IfEqual, prefs_LearnMode, Off
      Return
   
   IfEqual, SortOnly, 
      Return

   StringReplace, wordEscaped, word, ', '', All
   g_WordListDB.Query("UPDATE words SET count = count + 1 WHERE word = '" . wordEscaped . "';")
   
   Return
}

;------------------------------------------------------------------------

CleanupWordList(LearnedWordsOnly := false)
{
   ;Function cleans up all words that are less than the LearnCount threshold or have a NULL for count
   ;(NULL in count represents a 'wordlist.txt' word, as opposed to a learned word)
   global g_ScriptTitle
   global g_WordListDB
   global prefs_LearnCount
;   Progress, M, Please wait..., Cleaning wordlist, %g_ScriptTitle%
   if (LearnedWordsOnly) {
      g_WordListDB.Query("DELETE FROM Words WHERE count < " . prefs_LearnCount . " AND count IS NOT NULL;")
   } else {
      g_WordListDB.Query("DELETE FROM Words WHERE count < " . prefs_LearnCount . " OR count IS NULL;")
   }
   Progress, Off
}

;------------------------------------------------------------------------

MaybeUpdateWordlist()
{
   global g_LegacyLearnedWords
   global g_WordListDB
   global g_WordListDone
   global prefs_LearnCount
   
   ; Update the Learned Words
   IfEqual, g_WordListDone, 1
   {
      
      SortWordList := g_WordListDB.Query("SELECT Word FROM Words WHERE count >= " . prefs_LearnCount . " AND count IS NOT NULL ORDER BY count DESC;")
      
      for each, row in SortWordList.Rows
      {
         TempWordList .= row[1] . "`r`n"
      }
      
      If ( SortWordList.Count() > 0 )
      {
         StringTrimRight, TempWordList, TempWordList, 2
   
         FileDelete, %A_ScriptDir%\Temp_WordlistLearned.txt
         FileAppendDispatch(TempWordList, A_ScriptDir . "\Temp_WordlistLearned.txt")
         FileCopy, %A_ScriptDir%\Temp_WordlistLearned.txt, %A_ScriptDir%\WordlistLearned.txt, 1
         FileDelete, %A_ScriptDir%\Temp_WordlistLearned.txt
         
         ; Convert the Old Wordlist file to not have ;LEARNEDWORDS;
         IfEqual, g_LegacyLearnedWords, 1
         {
            TempWordList =
            FileRead, ParseWords, %A_ScriptDir%\Wordlist.txt
            LearnedWordsPos := InStr(ParseWords, "`;LEARNEDWORDS`;",true,1) ;Check for Learned Words
            TempWordList := SubStr(ParseWords, 1, LearnedwordsPos - 1) ;Grab all non-learned words out of list
            ParseWords = 
            FileDelete, %A_ScriptDir%\Temp_Wordlist.txt
            FileAppendDispatch(TempWordList, A_ScriptDir . "\Temp_Wordlist.txt")
            FileCopy, %A_ScriptDir%\Temp_Wordlist.txt, %A_ScriptDir%\Wordlist.txt, 1
            FileDelete, %A_ScriptDir%\Temp_Wordlist.txt
         }   
      }
   }
   
   g_WordListDB.Close(),
   
}

;------------------------------------------------------------------------

; Removes marks from letters.  Requires Windows Vista or later.
; Code by Lexikos, based on MS documentation
StrUnmark(string) {
   global g_OSVersion
   global g_NormalizationKD
   if (g_OSVersion < 6.0)
   {
      return string
   }
   
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
   
   StringReplace, string, string, �, ae, All
   StringReplace, string, string, �, AE, All
   StringReplace, string, string, �, oe, All
   StringReplace, string, string, �, OE, All
   StringReplace, string, string, �, ss, All   
   
   return, string  
   
}

