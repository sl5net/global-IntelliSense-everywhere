





; <td class="col1" style="color: transparent">Schule</td>
; These functions and labels are related to sending the word to the program

SendKey(Key){
   IfEqual, Key, $^Enter
   {
      Key = ^{Enter}
   } else IfEqual, Key, $^Space
   { 
      Key = ^{Space}
   } else {
      Key := "{" . SubStr(Key, 2) . "}"
   }
   
   SendCompatible(Key,1)
   Return
}

;------------------------------------------------------------------------


getWordIndex(word) {
msgbox, getWordIndex(word) `n is not implemented yet 17-07-10_14-10
}
getLineOfWord(word) {
  global g_SingleMatch
  ;~ global g_SingleMatchReplacement

;~ erste zeile mit eintrag im wörterbuch: g_SingleMatch[1] 10.07.2017 12:13
;~ letzte zeile mit eintrag im wörterbuch: g_SingleMatch[1] 10.07.2017 12:13

  global WordlistFileName
  global wordlist
  ;WordlistFileName = wordlist.txt
  WordlistFileName := wordlist
  if(!FileExist(WordlistFileName))
    msgbox, :( 17-07-10_13-48

    Loop, Read, %WordlistFileName%
    {
        if ErrorLevel
            break

        foundPos := RegExMatch(A_LoopReadLine, "^" . word )
        if ( foundPos  ) {
            ;msgBox, %A_LoopReadLine% 18-03-02_09-26
            ;tooltip,'%A_LoopReadLine%' = A_LoopReadLine `n (line:%A_LineNumber%)
            ;ToolTip1sec(A_LoopReadLine . "`n" . A_LineNumber . " " .  A_LineFile . " " .    Last_A_This)
            return, JEE_StrUtf8BytesToText( A_LoopReadLine )
            ; return A_Index
         }
        }

    if(0)
    Loop,9999
    {
        FileReadLine, thisLine , %WordlistFileName%, %A_Index%
        if ErrorLevel
            break

        foundPos := RegExMatch(thisLine, "^" . word )
        if ( foundPos  ) {
            ;msgBox, %thisLine% 17-07-10_13-28
            ;tooltip,'%thisLine%' = thisLine  `n (line:%A_LineNumber%)
            ;ToolTip1sec(thisLine . "`n" . A_LineNumber . " " .  A_LineFile . " " .    Last_A_This)
            return, thisLine
            return a_index
         }
    }
    ; MsgBox, '%WordlistFileName%' = WordlistFileName  n (line:%A_LineNumber%) n `n The end of the file has been reached or there was a problem.
return



firstLine := g_SingleMatch[1]

  word = Trim
  loop,9999
  {
    if(!g_SingleMatch[a_index]){
        aindexBackup := a_index
       break
    }
    thisLine := g_SingleMatch[a_index]
    foundPos := RegExMatch(thisLine, word )
    if ( foundPos  ) {
        msgBox, %thisLine% 170710_1328
        return a_index
     }
  }
  msgbox, :-( 10.07.2017 13:33
  return
  ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  if(false){
  loop,9999
  {
    if(!g_SingleMatch[a_index]){
        aindexBackup := a_index
       break
    }
  }
  lastMatchingWord := g_SingleMatch[A_Index-1] ; for e.g. 6 if you hit "___" 10.07.2017
  send, % "17-07-10_12-21 index= " . aindexBackup . " = " . lastMatchingWord
  }
  ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  if(false){ ; funktioniert nicht, noch nicht. egal 10.07.2017 13:15. keie Zeit
  global g_WordListDB
  loop,9999
  {
    if(!g_WordListDB[a_index]){
        aindexBackup := a_index
       break
    }
  }
  lastWord := g_WordListDB[A_Index-1] ; for e.g. 6 if you hit "___" 10.07.2017

;~   select = SELECT id FROM Words WHERE word ="%word%" ;
    StringReplace, SearchValueEscaped, word, ', '', All
  select := "SELECT * FROM Words WHERE word LIKE '" . SearchValueEscaped . "%' "
  select := "SELECT * FROM Words WHERE word LIKE 'Trim%' "
  select := "SELECT * FROM Words WHERE word = 'Trim(String)' "
  ; msgbox, '%select%' = select  n (line:%A_LineNumber%) n
  ; ______________________' ' = SearchValue  n (line:69) n17-07-10_12-21 index= 1
  table := g_WordListDB.Query( select )
 g_WordListDB.BeginTransaction()
 For each, row in myTable.Rows
 {
    SearchValue0 := row[0]
    SearchValue := row[1]
    Msgbox,'%SearchValue%' = SearchValue  n (line:%A_LineNumber%) n
 }
 g_WordListDB.EndTransaction()
; ____' ' = SearchValue  n (line:68) n17-07-10_12-21 index= 1
; ____ ____' ' = SearchValue  n (line:67) n17-07-10_12-21 index= 1
; send,'%SearchValue0% %SearchValue%' = SearchValue  n (line:%A_LineNumber%) n
; ________'' = SearchValue  n (line:66) n17-07-10_12-21 index= 1
; ___ __' ' = SearchValue  n (line:68) n17-07-10_12-21 index= 1
  send, % "17-07-10_12-21 index= " . aindexBackup . " = " . lastWord
    }
  ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
return
}
; __17-07-10_12-21 index= 6 __ __17-07-10_12-21 index= 6
; ___17-07-10_12-21 __17-07-10_12-21  ___17-07-10_12-21 index= 0
; ___17-07-10_12-21 index= 1
; ____17-07-10_12-21 index= 1











SendWord(WordIndex){
   global g_SingleMatch
   global g_SingleMatchReplacement

disableCopyQ() ; enableCopyQ() ;
   ; getWordIndex("__")

   ;Send the word
   if (g_SingleMatchReplacement[WordIndex]){
      sending := g_SingleMatchReplacement[WordIndex]
      sending := g_SingleMatchReplacement[WordIndex]
      ForceBackspace := true
   } else {
      sending := g_SingleMatch[WordIndex]
      ForceBackspace := false
   }

; sending := "getCorrectedStringUAOSS1==" getCorrectedStringUAOSS( sending  )

;sending := "JEE_StrTextToUtf8Bytes" JEE_StrTextToUtf8Bytes( sending )
;sending := JEE_StrUtf8BytesToText( sending )
;sending := getCorrectedStringUAOSS( sending  )
; MsgBox, % vText := JEE_StrUtf8BytesToText(vUtf8Bytes)


; sending := "getCorrectedStringUAOSS2==" getCorrectedStringUAOSS( sending  )
; sending = %sending%
; sending := getCorrectedStringUAOSS( sending  )

;Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)
; ein eineins|rr|zwei|ahk|autohotkey source code
; eins|rr|zwei|ahk|autohotkey source code
; thats great :) here we find the complete line :) inside sending 17.03.2017 18:23 17-03-17_18-23
 ; SciTEWindow\_global.txt
 ;~ Msgbox,'%WordIndex%' = WordIndex  `n (%A_LineFile%~%A_LineNumber%)

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; comments to WordIndex is numeric ID
;~ Msgbox, % g_Match[WordIndex] ; thats empty. nicht interessant 10.07.2017 10:49
;~ Msgbox, % g_SingleMatch[WordIndex] ; that only gets the text bofore the pipe | z.B. bei open|rr||ahk|run ....txt you get "open" 10.07.2017 10:53
;~ Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)
;~ sending = complete line z.B. bei open|rr||ahk|run ....txt you get "open|rr||ahk|run ....txt" 10.07.2017 10:53

