
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; hier wird das active �berschrieben: 12.07.2017 21:33
wordlistNEWactivate( wordlistDir , wordlistNEW, wordlistActive , typingAidSourcePath, activeClass := "" , activeTitle := "" ) {
; return, 1 ; return spielt keine rolle, quasi void 30.07.2017 12:52 17-07-30_12-52


  if(1)
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk", ":) _______________ Hello inside temp.ahk _____________"  )
      
    ; lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk", "START function: wordlistNEWactivate"  )


    global g_lineNumberFeedback
    g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%



    if(FileExist(wordlistNEW)) ; feature update 08.04.2017 19:43
       wordlistNEWarchivePath := wordlistNEW
    else
       wordlistNEWarchivePath = % wordlistDir . "\" . wordlistNEW
   ; From here we only use wordlistNEWarchivePath
   ; Next time this variable is used here: simplifyNameOfWordlistNEWstep1( wordlistNEW ) {  in line 256   12.07.2017 21:07

if(0 && !WinExist("1:" )){
    msg =
(
wordlistNEWarchivePath = '%wordlistNEWarchivePath%'
wordlistDir = '%wordlistDir%'
'%A_LineNumber%' = A_LineNumber
'%A_ScriptDir%' = A_ScriptDir
'%A_ScriptName%' = A_ScriptName
'%A_ThisFunc%' = A_ThisFunc
)
    feedbackMsgBox(msg,msg,1,1)
}


global g_doSaveLogFiles
if(Instr(wordlistNEWarchivePath,"\EVERYTHING\")){
    g_doSaveLogFiles := false
    lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,   "g_doSaveLogFiles := true" )
}else{
    g_doRunLogFiles := false
}


if(!wordlistNEWarchivePath)
    Msgbox,Oops !wordlistNEWarchivePath `n (Typing_Aid_everywhere_multi_clone.inc.ahk~%A_ThisFunc%~%A_`LineNumber%) `

   ; wordlistActivePath := typingAidSourcePath .  "\" . wordlistActive
   wordlistActivePath := A_ScriptDir . "\" . wordlistActive
   if(!FileExist(wordlistActivePath))
      MsgBox, :( '%wordlistActivePath%' = wordlistActivePath  `n (line:%A_LineNumber%) `n 18-01-20_17-12
; The active path, that the complete address of the file inc dir, has to be always present. if not then that is an error. 12.07.2017 21:10

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  if(!FileExist(wordlistNEWarchivePath)) {
  ; So hear it's possibly a good idea to generate a new one by using a template. 12.07.2017 21:12

    global g_lineNumberFeedback
    g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

    WinGetActiveTitle,at
    strLen_wordlistNEWar := StrLen(wordlistNEWarchivePath)
    if(strLen_wordlistNEWar < 5)
       MsgBox, :-( '%strLen_wordlistNEWar%' = strLen_wordlistNEWar  `n (line:%A_LineNumber%) `n
       ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
       ; Let's generate a pretty short 80 signs long name. 12.07.2017 21:14
    if(strLen_wordlistNEWar>70) {
      global g_lineNumberFeedback
      g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

      wordlistNEWarchivePath80 := "... " . SubStr(wordlistNEWarchivePath, -70 ) 
      ; MsgBox, '%wordlistNEWarchivePath80%' = wordlistNEWarchivePath80  `n (line:%A_LineNumber%) `n 
    } else {
       wordlistNEWarchivePath80 := wordlistNEWarchivePath
    }
   ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    initialWordList := getInitialWordList(wordlistNEWarchivePath,wordlistNEW)

; _%wordlistNEWarchivePath%|r|Here you could find your library

      FileAppend, `; '%at%' = at  `n `;  (line:%A_LineNumber%) `n%initialWordList% `n, % wordlistNEWarchivePath
   Sleep,500

   ; End of: if(!FileExist(wordlistNEWarchivePath))

    ; Now the new examples-template is saved inside of this file: wordlistNEWarchivePath
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
} else {
    ; No example template was used. The content is already there. Inside on this file. And don't need to be generated. 12.07.2017 21:36
    lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,   "startREADING: >" . wordlistNEWarchivePath . "< = wordlistNEWarchivePath" )

;<<<<<<<<<<<<< startREADING <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
       ; read #include commands
       exist_includeFilePath := 0
       includeFileSContent := ""
       wordlistGeneratedPath := ""
       isIncludeFileInside := false
       includeFileSContentWillBeNeedsSaved := false
       includeFilePathArray := Object()
       lineInRegExArray := Object()

lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "'" . wordlistGeneratedPath . "' = wordlistGeneratedPath `n'" . wordlistNEWarchivePath . " = wordlistNEWarchivePath " )

if(0 && !WinExist("1:" )){
msg =
(
wordlistNEWarchivePath = '%wordlistNEWarchivePath%'
wordlistDir = '%wordlistDir%'
'%A_LineNumber%' = A_LineNumber
'%A_ScriptDir%' = A_ScriptDir
'%A_ScriptName%' = A_ScriptName
'%A_ThisFunc%' = A_ThisFunc
)
feedbackMsgBox(msg,msg,1,1)
}


Loop, read, % wordlistNEWarchivePath
       {
           ; Beispiel:
; #Include .\..\Wordlists\Notepad\_global.txt
;           regEx := "i)^\s*#include\s*,\s*([^|!]+)\s*(?:((\||\!))\s*(.+))?\s*"
; include[ ]*(?:,|\s)[ ]*([^|!\n]+)[ ]*(?:((\||\!))[ ]*([^\n]+))?[ ]*
           regEx := "i)^[ ]*#include[ ]*(?:,|\s)[ ]*([^|!\n]+)[ ]*(?:((\||\!))[ ]*([^\n]+))?[ ]*"
           foundPos := RegexMatch( A_LoopReadLine, regEx, matchs)
; Msgbox,'%wordlistNEWarchivePath%' = wordlistNEWarchivePath `n '%includeFilePath%' = includeFilePath  `n (line:%A_LineNumber%) n
           if(foundPos){
            isIncludeFileInside := true
            includeFilePath     := matchs1
            lineInRegEx         := (matchs4) ? matchs3 . matchs4 : "|.*" ; | ist a positvie rule. alle matching lines goes inside the new file.
            lll_if_g_doSaveLogFiles_matches(A_LineNumber, A_ThisFunc, matchs1,matchs2,matchs3,matchs4)
            lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "lineInRegEx=>" . lineInRegEx . "<" )

            ;Msgbox,'%lineInRegEx%' = lineInRegEx  n (line:%A_LineNumber%) n
            lineInRegExArray.Insert(lineInRegEx)
            exist_includeFilePath := (FileExist(includeFilePath)) ? 1 : 0
            if(!exist_includeFilePath){
              msg =:-( ERROR %exist_includeFilePath% = exist_includeFilePath `n %includeFilePath% `n  >%wordlistNEWarchivePath%< = wordlistNEWarchivePath (from: %A_ScriptName%~%A_LineNumber%)
              Tooltip,%msg%
              g_doSaveLogFiles := true
              lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  msg)
            }
            
lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  ":| exist_includeFilePath =" . exist_includeFilePath . "   '" . wordlistNEWarchivePath . "' = wordlistNEWarchivePath ")

;<<<<<<<<<<<<<<  if(exist_includeFilePath)  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            if(exist_includeFilePath){
                wordlistNEWarchivePathBackup := wordlistNEWarchivePath
                wordlistGeneratedPath := wordlistNEWarchivePath . "._Generated.txt"

                lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "'" . wordlistGeneratedPath . "' = wordlistGeneratedPath `n'" . wordlistNEWarchivePath . " = wordlistNEWarchivePath " )


                exist_wordlistGeneratedPath := FileExist(wordlistGeneratedPath)

                FileGetTime, wordlistNEWarchivePathBackupModifiedTime, %wordlistNEWarchivePathBackup%
                FileGetTime, includeFileModifiedTime, %includeFilePath%
                
                wordlistGeneratedModifiedTime := 0
                if(exist_wordlistGeneratedPath)
                    FileGetTime, wordlistGeneratedModifiedTime, %wordlistGeneratedPath%

