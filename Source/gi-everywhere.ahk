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

FileEncoding, UTF-8

lll(A_LineNumber, A_LineFile, "hi from " A_LineFile)


CoordMode, ToolTip,Screen

fnReceive_ActionListAddress := Func("Receive_ActionListAddress").Bind(1)
; OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA  ; deprecated 15.02.2018 10:26
; ObjRegisterActive(Stuff, "{93C04B39-0465-4460-8CA0-7BFFF481FF98}")
ObjRegisterActive(fnReceive_ActionListAddress, "{93C04B39-0465-4460-8CA0-7BFFF481FF98}")  ; Receive_ActionListAddress(CopyOfData){
class Stuff{
    static abc := 1
    callFunction( name, p* ) { ;allows you to call any function in this script
        abc := func( name )
       %abc%( p* )
    }
}

global g_config
g_config := { list:{ change: { stopRexExTitle: false } } }
g_config := { FuzzySearch:{ enable: true, MAXlines : 87654, keysMAXperEntry : 6, minKeysLen: 4, doValueCopy : false } } ; difficult to implement symlink copy for not rr lines doValueCopy. todo: issue . doValueCopy : false  is not fully implemented
global g_config

; msgBox,% g_config["FuzzySearch"]["keysMAXperEntry"] "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
;msgBox,% g_config["FuzzySearch"]["MAXlines"] "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"

; global g_config := { Send:{ RealisticDelayDynamic: true } }
g_config .= { Send:{ RealisticDelayDynamic: false } }
; msgBox,% g_config["FuzzySearch"]["keysMAXperEntry"] "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"


; getRealisticDelayDynamicSendAHKcode
;  MsgBox,% ":( ERROR: " msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
; ActionLists

; doValueCopy. todo: issue . doValueCopy : false  is not fully implemented
; if(g_config["Send"]["RealisticDelayDynamic"])
; if(g_config["FuzzySearch"]["enable"] && a_index<455)
; if(g_config["FuzzySearch"]["keysMAXperEntry"] && a_index<455)


;global do_us_FuzzySearch := true
; g_config["list"]["change"]["stopRexExTitle"]))

global g_ListBoxX
global g_ListBoxY
g_ListBoxX := 0 ; if g_ListBoxX (not false > 0) it never usses CaretXorMouseXfallback . if you want go back to default, reload the
g_ListBoxY := 0 ; if g_ListBoxX (not false > 0) it never usses CaretXorMouseXfallback . if you want go back to default, reload the

global g_show_ListBox_Id_EMTY_COUNT := 0

global g_method := "Clipboard"

global g_regExReplaceInVisibleLine := "^([\w\d_-]+).*" ; show only first text , numers _ or -
global g_regExReplaceInVisibleLine := "^([^|]+).*" ; the string only before the first "|"

global g_regExReplaceInVisibleLine := "^[_]*([^|\n]+)[^\.\n]*?([^|\n]{3,})$" ; https://autohotkey.com/boards/viewtopic.php?p=215425#p215425 https://regex101.com/r/GQjPg0/1
global g_regExReplaceInVisibleLine := "^[_]*([^|\n]+)[^\.\n]*?([^|\n]{3,})?$" ; 18-06-10_09-34 https://autohotkey.com/boards/viewtopic.php?p=215425#p215425 https://regex101.com/r/GQjPg0/1
; the string only before the first "|"
demoTestData =
(
___your library open|rr||ahk|openInEditor,SourceTree.ahk
autoload.ahk
b&w ActionLists|r|E:\fre\ActionLists\TscShellContainerClass
Visual Basic|rr||ahk|q=b&w ActionLists
Recent|r|C:\Users\bla\AppData\Roaming\Microsoft\Windows\Recent
last used Recent|rr||ahk|q=Recent
)


global g_sending_is_buggy := false ; Solved: SendPlay. 29.07.2017 11:21
global g_doSaveLogFiles := false
global g_doRunLogFiles := false

global ActionList_isNotAProject := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\ActionLists\_globalActionListsGenerated\isNotAProject.ahk" )
global ActionList
global ActionListOLD
global activeTitle:=""

global g_doAskBevoreChangingActionList := false ; <== buggy dont know whey 19.03.2018 23:50
global g_doAskBevoreChangingActionList := true ; <== works preetty nice :) 19.03.2018 23:51
global g_minBytesNeedetToAskBevoreChangingActionList := 812345 ; <== Minimum bytes. then will be asked before the change 20.03.2018 18:22
if(0 && InStr(A_ComputerName,"SL5"))
    g_minBytesNeedetToAskBevoreChangingActionList := 812345 ; <== Minimum bytes. then will be asked before the change 20.03.2018 18:22

global g_ActionList_UsedByUser_since_midnight := {} ; [g_ActionListID]

global g_FLAGmsgbox := false

global g_ActionListID
global g_ActionListDBfileAdress := A_ScriptDir "\ActionListLearned.db"
if(1 && InStr(A_ComputerName,"SL5")){
    ; g_ActionListDBfileAdress := "E:\fre\private\HtmlDevelop\AutoHotKey\tools\TypingAid-master\Source\ActionListLearned.db"
    g_ActionListDBfileAdress := "G:\fre\private\sql\sqlite\ActionList.db"
}
; cre


global g_ListBoxFontSize := 16 ; works
global g_ListBoxFontSize := 2 ; work but its so small i could not read it too
global g_ListBoxFontSize := 8 ; work but its so small i could not read it too too tool
listBoxFontSizeOLD := g_ListBoxFontSize

ActionList := ActionListActive


feedbackMsgBoxCloseAllWindows()

temp := "___________________________________`n"
global g_doSaveLogFiles

    lll("`n" . A_LineNumber, A_ScriptName, temp . " STARTING first lines :) ")