; getWordIndex("Trim")
;
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;global g_Word
;Msgbox, % g_Word[2] ; ; i dont know what this is. most of time its emptty . rght? 10.07.2017 14:06
;  Msgbox, % g_SingleMatchReplacement[WordIndex] ; thats only the text behind the pipe |
; ________SciTEWindow\_global.txt
; zwei
; Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)
AHKcode := ""
doSendSpacesInAHKslow := false
doSendSpaceSlow := true
isAHKcode := false
WinGetActiveTitle, activeTitle

if (g_SingleMatch[WordIndex]) {
; eins|rr|zwei|ahk|autohotkey source code
; regIsAHKcode := "^([^\|]+?)\|rr\|(.*?)\|ahk\|(.*?)$"
regIsAHKcode := "^([^\|\n]+?)\|rr\|([^\n]*?)\|ahk\|([^\n]*?)$" ; works in phpstorm
; AHKdyn example super simple example
   ; if(RegExMatch( sending , ereg ,  m )) {
   if(RegExMatch( g_SingleMatch[WordIndex] , regIsAHKcode ,  m )) {
   isAHKcode := true

    AHKcode := m3

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; enable to use quellenangaben in ahk pseudo code.
; Beispiel:
;~ indirect hello AHKdyn Example|rr||ahk|q=indirect3
;~ indirect3|rr|indirect3 hello :-) 10.07.2017 14:27|ahk|

; indirect3 hello :-) 10.07.2017 14:27

   if( RegExMatch( AHKcode , "^\s*q=\s*(.+)\s*$" ,  m ) ) { ; q=
        line := getCorrectedStringUAOSS( getLineOfWord( m1 )) ; that works :) 10.07.2017 14:18
        isAHKcode := false
        if(RegExMatch( line , regIsAHKcode ,  m )) { ; repeat / overwrite last regex 10.07.2017 14:24
         isAHKcode := true
         AHKcode := m3
        }else{
         sending := line
         sending := RegExReplace(line, "i).*\|r\|(.*)", "$1") ; i know thats not redundanct. todo: do better reduaant style 10.07.2017 15:31
      }


    }
    ; ___ __ thats a simple simpleHello thats a simple simpleHello thats a simple simpleHello
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



; msgbox, '%line%' = line  n (line:%A_LineNumber%) n
; __asdkjfhsdf
if(isAHKcode)
    sending := m2
;    Msgbox, '%sending%' = sending  `n `n AHKcode = %m3% (line:%A_LineNumber%)


   }else
   if( doSendSpaceSlow && substr( g_SingleMatch[WordIndex], 1 , 2 ) != "__" && RegExMatch( activetitle , "\.(json|ts|css|html) - PhpStorm" ) ) {
   ; if(doSendSpaceSlow && "__" != substr( g_SingleMatch[WordIndex], 1 , 2 )  ){
       isAHKcode := true
       doSendSpacesInAHKslow := true
       sending := "" ; thats very fast. may use it in other casese 10.04.2017 13:29
       ; AHKcode := "Send," . g_SingleMatch[WordIndex]
       AHKcode := g_SingleMatch[WordIndex]

       ; lets open the wordlist inside notepad++ or so 19.04.2017 19:16
;       Msgbox,'%wordlistActive%' = wordlistActive  n (line:%A_LineNumber%) n   n (from: %A_LineFile%~%A_LineNumber%)
; Msgbox,n (from: %A_LineFile%~%A_LineNumber%)


    }
}




   ; Update Typed Count
   UpdateWordCount(sending,0)
   ;if( !isAHKcode )

if( doSendSpacesInAHKslow == false )
    SendFull(sending, ForceBackspace)

   ; thats behind sending
         ; thats great :) here we find the complete line :) inside sending 17.03.2017 18:30 17-03-17_18-30
   ;   Msgbox, '%sending%' = sending  n (line:%A_LineNumber%) n
; Msgbox, '%AHKcode%' = AHKcode `n (line:%A_LineNumber%)



if(false){
    Clipboard = %AHKcode%
    msgbox, %AHKcode%
}

    ;msgbox, isAHKcode = %isAHKcode%AHKdyn example super simple example


   if( isAHKcode ){
   AHKcode2 := ""
AHKcode2 .= "#" . "NoTrayIcon `n "
AHKcode2 .= "#" "MaxHotkeysPerInterval 99000000 `n "
AHKcode2 .= "#" "HotkeyInterval 99000000 `n "
AHKcode2 .= "SetWorkingDir, " . A_ScriptDir . "`n" ; doesent work has no effect ScriptDir|rr||ahk|send, % A_ScriptDir ; \\.\pipe 03.04.2017 11:17 17-04-03_11-17
AHKcode2 .= "SetBatchLines, -1 `n "
AHKcode2 .= "SetKeyDelay, -1, -1 `n "
AHKcode2 .= "SetWinDelay, -1 `n "
AHKcode2 .= "SetControlDelay, -1 `n "
AHKcode2 .= "Process, Priority,, H `n "

;>>>>>>>> DynaRun >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
FileRead,dynaRunFunctionImplementationSource,dynaRunFunctionImplementationSource.inc.ahk
AHKcode2 .= dynaRunFunctionImplementationSource  . "`n"
;>>>>>>>>>> DynaRun >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


