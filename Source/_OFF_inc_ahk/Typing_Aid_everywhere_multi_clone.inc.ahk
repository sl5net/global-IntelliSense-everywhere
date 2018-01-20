restoreOldClipboard(idBackup, ClipboardBackup) {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   MsgBox, 17-03-10_08-06
   ; by restoring we cant us a token or id becouse we dont know what the real value of clipboard was. 07.03.2017 08:08
   l := StrLen(idBackup)
   i:=0
   iMax:=99
   while(i++ < iMax )
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

         result:=SubStr(ClipboardBackup,l+1)
         Clipboard := result
         if(Clipboard <> ClipboardBackup)
            break
         ToolTip, '%Clipboard%' = Clipboard  `n '%result%' = result  `n  '%idBackup%' = idBackup  `n '%ClipboardBackup%' = ClipboardBackup  `n (line:%A_LineNumber%) `n 
         Sleep,5
   }
   if(i == iMax )
      MsgBox, :( '%iMax%' = '%iMax%' = iMax  `n (line:%A_LineNumber%) `n 
      Sleep, 3000 ; the time of the clipboard could get its real clipboard content. shorter maxes mor performant longer less errors 07.03.2017 09:39
   ;      MsgBox, '%Clipboard%' = Clipboard  `n (line:%A_LineNumber%) `n  
         return
}
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


wordlistOLDbackup( wordlistDir , wordlistOLD){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   FileCopy, % wordlistDir . "\" . wordlistOLD , % wordlistDir . "\" . wordlistOLD . ".backup.txt", 1
   return 1
} 

wordlistNEWactivate( wordlistDir , wordlistNEW, wordlistActive, typingAidSourcePath){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   wordlistNEWarchivePath = % wordlistDir . "\" . wordlistNEW
   wordlistActivePath := typingAidSourcePath .  "\" . wordlistActive 
   if(!FileExist(wordlistActivePath))
      MsgBox, :( '%wordlistActivePath%' = wordlistActivePath  `n (line:%A_LineNumber%) `n 18-01-20_17-10
   
   if(!FileExist(wordlistNEWarchivePath)) {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

            WinGetActiveTitle,at
strLen_wordlistNEWar := StrLen(wordlistNEWarchivePath)
if(strLen_wordlistNEWar < 5)
   MsgBox, :-( '%strLen_wordlistNEWar%' = strLen_wordlistNEWar  `n (line:%A_LineNumber%) `n 
if(strLen_wordlistNEWar>70)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

wordlistNEWarchivePath80 := "... " . SubStr(wordlistNEWarchivePath, -70 ) 
; MsgBox, '%wordlistNEWarchivePath80%' = wordlistNEWarchivePath80  `n (line:%A_LineNumber%) `n 
}
else
   wordlistNEWarchivePath80 := wordlistNEWarchivePath


initialWordList =   
(
___your library open|rr||ahk|run,..\%wordlistNEWarchivePath%
___open your library|rr||ahk|run,..\%wordlistNEWarchivePath%
___edit your library|rr||ahk|run,..\%wordlistNEWarchivePath%
___your library adress|r|%wordlistNEWarchivePath%
___your library short path|r|%wordlistNEWarchivePath80%
___your library name|r|%wordlistNEW%
; this is a comment written at 04.04.2017 12:03

AHKdyn example super simple example
AHKdyn example 000|r|thats example 0
AHKdyn example 1|rr||ahk|Send, hi world :-)
AHKdyn example 3|rr|; |ahk|Send,{Enter}hi world :-)
AHKdyn example 4|rr|; |ahk|m := "hi {Enter}world :-)" ``n Send, `%m`%
AHKdyn example 5|rr|Msgbox,|ahk|m =````n (from: `%A_ScriptName`%~`%A_LineNumber`%) ``n lm:=strlen(m)+1 ``n send, `%m`% {left `%lm`%}{shift down}{right `%lm`%}{shift up}
AHKdyn example 6|rr|hi :-) welcome to example 6|ahk|send, {enter} your wordlist is here: %wordlistDir%{enter}%wordlistNEW% {enter} activeTitle=%activeTitle%  activeTitle=`%activeTitle`% {enter}(line:%A_LineNumber%)
login by calling a ahk-script into your wordlist folder|rr||ahk|#include,`%A_ScriptDir`%\..\Wordlists\ChromeWidgetWin1\LoginSecret.ahk

ÃŸ|rr|it may helps to store the lib file as  ... see notepad++ > codeing OR Phpstorm > file encoding to > windows ...
codeing|rr|it may helps to store the lib file as  ... see notepad++ > codeing OR Phpstorm > file encoding to > windows ...
file encoding|rr|it may helps to store the lib file as  ... see notepad++ > codeing OR Phpstorm > file encoding to > windows ...
)


      FileAppend, `; '%at%' = at  `n `;  (line:%A_LineNumber%) `n%initialWordList% `n, % wordlistNEWarchivePath
   Sleep,500
}
   
   if(!FileExist(wordlistNEWarchivePath))
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

      MsgBox, :( !FileExist(%wordlistNEWarchivePath%)) `n `n '%wordlistNEWarchivePath%' = wordlistNEWarchivePath  `n wordlistNEW= %wordlistNEW% `n (line:%A_LineNumber%) `n RELOAD
      Reload
   }
   


FileCopy, % wordlistNEWarchivePath, % wordlistActivePath  , 1
      
   return 1
} 




wordlistOLDdisable( typingAidSourcePath, wordlistActive){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   wordlistActive = % typingAidSourcePath . "\" . wordlistActive
   wordlistDisable = % typingAidSourcePath . "\" . wordlistActive ".backup.txt"

   FileCopy, % wordlistActive  , % wordlistDisable , 1
   return 1
} 

checkFilePathExistens(wordlistDir, destinDir, sourceDir, typingAidAHK ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   DetectHiddenWindows,on
   SetTitleMatchMode,1
IfWinNotExist,TypingAid.ahk
{
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   IfWinNotExist,TypingAid
   {
    g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

;   MsgBox,,TypingAid  is running, :( `n are you sure TypingAid  is running? `n  IfWinNotExist TypingAid  `n (line:%A_LineNumber%) `n lets try start it automatically, 2
; lets wait and try again. maybe its reload its self and needs only a second
    Sleep, 1000 ; 1 Sekunde
    IfWinNotExist,TypingAid
        Run, % typingAidAHK
    g_tooltipText = WinWait TypingAid.ahk
    g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   WinWait,TypingAid,, 9
}
} 
DetectHiddenWindows,On
SetTitleMatchMode,2
IfWinNotExist,TypingAid
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   MsgBox,,NotExist?, :( IfWinNotExist '%typingAidAHK%' = typingAidAHK  `n (line:%A_LineNumber%) `n , 2
}

   if(! FileExist(wordlistDir) )
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   FileCreateDir, % wordlistDir
   Sleep,1000
   }
   if(! FileExist(wordlistDir) )
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   Last_A_This:=A_ThisFunc . A_ThisLabel 
   ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This) ;
   msg = 
   (
   :-(
   `n '%wordlistDir%' = wordlistDir  `n (line:%A_LineNumber%) `n 
   do not exist.
   )
   MsgBox, :(  `n  ! Exist(wordlistDir) %msg%
   Reload
   }
   if(! FileExist(sourceDir) )
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   Last_A_This:=A_ThisFunc . A_ThisLabel 
   ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This) ;
   msg_sourceDir = `n '%sourceDir%' = sourceDir  `n (line:%A_LineNumber%) `n
   MsgBox, :(  `n  ! Exist(sourceDir) %msg_sourceDir%
   }
   return  
}







simplifyNameOfWordlistNEWstep1( wordlistNEW ) {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

;   wordlistNEW := "superSimple" . ".txt"
   return wordlistNEW ; 
   
FoundPos := InStr(wordlistNEW, "\",0,-1 )
if( FoundPos )
   wordlistNEW:=SubStr(wordlistNEW,1,FoundPos) . "_" . SubStr(wordlistNEW,FoundPos) 
wordlistNEW := RegExReplace(  wordlistNEW, "(\w)[^\\]+\\", "$1")  ; E:\fre\private\HtmlDevelop\AutoHotKey\tools\TypingAid-master\Wordlists\ChromeWidgetWin1\GmailGoogleChrome.txt - Notepad++ ahk_class Notepad++ ==> EfpHAtTWCGmailGoogleChrome_txt_Notepad_.txt

 ;~ MsgBox, '%wordlistNEW%' = wordlistNEW  `n (line:%A_LineNumber%) `n 
wordlistNEW := RegExReplace(  wordlistNEW , "\s*\[[^\[\]]+\]+", "")  ; clone.ahk * SciTE4AutoHotkey [2 von 2]
wordlistNEW := RegExReplace(  wordlistNEW, "[\W_]+", "_")  . ".txt"
; MsgBox,'%ActiveClass%' = ActiveClass  `n (line:%A_LineNumber%) `n 



wordlistNEW := "dummiTestFromLine" . A_LineNumber . ".txt"
return wordlistNEW 
}


encodeAHKchars( s ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   s := RegExReplace( s , "(""|``)", "$1$1")
   s := RegExReplace( s , "(``n|`%|\(|\))", "``$1")
   return s
}
encodeAHKcharsOLD( s ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   s := RegExReplace( s , "(""|``)", "$1$1")
;   hi3 := RegExReplace( s , "(``)", "$1$1")
   s := RegExReplace( s , "`n", "``n")
   return s
}