if(!fileExist(ActionList_isNotAProject)){
    msg := ":( ERROR: !fileExist(" ActionList_isNotAProject " =ActionList_isNotAProject) `n`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    lll("`n" . A_LineNumber, A_ScriptName, msg)
    Msgbox,% msg
    clilpboard := msg
    sleep,5000
}
RegRead, ActionList, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionList ; todo: 02.03.2018 12:55 18-03-02_12-55
if(!fileExist(ActionList)){
    ; addet 26.4.2018 12:58 becouse of mistourios things
    ; deactivated 10.06.2018 08:36 becouse messeage disturbing every new installed is first time started.
    ; and becouse dont know the use of this lines?
    msg = :( !fileExist(%ActionList%) `n (%A_LineFile%~%A_LineNumber%)
    lll("`n" . A_LineNumber, A_ScriptName, msg)
    if(false){
        Msgbox,% msg
        clilpboard := msg
        sleep,5000
    }
}


maxLinesOfCode4length1 := 900 ;

; SetTimer, saveIamAllive, 8000 ; setinterval
SetTimer,checkInRegistryChangedActionListAddress,500 ; RegRead, ActionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionList
SetTimer,checkActionListTXTfile_sizeAndModiTime,3000
SetTimer,check_some_keys_hanging_or_freezed,1800 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
SetTimer,check_ActionList_GUI_is_hanging_or_freezed,1000 ; ; 26.09.2018 16:38 it sometimes happesn.


SetTimer,doListBoxFollowMouse,off
;SetTimer,doListBoxFollowMouse,off

; SetTitleMatchMode,regEx
; #IfWinActive,(Autohotkey|\.ahk)
; Hotkey, ^+esc, off

#IfWinActive,
Hotkey, WheelUp, off
Hotkey, WheelDown, off
Hotkey, #s, off ; toggle_RealisticDelayDynamic()
if(1 && InStr(A_ComputerName,"SL5"))
    Hotkey, #s, on ; toggle_RealisticDelayDynamic()
; #IfWinActive,AHK Studio ahk_class #32770
; Hotkey, ^s, on

#IfWinActive,

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

;msgbox,% A_LineNumber " " RegExReplace(A_LineFile,".*\\") "`n SuspendOn()`n"
Suspend, On ; wieder (10.07.2017 11:47) auskommentiert weils mir zu oft auf suspand on war. wehr oft wenn ich auf skype gewecheelt habe. hoffe die anderen bugFix haben den Seiteneffekt das ich dieses nicht mehr brauche.

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

; Gosub, setActionListFileUpdatedTime ; 29.04.2017 14:03

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

g_ActionListID := getActionListID(ActionList) ; 24.03.2018 23:02
ReadInTheActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))


g_WinChangedCallback := RegisterCallback("WinChanged")
g_ListBoxScrollCallback := RegisterCallback("ListBoxScroll")
if !(g_WinChangedCallback){
   MsgBox, Failed to register callback function  `n (%A_LineFile%~%A_LineNumber%)
   ExitApp
}
if !(g_ListBoxScrollCallback){
   MsgBox, Failed to register ListBox Scroll callback function  `n (%A_LineFile%~%A_LineNumber%)
   ExitApp
}
   
GetIncludedActiveWindow() ;Find the ID of the window we are using




MainLoop()

; dirty bugfix, https://github.com/sl5net/global-IntelliSense-everywhere/issues/4
; __ __
;<<<<<<<<<<<<<<<<< workaround <<<<<<<<<<<<<<<<<
; https://stackoverflow.com/questions/52493547/autohotkey-read-of-two-underscore-keys
; https://github.com/sl5net/global-IntelliSense-everywhere/issues/4
#IfWinActive,
~esc::
   toolTip2sec("esc::" A_LineNumber " " RegExReplace(A_LineFile,".*\\") )
   ; InactivateAll_Suspend_ListBox_WinHook()
   CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
   DisableWinHook()
   DisableKeyboardHotKeys()
   g_Word := ""
   ; EnableKeyboardHotKeys() ; <== not usefull. disturbing 28.10.2018 09:59
   ; InitializeHotKeys() ; <= if i use this ListBox never close 28.10.2018 09:56