if(0){
AHKcode2 .= "wordlist = , " . wordlistNEW . "`n" ; i cant do this :D becouse the script cant know this :D 12.08.2017 11:12
Msgbox,% AHKcode2 . "`n`n = AHKcode2 `n (%A_LineFile%~%A_LineNumber%)"
}
; doesent work has no effect ScriptDir|rr||ahk|send, % A_ScriptDir ; \\.\pipe 03.04.2017 11:17 17-04-03_11-17
; AHKcode2 .= "d := """ . a_scriptDir . """`n"

startPos := 1
if( false && doSendSpacesInAHKslow )
while( RegExMatch( AHKcode , "mPi)(^[ ]*Send[ ]*,[ ]*)([^\n]+)" , m , startPos ) ) {
    m1 := SubStr(AHKcode, mPos1 ,  mLen1 )
    m2 := SubStr(AHKcode, mPos2 ,  mLen2 )
    m2 := RegExReplace(m2, "([a-z,.\(\)\[\]]) ([a-z,.\(\)\[\]])" , "$1`nSleep,1000`nSend,{space}$2")
    endString := SubStr(AHKcode, mPos2 + mLen2 )
    AHKcode := SubStr(AHKcode, 1 , mPos2 -1 ) . m2 . endString
    startPos := mPos1 + m - 1
}

if( RegExMatch( activeTitle , "\.(json|ts|css|html) - PhpStorm" ) && substr( g_SingleMatch[WordIndex], 1 , 2 ) != "__" ) {
    global g_Word ; thats the beginning of the word user already typed. 27.04.2017 18:52
    AHKcode := getRealisticDelayDynamicSendAHKcode(g_Word,AHKcode)
}

AHKcode := RegExReplace(AHKcode, "#include[ ]*,[ ]*(\w)"           , "#include " . A_ScriptDir . "\\$1" ) ; dayTimeHello|rr||ahk|#include,incDynAhk\sendDayTimeHello.ahk
AHKcode := RegExReplace(AHKcode, "#include[ ]*,[ ]*([\.]{1,2}\\\w)", "#include " . A_ScriptDir . "\\$1" ) ; dayTimeHello|rr||ahk|#include,..\xyz\sendDayTimeHello.ahk
; AHKcode := RegExReplace(AHKcode, "#include[ ]*,[ ]*(\w)", "#include \\$1" ) ; dayTimeHello|rr||ahk|#include,incDynAhk\sendDayTimeHello.ahk
; AHKcode := RegExReplace(AHKcode, "#include[ ]*,[ ]*[\.]{0,2}\\(\w)", "#include \\$1" ) ; dayTimeHello|rr||ahk|#include,incDynAhk\sendDayTimeHello.ahk
StringReplace, AHKcode, AHKcode, `%A_ScriptDir`%, %A_ScriptDir%, All
StringReplace, AHKcode, AHKcode, `%A_WorkingDir`%, %A_WorkingDir%, All ; in some context its not neccasarry becouse its set ... 12.08.2017 11:22
; A_ScriptDir == A_WorkingDir is proably the same !! should be in this case :) 12.08.2017 11:26

StringReplace, AHKcode, AHKcode, #incDynAhk, #include %A_ScriptDir%\incDynAhk, All ; dayTimeHello|rr||ahk|#incDynAhk\sendDayTimeHello.ahk

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; todo: howto insert  a newwline text sign into te output 19.04.2017 21:01 ? not solved :(
; msgbox, '%AHKcode%' = AHKcode  n (line:%A_LineNumber%) n
AHKcode2 .= RegExReplace(AHKcode, "([^``])``n", "$1`n") ; ; thats we really need. the only chance to get newline inside the source code
; msgbox, '%AHKcode2%' = AHKcode2  n (line:%A_LineNumber%) n
; abc abc n
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; AHKcode2  = RegExReplace(AHKcode2 , "%A_ScriptDir%", A_ScriptDir)
; clipboard := AHKcode2
; msgbox, % AHKcode2n

send,{blind}
       global g_sending_is_buggy
       if( g_sending_is_buggy )
           lll(A_LineNumber, "Sending.ahk", "send,{blind} `n 17-07-29_11-47")

        ;msgbox,(%A_LineFile%~%A_LineNumber%) `n %AHKcode2% 
       DynaRun(AHKcode2)
   }

   ClearAllVars(true)
   ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   ; the following code was addet by Http://SL5.net 11.03.2017 17:54 17-03-11_17-54 . have fin & enjoy
   sending:=trim( sending )
   if(RegExMatch( sending , "^[^\s]+(\\[^\\\s]+\\[^\\\s]+\.txt)$", SubPat) ) ; stores in SubPat1. 30.04.2017 12:24 is that buggy ? correct? todo:
        absWordListAddress := A_ScriptDir . "\..\" . sending
        ;Msgbox,%absWordListAddress% `n (from: %A_LineFile%~%A_LineNumber%)
        fExistWL := FileExist(absWordListAddress)
        fExist := FileExist(sending)
        ; InStr(FileExist("C:\My Folder"), "D") would be true only if the file exists and is a directory.
      if((fExist && InStr(FileExist(fExist), "D"))  || (fExistWL && InStr(FileExist(fExistWL), "D"))  ) {
         ;~ hint := "... " . SubStr( sending, 60 ) 
         Sleep,1000
         MsgBox, 4, Open library? (id=1703171452) , would you open your library file? (Press YES or NO) `n `n ... %SubPat1% ; this window will not closed by reloading couse of his idetify code (1703171452). See in source below. 17-03-17_15-00
    IfMsgBox yes
        if(fExist)
            run, %sending%
        else
             run, %absWordListAddress%

                 ;Msgbox,%absWordListAddress% `n (from: %A_LineFile%~%A_LineNumber%)

      }

;
   ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   enableCopyQ() ;
   Return
}  
;------------------------------------------------------------------------
            
SendFull(SendValue,ForceBackspace:= false)
{
   global g_Active_Id
   global g_Word
   global prefs_AutoSpace
   global prefs_NoBackSpace
   global prefs_SendMethod

   global g_doUseSendPlay

   SwitchOffListBoxIfActive()
   
   BackSpaceLen := StrLen(g_Word)
   
   if (ForceBackspace || prefs_NoBackspace = "Off") {
      BackSpaceWord := true
   }
    ;  BackSpaceWord := false ; test 27.04.2017 18:40

;<<<<< Capitalize := false 13.08.2017 14:05 17-08-13_14-05 sl5 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if("Capitalize := false")
    Capitalize := false
else {
   ; match case on first letter if we are forcing a backspace AND CaseCorrection is off
   if (ForceBackspace && !(prefs_NoBackspace = "Off")) {
      IfEqual, A_IsUnicode, 1
      {
         if ( RegExMatch(Substr(g_Word, 1, 1), "S)\p{Lu}") > 0 )  
         {
            Capitalize := true
         }
      } else if ( RegExMatch(Substr(g_Word, 1, 1), "S)[A-ZÀ-ÖØ-ß]") > 0 )
      {
         Capitalize := true
      }
}
;>>>>>>>>>>>>>>>>>>>>  Capitalize := false 13.08.2017 14:05 17-08-13_14-05 sl5  >>>>>>>>>>>>>>>>>>>>>>>>>>
      
      StringLeft, FirstLetter, SendValue, 1
         StringTrimLeft, SendValue, SendValue, 1
      if (Capitalize) {
         StringUpper, FirstLetter, FirstLetter
      } else {
         StringLower, FirstLetter, FirstLetter
      }
      SendValue := FirstLetter . SendValue
   }


   ; if the user chose a word with accented characters, then we need to
   ; substitute those letters into the word
   StringCaseSenseOld := A_StringCaseSense
   StringCaseSense, Locale   
   if (!BackSpaceWord && !(SubStr(SendValue, 1, BackSpaceLen) = g_Word)) {
      BackSpaceWord := true
      
      SendIndex := 1
      WordIndex := 1
      NewSendValue =
      While (WordIndex <= BackSpaceLen) {
         SendChar := SubStr(SendValue, SendIndex, 1)
         WordChar := SubStr(g_Word, WordIndex, 1)
         SendIndex++
         
         if (SendChar = WordChar) {
            WordIndex++
            NewSendValue .= WordChar
         } else {
            
            SendCharNorm := StrUnmark(SendChar)
            ; if character normalizes to more than 1 character, we need
            ; to increment the WordIndex pointer again
            
            StringUpper, SendCharNormUpper, SendCharNorm
            StringLower, SendCharNormLower, SendCharNorm
            StringUpper, SendCharUpper, SendChar
            StringLower, SendCharLower, SendChar
            WordChar := SubStr(g_Word, WordIndex, StrLen(SendCharNorm))
            
            if (SendCharNorm == WordChar) {
               NewSendValue .= SendChar
            } else if (SendCharNormUpper == WordChar) {
               NewSendValue .= SendCharUpper
            } else if (SendCharNormLower == WordChar) {
               NewSendValue .= SendCharLower
            } else {
               NewSendValue .= SendChar
            }
            WordIndex += StrLen(SendCharNorm)
         }
      }
      
      NewSendValue .= SubStr(SendValue, SendIndex, StrLen(SendValue) - SendIndex + 1)
      
      SendValue := NewSendValue
   }

   StringCaseSense, %StringCaseSenseOld%
   
   ; If we are not backspacing, remove the typed characters from the string to send
   if !(BackSpaceWord)
   {
      StringTrimLeft, SendValue, SendValue, %BackSpaceLen%
   }
   
   ; if autospace is on, add a space to the string to send
   IfEqual, prefs_AutoSpace, On
      SendValue .= A_Space

      ; thats great :) here we find the complete line :) inside sending 17.03.2017 18:30 17-03-17_18-30
;      Msgbox, '%SendValue%' = SendValue  (line:%A_LineNumber%)  (line:%A_LineNumber%)

 ; Msgbox, '%SendValue%' = SendValue  `n '%sending%' = sending `n (line:%A_LineNumber%) n


;~ global g_useRAWsending
;~ if(g_useRAWsending)
;~     Raw:="{Raw}"

   IfEqual, prefs_SendMethod, 1
   {
      ; Shift key hits are here to account for an occassional bug which misses the first keys in SendPlay
        if(g_doUseSendPlay)
          sending = {Shift Down}{Shift Up}{Shift Down}{Shift Up}
      if (BackSpaceWord)
      {
          if(g_doUseSendPlay)
             sending .= "{BS " . BackSpaceLen . "}"
         else
             Send,{Backspace %BackSpaceLen%} ; workaround :) 29.07.2017 12:51 17-07-29_12-51 by sl5net
      }
      if(!g_doUseSendPlay)
          sending .= SendValue
      else
          sending .= "{Raw}" . SendValue

if(!g_doUseSendPlay){
    SendRaw, %sending%
}else{
       SendPlay, %sending% ; First do the backspaces, Then send word (Raw because we want the string exactly as in wordlist . txt)
}

             global g_sending_is_buggy
             if( g_sending_is_buggy )
                 lll(A_LineNumber, "Sending.ahk", "SendPlay, %sending% `n >" . sending . "<  `n 17-07-29_11-48")

if(false && g_sending_is_buggy){
lll(A_LineNumber, "Sending.ahk", "let test sending with differenct methods `n SendValue =" . SendValue . " `n 17-07-29_12-23")
;
SendEvent, 1SendEvent = %sending% `n
SendInput, 2SendInput = %sending% `n
SendPlay, 3SendPlay = %sending% `n
SendRaw, 4SendRaw = %sending% `n
}

      Return
   }


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;
; reg1SendEvenfoundPos := RegExMatch( "str" , "i)" )
; 2SendInpufoundPos := RegExMatch( "str" , "i)" )
; 4SendRaw = {Shift Down}{Shift Up}{Shift Down}{Shift Up}{BS 4}{
;
;



;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



; ms17-03-18_16-13
; =line:224Msgbox, ```n  ``n `n  (line:%A_LineNumber%)`
; ms17-03-18_16-13
;

; Msgbox, '%SendValue%' = SendValue  `n '%sending%' = sending `n (line:%A_LineNumber%) n
; Clipboard := SendValue
; Msgbox, ```n  ``n `n  (line:%A_LineNumber%)

; Sleep,1000
global g_sending_is_buggy
if(fals && g_sending_is_buggy){
lll(A_LineNumber, "Sending.ahk", "let test sending with differenct methods `n SendValue =" . SendValue . " `n 29.07.2017 11:06 17-07-29_11-07")
;
SendEvent, 1SendEvent = %SendValue% `n
SendInput, 2SendInput = %SendValue% `n
SendPlay, 3SendPlay = %SendValue% `n
SendRaw, 4SendRaw = %SendValue% `n
}
; sleep,2000
; reload

; i typed regex :
; 1SendEvenewStr := RegExReplace("abc", "i)")
; 2SendInpnewStr := RegExReplace("abc", "i)")
; 4SendRaw = {Shift Down}{Shift Up}{Shift Down}{Shift Up}{}

   if (BackSpaceWord)
   {
      sending = {BS %BackSpaceLen%}{Raw}%SendValue%
   } Else {
      sending = {Raw}%SendValue%
   }

   IfEqual, prefs_SendMethod, 2
   {
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if(WinActive("PhpStorm", "", ".ahk") || WinActive("New File ahk_class SunAwtDialog") || WinActive("Rename ahk_class SunAwtDialog") )  {
; setKeyDelay, DelayMilliSec, PressDuration, Play ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
    ; SetKeyDelay, 95, 10 ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
    if(true){
        global g_Word ; thats the beginning of the word user alreaddy typed. 27.04.2017 18:52
        AHKcode := getRealisticDelayDynamicSendAHKcode(g_Word,SendValue)
global g_sending_is_buggy
if( g_sending_is_buggy )
    lll(A_LineNumber, "Sending.ahk", " send,{blind} ")
send,{blind}
               DynaRun(AHKcode)
               } else {
    SetKeyDelay, -1, -1 ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
    Send, %sending% ; it doesent work with SendInput in slow motion  04.04.2017 21:50 17-04-04_21-50

global g_sending_is_buggy
if( g_sending_is_buggy )
    lll(A_LineNumber, "Sending.ahk", " Send, %sending% `n >" . sending . "<  `n 17-07-29_11-38")

    }
   Return
}

;

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

      SendInput, %sending% ; First do the backspaces, Then send word (Raw because we want the string exactly as in wordlist . txt)
 ;Msgbox, '%SendValue%' = SendValue  `n `n '%sending%' = sending `n (line:%A_LineNumber%) n

 global g_sending_is_buggy
 if( g_sending_is_buggy )
     lll(A_LineNumber, "Sending.ahk", "SendInput, %sending% `n >" . sending . "<  `n 17-07-29_11-42")

      Return
   }

   IfEqual, prefs_SendMethod, 3
   {
   global g_sending_is_buggy
   if( g_sending_is_buggy )
       lll(A_LineNumber, "Sending.ahk", " SendEvent, %sending% ")

      SendEvent, %sending% ; First do the backspaces, Then send word (Raw because we want the string exactly as in wordlist . txt)
 ;Msgbox, '%SendValue%' = SendValue  `n `n '%sending%' = sending `n (line:%A_LineNumber%) n
      Return
   }
 ;Msgbox, '%SendValue%' = SendValue  `n `n '%sending%' = sending `n (line:%A_LineNumber%) n
;
   ClipboardSave := ClipboardAll
   Clipboard = 
   Clipboard := SendValue
   ClipWait, 0
   
   if (BackSpaceWord)
   {
      sending = {BS %BackSpaceLen%}{Ctrl Down}v{Ctrl Up}
   } else {
   sending = {Ctrl Down}v{Ctrl Up}
   }

   IfEqual, prefs_SendMethod, 1C
   {
      sending := "{Shift Down}{Shift Up}{Shift Down}{Shift Up}" . sending
      SendPlay, %sending% ; First do the backspaces, Then send word via clipboard
      global g_sending_is_buggy
      if( g_sending_is_buggy )
          lll(A_LineNumber, "Sending.ahk", "SendPlay, %sending% `n >" . sending . "<  `n 17-07-29_11-41")

   } else IfEqual, prefs_SendMethod, 2C
   {
      SendInput, %sending% ; First do the backspaces, Then send word via clipboard
 global g_sending_is_buggy
 if( g_sending_is_buggy )
     lll(A_LineNumber, "Sending.ahk", "SendInput, %sending% `n >" . sending . "<  `n 17-07-29_11-43")

   } else IfEqual, prefs_SendMethod, 3C
   {
      SendEvent, %sending% ; First do the backspaces, Then send word via clipboard
       global g_sending_is_buggy
       if( g_sending_is_buggy )
           lll(A_LineNumber, "Sending.ahk", "SendEvent, %sending% `n >" . sending . "<  `n 17-07-29_11-44")

   } else {
      ControlGetFocus, ActiveControl, ahk_id %g_Active_Id%
      IfNotEqual, ActiveControl,
         ControlSend, %ActiveControl%, %sending%, ahk_id %g_Active_Id%
   }
         
   Clipboard := ClipboardSave
   Return
}

;------------------------------------------------------------------------
SendCompatible(SendValue,ForceSendForInput) {

    lll(A_LineNumber, "Sending.ahk", "SendCompatible(SendValue,ForceSendForInput) `n SendValue =" . SendValue . " `n 17-07-16_15-01")

   global g_IgnoreSend
   global prefs_SendMethod
   ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
       SetKeyDelay, 200, 20, Play ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
       Send, %SendValue%

        global g_sending_is_buggy
        if( g_sending_is_buggy )
            lll(A_LineNumber, "Sending.ahk", " Send, %SendValue% `n Send, %" . SendValue . "% `n 17-07-29_12-10")
; regeregregreg
      Return
      ; GetKeyState, LshiftState, Lshift, P; 96+ lines in autocopy.ahk
   ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

   IfEqual, ForceSendForInput, 1
   {
      g_IgnoreSend = 
      SendEvent, %SendValue%

       global g_sending_is_buggy
       if( g_sending_is_buggy )
           lll(A_LineNumber, "Sending.ahk", "SendEvent, %SendValue% `n >" . SendValue . "<  `n 17-07-29_11-45")


      Return
   }
   
   SendMethodLocal := SubStr(prefs_SendMethod, 1, 1)
   IF ( ( SendMethodLocal = 1 ) || ( SendMethodLocal = 2 ) )
   {
      SendInput, %SendValue%

       global g_sending_is_buggy
       if( g_sending_is_buggy )
           lll(A_LineNumber, "Sending.ahk", "SendInput, %SendValue% `n >" . SendValue . "<  `n 17-07-29_11-46")

      Return
   }

   IF ( ( SendMethodLocal = 3 ) || ( SendMethodLocal = 4 ) )
   {
      g_IgnoreSend = 1
      SendEvent, %SendValue%
             global g_sending_is_buggy
             if( g_sending_is_buggy )
                 lll(A_LineNumber, "Sending.ahk", "SendInput, %SendValue% `n >" . SendValue . "<  `n 17-07-29_11-46")

      Return
   }

   ; reg
   
   SendInput, %SendValue%
             global g_sending_is_buggy
             if( g_sending_is_buggy )
                 lll(A_LineNumber, "Sending.ahk", "SendInput, %SendValue% `n >" . SendValue . "<  `n 17-07-29_11-46")

   Return
}

;------------------------------------------------------------------------



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

getTypicalKeyLatency( key, factor = 1 ) {
; recordet at 10.04.2017 17:45 from sl5net
time2keyPressLog := {}
time2keyPressLog[" ,"] := 390
time2keyPressLog[" a"] := 109
time2keyPressLog[" b"] := 109
time2keyPressLog[" c"] := 249
time2keyPressLog[" d"] := 109
time2keyPressLog[" e"] := 110
time2keyPressLog[" F"] := 219
time2keyPressLog[" g"] := 156
time2keyPressLog[" h"] := 188
time2keyPressLog[" i"] := 172
time2keyPressLog[" J"] := 343
time2keyPressLog[" k"] := 203
time2keyPressLog[" l"] := 140
time2keyPressLog[" m"] := 109
time2keyPressLog[" n"] := 124
time2keyPressLog[" o"] := 140
time2keyPressLog[" p"] := 296
time2keyPressLog[" s"] := 140
time2keyPressLog[" t"] := 203
time2keyPressLog[" u"] := 140
time2keyPressLog[" v"] := 203
time2keyPressLog[" w"] := 125
time2keyPressLog[" y"] := 203
time2keyPressLog[" z"] := 219
time2keyPressLog[" ä"] := 312
time2keyPressLog["''"] := 203
time2keyPressLog[", "] := 109
time2keyPressLog["-A"] := 344
time2keyPressLog["-F"] := 312
time2keyPressLog["-L"] := 344
time2keyPressLog["-S"] := 359
time2keyPressLog[". "] := 109
time2keyPressLog[".h"] := 374
time2keyPressLog["01"] := 187
time2keyPressLog["15"] := 78
time2keyPressLog["2 "] := 390
time2keyPressLog["20"] := 187
time2keyPressLog["45"] := 109
time2keyPressLog[": "] := 234
time2keyPressLog["<m"] := 312
time2keyPressLog["> "] := 390
time2keyPressLog["? "] := 218
time2keyPressLog["a "] := 141
time2keyPressLog["ab"] := 156
time2keyPressLog["ad"] := 218
time2keyPressLog["ag"] := 125
time2keyPressLog["am"] := 156
time2keyPressLog["an"] := 140
time2keyPressLog["ap"] := 234
time2keyPressLog["ar"] := 125
time2keyPressLog["as"] := 265
time2keyPressLog["at"] := 124
time2keyPressLog["ay"] := 219
time2keyPressLog["be"] := 187
time2keyPressLog["bj"] := 249
time2keyPressLog["cl"] := 219
time2keyPressLog["co"] := 109
time2keyPressLog["cr"] := 203
time2keyPressLog["ct"] := 203
time2keyPressLog["cu"] := 249
time2keyPressLog["d "] := 171
time2keyPressLog["da"] := 141
time2keyPressLog["de"] := 156
time2keyPressLog["di"] := 219
time2keyPressLog["e "] := 109
time2keyPressLog["ea"] := 141
time2keyPressLog["ec"] := 187
time2keyPressLog["ee"] := 390
time2keyPressLog["eg"] := 203
time2keyPressLog["ei"] := 109
time2keyPressLog["el"] := 125
time2keyPressLog["em"] := 125
time2keyPressLog["en"] := 109
time2keyPressLog["er"] := 31
time2keyPressLog["es"] := 125
time2keyPressLog["et"] := 188
time2keyPressLog["ev"] := 359
time2keyPressLog["ex"] := 219
time2keyPressLog["fr"] := 187
time2keyPressLog["fu"] := 140
time2keyPressLog["g "] := 203
time2keyPressLog["ge"] := 172
time2keyPressLog["gh"] := 171
time2keyPressLog["gi"] := 109
time2keyPressLog["gu"] := 141
time2keyPressLog["h "] := 125
time2keyPressLog["ha"] := 125
time2keyPressLog["he"] := 125
time2keyPressLog["hi"] := 109
time2keyPressLog["ho"] := 140
time2keyPressLog["ht"] := 187
time2keyPressLog["i "] := 141
time2keyPressLog["ib"] := 234
time2keyPressLog["id"] := 203
time2keyPressLog["ie"] := 203
time2keyPressLog["im"] := 343
time2keyPressLog["in"] := 109
time2keyPressLog["is"] := 109
time2keyPressLog["it"] := 187
time2keyPressLog["je"] := 125
time2keyPressLog["k "] := 249
time2keyPressLog["ke"] := 109
time2keyPressLog["la"] := 109
time2keyPressLog["ld"] := 94
time2keyPressLog["le"] := 109
time2keyPressLog["ll"] := 156
time2keyPressLog["lo"] := 202
time2keyPressLog["ls"] := 109
time2keyPressLog["m "] := 78
time2keyPressLog["ma"] := 203
time2keyPressLog["me"] := 140
time2keyPressLog["ml"] := 109
time2keyPressLog["mp"] := 187
time2keyPressLog["my"] := 250
time2keyPressLog["n "] := 109
time2keyPressLog["na"] := 141
time2keyPressLog["nc"] := 203
time2keyPressLog["nd"] := 110
time2keyPressLog["ne"] := 140
time2keyPressLog["ng"] := 109
time2keyPressLog["ns"] := 124
time2keyPressLog["nt"] := 109
time2keyPressLog["o "] := 125
time2keyPressLog["ob"] := 187
time2keyPressLog["oe"] := 141
time2keyPressLog["og"] := 156
time2keyPressLog["ol"] := 218
time2keyPressLog["om"] := 124
time2keyPressLog["on"] := 156
time2keyPressLog["op"] := 390
time2keyPressLog["or"] := 109
time2keyPressLog["ou"] := 78
time2keyPressLog["ow"] := 125
time2keyPressLog["p "] := 218
time2keyPressLog["pe"] := 172
time2keyPressLog["pl"] := 188
time2keyPressLog["po"] := 140
time2keyPressLog["pp"] := 141
time2keyPressLog["pr"] := 140
time2keyPressLog["r "] := 140
time2keyPressLog["r."] := 234
time2keyPressLog["ra"] := 171
time2keyPressLog["re"] := 125
time2keyPressLog["ri"] := 156
time2keyPressLog["rk"] := 141
time2keyPressLog["ro"] := 140
time2keyPressLog["rs"] := 202
time2keyPressLog["rt"] := 156
time2keyPressLog["ry"] := 203
time2keyPressLog["s "] := 156
time2keyPressLog["se"] := 156
time2keyPressLog["si"] := 109
time2keyPressLog["sp"] := 359
time2keyPressLog["ss"] := 156
time2keyPressLog["st"] := 172
time2keyPressLog["sy"] := 172
time2keyPressLog["t "] := 109
time2keyPressLog["ta"] := 156
time2keyPressLog["te"] := 109
time2keyPressLog["th"] := 125
time2keyPressLog["ti"] := 47
time2keyPressLog["tm"] := 125
time2keyPressLog["to"] := 109
time2keyPressLog["ts"] := 172
time2keyPressLog["ul"] := 203
time2keyPressLog["un"] := 187
time2keyPressLog["ur"] := 125
time2keyPressLog["us"] := 156
time2keyPressLog["ve"] := 202
time2keyPressLog["w "] := 156
time2keyPressLog["wh"] := 109
time2keyPressLog["wi"] := 125
time2keyPressLog["wo"] := 172
time2keyPressLog["x."] := 234
time2keyPressLog["xp"] := 281
time2keyPressLog["y "] := 187
time2keyPressLog["ye"] := 202
time2keyPressLog["yo"] := 172
time2keyPressLog["ac"] := 156
time2keyPressLog["ag"] := 141
time2keyPressLog["al"] := 109
time2keyPressLog["am"] := 124
time2keyPressLog["an"] := 109
time2keyPressLog["Ap"] := 312
time2keyPressLog["ar"] := 172
time2keyPressLog["as"] := 187
time2keyPressLog["at"] := 156
time2keyPressLog["au"] := 109
time2keyPressLog["av"] := 203
time2keyPressLog["ba"] := 140
time2keyPressLog["bb"] := 187
time2keyPressLog["be"] := 156
time2keyPressLog["bi"] := 343
time2keyPressLog["bl"] := 141
time2keyPressLog["bt"] := 188
time2keyPressLog["Bu"] := 156
time2keyPressLog["c "] := 281
time2keyPressLog["ce"] := 171
time2keyPressLog["ch"] := 109
time2keyPressLog["ck"] := 140
time2keyPressLog["Co"] := 249
time2keyPressLog["cr"] := 188
time2keyPressLog["CS"] := 296
time2keyPressLog["d "] := 156
time2keyPressLog["da"] := 109
time2keyPressLog["de"] := 125
time2keyPressLog["Di"] := 140
time2keyPressLog["dl"] := 78
time2keyPressLog["dn"] := 140
time2keyPressLog["du"] := 109
time2keyPressLog["e "] := 109
time2keyPressLog["e-"] := 327
time2keyPressLog["e."] := 140
time2keyPressLog["ea"] := 171
time2keyPressLog["eb"] := 203
time2keyPressLog["ec"] := 218
time2keyPressLog["ed"] := 172
time2keyPressLog["eg"] := 124
time2keyPressLog["eh"] := 125
time2keyPressLog["ei"] := 109
time2keyPressLog["ek"] := 156
time2keyPressLog["el"] := 109
time2keyPressLog["em"] := 109
time2keyPressLog["en"] := 109
time2keyPressLog["ep"] := 125
time2keyPressLog["er"] := 16
time2keyPressLog["es"] := 140
time2keyPressLog["et"] := 125
time2keyPressLog["eu"] := 109
time2keyPressLog["ew"] := 328
time2keyPressLog["ez"] := 296
time2keyPressLog["f "] := 109
time2keyPressLog["f."] := 296
time2keyPressLog["fe"] := 140
time2keyPressLog["Fl"] := 156
time2keyPressLog["fo"] := 125
time2keyPressLog["fr"] := 156
time2keyPressLog["ft"] := 202
time2keyPressLog["g "] := 109
time2keyPressLog["ge"] := 109
time2keyPressLog["gi"] := 124
time2keyPressLog["gl"] := 125
time2keyPressLog["Go"] := 172
time2keyPressLog["gr"] := 156
time2keyPressLog["gs"] := 250
time2keyPressLog["gt"] := 156
time2keyPressLog["gu"] := 109
time2keyPressLog["h "] := 47
time2keyPressLog["ha"] := 93
time2keyPressLog["hb"] := 328
time2keyPressLog["he"] := 109
time2keyPressLog["hi"] := 78
time2keyPressLog["hk"] := 219
time2keyPressLog["hm"] := 203
time2keyPressLog["hn"] := 156
time2keyPressLog["ho"] := 93
time2keyPressLog["hr"] := 234
time2keyPressLog["ht"] := 109
time2keyPressLog["hä"] := 109
time2keyPressLog["ia"] := 281
time2keyPressLog["ib"] := 78
time2keyPressLog["ic"] := 109
time2keyPressLog["id"] := 156
time2keyPressLog["ie"] := 109
time2keyPressLog["if"] := 156
time2keyPressLog["ig"] := 156
time2keyPressLog["il"] := 172
time2keyPressLog["Im"] := 187
time2keyPressLog["in"] := 109
time2keyPressLog["io"] := 62
time2keyPressLog["ip"] := 78
time2keyPressLog["is"] := 140
time2keyPressLog["it"] := 125
time2keyPressLog["iw"] := 250
time2keyPressLog["Ja"] := 187
time2keyPressLog["JS"] := 390
time2keyPressLog["k "] := 172
time2keyPressLog["ka"] := 140
time2keyPressLog["ke"] := 109
time2keyPressLog["kl"] := 172
time2keyPressLog["Ko"] := 125
time2keyPressLog["ks"] := 187
time2keyPressLog["kt"] := 94
time2keyPressLog["l "] := 156
time2keyPressLog["la"] := 109
time2keyPressLog["lc"] := 109
time2keyPressLog["ld"] := 187
time2keyPressLog["le"] := 109
time2keyPressLog["li"] := 109
time2keyPressLog["ll"] := 156
time2keyPressLog["ln"] := 109
time2keyPressLog["lo"] := 203
time2keyPressLog["lt"] := 109
time2keyPressLog["lu"] := 171
time2keyPressLog["lä"] := 156
time2keyPressLog["Lö"] := 187
time2keyPressLog["lü"] := 234
time2keyPressLog["m "] := 125
time2keyPressLog["m-"] := 296
time2keyPressLog["ma"] := 109
time2keyPressLog["mb"] := 172
time2keyPressLog["me"] := 125
time2keyPressLog["mf"] := 203
time2keyPressLog["mi"] := 171
time2keyPressLog["mm"] := 171
time2keyPressLog["mo"] := 125
time2keyPressLog["mp"] := 312
time2keyPressLog["ms"] := 156
time2keyPressLog["mt"] := 109
time2keyPressLog["mu"] := 359
time2keyPressLog["n "] := 109
time2keyPressLog["n,"] := 219
time2keyPressLog["na"] := 140
time2keyPressLog["nb"] := 249
time2keyPressLog["nd"] := 109
time2keyPressLog["ne"] := 109
time2keyPressLog["ng"] := 110
time2keyPressLog["Ni"] := 109
time2keyPressLog["nk"] := 94
time2keyPressLog["nn"] := 141
time2keyPressLog["no"] := 109
time2keyPressLog["ns"] := 109
time2keyPressLog["nt"] := 109
time2keyPressLog["nu"] := 172
time2keyPressLog["nw"] := 187
time2keyPressLog["nz"] := 312
time2keyPressLog["o "] := 125
time2keyPressLog["oc"] := 140
time2keyPressLog["od"] := 110
time2keyPressLog["oe"] := 109
time2keyPressLog["og"] := 125
time2keyPressLog["oh"] := 312
time2keyPressLog["ol"] := 172
time2keyPressLog["om"] := 141
time2keyPressLog["on"] := 109
time2keyPressLog["oo"] := 187
time2keyPressLog["op"] := 281
time2keyPressLog["or"] := 109
time2keyPressLog["os"] := 358
time2keyPressLog["ot"] := 171
time2keyPressLog["ou"] := 62
time2keyPressLog["p "] := 187
time2keyPressLog["PA"] := 156
time2keyPressLog["ph"] := 203
time2keyPressLog["pl"] := 203
time2keyPressLog["po"] := 219
time2keyPressLog["pp"] := 156
time2keyPressLog["Pr"] := 219
time2keyPressLog["pt"] := 140
time2keyPressLog["pu"] := 218
time2keyPressLog["r "] := 109
time2keyPressLog["r,"] := 250
time2keyPressLog["ra"] := 110
time2keyPressLog["rc"] := 203
time2keyPressLog["rd"] := 109
time2keyPressLog["re"] := 109
time2keyPressLog["rf"] := 203
time2keyPressLog["rg"] := 187
time2keyPressLog["ri"] := 109
time2keyPressLog["rk"] := 156
time2keyPressLog["rl"] := 140
time2keyPressLog["rm"] := 187
time2keyPressLog["rn"] := 156
time2keyPressLog["ro"] := 172
time2keyPressLog["rr"] := 219
time2keyPressLog["rs"] := 124
time2keyPressLog["rt"] := 172
time2keyPressLog["ru"] := 187
time2keyPressLog["rv"] := 249
time2keyPressLog["rz"] := 202
time2keyPressLog["s "] := 109
time2keyPressLog["s-"] := 156
time2keyPressLog["sa"] := 156
time2keyPressLog["sc"] := 141
time2keyPressLog["sd"] := 390
time2keyPressLog["se"] := 109
time2keyPressLog["si"] := 109
time2keyPressLog["so"] := 109
time2keyPressLog["sp"] := 203
time2keyPressLog["ss"] := 141
time2keyPressLog["st"] := 109
time2keyPressLog["su"] := 140
time2keyPressLog["t "] := 109
time2keyPressLog["t,"] := 171
time2keyPressLog["t-"] := 297
time2keyPressLog["t."] := 124
time2keyPressLog["ta"] := 141
time2keyPressLog["te"] := 109
time2keyPressLog["tf"] := 234
time2keyPressLog["ti"] := 250
time2keyPressLog["tl"] := 125
time2keyPressLog["tm"] := 140
time2keyPressLog["tr"] := 156
time2keyPressLog["ts"] := 125
time2keyPressLog["tt"] := 124
time2keyPressLog["Tu"] := 187
time2keyPressLog["tw"] := 125
time2keyPressLog["ty"] := 218
time2keyPressLog["tz"] := 47
time2keyPressLog["tä"] := 140
time2keyPressLog["u "] := 125
time2keyPressLog["uc"] := 109
time2keyPressLog["ue"] := 93
time2keyPressLog["uf"] := 203
time2keyPressLog["ug"] := 140
time2keyPressLog["ui"] := 359
time2keyPressLog["uk"] := 390
time2keyPressLog["ul"] := 187
time2keyPressLog["Um"] := 171
time2keyPressLog["un"] := 171
time2keyPressLog["ur"] := 109
time2keyPressLog["us"] := 124
time2keyPressLog["ut"] := 109
time2keyPressLog["va"] := 171
time2keyPressLog["Ve"] := 172
time2keyPressLog["vi"] := 109
time2keyPressLog["vo"] := 109
time2keyPressLog["We"] := 125
time2keyPressLog["wi"] := 109
time2keyPressLog["wo"] := 125
time2keyPressLog["xi"] := 250
time2keyPressLog["ys"] := 234
time2keyPressLog["ze"] := 109
time2keyPressLog["zm"] := 359
time2keyPressLog["Zu"] := 140
time2keyPressLog["zw"] := 187
time2keyPressLog["ß "] := 343
time2keyPressLog["ße"] := 375
time2keyPressLog["äf"] := 141
time2keyPressLog["än"] := 172
time2keyPressLog["är"] := 203
time2keyPressLog["äs"] := 187
time2keyPressLog["ät"] := 110
time2keyPressLog["ös"] := 156
time2keyPressLog["üc"] := 219
if( time2keyPressLog[key] )
  r :=  time2keyPressLog[key]
Else {
  key := SubStr(key,2 , 1) . SubStr(key,1,1)
  r := time2keyPressLog[key]
  ;Msgbox,%key% --- %temp%`n (from: %A_LineFile%~%A_LineNumber%)
  if( RegExMatch(temp,"^d+$"))
        r :=  temp
    else
        r := 300
 }
 r := round( r * factor )

 return r
}

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
convertSendCode2SendPlayCode(AHKcode){
   AHKcode1 := AHKcode
; thats pseudo sendPlay . alternative ; However, SendPlay may have no effect at all on Windows Vista or later if User Account Control is enabled, even if the script is running as an administrator. mySendPlay
    StringReplace, AHKcode, AHKcode, ! , {!}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, # , {#}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, + , {+}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, ^ , {^}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, { , {{}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, } , {}}
        return AHKcode
}
getRealisticDelayDynamicSendAHKcode(g_Word,AHKcode){
 ; g_Word thats the already correct typied letters.
 ; AHKcode thats the letters we type next her in this function 30.04.2017 08:32

 ; if(false){
    ; todo: works relly fine. do the rest please 10.04.2017 18:34
 startPos := 1
 ; while( RegExMatch( AHKcode , "P)([\w ])([\w ])" , m , startPos ) ) { ; used till 10.04.2017 20:31 works

 ; quick and dirty repair: kind of encodeing. lets decode later.
  StringReplace, AHKcode , AHKcode ,``,´,, All ; its only for prevent errors. 27.04.2017 15:55 for eg if you want write ... thats working. it better then noting :) ... its not correct bad not so a big false. you could correct it manually easily
  ;~ StringReplace, AHKcode , AHKcode , ``, ´ ,, All ; its only for prevent errors. 27.04.2017 15:55 for eg if you want write ... thats working. it better then noting :) ... its not correct bad not so a big false. you could correct it manually easily
     ;~ StringReplace, AHKcode , AHKcode , ``, ````,, All ; its only for prevent errors. 27.04.2017 15:55 for eg if you want write
 ;~ tooltip,'%AHKcode%' = AHKcode  n (line:%A_LineNumber%) n
 ;~ sleep,2000


; lets ignore to send the first letters
BackSpaceLen := StrLen(g_Word)
  ;  msgbox,'%BackSpaceLen%' = BackSpaceLen   = '%g_Word%' = g_Word `n (%A_LineFile%~%A_LineNumber%)
AHKcode := substr(AHKcode, BackSpaceLen + 1)
isDoubleQuoteDeletedByBackspace := false
while( RegExMatch( AHKcode , "P)([^\n])([^\n])" , m , startPos ) ) {
    m1 := SubStr(AHKcode, mPos1 ,  mLen1 )
    m2 := SubStr(AHKcode, mPos2 ,  mLen2 )


    ; StringReplace, I_ThisCmd, I_ThisCmd, #, {#}  ; Replace leading #, if any.


    key := m1 . m2
    factor := 0.5
    factor := 0.9
    ; factor := 0.4
    ; factor := 10
    ; SendPlay may have no effect at all on Windows Vista or later if User Account Control is enabled, even if the script is running as an administrator. 10.04.2017 18:24
;~     if(m1 == "``")
;~         sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,#####"
;~     if(m2 == "``")
;~         sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,#####"
  ;  if(m2 == ";" || m2 == "`;"){
  ;      sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,###"
  ;      m2 := "uio"
  ;      }
    if(m2 == """" && !isDoubleQuoteDeletedByBackspace){ ; jetbrains often send outomatically the closing double quote. di dont like that this time. 28.04.2017 17:19
        sleepMili := "`n SendInput,{Backspace}"
        isDoubleQuoteDeletedByBackspace := true
        }
        ;~ sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,{Backspace}"
    else
        sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,"