selfPerformanceTest()
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   ClipboardBackup1703061259 := Clipboard
   ahkCode =
(
Clipboard := "selfPerformanceTest"
)
   ; test how long it takes , that clipboard will updated at this computer 06.03.2017 16:00
   ; ergebniss log:
 ; Sleep 156 ; millisec 20170306165639
 ; Sleep 62 ; millisec 17-03-06_17-29
 
   TickCount1 := A_TickCount ; YYYYMMDDHH24MISS 
   Loop,9
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   i := 0
      while(i++ < 99){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   Sleep,10
   result := DynaRunGetClipboard(ahkCode)
   if ( i > 100 || "selfPerformanceTest" == result)
      break
 }
    if ( "selfPerformanceTest" == result)
      break
}
millisec := A_TickCount - TickCount1
      Clipboard := "`; Sleep " . millisec . " `; millisec " . A_Now . " , line= " . A_LineNumber
    if ( "selfPerformanceTest" <> result)
      MsgBox, %   ":-( ERROR wrong result " . Clipboard
else {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

; MsgBox, % ":-)  " .  Clipboard
}
      Clipboard := ClipboardBackup1703061259
   return result
}

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
DynaRunGetClipboard2(ahkCode)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   MsgBox, that function is obsolte now 11.03.2017 16:57 `n  '%ahkCode%' = ahkCode  `n (line:%A_LineNumber%) `n 
   ClipboardBackup1703061259 := Clipboard   
   Loop,9
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   DynaRun(ahkCode)
   i := 0
      while(i++ < 99){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   Sleep,10
   result  = %Clipboard%
   if ( i > 100 || ClipboardBackup1703061259 <> result )
      break
 }
    if ( ClipboardBackup1703061259 <> result )
      break
}
Clipboard := ClipboardBackup1703061259
   return result 
}
selfPerformanceTest2(){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   ClipboardBackup1703061259 := Clipboard
   ahkCode =
(
Clipboard := "selfPerformanceTest2"
)
   ; test how long it takes , that clipboard will updated at this computer 06.03.2017 16:00
   ; ergebniss log:
   ; Sleep 47 ; millisec 20170306171409
   ; Sleep 1623 ; millisec , now= 20170306172251, result=17-03-06_12-56, line:433
   ; Sleep 47 ; millisec , now= 20170306172412, result=17-03-06_12-56, line:431
   ; Sleep 47 ; millisec , now= 20170306172500, result=17-03-06_12-56, line:432
   ; Sleep 47 ; millisec , now= 20170306172844, result=17-03-06_12-56, line:450
   
   TickCount1 := A_TickCount ; YYYYMMDDHH24MISS 
   Loop,9
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   DynaRun(ahkCode)
   i := 0
      while(i++ < 99){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   Sleep,10
   result  = %Clipboard%
   if ( i > 100 || "selfPerformanceTest2" == result)
      break
 }
;    if ( i > 100 || "selfPerformanceTest2" == result)

    if ( "selfPerformanceTest2" == result)
      break
}
millisec := A_TickCount - TickCount1
      Clipboard := "`; Sleep " . millisec . " `; millisec , now= " . A_Now . ", result=" . result . ", line:" . A_LineNumber
    if ( "selfPerformanceTest2" <> result)
MsgBox, ERROR !!! :-( `n %Clipboard% `n (line:%A_LineNumber%) `n 
else{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

m = %Clipboard% `n (line:%A_LineNumber%) `n 
   ToolTip4sec(m)
}
MsgBox, 17-03-10_08-04
      Clipboard := ClipboardBackup1703061259
   return result 
}
DynaRun(TempScript, pipename=""){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   static _:="uint",@:="Ptr"
   If pipename =
      name := "AHK" A_TickCount
   Else
      name := pipename
   __PIPE_GA_ := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
   __PIPE_    := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
   if (__PIPE_=-1 or __PIPE_GA_=-1)
      Return 0
   Run, %A_AhkPath% "\\.\pipe\%name%",,UseErrorLevel HIDE, PID
   If ErrorLevel
      MsgBox, 262144, ERROR,% "Could not open file:`n" __AHK_EXE_ """\\.\pipe\" name """"
   DllCall("ConnectNamedPipe",@,__PIPE_GA_,@,0)
   DllCall("CloseHandle",@,__PIPE_GA_)
   DllCall("ConnectNamedPipe",@,__PIPE_,@,0)
   script := (A_IsUnicode ? chr(0xfeff) : (chr(239) . chr(187) . chr(191))) TempScript
   if !DllCall("WriteFile",@,__PIPE_,"str",script,_,(StrLen(script)+1)*(A_IsUnicode ? 2 : 1),_ "*",0,@,0)
        Return A_LastError,DllCall("CloseHandle",@,__PIPE_)
   DllCall("CloseHandle",@,__PIPE_)
   Return PID
}
FileWriteAndRun(sayHelloCode, sayHelloFunctionInc){
 global g_lineNumberFeedback

 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   isFileExist := false
   FileWrite(sayHelloCode, sayHelloFunctionInc)
   Loop,99 
   {
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   IfExist  , % sayHelloFunctionInc
   {
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

      isFileExist := true
      break
   }
   Sleep,20
   }
   KeyWait Control  ; Wartet darauf, dass sowohl STRG als auch ALT losgelassen wird.
   run, % sayHelloFunctionInc
;   MsgBox, '%sayHelloFunctionInc%' = sayHelloFunctionInc  `n (line:%A_LineNumber%) `n 
return isFileExist 
}
FileWrite(sayHelloCode, sayHelloFunctionInc){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   if(FileExist(sayHelloFunctionInc))
   FileDelete, % sayHelloFunctionInc
   Sleep,100
   FileAppend, % sayHelloCode, % sayHelloFunctionInc
   return 1
}
mvarInjects(wordlistDir, wordlistNEW, ActiveClass, activeTitle){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

if(!wordlistDir)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

msgbox,!wordlistDir exitap (line:`%A_LineNumber`%) `n 17-03-19_14-06
exitapp
}
if(!wordlistNEW)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

msgbox,!wordlistNEW exitap (line:`%A_LineNumber`%) `n
exitapp
}
if(!ActiveClass)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

