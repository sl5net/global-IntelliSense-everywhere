
;<<<<<<<< IncludeI <<<< 171103161518 <<<< 03.11.2017 16:15:18 <<<<
#Include *i ..\Wordlists\activeClassManipulation.inc.ahk
; ^- obiges funktioniert (weil funktion sp�ter ausgef�hrt) bei `normalem` Aufruf. z.B. click von atuoload.ahk und darin ein:
; workingDir := HardDriveLetter . ":\fre\private\HtmlDevelop\AutoHotKey\tools\TypingAid-master\"
;  run, Typing_Aid_everywhere_multi_clone.ahk, %workingDir%
; #Include *i ..\Wordlists\activeClassManipulation.inc.ahk
;>>>>>>>> IncludeI >>>> 171103161523 >>>> 03.11.2017 16:15:23 >>>>

global g_doSaveLogFiles := true
global g_doSaveLogFiles := false
g_doRunLogFiles := false


; Menu, Tray, Icon, shell32.dll, 144
 Menu, Tray, Icon, shell32.dll, 107
; Menu, Tray, Icon, shell32.dll, 164
; Menu, Tray, Icon, shell32.dll, 227

;~ Menu, Tray, Icon, shell32.dll, 2 ; a ide or floppy
;~ Menu, Tray, Icon, shell32.dll, 250 ; pretty green stick
;~ Menu, Tray, Icon, shell32.dll, 250 ; pretty black stick

;~ Menu, Tray, Icon, shell32.dll, 240 ; pretty green clock
;~ Menu, Tray, Icon, shell32.dll, 266 ; pretty black clock




dog_lineNumberFeedback:=true
dog_lineNumberFeedback:=False
do_g_tooltipText:=false
do_tooltipReadWordList:=false
do_tooltipReadWordList:=true

g_tooltipText:=""
global g_lineNumberFeedback
g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

; ListGlobalVars() ; doesentn work
; test

;checkCriticalCommand()
SetTimer, checkCriticalCommandLbl, 2000
SetTimer, checkCriticalCommandLbl, Off

SetTimer, tooltipABS, 4000
; SetTimer, tooltipABS, 100
if(False) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   msg := getWelcomeMsg()
   MsgBox,% msg
} ;
isInternMsgTransportIsClipboard := false ; false. then using fileSystem: readfile, include copyfile
debugIt := true
debugIt := false   ;
; test_getNextLetterName(start,stop); 282+ lines in wavetanzen.eu.login.php.functions.inc.ahk
scriptNameShort := SubStr(A_ScriptName, 1 , - 4)
baseDir := "." ; the same folder not any special folder
sourceDir = %baseDir%
if(!FileExist(sourceDir)){
; thats possible to start more inside.
    baseDir := ""
    sourceDir :=""
}

typingAidSourcePath := sourceDir . "\Source"
typingAidSourcePath := ""
wordlistDirBase = %sourceDir%\..\Wordlists
wordlistDirBase = %sourceDir%\..\Wordlists
typingAidAHK := typingAidSourcePath  . "\TypingAid.ahk"
typingAidAHK := typingAidSourcePath  . "TypingAid.ahk"
wordlistActive := sourceDir . "\wordlist.txt"
wordlistOLD:=""

checkFilePathExistens1704291222(wordlistDirBase, destinDir, sourceDir, typingAidAHK)