msg= '%wordlistNEWarchivePathBackupModifiedTime%' > '%wordlistGeneratedModifiedTime%' (wordlistNEWarchivePathBackupModifiedTime > wordlistGeneratedModifiedTime)  `n'%includeFileModifiedTime%' > '%wordlistGeneratedModifiedTime%' (includeFileModifiedTime > wordlistGeneratedModifiedTime)
lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  msg)


                if( false 
                || !exist_wordlistGeneratedPath 
                || wordlistNEWarchivePathBackupModifiedTime > wordlistGeneratedModifiedTime  
                || includeFileModifiedTime > wordlistGeneratedModifiedTime ){
                    includeFileSContentWillBeNeedsSaved := true
                     ; continue ; include is old. older.
                   }{



                  ; lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk", "includeFilePathArray.Insert(" . includeFilePath . " `n 17-07-29_12-01" )
                    includeFilePathArray.Insert(includeFilePath)
}

           } ; endo of if(exist_includeFilePath){
; weihnachtsbaum 12.07.2017 23:10

         } else
            break
;>>>>>>>>>>>>>>>>> if(exist_includeFilePath)  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

         lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "'" . wordlistGeneratedPath . "' = wordlistGeneratedPath `n'" . wordlistNEWarchivePath . " = wordlistNEWarchivePath " )

       }


lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  includeFileSContentWillBeNeedsSaved . " = includeFileSContentWillBeNeedsSaved `n" . wordlistNEWarchivePath . " = wordlistNEWarchivePath `n" . "17-07-16_17-07")


if(includeFileSContentWillBeNeedsSaved ) {
; loop throw alls include files
; Loop % Array.MaxIndex()   ; More traditional approach.
for fileId, includeFilePath in includeFilePathArray ; Recommended approach in most cases.
{ ; for fileId, includeFilePath in includeFilePathArray

            lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc, includeFilePath)

            lineInRegEx := lineInRegExArray[fileId]
            regEx := SubStr( lineInRegEx , 2 )
            regExPREFIX := SubStr( lineInRegEx  , 1 , 1 ) ; its a | ir a bit !

            lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "lineInRegEx=" . lineInRegEx)
            lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "regEx=" . regEx)


            includeFileContent := ""
            if(lineInRegEx == "|.*"){
                FileRead, includeFileContent, %includeFilePath%
                includeFileContent .= "`n"
            }else{
                Loop, read, %includeFilePath%
                {
                    foundPos := RegExMatch( A_LoopReadLine , regEx  )

                    if( ( regExPREFIX =="|" && foundPos ) || ( regExPREFIX == "!" && !foundPos ) )
                        includeFileContent .= RTrim(A_LoopReadLine) . "`n"
                } ; END loop
            } ; END else
                if(includeFileContent)
                    includeFileSContent .= includeFileContent
            }
} ; END if(includeFileSContentWillBeNeedsSaved )


lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "'" . includeFileSContentWillBeNeedsSaved . "' = includeFileSContentWillBeNeedsSaved" )

; lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "'" . wordlistGeneratedPath . "' = wordlistGeneratedPath `n'" . wordlistNEWarchivePath . " = wordlistNEWarchivePath " )

if(includeFileSContentWillBeNeedsSaved )
    save_wordlistGeneratedPath(wordlistGeneratedPath,includeFileSContent,wordlistNEWarchivePath)

lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "'" . wordlistGeneratedPath . "' = wordlistGeneratedPath `n'" . wordlistNEWarchivePath . " = wordlistNEWarchivePath " )

        if(isIncludeFileInside && wordlistGeneratedPath){
           wordlistNEWarchivePath := wordlistGeneratedPath ; that it will be used as your wordllist with all sugestions :) 12.07.2017 22:58

            ExitAPP_if_NOT_wordlistGeneratedPath (A_LineNumber, A_ThisFunc, wordlistNEWarchivePath, wordlistGeneratedPath , wordlistNEW)
            ;ExitAPP_if_NOT_wordlistNEWarchivePath_and_NOT_wordlistNEW(A_LineNumber, A_ThisFunc, wordlistNEWarchivePath, wordlistGeneratedPath , wordlistNEW)
        }
;>>>>>>>>>>>>>>>>>> includeFileSContentWillBeNeedsSaved >>>>>>>>>>>>>>>>>>>>>>>>>>>
} ; EndOf: Loop, read, % wordlistNEWarchivePath

