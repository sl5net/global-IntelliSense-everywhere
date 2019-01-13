;These functions and labels are related to the active window



;/¯¯¯¯ EnableWinHook ¯¯ 181024134525 ¯¯ 24.10.2018 13:45:25 ¯¯\
; DisableWinHook()
EnableWinHook(){
   ; tooltip,EnableWinHook => return`n (%A_LineFile%~%A_LineNumber%)
   ; return ; todo: clean it ??
      ; vermutng1: dann funktionieren gar keine hotkeys mehr. also unbedingt laufen lassen
; vermutng1 falsch falsch. läuft immer noch.



; found it will be triggered here:
; PauseResumeScript:
; if (g_PauseState == "Paused"){
; Msgbox,g_PauseState == "Paused"`n (%A_LineFile%~%A_LineNumber%)



    global g_EVENT_SYSTEM_FOREGROUND
   global g_NULL
   global g_WINEVENT_SKIPOWNPROCESS
   global g_WinChangedEventHook
   global g_WinChangedCallback

    global activeTitle ; 19-01-09_17-26

   ; Set a hook to check for a  window

    ; activ at each window change 09.01.2019 19:50

    ; ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    if(g_listSELECT_FROM_WinTitle && WinExist(g_listSELECT_FROM_WinTitle)){
        if(false){
            tip =
            (
            g_listSELECT_FROM_WinTitle = %g_listSELECT_FROM_WinTitle%
            titClean=%titClean% ?= %flagTitle_giListSELECT_running%=flagTitle_giListSELECT_running
            )
            ToolTip,% tip "`n`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" ,550,55,8
        }
    }else{
    g_listSELECT_FROM_WinTitle := ""
    ; g_permanentSELECT := ""

; php ts test php. kkk lll lll

	flagTitle_giListSELECT := "giListSELECT" ; 09.01.2019 11:26 19-01-09_11-26
	flagTitle_giListSELECT_running := " (" flagTitle_giListSELECT ")" ; 09.01.2019 11:26 19-01-09_11-26
	lenTemp := strlen(flagTitle_giListSELECT_running)
    if(!activeTitle)
        WinGetTitle, activeTitle, A
	titClean := substr(activeTitle, - (lenTemp-1) )
	tip =
	(
g_listSELECT_FROM_WinTitle = %g_listSELECT_FROM_WinTitle%

; test too

name: titClean ?= flagTitle_giListSELECT_running
value: >%titClean%< ?= >%flagTitle_giListSELECT_running%<
	)
	; ToolTip,% tip "`n`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" ,550,55,8
	; msgbox,% tip "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
	; msgbox tooltip
	if(titClean == flagTitle_giListSELECT_running){
        g_listSELECT_FROM_WinTitle := activeTitle
        s1 := substr(activeTitle,1, - (lenTemp-1) )
        ;s2 := RegExReplace(s1, "i)(\bLike\b[^']+')([^']+)'" , "`n$1%$2%'") ; add wildcardd
        if(regExMatch(activeTitle , "i)(SELECT\s+actionList\b|\bFROM\s+actionLists\b)"  ))
            g_permanentSELECT_type := "SELECT actionList"
        else
            g_permanentSELECT_type := ""
        g_permanentSELECT := "SELECT " s1
        tip =
        (
        found: %g_listSELECT_FROM_WinTitle%

        %g_permanentSELECT%
        )
    	; ToolTip,% tip "`n`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" ,550,55,8
    }else {
        if(g_listSELECT_FROM_WinTitle)
            g_permanentSELECT := "" ; was set by winTitle
        g_listSELECT_FROM_WinTitle := ""
        g_permanentSELECT_type := ""
     }
}


       ;SoundbeepString2Sound(A_ThisFunc)



   If !(g_WinChangedEventHook)
   {
      MaybeCoInitializeEx()
      g_WinChangedEventHook := DllCall("SetWinEventHook", "Uint", g_EVENT_SYSTEM_FOREGROUND, "Uint", g_EVENT_SYSTEM_FOREGROUND, "Ptr", g_NULL, "Uint", g_WinChangedCallback, "Uint", g_NULL, "Uint", g_NULL, "Uint", g_WINEVENT_SKIPOWNPROCESS)



      ;msgbox,% g_WinChangedEventHook " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " "



      if !(g_WinChangedEventHook){



        Speak("Failed to register Event Hook")
        msg := "Failed to register Event Hook! `n  g_WinChangedEventHook=" . g_WinChangedEventHook . "`n 17-07-16_16-21"
        ToolTip5sec(msg " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " )
        ;msgbox, % msg
        lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,msg )
         return false
         ;ExitApp
      }
   }
   Return
}
;\____ EnableWinHook __ 181024134530 __ 24.10.2018 13:45:30 __/