; selfTestLoop1000(1)
; selfPerformanceTest()
; selfPerformanceTest2()

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
activeTitle:=""
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
while(true) {
SetTitleMatchMode,1
; IfWinNotExist,TypingAid - Active
DetectHiddenWindows,On ; if this is off it does not find in tray 27.04.2017
IfWinNotExist,TypingAid
{
    if(!FileExist(typingAidAHK)){
        MsgBox,:-( FileNotExist %typingAidAHK% `n 08.07.2017 14:06 17-07-08_14-06
        ExitApp
    }
    ; tooltip, RunWait %typingAidAHK%
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "Debuggging!  NOT Run % typingAidAHK " ) ; 18-01-20_18-56

    ; RunWait, % typingAidAHK 
    ; lll(A_LineNumber, A_ScriptName, "RunWait, % typingAidAHK")
}
SetTitleMatchMode,2 ; thats my default. do i need it later ? 08.07.2017 14:12


;If (A_TimeIdle < 50 || GetKeyState("ctrl", "P") || GetKeyState("Alt", "P") || GetKeyState("Shift", "P") || GetKeyState("LWin", "P") || GetKeyState("RWin", "P")  || GetKeyState("LButton", "P") ){
If (true){
    if(GetKeyState("ctrl", "P"))
        KeyWait, ctrl

    if(GetKeyState("Alt", "P"))
        KeyWait, Alt

    if(GetKeyState("Shift", "P"))
        KeyWait, Shift

    if(GetKeyState("LWin", "P"))
        KeyWait, RButton

    if(GetKeyState("RWin", "P"))
        KeyWait, RWin

        if(GetKeyState("LButton", "P"))
            KeyWait, LButton

        if(GetKeyState("RButton", "P"))
            KeyWait, RButton
}


global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%


    activeTitleOLD:=activeTitle
    activeClassOLD:=activeClass
    DetectHiddenText,Off
    WinGetActiveTitle, activeTitleREAL ; never manipulated name. 12.08.2017 00:10
    activeTitle := activeTitleREAL ; this will manipulated and reused in many other files and includes 12.08.2017 00:11
    WinGetClass, activeClass, % activeTitle
    activeTitle := RegExReplace(activeTitle, "`%", "_") ; should be easy to include variable later. some websites have suche long title with the procent in it. dont like it. simplify it. 16.03.2017 18:39

    if(!activeTitle ) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
        g_tooltipText = WinWaitNotActive, '%activeTitle%'=activeTitle  `n '%activeClass%' = activeClass  (line:%A_LineNumber%)
        ; sometimes buggy. it does not regognice a change ?? WinWaitActive [, WinTitle, WinText, Seconds, ExcludeTitle, ExcludeText]
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "Debugging: WinWaitNotActive, % activeTitle " )
        WinWaitNotActive, % activeTitle
    }

    activeClass := activeClassManipulation(activeClass, activeTitle)

    ;g_tooltipText = '%activeTitle%'=activeTitle  `n '%activeClass%' = activeClass
    ;Tooltip,%g_tooltipText% `n (from: %A_ScriptName%~%A_LineNumber%)

    ; thats only possibility proof. this should never happen

    ;msg = %activeTitleOLD% == %activeTitle% && %activeClassOLD% == %activeClass%
    ;lll(A_LineNumber, A_ScriptName, msg)


    g_tooltipText =

    filterFileName := "wordlistNameFilter.inc.ahk"

    ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    wordlistFilterPathNEWdir := wordlistDirBase . "\" . ActiveClass . "\"
    wordlistFilterPathNEW := wordlistFilterPathNEWdir . filterFileName
    if( !fileExist(wordlistFilterPathNEWdir) ){
                ActiveClass := "_globalWordListsGenerated"
                activeTitle := "_global"

                msg = !fileExist(wordlistFilterPathNEWdir === >%wordlistFilterPathNEWdir%<)  `n '%activeTitle%'=activeTitle  `n '%activeClass%' = activeClass `n (line:%A_LineNumber%)
                ;global g_doSaveLogFiles
                ;g_doSaveLogFiles := true
                ; if(g_doSaveLogFiles)
                ;lll( A_LineNumber, A_ScriptName, msg . "`n 17-07-29_14-18 ")

                ; impotend!!
                ; this line has to be includet into the this global:
                ; create own project dir or this|rr||ahk|WinGetClass,activeClass, A `n activeClass := RegExReplace( activeClass, "[\W_]+", "") `n d1 = %A_ScriptDir%\..\Wordlists\%activeClass% `n  FileCreateDir, %d1% `n run, %d1%
    }else{
        ; ; if(!fileExist(wordlistFilterPathNEW)
        ; dont nee to do anything here. i filter is not inside it will be automatically fixed some lines later :) 09.08.2017 19:59 17-08-09_19-59
        ; so dont be worry about it :) 09.08.2017 19:59 17-08-09_19-59
    }
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    if(activeTitleOLD == activeTitle && activeClassOLD == activeClass ){
        ; WinWaitNotActive, %activeTitle% ahk_class %activeClass%
        if(0){
        tip=WinWaitNotActive %activeTitleREAL%`n (%A_ScriptName%~%A_LineNumber%)
        ToolTip4sec(tip)
        WinWaitNotActive, %activeTitleREAL%
        }
        ; Sleep, 1000 ; 1 Sekunde
        continue
         FormatTime, timestampHHmmss, %A_now%,HH:mm:ss
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, regEx . " end of while(true)`n '" . activeTitle . "' = activeTitle `n  time:" . timestampHHmmss)
Msgbox,%activeTitle% `n`n %activeClass% `n`n  (%A_ScriptName%~%A_LineNumber%)
;ExitApp
    }


    wordlistOLD := wordlistNEW
    wordlistDir := wordlistDirBase . "\" . activeClass
    wordlistFilterPath := wordlistDirBase . "\" . filterFileName

    ;<<<<<<<<<<<<<<<<< run createEmptyFilterInNewDir <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ;<<<<<<<<<<<<<< createEmptyFilterInNewDir <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ; make sure we get no errors by including %wordlistFilterPath% ... create wordlist inside className folder
    wordlistFilterPathNEW := wordlistDirBase . "\" . ActiveClass . "\" . filterFileName
    ahkCode1 := getAhkCodeInsideFile(wordlistDir , wordlistFilterPathNEW  )
    createEmptyFilterInNewDir(       wordlistDir , wordlistFilterPathNEW , ahkCode1, isInternMsgTransportIsClipboard)

    ;

    if(debugIt) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
          ahkCode2 := getAhkCodeInsideFile(wordlistDirBase . "\FunnyWidgetHuHu" , wordlistDirBase . "\FunnyWidgetHuHu\" . filterFileName  ) 
    createEmptyFilterInNewDir(wordlistDirBase . "\FunnyWidgetHuHu" , wordlistDirBase . "\FunnyWidgetHuHu\" . filterFileName, ahkCode2, isInternMsgTransportIsClipboard) ; FunnyWidgetHuHu
    if(debugIt)
    MsgBox, '%ahkCode2%' = ahkCode2  `n (line:%A_LineNumber%) `n
    }
    ;>>>>>>>>>>>>>>>>> run createEmptyFilterInNewDir >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ;>>>>>>>>>>>>>> createEmptyFilterInNewDir >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    wordlistNEW := activeTitle
    wordlistNEW := simplifyNameOfWordlistNEWstep1( wordlistNEW )
;    lll(A_LineNumber, A_ScriptName,"wordlistDirBase= " . wordlistDirBase)
;    MsgBox, '%wordlistFilterPath%' = wordlistFilterPath  `n '%wordlistDir%' = wordlistDir `n '%wordlistDirBase%' = wordlistDirBase `n '%A_ScriptDir%' = A_ScriptDir `n (line:%A_LineNumber%) `n      ; thats the global wordlost
    wordlistFilterPath := wordlistDirBase . "\" . filterFileName
    if(1){ ; absolute path
        wordlistFilterPath2 := wordlistDir . "\" . filterFileName
        wordlistFilterPath2Abs := A_ScriptDir . "\" . wordlistFilterPath2
        StringReplace, wordlistFilterPath2Abs, wordlistFilterPath2Abs, \.\ , \
    }else
        wordlistFilterPath2 :=  wordlistDirBase . activeClass . "\" . filterFileName ; todo: doesent work :( 28.03.2017 20:20 17-03-28_20-20

; lll(A_LineNumber, A_ScriptName, "wordlistFilterPath2=" . wordlistFilterPath2 . " activeClass=" . activeClass . " filterFileName=" . filterFileName)

    if(!wordlistDir) {
        global g_lineNumberFeedback
        g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
        msgbox,!wordlistDir exitap (line:`%A_LineNumber`%) `n 17-03-19_14-06
        exitapp
    }
    if(!wordlistNEW)
        if(!activeTitle)
            wordlistNEW=noTitle
        else {
            global g_lineNumberFeedback
            g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
            m=!wordlistNEW `n '%activeTitle%' = activeTitle  `n  '%activeClass%' = activeClass `n'%wordlistDir%' = wordlistDir `n==> return (line:`%A_LineNumber`%) `n 17-03-19_14-09
            g_tooltipText:=m
            Msgbox,%m%`n (from: %A_ScriptName%~%A_LineNumber%) 17-08-11_23-42
           ; ToolTip5sec(m . " `n" . A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
            ; return ; we are inside a while loop ;) return probably makes now since there ;) 24.03.2017 20:29 17-03-24_20-29

sleepMili := 1000
msg =
(
no wordlistNEW and no activeTitle
we are inside a while loop

Sleep,%sleepMili%
WinWaitNotActive, %activeTitleREAL%,,15
continue
17-07-29_14-29
)
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll( A_LineNumber, A_ScriptName, msg . "`n 17-07-29_14-18 ")

            Sleep,%sleepMili%
            WinWaitNotActive, % activeTitleREAL,,15
            continue
        }
        if(false && !activeTitle) {
            global g_lineNumberFeedback
            g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
            msgbox,!activeTitle exitap (line:`%A_LineNumber`%) `n 17-03-19_14-19
            exitapp
        }

        if(!activeClass) {
            global g_lineNumberFeedback
            g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
            msgbox,!activeClass exitap (line:`%A_LineNumber`%) `n 17-03-19_14-15
            exitapp
        }

;<<<<<<<<<<<<< demoData =  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    demoData =
(
SetTitleMatchMode, 1
activeTitle := RegExReplace(activeTitle, "`%.*", "") ; should be easy to include variable later. some websites have suche long title with the procent in it. dont like it. simplify it. 16.03.2017 18:39
activeTitle := RegExReplace(activeTitle, "```%.*", "") ; should be easy to include variable later. some websites have suche long title with the procent in it. dont like it. simplify it. 16.03.2017 18:39
if`( false && A_ScriptName == "temp.ahk"`) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   wordlistDir = Wordlists\FunnyWidgetHuHu
   activeTitle = lustiger landkaese
   activeClass = FunnyWidgetHuHu
} else {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   wordlistDir = %wordlistDir%
   activeTitle = %activeTitle%
   activeClass = %activeClass%
   wordlistNEW = %activeTitle%
}
)
;>>>>>>>>>>>>>>>  demoData =  >>>>>>>>>>>>>>>>>>>>>>><>>>>>>>



    ahkSource := ";" . "this file was generated by " . A_ScriptFullPath  . " `n"
    ahkSource .= "g_lineNumberFeedback=" . A_ScriptName . "~" . A_ThisFunc . "~" . A_LineNumber . " token363 `n"
    ahkSource .= "#" . "SingleInstance, force"  . " `n"
    ahkSource .= "#" . "NoTrayIcon" . " `n"
    global g_doSaveLogFiles
    global g_doRunLogFiles
    ;global g_doSaveLogFiles := true
    ;g_doRunLogFiles := false

    ahkSource .= "global g_doSaveLogFiles" . " `n"
    ahkSource .= "global g_doRunLogFiles" . " `n"

    ahkSource .= "g_doSaveLogFiles := " . g_doSaveLogFiles . " `n"
    ahkSource .= "g_doRunLogFiles := " . g_doRunLogFiles . " `n"


    ahkSource .= demoData  . " `n"
    ; ahkSource .= "#" . "Include, " . wordlistFilterPath . "  `; thats the subfolder  wordlost inside class `n"


        ahkSource .= "wordlistFilterPath2 = " . wordlistFilterPath2 . " `n"
        ahkSource .= "wordlistFilterPath2Abs = " . wordlistFilterPath2Abs . " `n"
        ahkSource .= "fileEx := FileExist ( wordlistFilterPath2Abs ) `n"
        ; ahkSource .= "KeyWait Control  `; Wartet darauf, dass sowohl STRG als auch ALT losgelassen wird. `n"
        ahkSource .= "if( !fileEx ) { `n"
        ahkSource .= "message = :(  ``n '%wordlistFilterPath2%'  ``n '%wordlistFilterPath2Abs%'  ``n existiert nicht ( `%fileEx%` = fileEx ) . ``n ``n message with id (1704171514) was copied to the Clipboard. Sor you probably could find this source code little bit easier. ``n (from: %A_ScriptName%~%A_LineNumber%) `n "
        ahkSource .= "tooltip, `%message`% `n "

        ahkSource .= "Clipboard = `%message`%  `n "
        ahkSource .= "Msgbox,4 , :( wordlistNameFilter.inc.ahk not found , `%message`% , 4  `n "

        ahkSource .= "Sleep, 4000 `n"
        ahkSource .= "ExitApp  `n"
        ahkSource .= "} `n"
        ahkSource .= "#" . "Include *i " . wordlistFilterPath2Abs . "  `; thats the subfolder  wordlost inside class `n"
 ;   ahkSource .= "#" . "Include *i " . wordlistFilterPath2 . "  `; thats the subfolder  wordlost inside class `n" 

    ahkSource .= "varInjects1 := mvarInjects(wordlistDir, wordlistNEW, activeClass, activeTitle) `n"
    ; ahkSource .= "wordlistDir = " . wordlistDir  . " `n"
    ahkSource .= "wordlistOLD = " . wordlistOLD . " `n"
    ahkSource .= "typingAidSourcePath = " . typingAidSourcePath . " `n"
    ahkSource .= "wordlistActive  = " . wordlistActive  . " `n"
    ahkSource .= "wordlistOLDbackup( wordlistDir , wordlistOLD)" . " `n"
    ahkSource .= "wordlistOLDdisable( typingAidSourcePath, wordlistActive )" . " `n"
    ahkSource .= "wordlistNEWactivate( wordlistDir , wordlistNEW, wordlistActive, typingAidSourcePath, activeClass , activeTitle)" . " `n"
    ahkSource .= "varInjects2 := mvarInjects(wordlistDir, wordlistNEW, activeClass, activeTitle) `n"
    if(debugIt)
        ahkSource .= "MsgBox, , debugIt , `% varInjects1 . "" ``n "" . varInjects2 . "" ``n wordlistNEW = '"" . wordlistNEW . ""'  ``n (lineCaller:" . A_LineNumber . ") ``n "" ,9 `n"
    ahkSource .= "ExitApp" . " `n"
    ahkSource .= "#" . "Include, inc_ahk\\Typing_Aid_everywhere_multi_clone.inc.ahk  `; `n"
    ; createGLOBALwordlistNameFilterIfNotExist(wordlistDirBase ) ;  its possible to put it out of the loop, but if user delete it we get ugly errors. better gife a chance to ceate it imediatly again 06.03.2017 19:19
    ; wordlistNEW := getWordlistNEWfromPluginIfExist(wordlistDir, wordlistNEW, activeClass, activeTitle   ) ; ; thats plugin. you could filter, reduce the complexety of new file names
    ; ToolTip4sec(wordlistNEW . "= wordlistNEW `n " . A_LineNumber ) ;
    ; MsgBox, '%wordlistNEW%' = wordlistNEW  `n (line:%A_LineNumber%) `n
    DetectHiddenWindows,On
    SetTitleMatchMode,1
    ; IfWinNotExist,temp.ahk
    ; IfNotExist,temp.ahk