lll_if_g_doSaveLogFiles(A_LineNumber, A_ThisFunc,  "'" . wordlistGeneratedPath . "' = wordlistGeneratedPath `n'" . wordlistNEWarchivePath . " = wordlistNEWarchivePath " )

  ; All we have to do know is to  use this file. therefore we only copying it to the active used file. it will be overwritten. 12.07.2017 21:31

  ExitAPP_if_NOT_wordlistNEWarchivePath_and_NOT_wordlistNEW(A_LineNumber, A_ThisFunc, wordlistNEWarchivePath, wordlistGeneratedPath , wordlistNEW)
  if(1){
FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
content =
(
%A_WorkingDir%\%wordlistNEWarchivePath%
%activeClass%
%activeTitle%
wordlistNEWarchivePath = %wordlistNEWarchivePath%
activeClass  = %activeClass%
activeTitle = %activeTitle%
; FileReadLine,wordlistNEWarchivePath ,wordlist.txt, 1
)
; FileReadLine,activeClass ,wordlist.txt, 2
; FileReadLine,activeTitle ,wordlist.txt, 3
  FileAppend, % content, % timestampyyMMddHHmmss
  FileCopy, % timestampyyMMddHHmmss, % wordlistActivePath . ".status.txt" , 1
  FileDeleteAsyncDynaRun(timestampyyMMddHHmmss , 1000)
  }
  FileCopy, % wordlistNEWarchivePath, % wordlistActivePath  , 1
  return, 1
} ; EndOf function wordlistNEWactivate( wordlistDir , wordlistNEW, wordlistActive , typingAidSourcePath )
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



restoreOldClipboard(idBackup, ClipboardBackup) {

disableCopyQ() ; enableCopyQ() ;


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
   enableCopyQ() 
         return, 1
}
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