; msgbox, % convertSendCode2SendPlayCode(convertSendCode2SendPlayCode("%"))
if(true){
    m1 := convertSendCode2SendPlayCode(m1)
    ;m1 := "E1"
    if(false){
    if(m1 == "``;"){
        ; m1 := "```;" ; for eg CLIMBERS;
        ; m1 := "; " ; for eg CLIMBERS;
        m1 := "x2" ; for eg CLIMBERS;
    }
    if(m1 == "````;"){
        ; m1 := "```;" ; for eg CLIMBERS;
        ; m1 := "; " ; for eg CLIMBERS;
        m1 := "x4" ; for eg CLIMBERS;
    }
    if(m1 == "```;"){
        ; m1 := "```;" ; for eg CLIMBERS;
        ; m1 := "; " ; for eg CLIMBERS;
        m1 := "x3" ; for eg CLIMBERS;
    }
    if(m1 == ";"){
        ; m1 := "```;" ; for eg CLIMBERS;
        ; m1 := "; " ; for eg CLIMBERS;
        m1 := "x0" ; for eg CLIMBERS;
    }
    if(m1 == "`;"){
        ; m1 := "```;" ; for eg CLIMBERS;
        m1 := "; " ; for eg CLIMBERS;
        m1 := "x3" ; for eg CLIMBERS;
    }}
    if(m1 = " "){
        m1 := "{space}" ; that seems importend. for e.g. hiere: climbers = CLIMBERS;
    }
;    tooltip,'%m1%'=m1 (%A_LineFile%~%A_LineNumber%)
    ; m2 := convertSendCode2SendPlayCode(m2)
}
    AHKcodePre := SubStr(AHKcode, 1 , mPos1 + mLen1 -2 ) . m1
    AHKcodeEnd := SubStr(AHKcode, mPos2 )
    AHKcode := AHKcodePre . sleepMili . AHKcodeEnd
    ; startPos := startPos + m - 1
    startPos := mPos1 + strlen(m1) + strlen(sleepMili)
  ; tooltip, % strlen(AHKcode) . ": "  . AHKcode
  }
  if(isDoubleQuoteDeletedByBackspace)
    AHKcode .= "`n SendInput,{del}" ; delete the last double quote moved by jetbrains around 28.04.2017 17:29