;~     Tooltip, %ahkSource% `n (from: %A_ScriptName%~%A_LineNumber%)
;~     Msgbox,`n (from: %A_ScriptName%~%A_LineNumber%)
    
    IfWinNotExist,temp.ahk
    {
        KeyWait Control  ; Wartet darauf, dass sowohl STRG als auch ALT losgelassen wird.
        FileWriteAndRun( ahkSource , "temp.ahk" ) ; wozu ? 13.08.2017 10:52
    } else {
        KeyWait Control  ; Wartet darauf, dass sowohl STRG als auch ALT losgelassen wird.
        Tooltip, WinWaitClose   temp.ahk `n (from: %A_ScriptName%~%A_LineNumber%)
        WinWaitClose,temp.ahk,,5
        IfWinExist,temp.ahk
            MsgBox,4 ,Oops , :-O WinExist temp.ahk `n `n %A_ScriptName%~%A_LineNumber%,5
    }
    ; FileDeleteAsyncDynaRun(A_WorkingDir . "\temp.ahk" , 500)
    Sleep,40 ; you need to use it minimum of 3 seconds

global g_doSaveLogFiles
 if(g_doSaveLogFiles)
    lll("`n" . A_LineNumber, A_ScriptName, "FileDeleteAsyncDynaRun(temp.ahk , 4000)")

    g_tooltipText = WaitNotActive, %activeTitle%
    ; WinWaitNotActive [, WinTitle, WinText, Seconds, ExcludeTitle, ExcludeText]
    g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

DetectHiddenText,Off
    ; WinWaitNotActive, ahk_class %activeClass%

        global g_nextCriticalCommandString ; checkCriticalCommand()
        g_nextCriticalCommandString := "327:WinWaitNotActive, %activeTitle%" ; checkCriticalCommand()

        SetTimer, checkCriticalCommandLbl, On
        WinWaitNotActive, %activeTitle%
        SetTimer, checkCriticalCommandLbl, Off

        g_nextCriticalCommandString := ""


    ; WinWaitNotActive, %activeTitle% ahk_class %activeClass% ; seems not work alway. be careful !! with that :( 29.04.2017 22:13
;    WinWaitNotActive, %activeTitle% %activeClass%
    g_tooltipText = WinWaitNotActive, CopyQ
    g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

    WinWaitNotActive,CopyQ , , 9
    g_tooltipText = WinWaitNotActive,- Everything
    g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%

    WinWaitNotActive,- Everything , , 9 ; ahk_class EVERYTHING

    if( debugIt || 0) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
        l = ______________________________________________________________ `n ; %l%
    MsgBox, '%activeTitle%' = activeTitle  `n %l% '%varInjects%' = varInjects  %l% `n (line:%A_LineNumber%) `n  '%ahkSource%' = ahkSource of temp.php `n (line:%A_LineNumber%) `n
    }

  runTypingAidAHKifNotExist( typingAidAHK )

    if(false){
    FormatTime, timestampHHmmss, %A_now%,HH:mm:ss
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, regEx . " end of while(true)`n '" . activeTitle . "' = activeTitle `n  time:" . timestampHHmmss)
    }
} ; end of while(true)
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




