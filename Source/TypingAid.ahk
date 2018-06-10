; Indentation_style: https://de.wikipedia.org/wiki/Einrueckungsstil#SL5small-Stil
; # ErrorStdOut

#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
; Process, Priority,, H
Process, Priority,, Low
SetBatchLines, -1 ; Use SetBatchLines -1 to never sleep (i.e. have the script run at maximum speed). The default setting is 10m
; SetBatchLines, 10
SetKeyDelay, -1, -1
SetWinDelay, -1 ; Sets the delay that will occur after each windowing command, such as WinActivate.
; SetWinDelay, 10
SetControlDelay, -1 ; A short delay (sleep) is done automatically after every Control command that changes a control, namely Control, ControlMove, ControlClick, ControlFocus, and ControlSetText (ControlSend uses SetKeyDelay).
; SetControlDelay, 10


#Include %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

lll(A_LineNumber, A_LineFile, "hi from " A_LineFile)

fnReceive_wordlistAddress := Func("Receive_wordlistAddress").Bind(1)
; OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA  ; deprecated 15.02.2018 10:26
; ObjRegisterActive(Stuff, "{93C04B39-0465-4460-8CA0-7BFFF481FF98}")
ObjRegisterActive(fnReceive_wordlistAddress, "{93C04B39-0465-4460-8CA0-7BFFF481FF98}")  ; Receive_wordlistAddress(CopyOfData){
class Stuff{
    static abc := 1
    callFunction( name, p* ) { ;allows you to call any function in this script
        abc := func( name )
       %abc%( p* )
    }
}

global g_config := { list:{ change: { stopRexExTitle: false } } }
; g_config["list"]["change"]["stopRexExTitle"]))

global g_ListBoxX
global g_ListBoxY
g_ListBoxX := 0 ; if g_ListBoxX (not false > 0) it never usses CaretXorMouseXfallback . if you want go back to default, reload the
g_ListBoxY := 0 ; if g_ListBoxX (not false > 0) it never usses CaretXorMouseXfallback . if you want go back to default, reload the


global g_method := "Clipboard"

global g_regExReplaceInVisibleLine := "^([\w\d_-]+).*" ; show only first text , numers _ or -
global g_regExReplaceInVisibleLine := "^([^|]+).*" ; the string only before the first "|"

global g_regExReplaceInVisibleLine := "^[_]*([^|\n]+)[^\.\n]*?([^|\n]{3,})$" ; https://autohotkey.com/boards/viewtopic.php?p=215425#p215425 https://regex101.com/r/GQjPg0/1
; the string only before the first "|"
demoTestData =
(
___your library open|rr||ahk|run,SourceTree.txt
autoload.ahk
b&w Wordlists|r|E:\fre\Wordlists\TscShellContainerClass
Visual Basic|rr||ahk|q=b&w Wordlists
Recent|r|C:\Users\bla\AppData\Roaming\Microsoft\Windows\Recent
last used Recent|rr||ahk|q=Recent
)


global g_sending_is_buggy := false ; Solved: SendPlay. 29.07.2017 11:21
global g_doSaveLogFiles := false
global g_doRunLogFiles := false

global wordlist
global WordlistOLD
global activeTitle:=""

global g_doAskBevoreChangingWordlist := false ; <== buggy dont know whey 19.03.2018 23:50
global g_doAskBevoreChangingWordlist := true ; <== works preetty nice :) 19.03.2018 23:51
global g_minBytesNeedetToAskBevoreChangingWordlist := 81234 ; <== Minimum bytes. then will be asked before the change 20.03.2018 18:22
if(1 && InStr(A_ComputerName,"SL5"))
    g_minBytesNeedetToAskBevoreChangingWordlist := 812345 ; <== Minimum bytes. then will be asked before the change 20.03.2018 18:22

global g_FLAGmsgbox := false

global g_wordListID



global g_ListBoxFontSize := 16 ; works
global g_ListBoxFontSize := 2 ; work but its so small i could not read it too
global g_ListBoxFontSize := 8 ; work but its so small i could not read it too too tool
listBoxFontSizeOLD := g_ListBoxFontSize