AHKcode := "`nSend," . AHKcode
; msgbox, % AHKcode
;AHKcode  := AHKcodeNEW

; getTypicalKeyLatency( key )

; Msgbox, AHKcode = %AHKcode%
;AHKcode := RegExReplace(AHKcode, "\{Sleep\s{0,5}(\d+)\}" , "`n Sleep, $1 `n Send,")
; AHKcode

; deencodeing. the space becouse they key is wainting without using key. thats quick and dirty and good working workaround. 27.04.2017 18:22:
 StringReplace, AHKcode , AHKcode ,´,````{SPACE},, All
; Msgbox,'%AHKcode%' = AHKcode  `n (%A_LineFile%~%A_LineNumber%)
return AHKcode
}
 ; StringReplace, AHKcode , AHKcode ,;,````;,, All ; maybe this is not problem. may comment it oust
;AHKcode .= " `; TESSST 17-04-28_00-03"
;clipboard := AHKcode
 ; (literal semicolon). Note: This is necessary only if a semicolon has a space or tab to its left. If it does not, it will be recognized correctly without being escaped.
; AHKcode := RegExReplace(AHKcode, "`;", "X")


getCorrectedStringUAOSS( sending  ) {

sending := RegExReplace( sending , "i)Ã¼", Chr(252) ) ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "Ãœ", Chr(220) ) ; UE http://slayeroffice.com/tools/ascii/ Ãœbrigens
sending := RegExReplace( sending , "ueber", "" . Chr(252) .  "ber" ) ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bfÃ¼r\b","f" . Chr(252) . "r") ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bgrÃ¼nd","gr" . Chr(252) . "nd") ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bmuendl.\b","m" . Chr(252) . "uendl.") ; ue http://slayeroffice.com/tools/ascii/