return  ; probably redundant. its more secure if we do that.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
createGLOBALwordlistNameFilterIfNotExist(wordlistDirBase ) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   isDebuggingOverWriteAlwayUserUpdatesWithThisScript := false
   filterFileName := "wordlistNameFilter.inc.ahk"
 wordlistFilterPath := wordlistDirBase . "\" . filterFileName 
 if( isDebuggingOverWriteAlwayUserUpdatesWithThisScript ) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   ;   ;~ FileWrite(ahkCode, wordlistFilterPath) ; debbugging style. always overwrite it by the script. overwrite user updates in the script 05.03.2017 13:56
   FormatTime, timestamp, %A_now%,yy-MM-dd_HH-mm
    wordlistFilterPathBackup := wordlistDirBase . "\" . timestamp . "_" . filterFileName 

   FileCopy, % wordlistFilterPath, % wordlistFilterPathBackup
   FileDelete, % wordlistFilterPath
   Sleep,100
} 
 if(!fileExist(wordlistFilterPath)) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
; the following gives no errors

ahkCodeInsideFile =
(
`; GLOBAL FILTER / ROUTING
`; this file was generated %A_Now% by: `n`;  %A_ScriptFullPath% 
`; if you want you could update it by yourself. it will not overwritten by %A_ScriptName% 
`; if you delete it it will be generated again.
`; you could use it as a global filter/routing called from your special .../className/%filterFileName%

#SingleInstance, force
`; if you want you could use the follwong global variables fot calculating you new wordlistNEW : wordlistDir, wordlistNEW, activeClass, activeTitle  

if`(A_ScriptName == "wordlistNameFilter.inc.ahk" `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%  ; thats developer mode. this script is not includet. 08.03.2017 09:14
activeClass := "ChromeWidgetWin1" 
activeTitle  = I would like to hire a PHP Developer | Codeigniter | CSS | HTML5 | JSON | PHP - Google Chrome 
activeTitle := wordlistNEW
}