wordlist:=wordlistActive

feedbackMsgBoxCloseAllWindows()

temp := "___________________________________`n"
global g_doSaveLogFiles

    lll("`n" . A_LineNumber, A_ScriptName, temp . " STARTING first lines :) ")

RegRead, wordlist, HKEY_CURRENT_USER, SOFTWARE\sl5net, wordlist ; todo: 02.03.2018 12:55 18-03-02_12-55
if(!fileExist(wordlist)){ 
    ; addet 26.4.2018 12:58 becouse of mistourios things
    ; deactivated 10.06.2018 08:36 becouse messeage disturbing every new installed is first time started.
    ; and becouse dont know the use of this lines?
    msg = :( !fileExist(%wordlist%) `n (%A_LineFile%~%A_LineNumber%)
    lll("`n" . A_LineNumber, A_ScriptName, msg)
    if(false){
        Msgbox,% msg
        clilpboard := msg
        sleep,5000
    }
}


maxLinesOfCode4length1 := 900 ;

SetTimer, saveIamAllive, 8000 ; setinterval
SetTimer,checkInRegistryChangedWordlistAddress,1000 ; RegRead, wordlistActive, HKEY_CURRENT_USER, SOFTWARE\sl5net, wordlist
SetTimer,checkWordlistTXTfile_sizeAndModiTime,3000

SetTimer,doListBoxFollowMouse,off
;SetTimer,doListBoxFollowMouse,off
Hotkey, WheelUp, off
Hotkey, WheelDown, off


#SingleInstance,Force ; thats sometimes not working : https://autohotkey.com/boards/viewtopic.php?f=5&t=1261&p=144860#p144860

DetectHiddenWindows,Off
SetTitleMatchMode,1
scriptName := SubStr( A_ScriptName , 1 , Strlen(A_ScriptName)-4)
#NoTrayIcon ; make it unvisible #NoTrayIcon ; make it unvisible Wozu???????????? dar?ber kanne es erkennen ob nicht schon eine andere instanz l?uft... es w?rde sonst denken eine andere l?uft schon???? 16.11.2017 09:06 17-11-16_09-06

IfWinExist, %scriptName% - Active ; maybe  work 26.04.2017 15:28
{
 ; Msgbox,%scriptName% ?= %g_ScriptTitle% `n (%A_LineFile%~%A_LineNumber%)
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "exit ")
   ExitApp ; this protect hopefully the scipt from building 100drets of instances.
   ; this was happend during looking videos. tv- mediathek oder sometimes youtube.
}
Menu, Tray, Tip, %g_ScriptTitle% - Inactive ; make it visible again
WinShow,%g_ScriptTitle%
DetectHiddenWindows,On ; if this is off it does not find the tool in tray bar 27.04.2017 12:04
SetTitleMatchMode,2  ; if this is 1 it does not find the tool in tray bar 27.04.2017 12:04

; DetectHiddenWindows,On
; IfWinNotExist,Could not close the previous instance of this script_autoCloser.ahk
;    run,%A_ScriptDir%\Could not close the previous instance of this script_autoCloser.ahk

;WinWait,Typing_Aid_everywhere_multi_clone.ahk ahk_class AutoHotkey

g_nextCriticalCommandString := "104:Suspend, On"
; Disables all hotkeys

;msgbox,% A_LineNumber " " A_LineFile "`n SuspendOn()`n"
Suspend, On ; wieder (10.07.2017 11:47) auskommentiert weils mir zu oft auf suspand on war. wehr oft wenn ich auf skype gewecheelt habe. hoffe die anderen bugFix haben den Seiteneffekt das ich dieses nicht mehr brauche.

;WinSetTitle, TypingAid - Active, , TypingAid - Active wait4sec
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if(0){
f:= "problemHandler104SuspendOn.ahk"
f:= "problemHandler104SuspendOn.ahk"
ff := A_ScriptDir . "\" . f
DetectHiddenWindows,On
if( !WinExist(f) ){
   run,%ff% 
    WinWait,%f% ,,1
} ;
if( !WinExist(f) ){
   msg=%ff% NOTfound => ExitApp `n (from. %A_LineFile%~%A_LineNumber%)
    tooltip,% msg
    feedbackMsgBox(msg,msg,1,1)
   Sleep,3000
global g_doSaveLogFiles

    lll(A_LineNumber, A_LineFile, "Sleep,3000")
   ExitApp 
}
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

g_nextCriticalCommandString := ""
Gosub, saveIamAllive


; ListLines Off ; history of lines most recently executed is shown

g_OSVersion := GetOSVersion()

;Set the Coordinate Modes before any threads can be executed
CoordMode, Caret, Screen
CoordMode, Mouse, Screen

EvaluateScriptPathAndTitle()

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; next line is useless sice 16.07.2017 11:51 . i have daktivated it.
; SetTimer, checkActiveTitleChanged, 50 ; 31.07.2017 20:57
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;disable hotkeys until setup is complete
g_nextCriticalCommandString := "120:SuspendOn()"
g_nextCriticalCommandTimeIdle := A_TimeIdle
SuspendOn()  ; wieder (10.07.2017 11:51) auskommentiert weils mir zu oft auf suspand on war. wehr oft wenn ich auf skype gewecheelt habe. hoffe die anderen bugFix haben den Seiteneffekt das ich dieses nicht mehr brauche.
g_nextCriticalCommandString := ""

Gosub, setWordlistFileUpdatedTime ; 29.04.2017 14:03

BuildTrayMenu()      


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

lll(A_LineNumber, A_LineFile, "InitializeHotKeys()")
InitializeHotKeys()

global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "DisableKeyboardHotKeys()")
DisableKeyboardHotKeys()