sending := RegExReplace( sending , "Ã¶", Chr(246) ) ; oe zB hÃ¶ren http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "oe", Chr(246) ) ; oe zB hÃ¶ren http://slayeroffice.com/tools/ascii/

sending := RegExReplace( sending , "Ã¼", Chr(252) ) ; ue http://slayeroffice.com/tools/ascii/


; weiÃŸ
sending := RegExReplace( sending , "ÃŸ","" . Chr(223) . "") ; ss http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bgroÃŸ","gro" . Chr(223) . "") ; ss http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)lieÃŸlich\b","lie" . Chr(223) . "lich") ; scharfess http://slayeroffice.com/tools/ascii/ ausschlieÃŸlich
; sending := RegExReplace( sending , "i)ss", Chr(223) ) ; scharfess http://slayeroffice.com/tools/ascii/ Ausnahmen professionell

sending := RegExReplace( sending , "i)Ã¤", Chr(228) ) ; ae http://slayeroffice.com/tools/ascii/ ausschlieÃŸlich
sending := RegExReplace( sending , "Ã„", "" . Chr(196) . "" ) ; AE http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "u.Ã„.", "u." . Chr(196) . "." ) ; AE http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)beschÃ¤ftigte","besch" . Chr(228) . "ftigte ") ; ae http://slayeroffice.com/tools/ascii/ ausschlieÃŸlich
sending := RegExReplace( sending , "i)AuftrÃ¤ge","Auftr" . Chr(228) . "ge") ; ae http://slayeroffice.com/tools/ascii/ ausschlieÃŸlich