if `(!wordlistNEW `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
    m = ERROR wordlistNEW is EMPTY: ``n ``n '`%wordlistNEW`%' = wordlistNEW  ``n   17-03-05_14-51 ``n ``n '%wordlistFilterPath%' = wordlistFilterPath  ``n `(line:`%A_LineNumber`%`) ``n `%A_ScriptFullPath`% = A_ScriptFullPath   `(line: `%A_LineNumber`%` token50)
   Clipboard := m
    tooltip, ERRORmessage is copied to the >>Clipboard<< `%m`% 
    sleep,5000
    MsgBox, ERRORmessage is copied to the >>Clipboard<< , `%m`% , 7
    exitapp
 } 
if `(!wordlistDir `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
    MsgBox, ERROR wordlistDir is EMPTY 17-03-19_11-52
    exitapp
}
;
 if`(activeClass == "SciTEWindow" `) 
   wordlistNEW := "_global"
   else if `( instr`( activeTitle , ".ahk"`)  `) 
      wordlistNEW := "..\SciTEWindow\_global"
 
 else if `( activeClass == "ChromeWidgetWin1" `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   
`;   I would like to hire a PHP Developer | Codeigniter | CSS | HTML5 | JSON | PHP - Google Chrome ahk_class Chrome_WidgetWin_1 
   
 if `( instr`( activeTitle , "Benachrichtigung:"`)  &&  RegExMatch`( activeTitle , "Gmail"`)   `) 
      wordlistNEW := "Benachrichtigung_Google_Chrome"
   
 else if `(  RegExMatch`( activeTitle , "\bGmail\b"`) `) 
      wordlistNEW := "Gmail_Google_Chrome"
    
   else if `( RegExMatch`( activeTitle , "`(Messenger|facebook`)"  `)    `)    
      wordlistNEW := "Facebook_Google_Chrome"

   else if `( RegExMatch`( activeTitle , "i`)`(Zimmer|Wohnung`)"  `)    `)    
      wordlistNEW := "Zimmer_Wohnung_Google_Chrome"

   else if `( ! RegExMatch`( activeTitle , "`(Threema Web`)"  `)    `)    
      wordlistNEW := "_global.txt"
   
   } else
 {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
 wordlistNEW := RegExReplace`( wordlistNEW, "`(SciTE4AutoHotkey|PhpStorm`)\.+" , ""`)  
 }