;/¯¯¯¯ DisableWinHook ¯¯ 181024141107 ¯¯ 24.10.2018 14:11:07 ¯¯\
DisableWinHook(){
   global g_WinChangedEventHook



    ; SoundbeepString2Sound(A_ThisFunc)



   if (g_WinChangedEventHook)
   {
      if (DllCall("UnhookWinEvent", "Uint", g_WinChangedEventHook))
      {
         g_WinChangedEventHook =
         MaybeCoUninitialize()
      } else {
         MsgBox, Failed to Unhook WinEvent!
         ExitApp
      }
   }
   return
}
;\____ DisableWinHook __ 181024141113 __ 24.10.2018 14:11:13 __/



; SetTimer,checkWinChangedTitle,1000 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList


;/¯¯¯¯ set0() ¯¯ 190109172051 ¯¯ 09.01.2019 17:20:51 ¯¯\
set0(){
    global activeTitle
    global activeTitleOLD
    global actionList
    global actionListOLD
    global g_itsProbablyArecentUpdate
    global timeFirstTry_getNewListFromRegistry
    global milliesTried_getNewListFromRegistry
    activeTitleOLD := activeTitle
    actionList := ""
   actionListOLD := ""
   g_itsProbablyArecentUpdate := false
   timeFirstTry_getNewListFromRegistry := 0
   milliesTried_getNewListFromRegistry := 0
   return
}
;\____ set0() __ 190109172055 __ 09.01.2019 17:20:55 __/

;



checkWinChangedTitle:
global activeTitle
global activeTitleOLD
global actionList
global actionListOLD
global g_itsProbablyArecentUpdate

global g_listSELECT_FROM_WinTitle ; addet 19-01-09_11-51
global g_permanentSELECT ; addet 19-01-09_11-51
global g_permanentSELECT_type ; addet 19-01-09_11-51

    activeTitleOLD := activeTitle
    WinGetActiveTitle, activeTitle
    if(activeTitleOLD <> activeTitle){
       set0()
       Speak(A_ThisFunc A_thisLabel)
       SetTimer,checkInRegistryChangedActionListAddress,on ; seems has no effect anymore 01.11.2018 19:14
    }
return
;/¯¯¯¯ WinChanged ¯¯ 181022212344 ¯¯ 22.10.2018 21:23:44 ¯¯\
; Hook function to detect change of focus (and remove ListBox when changing active window)
; 31.10.2018 18:36: always if i change window by mousecliok
; 31.10.2018 18:36: always if i change window by alt+tab
; 01.11.2018 13:27 i called it manually by typing
; WinChanged(hWinEventHook, event, wchwnd, idObject, idChild, dwEventThread, dwmsEventTime)
; inside the function SendWord . and it works.
WinChanged(hWinEventHook, event, wchwnd, idObject, idChild, dwEventThread, dwmsEventTime){
   global g_inSettings
   global g_ManualActivate
   global g_OldCaretY
   global prefs_DetectMouseClickMove



    ; tooltip



    set0()
   EnableKeyboardHotKeys() ; seems needet 01.11.2018 19:04



   ; SoundbeepString2Sound(A_ThisFunc)
   speak(A_ThisFunc)
   ; SetTimer,checkInRegistryChangedActionListAddress,on ; seems has no effect anymore 01.11.2018 19:14
   gosub,checkInRegistryChangedActionListAddress
   ; but it should work: https://autohotkey.com/boards/viewtopic.php?p=247296#p247296



   ;  too too



   If (event <> 3){
      return
   }



   if (g_ManualActivate := true){
      ; ignore activations we've set up manually and clear the flag
      g_ManualActivate = 
      return
   }      



   if (g_inSettings := true ){
      return
   }



   if (SwitchOffListBoxIfActive()){
      return
   }



   IF ( ReturnWinActive() ){
      IfNotEqual, prefs_DetectMouseClickMove, On 
      {
         IfNotEqual, g_OldCaretY,
         {
            if ( g_OldCaretY != CaretYorMouseYfallback() )
            {
            ;   ToolTip,lost focus 17-03-12_16-14
               CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
            }
         }
      }
      ; SciTEWindow\_global.ahk
   } else {
      GetIncludedActiveWindow()
   }



    ; ToolTip,% g_WinChangedEventHook " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " "
    ; soundbeep,5000
    ; soundbeep,5000
    ; soundbeep,5000
    ; soundbeep,5000
    ;sleep,2000



   Return
}
;\____ WinChanged __ 181031183224 __ 31.10.2018 18:32:24 __/