;Change the Running performance speed (Priority changed to High in GetIncludedActiveWindow)
; SetBatchLines, -1

g_wordListID := getWordListID(wordlist) ; 24.03.2018 23:02
ReadInTheWordList()


g_WinChangedCallback := RegisterCallback("WinChanged")
g_ListBoxScrollCallback := RegisterCallback("ListBoxScroll")
if !(g_WinChangedCallback){
   MsgBox, Failed to register callback function
   ExitApp
}
if !(g_ListBoxScrollCallback){
   MsgBox, Failed to register ListBox Scroll callback function
   ExitApp
}
   
GetIncludedActiveWindow() ;Find the ID of the window we are using

MainLoop()

; dirty bugfix, https://github.com/sl5net/global-IntelliSense-everywhere/issues/4
#IfWinActive,
:*:___:: ; workaround if it comes sleeping
  ;run,% "E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere\start.ahk"
   run,% "..\start.ahk"
  Last_A_This:=A_ThisFunc . A_ThisLabel 
  ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
return 


RecomputeMatchesTimer:
   Thread, NoTimers
   RecomputeMatches()
Return

#MaxThreadsPerHotkey 1

; some users dont have numpad ; 25.03.2018 15:35
; keyState_Numpad := GetKeyState("NumpadAdd","P")
; MsgBox,%keyState_Numpad% = keyState_Numpad (line:%A_LineNumber%) `

$1::
;~ $!::
$Numpad1::
CheckWord("$1")
return


$2:: ; ; some users dont have numpad ; 25.03.2018 15:35
;~ $":: ; this is working
; VK07:: ; this is not working 21.04.2017 12:12
; maybe helful for you: http://www.kbdedit.com/manual/low_level_vk_list.html
; VK_OEM_7::

$Numpad2::
CheckWord("$2")
return

$3::  ; some users dont have numpad ; 25.03.2018 15:35
; $§:: ; problem with the paragraph sign. probably becouse of the document format. i dont need it so much. lets deactivate it. 21.04.2017 12:02
$Numpad3::
CheckWord("$3")
return
$4::  ; some users dont have numpad ; 25.03.2018 15:35
;~ $$::
$Numpad4::
CheckWord("$4")
return
$5::  ; some users dont have numpad ; 25.03.2018 15:35
$Numpad5::
CheckWord("$5")
return
$6::  ; some users dont have numpad ; 25.03.2018 15:35
;~ $&::
$Numpad6::
CheckWord("$6")
return
$7:: ;  ; some users dont have numpad ; 25.03.2018 15:35
;~ $/::
;~ ${::
$Numpad7::
CheckWord("$7")
return
$8::  ; some users dont have numpad ; 25.03.2018 15:35
;~ $(::
;~ $[::
$Numpad8::
CheckWord("$8")
return
$9::  ; some users dont have numpad ; 25.03.2018 15:35
;~ $)::
;~ $]::
$Numpad9::
CheckWord("$9")
return
$0:: ; some users dont have numpad ; 25.03.2018 15:35
;msgbox,0
CheckWord("$0")
;~ $=::0000
;~ $}::
return
$Numpad0::
;msgbox,Numpad0
CheckWord("$Numpad0")
; CheckWord(A_ThisHotkey)
Return


; $^Enter::
; $^Space::
; $Tab::
; $Up::
; $Down::
; $PgUp::
; $PgDn::
; $Right::
; $Enter::
;$NumpadEnter::
;EvaluateUpDown(A_ThisHotKey)
; Return

; $^+h::
; MaybeOpenOrCloseHelperWindowManual()
; Return

; $^+c::
; AddSelectedWordToList()
; Return

; $^+Delete::
; DeleteSelectedWordFromList()
; Return

; Configuration:
; GoSub, LaunchSettings
; Return

PauseResumeScript:
if (g_PauseState == "Paused"){
    Msgbox,g_PauseState == "Paused"`n (%A_LineFile%~%A_LineNumber%)
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
; 
#Include %A_ScriptDir%\Includes\TypingAid.inc.ahk