wordlistNEW := RegExReplace`( wordlistNEW, ".`(ahk|txt|htm|pdf`)\.+" , ""`)  
 wordlistNEW := RegExReplace`( wordlistNEW, "i`)[^\w\d_-]+" , "_"`)  
 wordlistNEW := RegExReplace`( wordlistNEW, "[_-]{2,}" , "_"`)  
 wordlistNEW := RegExReplace`( wordlistNEW, "^[_-]+" , ""`)  
 wordlistNEW := RegExReplace`( wordlistNEW, "[_-]+$" , ""`)  

 if`( SubStr`( wordlistNEW , -3 `) <> ".txt" `)
   wordlistNEW .= ".txt"
 
`; Clipboard := wordlistNEW `;  we dont transport usually inside this global file via clipboard 06.03.2017 19:41

`;  MsgBox,  '`%wordlistNEW`%' = wordlistNEW  ``n  17-03-06_18-48 ``n ``n `( line: `%A_LineNumber`%`) 


if`(A_ScriptName == "wordlistNameFilter.inc.ahk" `) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%   ; thats developer mode. this script is not includet. 08.03.2017 09:14
; Clipboard := wordlistNEW ;  we dont transport usually inside this global file via clipboard 06.03.2017 19:41
 MsgBox,  '`%wordlistNEW`%' = wordlistNEW  ``n `%activeClass`% = activeClass ``n  17-03-06_18-48 ``n ``n `( line: `%A_LineNumber`%`)
}
)
 ; MsgBox, % RegExReplace( " -- - -___ _ _ _ __", "[_\s]{2,}" , "_"`)  
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

 FileAppend,  % ahkCodeInsideFile , % wordlistFilterPath ; wordlistNameFilter.inc.ahk
} 
return 
}