wordlistOLDbackup( wordlistDir , wordlistOLD){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   FileCopy, % wordlistDir . "\" . wordlistOLD , % wordlistDir . "\" . wordlistOLD . ".backup.txt", 1
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
runTypingAidAHKifNotExist( typingAidAHK ){
   DetectHiddenWindows,on
   SetTitleMatchMode,2
    IfWinNotExist,TypingAid.ahk
    {
        g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
        IfWinNotExist,TypingAid
        {
            g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

        ;   MsgBox,,TypingAid  is running, :( `n are you sure TypingAid  is running? `n  IfWinNotExist TypingAid  `n (line:%A_LineNumber%) `n   lets try start it   automatically, 2
        ; lets wait and try again. maybe its reload its self and needs only a second
            Sleep, 2000 ; 1 Sekunde
            IfWinNotExist,TypingAid
            {

                ; gosub,couldIfindMyself
                msg := "Run, typingAidAHK"
                ; Run, % typingAidAHK
                RunAs,Administrator, % typingAidAHK

                tooltip, '%msg%' = msg  `n (line:%A_LineNumber%)
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk", msg )

            }

            g_tooltipText = WinWait TypingAid.ahk
            g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
            WinWait,TypingAid.ahk,, 9
            IfWinNotExist,TypingAid
            {
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk", "IfWinNotExist,TypingAid -> exitapp")
                exitapp
            }
        }
    }
    return
}
checkFilePathExistens1704291222(wordlistDir, destinDir, sourceDir, typingAidAHK ){


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
    Sleep, 2000 ; 1 Sekunde
    IfWinNotExist,TypingAid
    {
        ; gosub,couldIfindMyself
        Run, % typingAidAHK
;        lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk", "Run, % typingAidAHK")
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk", "Debuggging!  NOT Run % typingAidAHK " )

    }
    g_tooltipText = WinWait TypingAid.ahk
    g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   WinWait,TypingAid,, 9
    IfWinNotExist,TypingAid
    {
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk", "IfWinNotExist,TypingAid -> exitapp")
        exitapp
    }
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
   Sleep,100
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
   MsgBox, :( =>Reload  `n  ! Exist(wordlistDir) %msg%
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
wordlistNEW := RegExReplace(  wordlistNEW, "(\w)[^\\]+\\", "$1")  ; ChromeWidgetWin1\GmailGoogleChrome.txt - Notepad++ ahk_class Notepad++ ==> EfpHAtTWCGmailGoogleChrome_txt_Notepad_.txt

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

disableCopyQ() ; enableCopyQ() ;

   ClipboardBackup1703061259 := Clipboard
   ahkCode =
(
Clipboard = selfPerformanceTest
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

      enableCopyQ() ; enableCopyQ() ;
   return result
}

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
DynaRunGetClipboard2(ahkCode){

disableCopyQ() ; enableCopyQ() ;

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
Clipboard = selfPerformanceTest2
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
     enableCopyQ() ; enableCopyQ() ;
   return result 
}
;<<<<<<<<<<<<<< FileDeleteAsyncDynaRun <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
 FileDeleteAsyncDynaRun(fileAbsAdress , waitMiliBefore=3000){
  ahkCode =
  (
  Sleep, %waitMiliBefore%
  FIleDelete, %fileAbsAdress%
  exitapp
  )
  DynaRun(ahkCode)
  return
}
;>>>>>>>>>>>>> FileDeleteAsyncDynaRun >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

DynaRunENDa�sldkjfa�sldkjfl(TempScript, pipename="") {
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
   ; gosub,couldIfindMyself
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
   ;feedbackMsgBox(sayHelloCode . "`n`n`n" . sayHelloFunctionInc,A_LineNumber . " Typing_Aid_everywhere_multi_clone.inc.ahk")
   FileWrite(sayHelloCode, sayHelloFunctionInc)
   Loop,200 ;  
   {
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

   if(GetKeyState("Ctrl", "P"))
    KeyWait Control  ; Wartet darauf, dass sowohl STRG als auch ALT losgelassen wird.

   if(FileExist(sayHelloFunctionInc)){
    g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
      isFileExist := true
      break
   }
   Sleep,20
   }
   
   ;gosub,couldIfindMyself
   if(FileExist(sayHelloFunctionInc))
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

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
wordlistNEW_time_between := wordlistNEW
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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

; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
wordlistNEW := maybeSuperglobalWordList`(wordlistNEW, wordlistNEW_time_between , ActiveClass, activeTitle `)



`; Clipboard := wordlistNEW    we dont need that anymore. becouse now we work without the clipboard 09.03.2017 21:21 isInternMsgTransportIsClipboard := false `; false. then using fileSystem: readfile, include copyfile
)



return ahkCodeInsideFile
}

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
DynaRunGetClipboard(value){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

disableCopyQ() ; enableCopyQ() ;

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
token = %id%%value%
ahkCode =
(
Clipboard =  %token%
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

enableCopyQ() ; enableCopyQ() ;

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


;<<<<<<<<<<<<<<<<<<< getInitialWordList <<<<<<<<<<<<<<<<<<<<<<<<<<<
getInitialWordList(wordlistNEWarchivePath,wordlistNEW){
; Start filling the template variable with useful examples 12.07.2017 21:18

if(!wordlistNEWarchivePath)
    Msgbox,Oops !wordlistNEWarchivePath `n (Typing_Aid_everywhere_multi_clone.inc.ahk~%A_ThisFunc%~%A_`LineNumber%) `

initialWordList =
(
; %activeTitle% ; = activeTitle 17-08-10_16-03
; #Include .\..\Wordlists\_globalWordLists\examplesForBeginners.txt
___your library open|rr||ahk|run,..\%wordlistNEWarchivePath%
)
; EndOf filling the template variable with useful examples 12.07.2017 21:18
return initialWordList
}
;>>>>>>>>>>>>>>>>>>>>> getInitialWordList >>>>>>>>>>>>>>>>>>>>>>>>>

#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise müsen ans Dateiende
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk


;<<<<<<<<<<<<<<<<<< ExitAPP_if_NOT_wordlistNEWarchivePath_and_NOT_wordlistNEW<<<<<<<<<<<<<<<<<<<<<<<<<<<<
ExitAPP_if_NOT_wordlistNEWarchivePath_and_NOT_wordlistNEW(ALineNumber, AThisFunc, wordlistNEWarchivePath, wordlistGeneratedPath , wordlistNEW){
  if( !FileExist(wordlistNEWarchivePath) ) {
    global g_lineNumberFeedback
    g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.inc.ahk / %A_ScriptName% ~%AThisFunc%~%ALineNumber%
    msg = :( !FileExist(%wordlistNEWarchivePath%)) `n `n '%wordlistNEWarchivePath%' = wordlistNEWarchivePath  `n '%wordlistGeneratedPath%' = wordlistGeneratedPath  `n wordlistNEW= %wordlistNEW% `n ==> ExitAPP 17-08-11_01-01
    tooltip,%msg% `n`n ( %g_lineNumberFeedback% )

    lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  msg)


    ; lll(AThisFunc . "~" . ALineNumber, A_ScriptName, msg)
    Sleep,3000 ; function wordlistNEWactivate ??? right ??
    ExitAPP
  }
  return
}
;>>>>>>>>>>>>>> ExitAPP_if_NOT_wordlistNEWarchivePath_and_NOT_wordlistNEW>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;<<<<<<<<<<<<<<<<<< ExitAPP_if_NOT_wordlistGeneratedPath <<<<<<<<<<<<<<<<<<<<<<<<<<<<
ExitAPP_if_NOT_wordlistGeneratedPath(ALineNumber, AThisFunc, wordlistNEWarchivePath, wordlistGeneratedPath , wordlistNEW){
  if(!FileExist(wordlistGeneratedPath)) {
    global g_doSaveLogFiles
    g_doSaveLogFiles := 1
    global g_lineNumberFeedback
    ;g_lineNumberFeedback=%A_ScriptName%~%AThisFunc%~%ALineNumber%
    g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.inc.ahk / %A_ScriptName% ~%AThisFunc%~%ALineNumber%
    msg = :( !FileExist(%wordlistNEWarchivePath%)) `n `n '%wordlistNEWarchivePath%' = wordlistNEWarchivePath  `n '%wordlistGeneratedPath%' = wordlistGeneratedPath  `n wordlistNEW= %wordlistNEW% `n ==> ExitAPP 17-08-11_00-00 `n %g_lineNumberFeedback%
    tooltip,% msg


    lll_if_g_doSaveLogFiles(ALineNumber, A_ScriptName, msg)

    ;lll(AThisFunc . "~" . ALineNumber, A_ScriptName, msg)
    Sleep,3000 ; function wordlistNEWactivate ??? right ??
    ExitAPP
  }
  return
}
;>>>>>>>>>>>>>> ExitAPP_if_NOT_wordlistGeneratedPath >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<< lll_if_g_doSaveLogFiles <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,msg ){
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
    lll(AThisFunc . "~" . ALineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk" , msg)
    ; llll(A_LineNumber, A_ScriptName, "")
; Msgbox,'%g_doSaveLogFiles%' = g_doSaveLogFiles   (%A_ScriptName%~%A_LineNumber%) `
return
}
;>>>>>>>>>>>>>>>>> lll_if_g_doSaveLogFiles >>>>>>>>>>>>>>>>>>>>>>>>>>><>

; wordlistNEWarchivePath
save_wordlistGeneratedPath(wordlistGeneratedPath,includeFileSContent,wordlistNEWarchivePath) {

if(!wordlistNEWarchivePath){
    Tooltip, >%fileContent%< =fileContent `n (from: %A_ScriptName%~%A_LineNumber%)
    ; msgbox,cant read  >%fileContent%< =fileContent `n  becouse !wordlistNEWarchivePath `n (from: %A_ScriptName%~%A_LineNumber%)

        global g_doSaveLogFiles
        g_doSaveLogFiles := 1
        global g_lineNumberFeedback

        g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.inc.ahk / %A_ScriptName% ~%A_ThisFunc%~%A_LineNumber%

        msg=:( !fileContent `n `n ==> ExitApp  `n `n (g_lineNumberFeedback)
        tooltip,% msg
        lll_if_g_doSaveLogFiles(A_LineNumber, A_ScriptName, msg)
    ExitApp
}

    ExitAPP_if_NOT_wordlistGeneratedPath (A_LineNumber, A_ThisFunc, wordlistNEWarchivePath, wordlistGeneratedPath , wordlistNEW)
    ;ExitAPP_if_NOT_wordlistGeneratedPath (A_LineNumber, A_ThisFunc, wordlistNEWarchivePath, wordlistGeneratedPath , wordlistNEW)

    if(FileExist(wordlistGeneratedPath))
        FileDelete, %wordlistGeneratedPath%
    Sleep,60
    FileAppend,% includeFileSContent, % wordlistGeneratedPath
    ; Sleep,20
    FileRead, fileContent, %wordlistNEWarchivePath%
    ;Sleep,20
    FileAppend,% fileContent, % wordlistGeneratedPath
    if(false)lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk", "SAVED: " . wordlistGeneratedPath)
    Sleep,60
    return
}

lll_if_g_doSaveLogFiles_matches(ALineNumber, AThisFunc, matchs1,matchs2,matchs3,matchs4){
if(0){
lll:=";<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<", "matchs1: " . matchs1
tooltip,'%lll%' = lll    (line:%A_LineNumber%)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  lll)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  "matchs2=" . matchs2)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  "matchs3=" . matchs3)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  "matchs4=" . matchs4)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  ";>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
}
return
}