;<<<<<<<< reloadWordlost <<<< 180208163147 <<<< 08.02.2018 16:31:47 <<<<
reloadWordlost:
ParseWordsCount := ReadWordList()
prefs_Length := setLength(ParseWordsCount, maxLinesOfCode4length1)
 ;feedbackMsgBox("reloadWordlost:",A_LineNumber . " " .  A_LineFile,1,1)

; ToolTipSec(t,x=123,y=321,sec=1000); 75+ lines in Live Edit Live_Edit Pseudo Live Edit for Chrome Firefox PhpStorm.ahk

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

    lll(A_LineNumber, A_LineFile,  "Goto, doReload `n reason for being carefully with reload `;) https://youtu.be/2a_AsYubzvE " )
    ;~ ToolTip, % A_TickCount
}
return
;>>>>>>>> reloadWordlost >>>> 180208163153 >>>> 08.02.2018 16:31:53 >>>>



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
doReload:
return ; reload is deaktivated today :D 29.07.2017 14:51 17-07-29_14-51 . i using it from the Administrator user
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




ifWordlistFileWasUpdatedChanged:
msgbox,18-03-02_12-51 return
return

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

lll(A_LineNumber, A_LineFile, "Title changed, Wordlist(modiTime) NOT changed so fast ... ups `n Wordlist=>" . Wordlist . "< `n Sleep,100")
                  isActuallyWrittenToLog := true
               }
               FileGetTime, WordlistModiTime, %Wordlist%, M
            }
         
            msg = %ActiveTitleOLD%  <> `n%ActiveTitle%
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "`n Sleep,100 `n" . msg . "`n ==> Goto, doReload")
           ;feedbackMsgBox("ReadInTheWordList",A_LineNumber . " , " . A_ScriptName,1,1)
            ReadInTheWordList() ; 07.02.2018 17:28
         }
    }
    ;Msgbox, wordlist was changed (%A_LineFile%~%A_LineNumber%)
    WordlistModiTime_OLD:=WordlistModiTime

   ; lll(A_LineNumber, A_LineFile, "doReloadIfScriptDontMoveThisLine()")

    doReloadIfScriptDontMoveThisLine()
;
Return

saveIamAllive:
   FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
   FormatTime, timestampyyMMddHHmmssPretty, %A_now%,yy:MM:dd HH:mm:ss
   FileDelete, TypingAid_programmCounter_LineAndTime.txt
   FileAppend,117_%timestampyyMMddHHmmssPretty%_line_%timestampyyMMddHHmmss% , TypingAid_programmCounter_LineAndTime.txt