foundPos := RegExMatch( sending , "i)Ã" )
if(foundPos){
    msgbox,17-05-23_17-09 :( '%sending%' = sending  (line:%A_LineNumber%)
}
foundPos := RegExMatch( sending , "Ã¼" )
if(foundPos){
    msgbox,18-03-01_15-49 :( '%sending%' = sending  (line:%A_LineNumber%)
}


return sending  
}









;==================================================

;e.g. vText := JEE_StrUtf8BytesToText(vUtf8Bytes)

JEE_StrUtf8BytesToText(ByRef vUtf8Bytes)
{
	if A_IsUnicode
	{
		VarSetCapacity(vTemp, StrPut(vUtf8Bytes, "CP0"))
		StrPut(vUtf8Bytes, &vTemp, "CP0")
		return StrGet(&vTemp, "UTF-8")
	}
	else
		return StrGet(&vUtf8Bytes, "UTF-8")
}

;==================================================

;e.g. vUtf8Bytes := JEE_StrTextToUtf8Bytes(vText)

JEE_StrTextToUtf8Bytes(ByRef vText)
{
	VarSetCapacity(vTemp, StrPut(vText, "UTF-8"))
	StrPut(vText, &vTemp, "UTF-8")
	return StrGet(&vTemp, "CP0")
}

;==================================================