;/¯¯¯¯ SwitchOffListBoxIfActive ¯¯ 181022212325 ¯¯ 22.10.2018 21:23:25 ¯¯\
; this function is triggerd early every key pressed 01.11.2018 13:02
SwitchOffListBoxIfActive(){
   global g_Active_Id
   global g_ListBox_Id
   global g_ManualActivate



  ; Speak(A_ThisFunc)



   if (g_Active_Id && g_ListBox_Id) {
      WinGet, Temp_id, ID, A   
      IfEqual, Temp_id, %g_ListBox_Id%
      {
         ;set so we don't process this activation
         g_ManualActivate := true
         WinActivate, ahk_id %g_Active_Id%



         return, true
      }
   }
   return, false
}
;\____ WinChanged __ 181022212351 __ 22.10.2018 21:23:51 __/



;/¯¯¯¯ GetIncludedActiveWindow ¯¯ 181022212408 ¯¯ 22.10.2018 21:24:08 ¯¯\
; Wrapper function to ensure we always enable the WinEventHook after waiting for an active window
; Returns true if the current window is included
GetIncludedActiveWindow() {
   global g_Active_Pid
   global g_Active_Process
   global g_DpiAware
   global g_OSVersion
   global g_Process_DPI_Unaware
   global g_Process_System_DPI_Aware
   global g_Process_Per_Monitor_DPI_Aware
   global prefs_ListBoxNotDPIAwareProgramExecutables



 ;   SoundbeepString2Sound(A_ThisFunc)



   CurrentWindowIsActive := GetIncludedActiveWindowGuts()



   if (g_Active_Pid) {
      ; we'll first assume the software is system DPI aware
      DpiAware := g_Process_System_DPI_Aware
      ; if Win 8.1 or higher, we can actually check if it's system DPI aware
      if (g_OSVersion >= 6.3)
      {
         ProcessHandle := DllCall("OpenProcess", "int", g_PROCESS_QUERY_INFORMATION | g_PROCESS_QUERY_LIMITED_INFORMATION, "int", 0, "UInt", g_Active_Pid)
         DllCall("GetProcessDpiAwareness", "Ptr", ProcessHandle, "Uint*", DpiAware)
         DllCall("CloseHandle", "Ptr", ProcessHandle)
      }



      ; check the override list for processes that aren't DPI aware
      if (DpiAware != g_Process_DPI_Unaware) {  
         Loop, Parse, prefs_ListBoxNotDPIAwareProgramExecutables, |
         {
            IfEqual, g_Active_Process, %A_LoopField%
            {
               DpiAware := g_Process_DPI_Unaware
               break
            }
         }
      }



      If (DpiAware == g_Process_DPI_Unaware) {
         g_DpiAware := DpiAware
      } else if (DpiAware == g_Process_System_DPI_Aware) {
         g_DpiAware := DpiAware
      } else if (DpiAware == g_Process_Per_Monitor_DPI_Aware) {
         g_DpiAware := DpiAware
      } else {
         g_DpiAware := g_Process_System_DPI_Aware
      }
   }



   EnableWinHook()



   ; ToolTip,% g_WinChangedEventHook " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " "
   ; soundbeep,1000



   Return, CurrentWindowIsActive
}
;\____ GetIncludedActiveWindow __ 181022212417 __ 22.10.2018 21:24:17 __/