;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
getWordlistNEWfromPluginIfExist(wordlistDir, wordlistNEW, activeClass, activeTitle   ) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   m = '%wordlistNEW%' = wordlistNEW  `n '%wordlistDir%' = wordlistDir  `n  '%activeTitle%' = activeTitle  `n 
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.ahk" ,m)

   lineB := "<<<<<<<<<<<<<<<<<<<<<<`n"
   lineE := ";>>>>>>>>>>>>>>>>>>>>>>`n"

 wordlistFilterPath := wordlistDir . "\wordlistNameFilter.inc.ahk"
 if(!fileExist(wordlistFilterPath)) {
   ahkCodeInsideFile := getAhkCodeInsideFile(wordlistDir, wordlistFilterPath )
   FileAppend,  % ahkCodeInsideFile , % wordlistFilterPath ; wordlistNameFilter.inc.ahk
   if(!FileExist(wordlistFilterPath))
      MsgBox, :-( `n !FileExist(wordlistFilterPath)) `n  (line:%A_LineNumber%)  '%wordlistFilterPath%' = wordlistFilterPath  `n (line:%A_LineNumber%) `n 
} else
   FileRead, ahkCodeInsideFile, % wordlistFilterPath
; ahkCode := encodeAHKchars(ahkCode)
varInjects := mvarInjects(wordlistDir, wordlistNEW, activeClass, activeTitle)
ahkCode := RegExReplace( ahkCodeInsideFile , "`;\s*dontDeleteThisPlaceholder" , varInjects )  ; dontDeleteThisPlaceholder is definde since 17-03-06_10-25 inside the global filter

 ClipboardBackup = 17-03-05_17-17
 ; ClipboardBackup = %Clipboard% ; old destrois eventually bin clipboards
 ClipboardBackup := ClipboardAll
 if(ClipboardBackup  == "17-03-05_17-17")
   MsgBox, :(  (line:%A_LineNumber%)  17-04-02_14-52
   
   m = '%wordlistNEW%' = wordlistNEW  `n '%activeTitle%' = activeTitle  `n 
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.ahk" , "`n" . m)
wordlistNEW := DynaRunGetClipboard(ahkCode)
   m = '%wordlistNEW%' = wordlistNEW  `n '%activeTitle%' = activeTitle  `n 
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, "Typing_Aid_everywhere_multi_clone.ahk" , "`n" . m)

worlistExtension := SubStr(wordlistNEW, -3)
if( worlistExtension  <> ".txt" ) {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   m = '%wordlistNEW%' = wordlistNEW  `n 
      ToolTip5sec(A_LineNumber . "THATS VERY QUICK AND DIRTY AND MAYBEEEE IT HALPS NOT!!!! " . A_ScriptName . " " . m) ;
; return,  "superSimple.txt"
      ; ################################################
      ; ################################################
      ; ################################################
      ; ################################################

   ClipboardBackup1703052115 = %Clipboard%
   ;~ clipboard := wordlistFilterPath
   disableCopyQ() ; enableCopyQ() ;
   clipboard := varInjects
   
   msg = a bug in your  `n %wordlistFilterPath%  `n this path is now copied to your Clipboard (line:%A_LineNumber%) `n ? `n '%ClipboardBackup%' = ClipboardBackup  `n 
   if( ClipboardBackup == wordlistNEW)
      m2 = ClipboardBackup == wordlistNEW == '%wordlistNEW%'  <=== thats bad :-( `n 
   m3 := " StrLen(wordlistNEW)=" . StrLen(wordlistNEW) . "`n"
   MsgBox, :-( ERROR: (line:%A_LineNumber%)  `n%m2% %m3% worlistExtension != .txt ='%worlistExtension%' `n wordlistNEW='%wordlistNEW%'   `n`ncode=`n %lineB%%ahkCode% `n%lineE%  `n  %msg% `n (line:%A_LineNumber%) 
   Clipboard = %ClipboardBackup1703052115%
   enableCopyQ() ; enableCopyQ() ;
}

if(false)
Loop,20
 {
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
Clipboard = %ClipboardBackup%
cExtension := SubStr(Clipboard, -3)
if( worlistExtension  <> ".txt" )
   break
if( Clipboard == ClipboardBackup )
   break
Sleep,50
}



; Clipboard := wordlistFilterPath
; MsgBox, '%ahkCode%' = ahkCode  `n  `n '%ahkCodeInsideFile%' = ahkCodeInsideFile  `n  `n  '%wordlistNEW%' = wordlistNEW  `n (line:%A_LineNumber%) `n 
; MsgBox, '%ahkCode%' = ahkCode  `n  `n '%ahkCodeInsideFile%' = ahkCodeInsideFile  `n  `n  '%wordlistNEW%' = wordlistNEW  `n (line:%A_LineNumber%) `n 
;~ ToolTip, %ahkCode% , 10,10
;~ Sleep,1000
return wordlistNEW
}

createEmptyFilterInNewDir(wordlistDir, wordlistFilterPath,ahkCode, isInternMsgTransportIsClipboard){
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
if(!FileExist(wordlistDir)){
global g_lineNumberFeedback
 g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
   FileCreateDir, % wordlistDir
   ;~ FileAppend, , % wordlistFilterPath
}
;~ if(!isInternMsgTransportIsClipboard) 
   if(!FileExist( wordlistFilterPath ) ){
      g_lineNumberFeedback=%A_ScriptName%~%A_ThisFunc%~%A_LineNumber%
      FileAppend, % ahkCode , % wordlistFilterPath
    }
return true
}
   

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<




tooltipABS:
; IfGreater, A_TimeIdle, 300000, Reload  ; MsgBox, The last keyboard or mouse activity was at least 5 minutes ago.
;    Reload ; todo: quick and dirty ... script sometimes hangs 22.03.2017 11:42 17-03-22_11-42
; IfGreater, A_TimeIdle, 600000, MsgBox, The last keyboard or mouse activity was at least 10 minutes ago.
if(!do_g_tooltipText)
    return
    if(!g_tooltipText)
      Return
    if(dog_lineNumberFeedback)
        tooltip, % "X " . g_tooltipText . "`n" . g_lineNumberFeedback , 110 , 122
    else
        tooltip, % "X " . g_tooltipText , 110 , 122

    if(!Xtooltip) {
        SetTitleMatchMode, 2
;~         IfWinActive, % A_ScriptName
            WinGetPos, Xtooltip, Ytooltip, W, H, ahk_class tooltips_class32
    }
    else
        WinMove, ahk_class tooltips_class32, , % abs(Xtooltip), % abs(Ytooltip) ; thats the only chance to move tooltip to absolute sceen position.

~LButton::
 ; tooltip close by clicking
    WinGetPos, X, Y, W, H, ahk_class tooltips_class32
    MouseGetPos, mX, mY
    if (mX >= X && mX <= (X+W)) && (mY >= Y && mY <= (Y+H)){
        g_tooltipText:=
		ToolTip
    }
    return

Return

AbsolutePath(AbsolutPath, RelativePath, s="\") {
    ; its actually not used inside of this script 24.03.2017 05:27 ,
    return
    len := InStr(AbsolutPath, s, "", InStr(AbsolutPath, s . s) + 2) - 1   ;get server or drive string length
    pr := SubStr(AbsolutPath, 1, len)                                     ;get server or drive name
    AbsolutPath := SubStr(AbsolutPath, len + 1)                           ;remove server or drive from AbsolutPath
    If InStr(AbsolutPath, s, "", 0) = StrLen(AbsolutPath)                 ;remove last \ from AbsolutPath if any
        StringTrimRight, AbsolutPath, AbsolutPath, 1
    If InStr(RelativePath, s, "", 0) = StrLen(RelativePath)               ;remove last \ from RelativePath if any
        StringTrimRight, RelativePath, RelativePath, 1
    If InStr(RelativePath, s) = 1                                         ;when first char is \ go to AbsolutPath of server or drive
        AbsolutPath := "", RelativePath := SubStr(RelativePath, 2)            ;set AbsolutPath to nothing and remove one char from RelativePath
    Else If InStr(RelativePath,"." s) = 1                                 ;when first two chars are .\ add to current AbsolutPath directory
        RelativePath := SubStr(RelativePath, 3)                               ;remove two chars from RelativePath
    Else {                                                                ;otherwise
        StringReplace, RelativePath, RelativePath, ..%s%, , UseErrorLevel     ;remove all ..\ from RelativePath
        Loop, %ErrorLevel%                                                    ;for all ..\
            AbsolutPath := SubStr(AbsolutPath, 1, InStr(AbsolutPath, s, "", 0) - 1)  ;remove one folder from AbsolutPath
      }
    Return, pr . AbsolutPath . s . RelativePath                             ;concatenate server + AbsolutPath + separator + RelativePath
  }


  ListGlobalVars()  {
        ; its actually not used inside of this script 24.03.2017 05:27 ,
    return

      static hwndEdit, pSFW, pSW, bkpSFW, bkpSW
; https://autohotkey.com/board/topic/20925-listvars/#entry156570
      if !hwndEdit
      {
          dhw := A_DetectHiddenWindows
          DetectHiddenWindows, On
          Process, Exist
          ControlGet, hwndEdit, Hwnd,, Edit1, ahk_class AutoHotkey ahk_pid %ErrorLevel%
          DetectHiddenWindows, %dhw%

          astr := A_IsUnicode ? "astr":"str"
          ptr := A_PtrSize=8 ? "ptr":"uint"
          hmod := DllCall("GetModuleHandle", "str", "user32.dll", ptr)
          pSFW := DllCall("GetProcAddress", ptr, hmod, astr, "SetForegroundWindow", ptr)
          pSW := DllCall("GetProcAddress", ptr, hmod, astr, "ShowWindow", ptr)
          DllCall("VirtualProtect", ptr, pSFW, ptr, 8, "uint", 0x40, "uint*", 0)
          DllCall("VirtualProtect", ptr, pSW, ptr, 8, "uint", 0x40, "uint*", 0)
          bkpSFW := NumGet(pSFW+0, 0, "int64")
          bkpSW := NumGet(pSW+0, 0, "int64")
      }

      if (A_PtrSize=8) {
          NumPut(0x0000C300000001B8, pSFW+0, 0, "int64")  ; return TRUE
          NumPut(0x0000C300000001B8, pSW+0, 0, "int64")   ; return TRUE
      } else {
          NumPut(0x0004C200000001B8, pSFW+0, 0, "int64")  ; return TRUE
          NumPut(0x0008C200000001B8, pSW+0, 0, "int64")   ; return TRUE
      }

      ListVars

      NumPut(bkpSFW, pSFW+0, 0, "int64")
      NumPut(bkpSW, pSW+0, 0, "int64")

      ControlGetText, text,, ahk_id %hwndEdit%

      RegExMatch(text, "sm)(?<=^Global Variables \(alphabetical\)`r`n-{50}`r`n).*", text)
      return text
  }

checkCriticalCommandLbl:
    checkCriticalCommand()
Return

checkCriticalCommand(sec := 2 ){
;return

global g_nextCriticalCommandString
;        g_nextCriticalCommandString :="327:WinWaitNotActive, %activeTitle%" ; checkCriticalCommand()
        global g_nextCriticalCommandTimeIdle ; checkCriticalCommand() WinWaitNotActive, %activeTitle% %activeClass%

if(0){ ; check if this is arrived 30.04.2017 09:43
    Msgbox,n (%A_ScriptName%~%A_LineNumber%) :-)
    ExitApp
}
    ; is this function triggerd evver onee time? i dont know if setinterval works if the script stucks. may we cant do anything then from inside the script. needs temp ahk. 30.04.2017 09:25
    global g_nextCriticalCommandString ; checkCriticalCommand()
    global g_nextCriticalCommandTimeIdle ; checkCriticalCommand()
    ; g_nextCriticalCommandString := "104:SuspendOn()"

    if(g_nextCriticalCommandString == "327:WinWaitNotActive, %activeTitle%"){
        if(!g_nextCriticalCommandTimeIdle || g_nextCriticalCommandTimeIdle < 1)
            g_nextCriticalCommandTimeIdle := A_TimeIdle
        else if (g_nextCriticalCommandTimeIdle * 1000 > sec)
        {
             global activeTitleOLD
             global activeTitle
             global activeClassOLD
             global activeClass


             if( activeTitle == activeTitleOLD && activeClass <> activeClassOLD ){
                 ; if this ever happend ? of is this function ovsolete? 30.04.2017 09:59 :D i dont knew
                 ; Msgbox, title is the same but class differs. a new wordlist shod be used. (%A_ScriptName%~%A_LineNumber%)

                 if ( 0) {
                 ; yeeeaaahhh now it happens first time 30.04.2017 10:54 :)
                 ; for testing i created this code:
                     WinSetTitle,main.ts.txt - Editor,, main.ts
                     WinSetTitle,main.ts.txt - WordPad,, main.ts
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "ExitApp")
                     ExitApp
                 }
global g_doSaveLogFiles
 if(g_doSaveLogFiles)
lll(A_LineNumber, A_ScriptName, "reload 17-08-04_14-42")
global g_doRunLogFiles
 if(g_doRunLogFiles)
run,log\%A_ScriptName%.log.txt
                 Reload
             }
             if( 0 ) ; fo debugging really useful.
            tooltip,%activeTitle%`n ?= `n%activeTitleOLD% `n `n  %g_nextCriticalCommandTimeIdle% = g_nextCriticalCommandTimeIdle `n (%A_ScriptName%~%A_LineNumber%)
        }
    } else
        g_nextCriticalCommandTimeIdle := 0
    return

; g_nextCriticalCommandString := "120:SuspendOn()"
; g_nextCriticalCommandTimeIdle := A_TimeIdle
}







  
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk ; A_ScriptDir
#Include %A_ScriptDir%\inc_ahk\Typing_Aid_everywhere_multi_clone.inc.ahk


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
couldIfindMyself:
DetectHiddenWindows,On
IfWinNotExist,% A_ScriptName
{
   ToolTip, i cant find myself `n ( %A_ScriptName% ) `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n (programmed at 11.07.2017 15:12)
   ; thats a totally stupid situation, but it happen often.
   ; not always but often.
   ; then i think no autohotkey scrpt should start oter scripts. 
   ; its to dangerous that a stack overflow happens.
   ; may one good workaround could be, wait a lang time and then try it again or pause the script for ever..... and ever ...
   suspend,On 
   min := 60 * 1000
   ; sleep, % 9 * min 
   ; reload 
   Pause
}
FOUNDmyselfCounter += 1
if(false){
ToolTip, i FOUND :-) myself yeaah `n not a totally idiot :) `n ( %A_ScriptName% )  `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n  (programmed at 11.07.2017 20:26)
}
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