return


;<<<<<<<< ordlistTXTfile <<<< 180319224633 <<<< 19.03.2018 22:46:33 <<<<
checkWordlistTXTfile_sizeAndModiTime:
    SetTimer,checkInRegistryChangedWordlistAddress,Off

    if(!FileExist(wordlist)){
        wordlist := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\Wordlists\_globalWordListsGenerated\_global.txt" )
    }
    if(!FileExist(wordlist)){
        MsgBox,ups !FileExist(wordlist = %wordlist%) 99999
    }



    FileGetSize, WordlistSize, %wordlist%
    FileGetTime, WordlistModified, %wordlist%, M
    FormatTime, WordlistModified, %WordlistModified%, yyyy-MM-dd HH:mm:ss

    SELECTwordlistmodified := "SELECT id, wordlistmodified, wordlistsize FROM Wordlists WHERE wordlist = '" . wordlist . "';"
    ;clipboard := SELECTwordlistmodified ; SELECT wordlistmodified, wordlistsize FROM Wordlists WHERE wordlist = '..\Wordlists\_globalWordListsGenerated\_global.txt';
    ; [2018-03-20 11:56:58] [1] [SQLITE_ERROR] SQL error or missing database (no such table: Wordlists)
    WordsTbl := g_WordListDB.Query(SELECTwordlistmodified)
    For each, row in WordsTbl.Rows
    {
        g_wordListID := row[1]
        WordlistLastModified := row[2]
        WordlistLastSize := row[3]
        break
    }
    ; doReadWordlistTXTfile := (WordlistSize && WordlistModified && (WordlistSize <> WordlistLastSize || WordlistModified > WordlistLastModified))
    doReadWordlistTXTfile := (WordlistSize <> WordlistLastSize || WordlistModified <> WordlistLastModified || !WordlistLastSize || !WordlistLastSize)
    if(doReadWordlistTXTfile){
        ;msgbox, doReadWordlistTXTfile 654654654
        ReadInTheWordList()
        ;ParseWordsCount := ReadWordList() ; there is also update and select of time of the wordlist
        ;prefs_Length := setLength(ParseWordsCount, maxLinesOfCode4length1)
        ; RebuildDatabase()
        ; msgbox, have fun with :) `n %wordlist% 18-03-02_18-37  (%A_LineFile%~%A_LineNumber%)

        RecomputeMatches()
        tip:="doReadWordlistTXTfile=" doReadWordlistTXTfile " ReadInTheWordList()  wordlist=" wordlist " 4567984654888888 "
        sqlLastError := SQLite_LastError()
        tip .= "`n sqlLastError=" sqlLastError " `n( " A_LineFile "~" A_LineNumber ")"
        if( instr(sqlLastError, "no such table") ){
            tooltip, % tip
            SuspendOn()
            ;msgbox,% tip
            RebuildDatabase()
            SuspendOff()
            sleep,3000
            ; msgbox,% tip
            ; reload ; hardcore. anyway. thats a way it works
        }
        ;pause ; RebuildDatabase()
        sleep,100
        ;reload ; hardcore. anyway. thats a way it works
    }
    SetTimer,checkInRegistryChangedWordlistAddress,On
return
;>>>>>>>> checkWordlistTXTfile_sizeAndModiTime >>>> 180319224746 >>>> 19.03.2018 22:47:46 >>>>



;<<<<<<<< checkInRegistryChangedWordlistAddress <<<< 180319214428 <<<< 19.03.2018 21:44:28 <<<<
checkInRegistryChangedWordlistAddress:

if(g_config["list"]["change"]["stopRexExTitle"]=="."){
    temp := g_config["list"]["change"]["stopRexExTitle"]
    tip = stopRexExTitle is >%temp%< %wordlist%
    lineFileName := RegExReplace(A_LineFile, ".*\\([\w\s\.]+)$", "$1")
    ToolTip5sec(tip " (" A_LineNumber " " lineFileName . " )",1,-33 )
    return
}

if(0 && InStr(A_ComputerName,"SL5"))
    ToolTip5sec(wordlist " `n(" A_LineNumber " " A_LineFile . " )" )

    ;SetTimer,checkWordlistTXTfile_sizeAndModiTime,Off

    global g_SingleMatch
    global g_FLAGmsgbox

    SetTitleMatchMode,2
    if(WordlistSize > g_minBytesNeedetToAskBevoreChangingWordlist)
        If(WinExist("wordlistChangedInRegistry") ){
            g_FLAGmsgbox := true
            return ; no update jet
    }

    if(1){
        ; not needet to check, but maybe mmore pretty coding ?? 20.03.2018 18:34 TODO
        ; its more pretty to have a updated text inside this box, therfore close it first. 20.03.2018 18:35
        name := "wordlistChangedInRegistry"
        while(WinExist(name) && A_Index < 9){
            WinClose,% name
            winWaitclose,% name,,1
        }
        while(WinExist(name) && A_Index < 9){
            WinKill,% name
            winWaitclose,% name,,1
        }
        If(WinExist("wordlistChangedInRegistry") ){
            tooltip,Oops  `n should never happen BUG `n was not able to close wordlistChangedInRegistry `n`n  ==> reload in 9Seconds (%A_LineFile%~%A_LineNumber%) 20.03.2018 18:54
            sleep,9000
            reload
            return
        }
    }

    RegRead, wordlistNewTemp, HKEY_CURRENT_USER, SOFTWARE\sl5net, wordlist
    isRegListChanged := (wordlistNewTemp && wordlist <> wordlistNewTemp)
    if(!isRegListChanged || A_TimeIdle < 1333)
        return

    if(g_config["list"]["change"]["stopRexExTitle"]){
        regExPattern := g_config["list"]["change"]["stopRexExTitle"]
        ; regExPattern := g_config\["list"\]\["change"\]\["stopRexExTitle"\]\s*:=\s*(\w+)
        foundPos := RegExMatch( wordlistNewTemp, regExPattern ,  matchs )
        if(foundPos)
            return

    }



    if(!fileExist(wordlistNewTemp)){ ; addet 26.4.2018 12:58 becouse of mistourios things
        clilpboard := wordlistNewTemp
        msg = :( list read by RegRead NOT `n wordlistNewTemp=%wordlistNewTemp% `n clilpboard = %wordlistNewTemp% `n  (%A_LineFile%~%A_LineNumber%)
        Msgbox,% msg
        clilpboard := msg
        sleep,5000
    }

    if(g_doAskBevoreChangingWordlist && WordlistSize > g_minBytesNeedetToAskBevoreChangingWordlist){
        AHKcodeMsgBox := "#" . "NoTrayIcon `n "
        temp = msgbox,,wordlistChangedInRegistry, Would you use new list now? ``n ``n Say goodbye to? (%WordlistSize% bytes > %g_minBytesNeedetToAskBevoreChangingWordlist%) ``n  %wordlist% ``n exitApp
AHKcodeMsgBox .= temp
        if(g_FLAGmsgbox){
            g_FLAGmsgbox := false ; just clicked msgboxWindow
        }else{
            DynaRun(AHKcodeMsgBox) ; wait for user decision
            tooltip,WinWait wordlistChangedInRegistry
            ;WinWait,wordlistChangedInRegistry
            WinWait,wordlistChangedInRegistry,,1
            ;msgbox,18-03-02_17-42 %AHKcodeMsgBox%
            tooltip,

            return ; no update jet
        }
    }

   if( !FileExist(wordlistNewTemp) ){
        ; Msgbox,:(  '%wordlistNewTemp%' = wordlistNewTemp `n Wordlist is not a file  (%A_LineFile%~%A_LineNumber%)
        wordlistOLD := "" ; probably programmer want a reloud soon. quck an dirty ???
        return
    }

        wordlist := wordlistNewTemp
        wordlistOLD := wordlist
        g_wordListID := getWordListID(wordlist) ; 24.03.2018 23:02

        ;tip=%wordlist% (%WordlistSize%) `n%wordlistOLD% (%WordlistLastSize%) = old `n ( %A_LineFile%~%A_LineNumber% )
        ;ToolTip4sec(tip)
        ;msgbox,%wordlist%  (%A_LineFile%~%A_LineNumber%)

        ;if(g_FLAGmsgbox == 0)
            RecomputeMatches()

    ; gosub onLink2wordlistChangedInRegistry ; ToolTip3sec(A_LineNumber . " " . A_LineFile . " " . Last_A_This)
return
;>>>>>>>> checkInRegistryChangedWordlistAddress >>>> 180319214434 >>>> 19.03.2018 21:44:34 >>>>

; ToolTip1sec(A_LineNumber . " " . A_LineFile . " " . Last_A_This) )


;<<<<<<<< onLink2wordlistChangedInRegistry <<<< 180319214441 <<<< 19.03.2018 21:44:41 <<<<
onLink2wordlistChangedInRegistry:

if(g_doListBoxFollowMouse)
  Return  ; __

    ;Msgbox,RETURN OFF`n (%A_LineFile%~%A_LineNumber%)
    ;return
    global g_SingleMatch
    global g_FLAGmsgbox
    SetTitleMatchMode,2

    ;SetTimer,checkInRegistryChangedWordlistAddress,off


    FileGetTime, WordlistModified, %wordlist%, M
    FormatTime, WordlistModified, %WordlistModified%, yyyy-MM-dd HH:mm:ss
    ;ToolTip4sec(wordlist " = wordlist `n"  WordlistModified  " `n" . A_LineNumber . " " . A_ScriptName . " " . Last_A_This,1,1)
    if(WordlistModiTime_OLD <> WordlistModiTime && WordlistModiTime_OLD ){
        ;Msgbox,WordlistModiTime_OLD <> WordlistModiTime `n (%A_LineFile%~%A_LineNumber%)
        ; ParseWordsCount := ReadWordList()
        ; prefs_Length := setLength(ParseWordsCount, maxLinesOfCode4length1)

        g_wordListID := getWordListID(wordlist) ; 24.03.2018 23:02
        ReadInTheWordList()
        prefs_Length := setLength(ParseWordsCount, maxLinesOfCode4length1)
        ; RebuildDatabase()

        ;If(WinExist("wordlistChangedInRegistry"))
        winclose,wordlistChangedInRegistry

        ;SetTimer,checkInRegistryChangedWordlistAddress,on
        ;ToolTip4sec("RecomputeMatches() `n " wordlist " = wordlist `n"  WordlistModified  " `n" . A_LineNumber . " " . A_ScriptName . " " . Last_A_This,1,1)
        ;RecomputeMatches() ; 27.03.2018 23:51
        return ; no update jet
    }
    WordlistModiTime_OLD := WordlistModiTime

    if(0 && firstLine := g_SingleMatch[1])
        tooltip,%firstLine% `n (%A_LineFile%~%A_LineNumber%)

    ; WinWaitNotActive,wordlistChangedInRegistry ahk_class AutoHotkeyGUI

    ; DetectHiddenWindows,On ; it set the window to no tray icon. i surprized to use now DetectHiddenWindows,On 18-03-03_17-16 Really necasary ??? TODO:need it ?


    ; may there was a change anyway

return

;
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
couldIfindMyself:
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "couldIfindMyself cant find scripts running in tray. so its useless :( deprevated. return from function :( now.")

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
      msgbox,% A_LineNumber " " A_LineFile "`n SuspendOn()`n"

   min := 60 * 1000
   ; sleep, % 9 * min 
   ; reload 
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "ExitApp")
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
if(false && ActiveTitleOLD <> ActiveTitle){
    ActiveTitleOLD := ActiveTitle
    ; sleep,120 ; it needs a little time to copy the files 31.07.2017 21:30
msg=`n (%A_LineFile%~%A_LineNumber%)
feedbackMsgBox(msg,msg,1,1)
    SetTimer, ifWordlistFileWasUpdatedChanged, 100
}
return

;
/*
    ObjRegisterActive(Object, CLSID, Flags:=0)
    
        Registers an object as the active object for a given class ID.
        Requires AutoHotkey v1.1.17+; may crash earlier versions.
    
    Object:
            Any AutoHotkey object.
    CLSID:
            A GUID or ProgID of your own making.
            Pass an empty string to revoke (unregister) the object.
    Flags:
            One of the following values:
              0 (ACTIVEOBJECT_STRONG)
              1 (ACTIVEOBJECT_WEAK)
            Defaults to 0.
    
    Related:
        http://goo.gl/KJS4Dp - RegisterActiveObject
        http://goo.gl/no6XAS - ProgID
        http://goo.gl/obfmDc - CreateGUID()
*/
ObjRegisterActive(Object, CLSID, Flags:=0) {
    static cookieJar := {}
    if (!CLSID) {
        if (cookie := cookieJar.Remove(Object)) != ""
            DllCall("oleaut32\RevokeActiveObject", "uint", cookie, "ptr", 0)
        return
    }
    if cookieJar[Object]
        throw Exception("Object is already registered", -1)
    VarSetCapacity(_clsid, 16, 0)
    if (hr := DllCall("ole32\CLSIDFromString", "wstr", CLSID, "ptr", &_clsid)) < 0
        throw Exception("Invalid CLSID", -1, CLSID)
    hr := DllCall("oleaut32\RegisterActiveObject"
        , "ptr", &Object, "ptr", &_clsid, "uint", Flags, "uint*", cookie
        , "uint")
    if hr < 0
        throw Exception(format("Error 0x{:x}", hr), -1)
    cookieJar[Object] := cookie
}
;
setWordlistFileUpdatedTime:
    ;msgbox, setWordlistFileUpdatedTime 18-03-02_11-49
    return
; lets do this only first time for initializing 29.04.2017 13:40
   WordlistFileName = wordlist .txt
   Wordlist = %A_ScriptDir%\%WordlistFileName%

    Wordlist := wordlist ; todo: very ugly. no time 02.03.2018 12:54 18-03-02_12-54

   WordlistOLD := Wordlist

   if( !FileExist(Wordlist) || InStr(FileExist(Wordlist), "D") ){
        Msgbox,:(  '%Wordlist%' = Wordlist  `n Wordlist is not a file  (%A_LineFile%~%A_LineNumber%)
        return
    }
    FileGetTime, WordlistModiTime, %Wordlist%, M
    WordlistModiTime_OLD:=WordlistModiTime
return
;

wordlistTooltip:
    tip=%wordlist% `n%wordlistOLD% = old `n ( %A_LineFile%~%A_LineNumber% )
    ToolTip,% tip
return

WheelUp::
    global g_ListBoxFontSize
    g_ListBoxFontSize := g_ListBoxFontSize + 1
    Tooltip,WheelDown:: Size=%g_ListBoxFontSize% `n (from: %A_LineFile%~%A_LineNumber%) ; to to
return

WheelDown::
    global g_ListBoxFontSize
    g_ListBoxFontSize := g_ListBoxFontSize - 1
    Tooltip,WheelDown:: Size=%g_ListBoxFontSize% `n (from: %A_LineFile%~%A_LineNumber%) ; to to
return

recreateListBox_IfFontSizeChangedAndTimeIdle(g_ListBoxFontSize, newListBoxFontSize){
  if ( A_TimeIdlePhysical < 1000 * 0.5 )
    return false
    if(g_ListBoxFontSize <> newListBoxFontSize ){
        g_ListBoxFontSize := newListBoxFontSize ; ; to to
        ; ListBoxEnd()
        DestroyListBox()
        InitializeListBox()
        return g_ListBoxFontSize
    }
    return false
}
; too
doListBoxFollowMouse:
      MouseGetPos, g_ListBoxX, g_ListBoxY
      g_ListBoxX := g_ListBoxX - 77
      g_ListBoxY := g_ListBoxY - 77

      newFontSize := recreateListBox_IfFontSizeChangedAndTimeIdle(listBoxFontSizeOLD , g_ListBoxFontSize )
      if(newFontSize){
        g_ListBoxFontSize := newFontSize
        listBoxFontSizeOLD := g_ListBoxFontSize
       }else
          ShowListBox(g_ListBoxX,g_ListBoxY)
return

;__ too ha ha