;/¯¯¯¯ GetIncludedActiveWindowGuts ¯¯ 181022212430 ¯¯ 22.10.2018 21:24:30 ¯¯\
GetIncludedActiveWindowGuts() {
   global g_Active_Id
   global g_Active_Pid
   global g_Active_Process
   global g_Active_Title
   global g_Helper_Id
   global g_LastActiveIdBeforeHelper
   global g_ListBox_Id
   global g_MouseWin_Id
   Process, Priority,,Normal
   ;Wait for Included Active Window



  ;  SoundbeepString2Sound(A_ThisFunc)



   CurrentWindowIsActive := true



   Loop
   {
      WinGet, ActiveId, ID, A
      WinGet, ActivePid, PID, ahk_id %ActiveId%
      WinGet, ActiveProcess, ProcessName, ahk_id %ActiveId%
      WinGetTitle, activeTitle, ahk_id %ActiveId%
      IfEqual, ActiveId, 
      {
         IfNotEqual, g_MouseWin_Id,
         {
            IfEqual, g_MouseWin_Id, %g_ListBox_Id% 
            {
               WinActivate, ahk_id %g_Active_Id%
               Return, CurrentWindowIsActive
            }
         }



         CurrentWindowIsActive := false



             lll( A_ThisFunc ":" A_LineNumber , A_LineFile ," InactivateAll_Suspend_ListBox_WinHook() 17-08-04_16-19c")
             ; run,\.\log\%A_LineFile%.log.txt



         InactivateAll_Suspend_ListBox_WinHook()
         ;Wait for any window to be active



         tip="WinWaitActive, , , , ZZZYouWillNeverFindThisStringInAWindowTitleZZZ`n" A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") . " " . Last_A_This
         ToolTip4sec(tip " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
         ; msgbox,% tip
         WinWaitActive, , , , ZZZYouWillNeverFindThisStringInAWindowTitleZZZ
         Continue
      }
      IfEqual, ActiveId, %g_Helper_Id%
         Break
      IfEqual, ActiveId, %g_ListBox_Id%
         Break
      If CheckForActive(ActiveProcess,activeTitle)
         Break



      CurrentWindowIsActive := false
                   lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"GetIncludedActiveWindowGuts() > LOOP >  CurrentWindowIsActive := false > InactivateAll_Suspend_ListBox_WinHook() 18-02-10_09-44")
                  ; run,\.\log\%A_LineFile%.log.txt



      InactivateAll_Suspend_ListBox_WinHook()
      SetTitleMatchMode, 3 ; set the title match mode to exact so we can detect a window title change
      ; Wait for the current window to no longer be active
      WinWaitNotActive, %activeTitle% ahk_id %ActiveId% ; whats the use of this ? script stops at this possition. i will deactivat this line now 16.07.2017 11:31 17-07-16_11-31
      SetTitleMatchMode, 2
      ActiveId = 
      activeTitle =
      ActiveProcess =
   }
;
   IfEqual, ActiveId, %g_ListBox_Id%
   {
      g_Active_Id :=  ActiveId
      g_Active_Pid := ActivePid
      g_Active_Process := ActiveProcess
      g_Active_Title := activeTitle
      Return, CurrentWindowIsActive
   }



   ;if we are in the Helper Window, we don't want to re-enable script functions
   IfNotEqual, ActiveId, %g_Helper_Id%
   {
      ; Check to see if we need to reopen the helper window
      MaybeOpenOrCloseHelperWindow(ActiveProcess,activeTitle,ActiveId)
      SuspendOff()
      ;Set the process priority back to High
      Process, Priority,,High
      g_LastActiveIdBeforeHelper = %ActiveId%



   } else {
      IfNotEqual, g_Active_Id, %g_Helper_Id%
         g_LastActiveIdBeforeHelper = %g_Active_Id%               
   }



   global g_LastInput_Id
   ;Show the ListBox if the old window is the same as the new one
   IfEqual, ActiveId, %g_LastInput_Id%
   {
      WinWaitActive, ahk_id %g_LastInput_Id%,,0
      ;Check Caret Position again
      CheckForCaretMove("LButton")
      ShowListBox()
   } else
      CloseListBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
   g_Active_Id :=  ActiveId
   g_Active_Pid := ActivePid
   g_Active_Process := ActiveProcess
   g_Active_Title := activeTitle



  ; ToolTip,% g_WinChangedEventHook " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " "
  ; soundbeep,800



   Return, CurrentWindowIsActive
}
;\____ GetIncludedActiveWindowGuts __ 181031183032 __ 31.10.2018 18:30:32 __/