msgbox,!ActiveClass exitap (line:`%A_LineNumber`%) `n
exitapp
}
if(!activeTitle)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
}

   varInjects =
   (
   wordlistDir = %wordlistDir%
   wordlistNEW = %wordlistNEW%
   ActiveClass = %ActiveClass%
   activeTitle = %activeTitle% `n
   )
   return varInjects
}
getWelcomeMsg(){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

msg = 
(
this `n `n  %A_ScriptName% `n 
copies the activAid for every window class you are using automatically
runs this and close/kills the other activAid

if you try to find which file belongs to your wordlist type _____ it hopefully helps
   
WordlistLearned.txt is a global wordlist.
for activate your updates in this file please 
close TypingAid and
delete WordlistLearned.db
   
descriptions:
<word>|d|<description>
"Word descriptions can be added to 'Wordlist.txt' that will appear in the wordlist next to the word. These descriptions should be in the form of 
<word>|d|<description>, e.g., Tylenol|d|Pain Reliever. 
This could be used for things like definitions, translation aids, or function arguments. When Fixed Width fonts are used in the wordlist, the description columns will be tabbed evenly so they line up."
04.03.017 16:16 from https://github.com/ManiacDC/TypingAid

replacements:
<word>|r|<description>
"Word replacements can be added to 'Wordlist.txt' that will appear in the wordlist next to the word. These replacements should be in the form of 
<word>|r|<description>, e.g., fire|r|fuego. 
When the word is chosen, it will be backspaced out and replaced with the new word. If Case Correction is off, the first letter will be changed to match the case of the word being replaced. This could be used for spelling replacements, text expansion, or translation aids. Multiple replacements can be defined for a word (put each on a separate line)."
04.03.017 16:16 from https://github.com/ManiacDC/TypingAid

problems:
may have problems with cooding. may save your wordlists as UTF-8 or convert it. for e.g. with notepad. codierung > convert to UTF-8
hint from hints: http://stackoverflow.com/questions/2527269/any-tool-to-convert-bulk-php-files-to-utf-8-without-bom :
Before trying this, you must make a backup of your files.
You need to create a macro that does this:
Convert the currently opened file to UTF-8 w/o BOM;
Select all the text in your file, and copy it (why this? it looks like a bug. if you won't do this, your file will be replaced with your current clipboard content...);
Save the current file;
Close the current file.
Save this macro.
Now, open your files, and run it with the "Run a Macro Multiple Times..." command. If you opened 100 files, let it run for 100 times.

its not a bug, its a feature ;)
you may think first letters want replace. yes thats true. thats a feature ;) not a bug. you could choose by yourself to write it upper or lowercase. 05.03.2017 02:11

05.03.2017 01:26
)
return msg
}

getAhkCodeInsideFile(wordlistDir, wordlistFilterPath ) {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

ahkCodeInsideFile =
(
#SingleInstance, force
`; dontDeleteThisPlaceholder
#Include %wordlistDir%\..\wordlistNameFilter.inc.ahk `; global wordlist . pleas dont delete this line! 17-03-06_10-59
wordlistFilterPath = %wordlistFilterPath% `n ; (line:`%A_LineNumber`%) `n 
`; if you want you could use the follwong global variables fot calculating you new wordlistNEW : wordlistDir, wordlistNEW, ActiveClass, activeTitle  
if `(!wordlistNEW `){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

    MsgBox, ERROR wordlistNEW is EMPTY 17-03-05_14-51
    exitapp
}
if `(!wordlistDir `){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

    MsgBox, ERROR wordlistDir is EMPTY 17-03-19_11-52
    exitapp
}
`; Clipboard := wordlistNEW    we dont need that anymore. becouse now we work without the clipboard 09.03.2017 21:21 isInternMsgTransportIsClipboard := false `; false. then using fileSystem: readfile, include copyfile
)
return ahkCodeInsideFile
}

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
DynaRunGetClipboard(value){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   MsgBox, 17-03-10_08-06
   ; if you make much clipboard work during the test, you could see its not working fine :( 07.03.2017 01:05
;   id = 17-03-07_00-32 ; without this nummer you get some 1000 without any false, some with some false 07.03.2017 00:49
   id := A_TickCount . "_line_" . A_LineNumber ; ; first teset no error with value
      ;~ value := RegExReplace(value,"(Clipboard\s*:=)\s*(\w+)", "$1" . " . """ . id . """ " . "$2" )  ; Clipboard := wordlistNEW
      ;~ value := RegExReplace(value,"(Clipboard\s*:=)\s*(\w+)", "$1" . " . """ . id . """ " . "$2" )  ; Clipboard := wordlistNEW
if(RegExMatch(value, "Clipboard\s*:?=") ) {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   ahkCode  := RegExReplace(value,"(Clipboard\s*:=)\s*(\w+)", "$1" . " """ . id . """ . " . "$2" )  ; Clipboard := wordlistNEW
   ;~ Clipboard := ahkCode ; debugging only
   ;~ MsgBox, '%Clipboard%' = Clipboard  `n (line:%A_LineNumber%) `n  ; debugging only
}
else{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   yesValueShouldGetEqualResult := true
token  = %id%%value%
ahkCode =
(
Clipboard  = %token%
)
}
; Clipboard := ahkCode  ; debugging reasons 17-03-07_19-14
; MsgBox, '%ahkCode%' = ahkCode  `n (line:%A_lineNumber%) `n 
   k := 0
   while( k++ < 1000) {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

      
         idBackup := A_TickCount  . "_line_" . A_LineNumber
   ClipboardBackup1703061255 =%idBackup%%Clipboard% ; this only allows text clipboard 07.03.2017 09:15


   result := DynaRunGetClipboard2(ahkCode)
   restoreOldClipboard(idBackup, ClipboardBackup1703061255 )
;      Clipboard := ClipboardBackup1703061255 ; sometimes this not turn to old value :( 07.03.2017 01:01
    ;  ToolTip, % result
   if(foundPos:=InStr(result,id)) ; usually its the first try. if there is no user action all are ok. if you act every 100 it could one false
      break
   Sleep,10 ; its needet. if you chunk your clipboad it takes a  little time (few seconds) sometimes, till the script runs again. 07.03.2017 00:57
   ;restoreOldClipboard(idBackup, ClipboardBackup1703061255 ) ; Clipboard := ClipboardBackup1703061255 ; sometimes not work :( 07.03.2017
}
   if(foundPos){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

               result:=SubStr(result , StrLen(id)+1)
   }  else
      MsgBox, :( id not found `n  '%id%' = id  `n`n   result= '%result%' `n `n  token = '%token%'  `n (line:%A_LineNumber%) `n 
   if( yesValueShouldGetEqualResult && result <> value )
      MsgBox, :( '%id%' = id  `n  result= '%result%' <> '%token%'  `n (line:%A_LineNumber%) `n ; and sometimes it happens anyway . id was not wiped out 07.03.2017 08:18



;Sleep,100
;   restoreOldClipboard(idBackup, ClipboardBackup1703061255 )

; sure id cant be inside. or not?
   if(foundPos:=InStr(result, id )) ; usually its the first try. if there is no user action all are ok. if you act every 100 it could one false
MsgBox, :( '%id%' = id   `n  '%result%' = result  `n (line:%A_LineNumber%) `n 

   return result
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

selfTestLoop1000(loopMax){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   MsgBox, 17-03-10_08-04
   ; if you make much clipboard work during the test, you could see its not working fine :( 07.03.2017 01:05
   i := 0
;   id = 17-03-07_00-32 ; without this nummer you get some 1000 without any false, some with some false 07.03.2017 00:49
   while( i++ < loopMax)    {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

      ToolTip, %i% < %loopMax%
      value = selfTest1703061808i%i%
      ;ahkCode := "Clipboard . " = "" . value . """"
 result :=  DynaRunGetClipboard(value)

    }
    if(result <> value )
        MsgBox, :( value = '%value%' <> '%result%' = result  `n (line:%A_LineNumber%) `n
    return result
}


#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise müsen ans Dateiende
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