return
#IfWinActive,alsdkfjasödklfjasdöklfasödf
:b0*?:__:: ;does not delete the underscores
    ; ToolTip4sec(" (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
    ; return
    SetTimer, show_ListBox_Id, 600 ; setinterval
    Sleep,100
    g_reloadIf_ListBox_Id_notExist := true
    ; reload_IfNotExist_ListBoxGui()
    ; ~_:: countUnderscore++ if(countUnderscore == 2){ countUnderscore := 0 reload_IfNotExist_ListBoxGui()
return
;>>>>>>>>>>>>>>>>> workaround >>>>>>>>>>>>>>>

reload_IfNotExist_ListBoxGui(){
   global g_ListBox_Id


if(true){
    winTitle := "Word List Appears Here."
    class := "ahk_class AutoHotkeyGUI"

    ; DetectHiddenText, on
    DetectHiddenWindows, on
    WinWait,%winTitle% %class%, , 5
    WinGet, listBox_Id, ID, Word List Appears Here.
    msg := listBox_Id " - g_ListBox_Id : " g_ListBox_Id
    ;ToolTip4sec(msg " = msg (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
    tooltip,% msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    ;MsgBox,% msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    IfWinExist, %winTitle% %class%, , 5
        MsgBox,% msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    ;__ __ __ __ __ __ ______ __

}

    AHKcode := "#" . "NoTrayIcon `n "
    AHKcode =
(
    ; class := "ahk_class AutoHotkeyGUI"
    SetTitleMatchMode, 2
    ; DetectHiddenText, on
    DetectHiddenWindows, on
    winTitle := "Word List Appears Here."
    WinWait,`%winTitle`% `%class`%, , 1
    WinGet, listBox_Id, ID, Action List Appears Here.
    IfWinNotExist, `%winTitle`% ; `%class`% __
    {
    ; if(!listBox_Id){
       MsgBox, `%winTitle`% NOT Exist `%class`%  : %A_LineFile%~%A_LineNumber%
       run,`% "..\start.ahk"
    } else {
        tooltip, winTitle=`%winTitle`% found: winText=`%winText`% :%countUnderscore% = countUnderscore : %A_LineFile%~%A_LineNumber%,1,1
        MsgBox, `%winTitle`% Exist `%class`%  : %A_LineFile%~%A_LineNumber%
        sleep,2200
    }
    exitapp
)
    DynaRun(AHKcode)

    return
}



;<<<<<<<<<<<<<<<<< workaround <<<<<<<<<<<<<<<<<
; https://github.com/sl5net/global-IntelliSense-everywhere/issues/4
; :*:___:: ; workaround if it comes sleeping
;   ;run,% "E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere\start.ahk"
;   tooltip, reload every idle time? 31.07.2018 11:44 18-07-31_11-44
;   pause
;    run,% "..\start.ahk"
  ;InitializeListBox() ; don work. produce error... new test 18-06-11_20-00
;   Last_A_This:=A_ThisFunc . A_ThisLabel
;   ToolTip4sec("InitializeListBox `n " A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
return 
;>>>>>>>>>>>>>>>>> workaround >>>>>>>>>>>>>>>
#IfWinActive,
^+f5:: ; exit-all-scripts and restart
    if(1 && InStr(A_ComputerName,"SL5")){
        setRegistry_toDefault()
        ; exit_all_scripts()
        run,..\start.ahk
    }
return
; #IfWinActive,Action List Appears Here. ahk_class AutoHotkeyGUI
; #IfWinActive,ahk_class AutoHotkeyGUI
;#IfWinActive,"ListBoxTitle (sec="
#IfWinActive,
WheelUp::
 global g_ListBoxFontSize
 g_ListBoxFontSize := g_ListBoxFontSize + 1
 Tooltip,WheelDown:: Size=%g_ListBoxFontSize% `n (from: %A_LineFile%~%A_LineNumber%) ; to to
return
#IfWinActive,
WheelDown::
 global g_ListBoxFontSize
 g_ListBoxFontSize := g_ListBoxFontSize - 1
 Tooltip,WheelDown:: Size=%g_ListBoxFontSize% `n (from: %A_LineFile%~%A_LineNumber%) ; to to
return
#IfWinActive,
#s::
 toggle_RealisticDelayDynamic(){
     global g_config
     g_config["Send"]["RealisticDelayDynamic"] := ( g_config["Send"]["RealisticDelayDynamic"] ) ? false : true
     ToolTip2sec("RealisticDelayDynamic = " g_config["Send"]["RealisticDelayDynamic"] " `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This,1,1)
 }
return
#IfWinActive,AHK Studio ahk_class #32770
~^s::
 someFunction(){
    WinWaitActive,AHK Studio ahk_class #32770,Please close any error messages and try again,1
     winclose,
     msgBox,% ":( ERROR: " msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
 }
return
; ToolTip3sec("^+esc:: exit-all-scripts",1,1)
;
SetTitleMatchMode,regEx
#IfWinActive,i).*(Autohotkey|\.ahk|IntelliSense)
; #IfWinActive,
^+esc:: ; exit-all-scripts. usefull in developer mode
    if(1 && InStr(A_ComputerName,"SL5") ){
     setRegistry_toDefault()
     exit_all_scripts()
     ; MsgBox, `n (%A_LineFile%~%A_LineNumber%)
     exitapp
    }
 return

#IfWinActive, ; thats probably needet. 27.09.2018 10:29 was problem that hitting 1 , 2 , 3 ... not triggered any. triggers notihng.. with this line it works again.
RecomputeMatchesTimer:
   Thread, NoTimers
   if(1 && InStr(A_ComputerName,"SL5"))
       tooltip,% "RecomputeMatchesTimer: (" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\") ")",1,1
   RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; RecomputeMatchesTimer:
Return

; Msgbox,(`%A_LineFile`%~`%A_LineNumber`%)

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
; $�:: ; problem with the paragraph sign. probably becouse of the document format. i dont need it so much. lets deactivate it. 21.04.2017 12:02
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
#Include %A_ScriptDir%\Includes\gi-everywhere.inc.ahk

;<<<<<<<< reloadWordlost <<<< 180208163147 <<<< 08.02.2018 16:31:47 <<<<
reloadWordlost:
ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
prefs_Length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
 ;feedbackMsgBox("reloadWordlost:",A_LineNumber . " " .  A_LineFile,1,1)

; ToolTipSec(t,x=123,y=321,sec=1000); 75+ lines in Live Edit Live_Edit Pseudo Live Edit for Chrome Firefox PhpStorm.ahk

ActiveTitleOLD := ActiveTitle
WinGetActiveTitle, ActiveTitle
;gi-everywhere Settings ahk_class AutoHotkeyGUI
settitlematchmode,1
;detecthiddenwindows,On
; IfWinExist,gi-everywhere Help
;{
;   Sleep,9000
;   return
;}
;ifwinexist, gi-everywhere Settings ; A window's title must start with the specified WinTitle to be a match.
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




ifActionListFileWasUpdatedChanged:
msgbox,18-03-02_12-51 return
return

    FileGetTime, ActionListModiTime, %ActionList%, M
    if(ActionListModiTime_OLD <> ActionListModiTime){
        SetTimer, ifActionListFileWasUpdatedChanged, Off
        SetTimer, ifActionListFileWasUpdatedChanged, 1500 ; one second is really slow. this line is a little obsulete. but better let it be. 31.07.2017 22:45
        ActionListOLD := ActionList
        ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        prefs_Length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
        ;GoSub, reloadWordlost
        WinGetActiveTitle, ActiveTitle
        if(ActiveTitleOLD <> ActiveTitle )
            ActiveTitleOLD := ActiveTitle
    }else{
        ; sometimes it stacks at line 105 105: Suspend,On (573.41)
        ;~ it needs then reloaded 29.04.2017 13:35
        WinGetActiveTitle, ActiveTitle
        if(ActiveTitleOLD && ActiveTitleOLD <> ActiveTitle && ActionListOLD == ActionList ){
         
            ActionListModiTime_OLD:=ActionListModiTime
            i := 0
            isActuallyWrittenToLog := false
            while(ActionListModiTime_OLD == ActionListModiTime && i++ < 25){
               ; lets wait a little for new given/copied ActionList 16.07.2017 02:01
               Sleep,100
               if(!isActuallyWrittenToLog){
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "Title changed, ActionList(modiTime) NOT changed so fast ... ups `n ActionList=>" . ActionList . "< `n Sleep,100")
                  isActuallyWrittenToLog := true
               }
               FileGetTime, ActionListModiTime, %ActionList%, M
            }
         
            msg = %ActiveTitleOLD%  <> `n%ActiveTitle%
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "`n Sleep,100 `n" . msg . "`n ==> Goto, doReload")
           ;feedbackMsgBox("ReadInTheActionList",A_LineNumber . " , " . A_ScriptName,1,1)
            ReadInTheActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; 07.02.2018 17:28
         }
    }
    ;Msgbox, ActionList was changed (%A_LineFile%~%A_LineNumber%)
    ActionListModiTime_OLD:=ActionListModiTime

   ; lll(A_LineNumber, A_LineFile, "doReloadIfScriptDontMoveThisLine()")

    doReloadIfScriptDontMoveThisLine()
;
Return

saveIamAllive:
    return
   FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
   FormatTime, timestampyyMMddHHmmssPretty, %A_now%,yy:MM:dd HH:mm:ss
   FileDelete, gi-everywhere_programmCounter_LineAndTime.txt
tooltip,% "FileAppend (" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\") ")"
   FileAppend,117_%timestampyyMMddHHmmssPretty%_line_%timestampyyMMddHHmmss% , gi-everywhere_programmCounter_LineAndTime.txt
return






;/¯¯¯¯ checkActionListTXTfile_sizeAndModiTime ¯¯ 181023101000 ¯¯ 23.10.2018 10:10:00 ¯¯\
checkActionListTXTfile_sizeAndModiTime:
    SetTimer,checkInRegistryChangedActionListAddress,Off

    if(!FileExist(ActionList)){
        if(0 && InStr(A_ComputerName,"SL5")) ; 23.10.2018 10:08 was used
            msgBox,% " is this deadlink? never uses? (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        ; ActionList := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\ActionLists\_globalActionListsGenerated\_global.ahk" )
        ActionList := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\ActionLists\_globalActionListsGenerated\isNotAProject.ahk" )
    }
    if(!FileExist(ActionList)){
        msg := "!FileExist(ActionList = " ActionList ")"
        MsgBox,% "ups" msg "`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    }



    FileGetSize, ActionListSize, %ActionList%
    FileGetTime, ActionListModified, %ActionList%, M
    FormatTime, ActionListModified, %ActionListModified%, yyyy-MM-dd HH:mm:ss

    SELECTActionListmodified := "SELECT id, ActionListmodified, ActionListsize FROM ActionLists WHERE ActionList = '" . ActionList . "';"
    ;clipboard := SELECTActionListmodified ; SELECT ActionListmodified, ActionListsize FROM ActionLists WHERE ActionList = '..\ActionLists\_globalActionListsGenerated\_global.txt';
    ; [2018-03-20 11:56:58] [1] [SQLITE_ERROR] SQL error or missing database (no such table: ActionLists)
    WordsTbl := g_ActionListDB.Query(SELECTActionListmodified)
    For each, row in WordsTbl.Rows
    {
        g_ActionListID := row[1]
        ActionListLastModified := row[2]
        ActionListLastSize := row[3]
        break
    }
    ; doReadActionListTXTfile := (ActionListSize && ActionListModified && (ActionListSize <> ActionListLastSize || ActionListModified > ActionListLastModified))

; tooltTip2sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)

    isSizeChanged := (ActionListSize <> ActionListLastSize)
    isTimeChanged := (ActionListModified <> ActionListLastModified)
    isSizeNull := (!ActionListLastSize || !ActionListLastSize)

    doReadActionListTXTfile := (isSizeChanged || isTimeChanged || isSizeNull )
    doReadActionListTXTfileSTR = %isSizeChanged%||%isTimeChanged%||%isSizeNull%
    if(doReadActionListTXTfile){
        ;msgbox, doReadActionListTXTfile 654654654

        if(0 && isTimeChanged){
            msg =
             (
             %isTimeChanged% = isTimeChanged ('%ActionListModified%' <> '%ActionListLastModified%')
             %g_ActionListID% = g_ActionListID
             %ActionList% = ActionList
             )
            msgbox,% msg "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
        }
        if(0 && isSizeNull){
            msg =
             (
             the old list and the new list is 0 size
             %isSizeChanged% = isSizeChanged
             %g_ActionListID% = g_ActionListID
             %ActionList% = ActionList
              (ActionListSize='%ActionListSize%' <> '%ActionListLastSize%'=ActionListLastSize)
             )
            msgbox,% msg "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
        }
        ReadInTheActionList("checkActionListTXTfile_sizeAndModiTime:" doReadActionListTXTfileSTR " " A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        ;ParseWordsCount := ReadActionList(calledFromStr) ; there is also update and select of time of the ActionList
        ;prefs_Length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
        ; RebuildDatabase()
        ; msgbox, have fun with :) `n %ActionList% 18-03-02_18-37  (%A_LineFile%~%A_LineNumber%)

        RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; doReload:
        tip := "doReadActionListTXTfile=" doReadActionListTXTfile " ReadInTheActionList  ActionList=" ActionList " 4567984654888888 "
        sqlLastError := SQLite_LastError()
        tip .= "`n sqlLastError=" sqlLastError " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
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
    SetTimer,checkInRegistryChangedActionListAddress,On
return
;\____ checkActionListTXTfile_sizeAndModiTime __ 181023101012 __ 23.10.2018 10:10:12 __/









;/¯¯¯¯ checkInRegistryChangedActionListAddress ¯¯ 181025104242 ¯¯ 25.10.2018 10:42:42 ¯¯\
checkInRegistryChangedActionListAddress:

if( 1 && InStr(A_ComputerName,"SL5")){
    ; G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\AHK-Studio\AHK-Studio Backup
    ;
}


if(ActionList == ActionList_isNotAProject){ ; it happens: 23.10.2018 10:33
    ; msgBox,% "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    return
}

if(false && g_ActionList_UsedByUser_since_midnight[g_ActionListID]){
    msgBox,% "g_ActionList_UsedByUser_since_midnight[g_ActionListID]: " g_ActionList_UsedByUser_since_midnight[g_ActionListID] "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
}
if(g_config["list"]["change"]["stopRexExTitle"]=="."){
    temp := g_config["list"]["change"]["stopRexExTitle"]
    tip = stopRexExTitle is >%temp%< %ActionList%
    lineFileName := RegExReplace(A_LineFile, ".*\\([\w\s\.]+)$", "$1")
    ToolTip5sec(tip " (" A_LineNumber " " lineFileName . " )",1,-33 )
    return
}
if(0 && InStr(A_ComputerName,"SL5"))
	ToolTip5sec(ActionList " `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\")  . " )" )

    ;SetTimer,checkActionListTXTfile_sizeAndModiTime,Off

global g_SingleMatch
global g_FLAGmsgbox



SetTitleMatchMode,2
if( g_ActionList_UsedByUser_since_midnight[g_ActionListID] ){
	If(WinExist("ActionListChangedInRegistry") )
	    winClose,ActionListChangedInRegistry
    winWaitclose,ActionListChangedInRegistry, , 2
    g_FLAGmsgbox := false
}else if( ActionListSize > g_minBytesNeedetToAskBevoreChangingActionList)
	If(WinExist("ActionListChangedInRegistry") ){
            g_FLAGmsgbox := true
            return ; no update jet
    }

    if(1){
        ; not needet to check, but maybe mmore pretty coding ?? 20.03.2018 18:34 TODO
        ; its more pretty to have a updated text inside this box, therfore close it first. 20.03.2018 18:35
        name := "ActionListChangedInRegistry ahk_class #32770"
        while(WinExist(name) && A_Index < 9){
            WinClose,% name
            winWaitclose,% name,,1
        }
        while(WinExist(name) && A_Index < 9){
            WinKill,% name
            winWaitclose,% name,,1
        }
        If(WinExist("ActionListChangedInRegistry") ){
            tooltip,Oops  `n should never happen BUG `n was not able to close ActionListChangedInRegistry `n`n  ==> reload in 9Seconds (%A_LineFile%~%A_LineNumber%) 20.03.2018 18:54
            sleep,9000
            ; reload
            RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; in checkInRegistryChangedActionListAddress
            return
        }
    }



    RegRead, ActionListNewTemp_withoutExt, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionList
    isRegListChanged := (ActionListNewTemp_withoutExt && ActionList <> ActionListNewTemp_withoutExt)
    if(!isRegListChanged || A_TimeIdle < 1333)
        return
     if( InStr( ActionListNewTemp_withoutExt, "\.ahk")){ ; without file name 25.10.2018 11:33
        ; Msgbox,InStr( ActionListNewTemp_withoutExt, "\.ahk") ==> RETURN `n (%A_LineFile%~%A_LineNumber%)
        log =
        (
        Oops: InStr( ActionList, "\.ahk")
        This may happen for example with Java applications. JetBrains IDE Search Window or so.
        A_ThisFunc = %A_ThisFunc%
        Log:
        ; it happens: 25.10.2018 12:06
        ActionListNewTemp_withoutExt[30 of 259]: ..\ActionLists\AutoHotkey\.ahk
        ActionListOLD[33 of 63]: ..\ActionLists\noName\Cortana.ahk
        )
        log .= "`n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        if(1 && InStr(A_ComputerName,"SL5"))
            feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, log )
            ;msgBox,% log " ==> RETURN `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    }



    if(g_config["list"]["change"]["stopRexExTitle"]){
        regExPattern := g_config["list"]["change"]["stopRexExTitle"]
        ; regExPattern := g_config\["list"\]\["change"\]\["stopRexExTitle"\]\s*:=\s*(\w+)
        foundPos := RegExMatch( ActionListNewTemp_withoutExt, regExPattern ,  matchs )
        if(foundPos)
            return

    }

    if(fileExist(ActionListNewTemp_withoutExt ".ahk")){ ; addet 26.4.2018 12:58 becouse of mistourios things
        msg = pease use Action Lists without Extension `n thats not an error, a warning`n
        msg .= ActionListNewTemp_withoutExt "`n" ; inside checkInRegistryChangedActionListAddress
        if( SubStr( ActionListNewTemp_withoutExt , -3 ) == ".ahk" )
            ActionListNewTemp_withoutExt := SubStr( ActionListNewTemp_withoutExt, 1, -4 )
        msg .= ActionListNewTemp_withoutExt " <== repaired`n" ; inside checkInRegistryChangedActionListAddress
        msg .= " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        if(1 && InStr(A_ComputerName,"SL5"))
            ToolTip2sec( msg, 1,1 )
            ; feedbackMsgBox(msg,msg,1,1)
        if(!fileExist(ActionListNewTemp_withoutExt ".ahk")){
            clilpboard := ActionListNewTemp_withoutExt
            msg = :( list read by RegRead NOT exist: `n`n ActionListNewTemp_withoutExt = `n >>%ActionListNewTemp_withoutExt%<< `n = clilpboard = `n
            msg .= " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
            ActionList := ActionList_isNotAProject
            if(1 && InStr(A_ComputerName,"SL5")){
                ; msgBox,% ":( ERROR: " msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                ; feedbackMsgBox(msg,msg,1,1)
                ToolTip3sec( msg )
                ; clilpboard := msg
                ; sleep,5000
            }
            sleep,2000
            ; 111123456789
    }
}

    ; takes a little time to read data von database. 19.10.2018 12:21
	if(A_TickCount > 4000 && !g_ActionList_UsedByUser_since_midnight[g_ActionListID] && g_doAskBevoreChangingActionList && ActionListSize > g_minBytesNeedetToAskBevoreChangingActionList){
        AHKcodeMsgBox := "#" . "NoTrayIcon `n "
        ; temp = msgbox,,ActionListChangedInRegistry, Would you use new list now? ``n (new ``n Say goodbye to? (%ActionListSize% bytes > %g_minBytesNeedetToAskBevoreChangingActionList%) ``n  %ActionList% ``n exitApp
        ; %ActionList%
        temp =
        (
        ; msgbox,262176,ActionListChangedInRegistry, Would you use new list now? ``n ``n Say goodbye to? (%ActionListSize% bytes > %g_minBytesNeedetToAskBevoreChangingActionList%) ``n  That msgBox works like change list stopper ``n  ``n  F1=WebSearch
        msgbox,262176,ActionListChangedInRegistry, Would you use new list now? ``n ``n Say goodbye to  ``n  %ActionList% ``n ? ``n  That msgBox works like change list stopper ``n  (%ActionListSize% bytes > %g_minBytesNeedetToAskBevoreChangingActionList%) ``n  ``n  F1=WebSearch
        #ifwinactive,ActionListChangedInRegistry
        f1::
        run,https://www.google.de/search?q=ActionListChangedInRegistry global-IntelliSense-everywhere
        WinWaitActive,ActionListChangedInRegistry global-IntelliSense-everywhere,,3
        sleep,1000
        IfWinActive,
        {
            sleep,60
            send,^f ActionListChangedInRegistry
        }
        return
        exitApp
        )
		AHKcodeMsgBox .= temp
        if(g_FLAGmsgbox){
            g_FLAGmsgbox := false ; just clicked msgboxWindow
        }else{
            DynaRun(AHKcodeMsgBox) ; wait for user decision
            tooltip,WinWait ActionListChangedInRegistry  `n (%A_LineFile%~%A_LineNumber%)
            ;WinWait,ActionListChangedInRegistry
            WinWait,ActionListChangedInRegistry,,1
            ;msgbox,18-03-02_17-42 %AHKcodeMsgBox%
            tooltip,

            return ; no update jet
        }
    }

    ActionListNewTemp_withoutExt := RegExReplace(ActionListNewTemp_withoutExt, "i)(\.ahk\b)+$") ; clean strange wordlists ectension 27.10.2018 23:47

   if( !FileExist(ActionListNewTemp_withoutExt ".ahk") ){
        msg := "ActionList >"ActionListNewTemp_withoutExt ".ahk< `n = ActionListNewTemp_withoutExt (=clipBoard) `n ActionList NOT exist"
        msg := ":( ERROR: " msg "`n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        if(1 && InStr(A_ComputerName,"SL5")){
            clipBoard := removesSymbolicLinksFromFileAdress(A_ScriptDir "\" ActionListNewTemp_withoutExt ".ahk")
            ToolTip3sec(msg "`n" A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This,1,1)
        }

        ; Msgbox,% ":( ERROR: " msg "`n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        ; feedbackMsgBox(msg,msg,1,1)
        ActionList := globalActionListDir   "\_globalActionListsGenerated\isNotAProject.ahk"
        sleep,1000
        ; ActionListOLD := "" ; probably programmer want a reloud soon. quck an dirty ???
        ; return
    }

; returns the position of an occurrence of the string Needle in the string Haystack. Position 1 is the first character; this is because 0 is synonymous with "false",
   if( FileExist(ActionListNewTemp_withoutExt ".ahk._Generated.ahk") && !InStr(ActionListNewTemp_withoutExt, "._Generated.ahk") )
        ActionList := ActionListNewTemp_withoutExt ".ahk._Generated.ahk" ; that's probably did wrong place. But is a working bugfix. fallback. 25.10.2018 19:48
    else
        ActionList := ActionListNewTemp_withoutExt ".ahk"

    ActionList := StrReplace(ActionList, ".ahk._Generated.ahk._Generated.ahk", ".ahk._Generated.ahk") ; clean strange wordlists 25.10.2018 20:03

    ; tool too
    if(ActionListOLD == ActionList) ; thats fixed that the list is lcoaed always to early with ClearAllVars
        return
    ActionListOLD := ActionList
    g_ActionListID := getActionListID(ActionList) ; 24.03.2018 23:02

    ;tip=%ActionList% (%ActionListSize%) `n%ActionListOLD% (%ActionListLastSize%) = old `n ( %A_LineFile%~%A_LineNumber% )
    ;ToolTip4sec(tip)
    ;msgbox,%ActionList%  (%A_LineFile%~%A_LineNumber%)

    ;/¯¯¯¯ very_happy ¯¯ 181024144052 ¯¯ 24.10.2018 14:40:52 ¯¯\
    InactivateAll_Suspend_ListBox_WinHook() ; addet 24.10.2018 14:16

    ; This is to blank all vars related to matches, ListBox and (optionally) word
    ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),True) ; 24.10.2018 14:16 may help listBoxGUI NEVER HANGS TODO:check it
    ; I think it might be handy if the search word is already on the next list. Therefore I commented this line out today 24.10.2018 14:48
    ;\____ very_happy __ 181024144106 __ 24.10.2018 14:41:06 __/


        ;if(g_FLAGmsgbox == 0)
            RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; in checkInRegistryChangedActionListAddress

    ; gosub onLink2ActionListChangedInRegistry ; ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
return
;\____ checkInRegistryChangedActionListAddress __ 181025104318 __ 25.10.2018 10:43:18 __/












; ToolTip1sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This) )


;<<<<<<<< onLink2ActionListChangedInRegistry <<<< 180319214441 <<<< 19.03.2018 21:44:41 <<<<
onLink2ActionListChangedInRegistry:

if(g_doListBoxFollowMouse)
  Return

    ;Msgbox,RETURN OFF`n (%A_LineFile%~%A_LineNumber%)
    ;return
    global g_SingleMatch
    global g_FLAGmsgbox
    SetTitleMatchMode,2

    ;SetTimer,checkInRegistryChangedActionListAddress,off


    FileGetTime, ActionListModified, %ActionList%, M
    FormatTime, ActionListModified, %ActionListModified%, yyyy-MM-dd HH:mm:ss
    ;ToolTip4sec(ActionList " = ActionList `n"  ActionListModified  " `n" . A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This,1,1)
    if(ActionListModiTime_OLD <> ActionListModiTime && ActionListModiTime_OLD ){
        ;Msgbox,ActionListModiTime_OLD <> ActionListModiTime `n (%A_LineFile%~%A_LineNumber%)
        ; ParseWordsCount := ReadActionList(calledFromStr)
        ; prefs_Length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)

        g_ActionListID := getActionListID(ActionList) ; 24.03.2018 23:02
        ReadInTheActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        prefs_Length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
        ; RebuildDatabase()

        ;If(WinExist("ActionListChangedInRegistry"))
        winclose,ActionListChangedInRegistry

        ;SetTimer,checkInRegistryChangedActionListAddress,on
        ;ToolTip4sec("RecomputeMatches(calledFromStr) `n " ActionList " = ActionList `n"  ActionListModified  " `n" . A_LineNumber . " " . A_ScriptName . " " . Last_A_This,1,1)
        ;RecomputeMatches(calledFromStr) ; 27.03.2018 23:51
        return ; no update jet
    }
    ActionListModiTime_OLD := ActionListModiTime

    if(0 && firstLine := g_SingleMatch[1])
        tooltip,%firstLine% `n (%A_LineFile%~%A_LineNumber%)

    ; WinWaitNotActive,ActionListChangedInRegistry ahk_class AutoHotkeyGUI

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



; IfWinNotActive,gi-everywhere.ahk - SciTE4AutoHotkey



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
      msgbox,% A_LineNumber " " RegExReplace(A_LineFile,".*\\") "`n SuspendOn()`n"



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
setActionListFileUpdatedTime:
    ;msgbox, setActionListFileUpdatedTime 18-03-02_11-49
    return
; lets do this only first time for initializing 29.04.2017 13:40
   ActionListFileName = ActionList.ahk
   ActionList = %A_ScriptDir%\%ActionListFileName%

    ActionList := ActionList ; todo: very ugly. no time 02.03.2018 12:54 18-03-02_12-54

   ActionListOLD := ActionList

   if( !FileExist(ActionList) || InStr(FileExist(ActionList), "D") ){
        Msgbox,:(  '%ActionList%' = ActionList  `n ActionList is not a file  (%A_LineFile%~%A_LineNumber%)
        return
    }
    FileGetTime, ActionListModiTime, %ActionList%, M
    ActionListModiTime_OLD:=ActionListModiTime
return
;

ActionListTooltip:
    tip=%ActionList% `n%ActionListOLD% = old `n ( %A_LineFile%~%A_LineNumber% )
    ToolTip,% tip
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
      g_ListBoxY := round(g_ListBoxY / 100) * 100  - 80

;    class := "ahk_class AutoHotkeyGUI"
;    winTitle := "Action List Appears Here."
;    WinGetPos, X, Y, W, H, %winTitle% %class%

      newFontSize := recreateListBox_IfFontSizeChangedAndTimeIdle(listBoxFontSizeOLD , g_ListBoxFontSize )
      if(newFontSize){
        g_ListBoxFontSize := newFontSize
        listBoxFontSizeOLD := g_ListBoxFontSize
       }else
          ShowListBox(g_ListBoxX,g_ListBoxY)
return


check_some_keys_hanging_or_freezed:
  if( A_TimeIdlePhysical <= 1000 * 3 )
    return
  fixBug_Alt_Shift_Ctrl_hanging_down()
return


setRegistry_toDefault(){
    globalActionListDir := "..\ActionLists"
    ; globalActionList := globalActionListDir "\_globalActionListsGenerated\_global.ahk"
    globalActionList := globalActionListDir   "\_globalActionListsGenerated\isNotAProject.ahk"

    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListDir, %globalActionListDir% ; RegWrite , RegSave , Registry
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListActive, %globalActionList% ; RegWrite , RegSave , Registry
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListNEW, %globalActionList% ; RegWrite , RegSave , Registry
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionList, %globalActionList% ; RegWrite , RegSave , Registry
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, toDo, A_ScriptName " " A_LineNumber ": "  . " to many. 2 or 3 enough"  ; RegWrite , RegSave , Registry
}

exit_all_scripts(){
        DetectHiddenWindows, On
        WinGet, List, List, ahk_class AutoHotkey
        Loop %List%
          {
            WinGet, PID, PID, % "ahk_id " List%A_Index%
            If ( PID <> DllCall("GetCurrentProcessId") )
                 PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index%
          }
}

fixBug_Alt_Shift_Ctrl_hanging_down(){
  ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
    Suspend,On
 if( GetKeyState("Alt","P") ){ 
    tip := "Alt is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{AltUp}
  }
 if( GetKeyState("RAlt","P") ){
    tip := "Alt is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{RAltUp}
  }
 if( GetKeyState("Ctrl","P") ){
    tip := "Ctrl is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{CtrlUp}
  }
 if( GetKeyState("Shift","P") ){ 
    tip := "Shift is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{ShiftUp}
  }
 if( GetKeyState("AltGr","P") ){
    tip := "AltGr is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{ALTGR}
  }
 if( !GetKeyState("NumLock","T") ){
    tip := "NumLock was not on. we need numpad"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{NumLock}
  }
    Suspend, Off
  return
} ; endOf: fixBug_Alt_Shift_Ctrl_hanging_down


;/¯¯¯¯ check_ActionList_GUI_is_hanging_or_freezed ¯¯ 181024140430 ¯¯ 24.10.2018 14:04:30 ¯¯\
check_ActionList_GUI_is_hanging_or_freezed:
  ; g_ListBox_Id
  ;if( A_TimeIdlePhysical < 1000 * 9 )
  ;      return
  ;  ToolTip,%g_ListBox_Id% = g_ListBox_Id `n %g_ListBoxTitle% = g_ListBoxTitle `n %g_ListBoxTitle_firstTimeInMilli% = g_ListBoxTitle_firstTimeInMilli `n (%A_LineFile%~%A_LineNumber%),,1

    ; msgbox,%g_ListBoxTitle% = g_ListBoxTitle `n (%A_LineFile%~%A_LineNumber%)
    ; if(!g_ListBoxTitle)
      ;  return ; probably no problem
    SetTitleMatchMode,1
    DetectHiddenWindows,Off
    IfWinNotExist, % g_ListBoxTitle
        return ; probably no problem
    if(!g_ListBoxTitle_firstTimeInMilli){
         MsgBox, % ":( milli is empty  `n should never happens `n g_ListBoxTitle=" g_ListBoxTitle " `n g_ListBoxTitle_firstTimeInMilli = " g_ListBoxTitle_firstTimeInMilli "`n(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
        return
    }
    ;tooltip too too too__too

    elapsedMilli := A_TickCount - g_ListBoxTitle_firstTimeInMilli
    elapsedSec := ceil(elapsedMilli/1000)
    ; tip = %g_ListBoxTitle% = g_ListBoxTitle `n %elapsedSec% = elapsedSec `n (%A_LineFile%~%A_LineNumber%)
    ; ToolTip,%g_ListBoxTitle% = g_ListBoxTitle `n %elapsedSec% = elapsedSec `n (%A_LineFile%~%A_LineNumber%)
    ;MsgBox, % tip "`n`n" elapsedMilli  "millisec = " elapsedSec "sec have elapsed. (" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
    if(elapsedSec > 11){
     ;winclose, % g_ListBoxTitle
     ToolTip3sec("DestroyListBox()`n`n" A_LineNumber " " A_ScriptName )
     DestroyListBox()

     ; script hangs at this position
     ;winclose, % g_ListBoxTitle
     ;winkill, % g_ListBoxTitle
     ; reload ; script hangs if gui was not used. here we could check if its hanging. 27.09.2018 19:21 if ListBox was not used and not closed. reload helps to get script running again.
    RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; <=== dont know if this helps 19.10.2018 11:24 in check_ActionList_GUI_is_hanging_or_freezed
     ;MsgBox, % tip "`n`n" elapsedMilli  "millisec = " elapsedSec "sec have elapsed. (" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
    AHKcode := "#" . "NoTrayIcon `n "
    AHKcode =
    (
    SetTitleMatchMode, 2
    WinWaitActive,menu closed? #32770, ,1
    winclose,
    exitapp,
     )
     DynaRun(AHKcode)
     ; menu closed? ahk_class #32770 ; mouseWindowTitle=0x23d0f68  ;
     MsgBox , ,menu closed? , is it closed??? `n (%A_LineFile%~%A_LineNumber%) , 1 ; <== helps closing the listbox probalby 19.10.2018 11:28
    }
    return
  clipboard := tip
  ; too too too
return
;\____ check_ActionList_GUI_is_hanging_or_freezed __ 181024140439 __ 24.10.2018 14:04:39 __/



; too too too too toolt



;/¯¯¯¯ show_ListBox_Id
show_ListBox_Id:
    SetTimer, show_ListBox_Id, Off ; setinterval

    global g_ListBox_Id
    global g_reloadIf_ListBox_Id_notExist
    ;ToolTip1sec(g_ListBox_Id " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This,1,1)
    if(g_ListBox_Id){
        g_show_ListBox_Id_EMTY_COUNT := 0
        return
    }
    while(A_index < 100 && !g_ListBox_Id && g_reloadIf_ListBox_Id_notExist){
        sleep,10 ; Gives listbox time to arise 28.10.2018 15:18
    }
    if(!g_ListBox_Id && g_reloadIf_ListBox_Id_notExist){
        g_show_ListBox_Id_EMTY_COUNT++

    ;/¯¯¯¯ happens ¯¯ 181024150019 ¯¯ 24.10.2018 15:00:19 ¯¯\
    ; it happend 24.10.2018 15:00 will i triggered around so muhc. my foul.
    ; msgbox, should neerv happens  24.10.2018 14:28
    ToolTip5sec( g_show_ListBox_Id_EMTY_COUNT ": DisEn `n`n Very rare error which will definitely not happen again. or? (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " al= " RegExReplace(ActionList,".*\\") "  2:" ActionListNEW ,1,1)
    ; MsgBox, % ":( milli is empty  `n should never happens `n g_ListBoxTitle=" g_ListBoxTitle " `n g_ListBoxTitle_firstTimeInMilli = " g_ListBoxTitle_firstTimeInMilli "`n(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
    ;\____ happens __ 181024150022 __ 24.10.2018 15:00:22 __/

        if(1 && g_show_ListBox_Id_EMTY_COUNT >= 1){
            InactivateAll_Suspend_ListBox_WinHook() ; addet 24.10.2018 14:16
            ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),True) ; 24.10.2018 14:16 may help listBoxGUI NEVER HANGS TODO:check it
        }
        if(1 && g_show_ListBox_Id_EMTY_COUNT >= 2){ ; the only think that helps today 24.10.2018 15:11
            RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, Reload , % A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
            reload ;  [^;\n]*[ ]*\breload\b\n <= cactive reloads 18-10-28_11-47
            ; run,% "..\start.ahk" ; deactivated. test 22.10.2018 05:54
        }
        if(1 && g_show_ListBox_Id_EMTY_COUNT >= 2){
            ; DisableWinHook() ; stoped. todo: test 23.10.2018 11:17
            try{
                EnableWinHook()
            }
            ;/¯¯¯¯ ReturnWinActive ¯¯ 181022213048 ¯¯ 22.10.2018 21:30:48 ¯¯\
            ReturnWinActive() ; <=========== addet today as an test. its not disturbing. dont know if its halp
            ;\____ ReturnWinActive __ 181022213051 __ 22.10.2018 21:30:51 __/
        }
        if(1 && g_show_ListBox_Id_EMTY_COUNT >= 3)
            RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; <=== hope it helps. not sure 22.10.2018 07:59


        ;/¯¯¯¯ ;ToolTip1sec(g_ListBox_Id ¯¯ 181022055812 ¯¯ 22.10.2018 05:58:12 ¯¯\
        ; tested . it works. dont need to reload or so
        ToolTip5sec( g_show_ListBox_Id_EMTY_COUNT ": DisEn (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " al= " RegExReplace(ActionList,".*\\") "  2:" ActionListNEW ,1,1)


        if(0 && g_show_ListBox_Id_EMTY_COUNT >= 2){

            try{
             RebuildMatchList() ; line addet 19.03.2018 20:57
             InitializeListBox() ; line addet 19.03.2018 20:57^
             }
         ; RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; line addet 19.03.2018 21
        }

        ;\____ ;ToolTip1sec(g_ListBox_Id __ 181022055815 __ 22.10.2018 05:58:15 __/

        ; RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; <=== hope it helps. not sure 19.10.2018 11:34 ... not helped 19.10.2018 11:37
        ; goto, lblTopOfScriptLine111 ; <=== hope it helps. ...  not helped 19.10.2018 11:37
    }
        ;reload
        ;MsgBox, , repair Manue, repair Manue, 1
    g_reloadIf_ListBox_Id_notExist := false
        ;MsgBox, [ Options, Title, Text, Timeout]
        ;
return
;\____ show_ListBox_Id