;/¯¯¯¯ CheckForActive ¯¯ 181031183100 ¯¯ 31.10.2018 18:31:00 ¯¯\
CheckForActive(ActiveProcess,activeTitle){



   ;Check to see if the Window passes include/exclude tests
   global g_InSettings
   global prefs_ExcludeProgramExecutables
   global prefs_ExcludeProgramTitles
   global prefs_IncludeProgramExecutables
   global prefs_IncludeProgramTitles



  ; ToolTip,% g_WinChangedEventHook " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " "
 ; SoundbeepString2Sound(A_ThisFunc)



   quotechar := """"



   If g_InSettings
      Return,



   Loop, Parse, prefs_ExcludeProgramExecutables, |
   {
      IfEqual, ActiveProcess, %A_LoopField%
         Return,
   }



   Loop, Parse, prefs_ExcludeProgramTitles, |
   {



      if (SubStr(A_LoopField, 1, 1) == quotechar && SubStr(A_LoopField, StrLen(A_LoopField), 1) == quotechar)
      {
         StringTrimLeft, TrimmedString, A_LoopField, 1
         StringTrimRight, TrimmedString, TrimmedString, 1
         IfEqual, activeTitle, %TrimmedString%
         {
            return,
         }
      }  else IfInString, activeTitle, %A_LoopField%
      {
         return,
      }
   }



   IfEqual, prefs_IncludeProgramExecutables,
   {
      IfEqual, prefs_IncludeProgramTitles,
         Return, 1
   }



   Loop, Parse, prefs_IncludeProgramExecutables, |
   {
      IfEqual, ActiveProcess, %A_LoopField%
         Return, 1
   }



   Loop, Parse, prefs_IncludeProgramTitles, |
   {
      if (SubStr(A_LoopField, 1, 1) == quotechar && SubStr(A_LoopField, StrLen(A_LoopField), 1) == quotechar)
      {
         StringTrimLeft, TrimmedString, A_LoopField, 1
         StringTrimRight, TrimmedString, TrimmedString, 1
         IfEqual, activeTitle, %TrimmedString%
         {
            Return, 1
         }
      } else IfInString, activeTitle, %A_LoopField%
      {
         Return, 1
      }
   }



   Return, 
}
;\____ CheckForActive __ 181022212448 __ 22.10.2018 21:24:48 __/



;/¯¯¯¯ ReturnWinActive ¯¯ 181022212502 ¯¯ 22.10.2018 21:25:02 ¯¯\
ReturnWinActive(){
   global g_Active_Id
   global g_Active_Title
   global g_InSettings



  ;   ToolTip,% g_WinChangedEventHook " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " "
  ;  SoundbeepString2Sound(A_ThisFunc)



   IF g_InSettings
      Return



   if (SwitchOffListBoxIfActive()){
      return, true
   }



   WinGet, Temp_id, ID, A
   WinGetTitle, Temp_Title, ahk_id %Temp_id%
   Last_Title := g_Active_Title
   ; remove all asterisks, dashes, and spaces from title in case saved value changes
   StringReplace, Last_Title, Last_Title,*,,All
   StringReplace, Temp_Title, Temp_Title,*,,All
   StringReplace, Last_Title, Last_Title,%A_Space%,,All
   StringReplace, Temp_Title, Temp_Title,%A_Space%,,All
   StringReplace, Last_Title, Last_Title,-,,All
   StringReplace, Temp_Title, Temp_Title,-,,All
   Return, (( g_Active_Id == Temp_id ) && ( Last_Title == Temp_Title ))
}
;\____ ReturnWinActive __ 181022212545 __ 22.10.2018 21:25:45 __/