; https://stackoverflow.com/questions/4675202/notepad-setting-for-disabling-auto-open-previous-files

#Include %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

Menu, Tray, Icon, shell32.dll, 24
;~ Menu, Tray, Icon, shell32.dll, 2 ; a ide or floppy
; MsgBox,% "ExitApp " msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

OnExit("exitFunc")  

doWorkaroundRerun_gIntelliISense := false 
;doWorkaroundRerun_gIntelliISense := true
global g_DelayMilliSec := 150
; global g_DelayMilliSec := 500
global g_PressDuration := 370

pleaseSeteNotepadPP =
(
For versions 6.6+ you need to uncheck 
"Remember the current session for next launch" on Settings -> Preferences -> Backup.
Einstellungen -> Optionen -> Backup : UnCheck "Aktuelle Sitzung für den nächsten Start merken."
)

global g_error_log := ""
global g_closedAHKlist := []
if(1){ ; may better do this
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
}

  deleteAll_tstamp_in_32770_folder() ; dont do it while notpad is open. it may crash 18-03-31_23-58 31.03.2018 23:59



  ; feedbackMsgBoxCloseAllWindows()
  closeAllOtherAHK() 
  restoreClosedAHK() 
  
  SetTimer,lbsFastTime,100
  tWL := tests()
  

  if(Trim(g_error_log)) {
    while(1){
      SoundbeepGameOver()
      Sleep,6000
      ;Msgbox,%g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%) 
    }
    Msgbox, ,:( %g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%)   , , 5
  }else{
    ;SoundbeepACK()
    SoundbeepMissionImpossibleTheme()
    Msgbox, , :-) all tests run without errors  :-) `n (%A_LineFile%~%A_LineNumber%)  , , 2
  }
 

    Msgbox,rerun ? `n (%A_LineFile%~%A_LineNumber%) 
  Reload
  
return

#IfWinActive,
f12::
  Hotkey,f12,f12,Off
  MsgBox,reRun ?
  Reload
return

SetTitleMatchMode,2
#IfWinActive,g-IntelliSense_unitTests
f10::tests()
;return
;<<<<<<<< tests <<<< 180329000517 <<<< 29.03.2018 00:05:17 <<<<
tests(){
  ToolTip,
  if(1)
    run,..\start.ahk
  

  SetTitleMatchMode,2
  if(0){ ; its not working
    DetectHiddenWindows,On
    name=gi-everywhere.ahk
    name=gi-everywhere - Active ahk_class AutoHotkey
    WinShow,% name
    IfWinExist,% name
      Msgbox,`n (%A_LineFile%~%A_LineNumber%) 
    if(WinExist(name))
      Msgbox,`n (%A_LineFile%~%A_LineNumber%) 
    return
    
    DetectHiddenWindows,on
    WinWait,gi-everywhere - Active,,12
    if(!winWaitLoop("gi-everywhere - Active"))
      return
    DetectHiddenWindows,Off

  }
  ; too tooo__
  ; emty ActionList state. space for new one without question about it:
  ;setRegistry_ActionList("notWorkingFileAdress18-03-31_09-19")
#Include,RegWrite181031.ahk

  ; if(doWorkaroundRerun_gIntelliISense)
  ;  run,..\start.ahk
  Sleep,2000
  ;feedbackMsgBox("hi :) lets make some tests now. ", A_LineNumber . " , " . A_ScriptName,1,1)
  SetTitleMatchMode,2

  closeDisturbingWindows()

  ;feedbackMsgBox("try: create window never existed before", A_LineNumber . " , " . A_ScriptName,1,1)
  openInputBoxTitle := create_a_window_never_existed_before()
  WinSet, AlwaysOnTop, On, % openInputBoxTitle
  WinMove, % openInputBoxTitle, , 380 , 200,1500
  Sleep,4500 ; give script time to genere new list address
  close_ActionListChangedInRegistry()
  
  
  feedbackMsgBox("try: open ActionList first time", A_LineNumber . " , " . A_ScriptName,1,1)
  ;SetTimer,setStatus_created_token,10 ; global g_created_token  ; not working. this window is to fast
  tWL := open_ActionList_first_time( openInputBoxTitle )
  WinActivateTry(tWL,9)
  WinGetActiveTitle, tWL
  check_wrong_ActionLists()
  ; now new list is created :) that wunderful :) 
  if(g_error_log) {
    Msgbox,%g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%) 
    return tWL
  }
  Sleep,1000
  ; global g_created_token ; not working. this window is to fast
  ; MsgBox,% g_created_token " = g_created_token "  ; not working. this window is to fast
  ; return

  if(doWorkaroundRerun_gIntelliISense)
    run,..\start.ahk
  ;Sleep,3500




  feedbackMsgBox("try: open ActionList second time", A_LineNumber . " , " . A_ScriptName,1,1)
  tWLsaved := tWL
  check_wrong_ActionLists()
  WinActivateTry(tWL,9)
  tWL := open_for_second_time_ActionList_of_this_new_window(openInputBoxTitle)
  if(!tWL || !InStr(tWLsaved,tWL)){ ; tWL is maybe only the file name. thats ok
    SoundbeepNoACK()
    Msgbox,:( `ntWLsaved <> tWL `n%tWLsaved% <> %tWL%=tWL `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber%) 
    return tWL
  }
  SoundbeepACK()
  WinActivateTry(tWL,9)
  WinGetActiveTitle, tWL ; need complete title !! becouse of poof saved state of notepadd++
  ; now list is reopend :) that wunderful :) 
  check_wrong_ActionLists()

  if(g_error_log) {
    SoundbeepNoACK()
    Msgbox,%g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%) 
    return tWL
  }
  SoundbeepACK()
  if(true){
    ;feedbackMsgBox("try:add helloEurope|r|helloWorld to ActionList now", A_LineNumber . " , " . A_ScriptName,1,1)
    WinActivateTry(tWL,9)
    IfWinNotExist,% tWL
    {   
      SoundbeepNoACK()
      Msgbox,:( `n WinNotExist %tWL% `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber% )    
    }
    ;IfWinNotActive,% tWL ; is nicht so wichtig
    ;  Msgbox,:( `n WinNotActive %tWL% `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber% )
    tWLsaved := tWL
    Loop,9
    {
      sendAeUeLines(tWLsaved) ; this function do not saved
      Sleep,60
      WinGetActiveTitle, tWLunsaved
      if(tWLunsaved <> tWL1saved)
        break
    }
    if(tWLunsaved <> tWLsaved)
      isLinesAddet := true
    
    if(!isLinesAddet){
      SoundbeepNoACK()
      Msgbox,:( no lines addet. name of notepaddWindow not chaged: `ntWLsaved == tWLunsaved `n %tWLsaved% == %tWLunsaved% `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber%) 
    }
     
    global g_DelayMilliSec
    global g_PressDuration
    SetKeyDelay,% g_DelayMilliSec,% g_PressDuration ; sometimes helpful 28.03.2018 23:17
    while(A_Index < 50){
      WinActivateTry(tWLunsaved,9)
      IfWinActive,% tWLunsaved
        send,^s ; save the changes 
      If(!winExist(tWLunsaved))
        break ; its saved :)
  }
    IfWinExist,% tWLunsaved
    {
      SoundbeepNoACK()
      Msgbox,:( `n IfWinExist `n%tWLunsaved% `n not saved (%A_LineFile%~%A_LineNumber%) 
      ;Msgbox,:( `ntWLsaved <> tWL `n%tWLsaved% <> %tWL% `n not saved (%A_LineFile%~%A_LineNumber%) 
    }
    ;Msgbox,saved ?? `n (%A_LineFile%~%A_LineNumber%) 
    
    IfWinNotActive,% t
    {
      SoundbeepNoACK()
      g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"  
    }      
    winCloseTry(t)
  }
    
    address := isActionListFileExist(openInputBoxTitle) ; warten bis erstellt ist
    FileRead,content, % address
    if(!InStr(content, "helloEurope|r|helloWorld")){
      SoundbeepNoACK()
      Msgbox,:( `n %address% `n not saved (%A_LineFile%~%A_LineNumber%) 
      return
  }
  SoundbeepACK()
    
  feedbackMsgBox("try: open generated", A_LineNumber . " , " . A_ScriptName,1,1)
  SetTitleMatchMode,2
  while(A_Index < 5){
    send2inputBox("__",5,openInputBoxTitle) 
    IfWinExist,% ".ahk._Generated.ahk"
      break
  }
  SoundbeepACK()
  WinMove,.ahk._Generated.ahk,, 912,35, 882,1055

  WinActivateTry(tWL,9)
  
  if(False){
  SetTitleMatchMode,2
  while(A_Index<5 && !WinExist("hi World")){
    if(!trickyUglySendTextWorkaround2inputBox("hi","", openInputBoxTitle)) 
      break
  }
  if(!WinExist("","hi World"))
        g_error_log .= ":( hi World " A_ThisFunc " (line=" A_LineNumber ") `n"
  }

  WinActivateTry(tWL,9)

    msg := "try some action like helloEurope|r|helloWorld in inputbox ", A_LineNumber . " , " . A_ScriptName
    feedbackMsgBox(msg)
    if(!trickyUglySendTextWorkaround2inputBox("aa",chr(228), openInputBoxTitle))
        g_error_log .= ":( ae " A_ThisFunc " (line=" A_LineNumber ") `n"

 ; global g_DelayMilliSec := 2000
 ; global g_PressDuration := 2000
 ;   if(!trickyUglySendTextWorkaround2inpu5tBox("hell","helloWorld", openInputBoxTitle)) 
  ;      g_error_log .= ":( helloE " A_ThisFunc " (line=" A_LineNumber ") `n"
    ;trickyUglySendTextWorkaround2inputBox("he","hallo", openInputBoxTitle)
    ;__feedbackMsgBox("try: list text hotkeys", A_LineNumber . " , " . A_ScriptName,1,1)
    ;trickyUglySendTextWorkaround2inputBox("held","hallo", openInputBoxTitle)

  return tWL

  Msgbox,rerun ? `n (%A_LineFile%~%A_LineNumber%) 
  Reload
  
  ;Msgbox, :-) all tests run without errors  :-) `n (%A_LineFile%~%A_LineNumber%) 
  ;close_tstamp()  
}
;>>>>>>>> tests >>>> 180329000537 >>>> 29.03.2018 00:05:37












open_for_second_time_ActionList_of_this_new_window(openInputBoxTitle){
 if(!openInputBoxTitle){
    Msgbox,:( `n (%A_LineFile%~%A_LineNumber%)
    return false
  }
  tWL := openInputBoxTitle ".ahk"
  
;############## we inside: open_for_second_time_ActionList_of_this_new_window
 ; next step open it again
    ;close_tstamp()   ; first close it
    SetTitleMatchMode,2
    Loop,29
    {
      ;IfWinExist,.txt
        WinClose,.ahk
        WinClose,% tWL
      WinWaitClose,.ahk,,1
      IfWinNotExist,.ahk
        break
    } 
    IfWinExist,.ahk
    {
      Msgbox,:( `n %t% `n  found `n (%A_LineFile%~%A_LineNumber%) 
      return False
    }
     ; Msgbox,all txt now closed ????????????????? `n %t% `n  found `n (%A_LineFile%~%A_LineNumber%) 
    
;############## we inside: open_for_second_time_ActionList_of_this_new_window
    
    openInputBox(openInputBoxTitle)
    ;WinActivateTry(openInputBoxTitle,9)
    ;WinActivate,openInputBoxTitle
    menuNr := 4 
    t := openInputBoxTitle ".ahk"
    Loop,24
    {
      WinActivateTry(openInputBoxTitle,9)
      runMenu("__",menuNr, openInputBoxTitle ) ; open new ahk
      SetTitleMatchMode,2
      WinWait,% t,,3
      IfWinExist,% t
        break
      if(A_Index > 1 && Mod(A_Index, 4) == 0){
        ;ToolTip4sec(":( freezed ?? ==> start.ahk `n " A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
        ToolTip4sec(":( freezed ??  `n " A_LineNumber ==>  " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
        Send,{AltDown}{Tab 3}{AltUp}
        ;run,..\start.ahk1
        close_ActionListChangedInRegistry()
        Sleep,3100
      }
    }  
    SetTitleMatchMode,2
    WinWait,% t, ,16 ; use 9 sec bevor. that was to short 
    IfWinExist,% t
      return t
    
    Msgbox,:( `n %t% `n not found `n (%A_LineFile%~%A_LineNumber%) 
  g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
}









  winWaitLoop(t, maxLoops:=400,s :=100){
    SetTitleMatchMode,2
    Loop,%maxLoops%
    {
      IfWinExist,% t
        return t
      Sleep,% s
    }
    IfWinExist,% t
      return t
      ; Msgbox,:( `n %t% `n not found `n (%A_LineFile%~%A_LineNumber%) 
    g_error_log .= ":( " t " `n not found `n `n (" A_ThisFunc ", line=" A_LineNumber ") `n"
    return false
  }





create_a_window_never_existed_before(){
  wn := openInputBox()
  return wn
}

openInputBox(timestampyyMMddHHmmss:=""){
  if(!timestampyyMMddHHmmss){
    FormatTime, timestampyyMMddHHmmss , %A_now%,yyMMddHHmmss
    timestampyyMMddHHmmss := "tstamp_" timestampyyMMddHHmmss 
    FormatTime, timestampyyMMddHHmmssPretty, %A_now%,yy:MM:dd HH:mm:ss 
  }else{
    SetTitleMatchMode,1
    IfWinExist,% timestampyyMMddHHmmss
    {
      WinActivate,% timestampyyMMddHHmmss
      return
    }
    SetTitleMatchMode,3
    IfWinExist,% timestampyyMMddHHmmss
    {
      WinActivate,% timestampyyMMddHHmmss
      return
    }
    SetTitleMatchMode,2
    IfWinExist,% timestampyyMMddHHmmss
    {
      WinActivate,% timestampyyMMddHHmmss
      return
    }
  }
  AHKcode = InputBox, UserInput, %timestampyyMMddHHmmss%, dymmy text , , 190, 90
  DynaRun(AHKcode) ; wait for user decision
  SetTitleMatchMode,3
  WinWait, % timestampyyMMddHHmmss, , 6
  IfWinNotExist,% timestampyyMMddHHmmss
  {
    Msgbox,:( `n %timestampyyMMddHHmmss% `n not found `n (%A_LineFile%~%A_LineNumber%) 
    g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
    return
  }
  close_ActionListChangedInRegistry()
  return timestampyyMMddHHmmss
}





send2inputBox_OLD(text,nr := 1,t:=""){ ; of https://github.com/sl5net/global-IntelliSense-everywhere
  if(!t){
    Msgbox,:( `n !t parameter empty `n found `n (%A_LineFile%~%A_LineNumber%) 
    return false
  }
  
  SetTitleMatchMode,2
  ;closeDisturbingWindows_without_tstamp_18()
  close_ActionListChangedInRegistry()

if(1){ ; may better do this
  SendLevel 0
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
  SendLevel 100
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
}

  SendLevel 100
  SetCapsLockState,Off
  
  ;SetKeyDelay,180,120
  global g_DelayMilliSec
  global g_PressDuration
  SetKeyDelay,% g_DelayMilliSec,% g_PressDuration ; sometimes helpful 28.03.2018 23:17
  ;SetKeyDelay,80,320 ; works much better !!! :)

  WinActivate,% t
  WinWaitActive,% t, , 1

;############# inside send2inputBox_OLD

  IfWinNotActive,% t
    return false
  IfWinActive,% t ".ahk"
    return false

  Sleep, 2000
  SendRaw,% text
  Sleep,800
  
  IfWinNotActive,% t
    return false
  IfWinActive,% t ".ahk"
    return false
  
  SendRaw,% nr
  Sleep,900
  return true
}





runMenu(text,nr,t,sLevel:=55){ ; of https://github.com/sl5net/global-IntelliSense-everywhere
  if(!nr){
    ToolTip,:( `n !nr parameter empty `n  (%A_LineFile%~%A_LineNumber%) 
    return false
  }  
  if(!t){
    ToolTip,:( `n !t parameter empty `n  (%A_LineFile%~%A_LineNumber%) 
    return false
  }
  
  SetTitleMatchMode,2
  ;closeDisturbingWindows_without_tstamp_18()
  close_ActionListChangedInRegistry()

if(1){ ; may better do this
  SendLevel 0
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
  SendLevel 100
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
}

SendLevel, % sLevel
ToolTip,% "A_SendLevel = " A_SendLevel "`n" A_LineNumber   
SetCapsLockState,Off
  
  ;DelayMilliSec := 50
  ;PressDuration := 20
  global g_DelayMilliSec
  global g_PressDuration
  SetKeyDelay,% g_DelayMilliSec,% g_PressDuration, SendInput ; sometimes helpful 28.03.2018 23:17
  ; SetKeyDelay,180,120
  ; SetKeyDelay,80,320 ; works much better !!! :)

  close_ActionListChangedInRegistry()
  WinActivate,% t
  WinWaitActive,% t, , 1

  WinActivateTry(t,9)
; ### we inside: runMenu(nr := 1 ...

  IfWinNotActive,% t
    return false
  IfWinActive,% t ".ahk"
    return false

; ############### inside runMenu(

  ;send,%nr%{space}
  ;send,%nr%
  ; ControlSend, , % nr, % t  ; Send directly 

  IfWinNotActive,% t
    return false
  ;Send,{space} ; for some reasons??? need a space
  ; SendInput {space} ; destros input ups 
  Sleep,3000
  SendInput {Raw}%text% ; geht auch
  ;SendRaw, %text%  ; geht auch
  ;ControlSendRaw, , ____, % t  ; Send directly 
  ;ControlSend, , ____, % t  ; Send directly 
  Sleep,800
  close_ActionListChangedInRegistry()

; ############### inside runMenu(

; ### we inside: runMenu(nr := 1 ...

;ControlSend, , % nr, % t  ; Send directly 
  ; send,% nr ; open ActionList / entry one
  close_ActionListChangedInRegistry()
  ;ControlSendRaw, , % nr, % t  ; Send directly ; dont use it 
  SendRaw,% nr ; open ActionList / entry one
  Sleep,433
  
  IfWinNotActive,% t
    return false
  IfWinActive,% t ".ahk"
    return false

; ############### inside runMenu(

; ### we inside: runMenu(nr := 1 ...

  
  return true
}

lbsFastTime:
  ;close_ActionListChangedInRegistry()
  t = Save ahk_class #32770 ; mouseWindowTitle=0x2fd0f52  ; 
  ControlSend, , n , % t ; dont save
  ;ControlSend,n
  WinClose,% t
  
  t = Keep non existing file ahk_class #32770 ; mouseWindowTitle=0xb805f2  ; 
  ControlSend, , n , % t ; dont save
  WinClose,% t
  
; WinMove,Save ahk_class #32770 ,, 1011,696, 554,220

return




closeDisturbingWindows_without_tstamp_18(){
  close_ActionListChangedInRegistry()
  close_ahk_global_txt()
}
closeDisturbingWindows(){
  close_tstamp()
  close_ActionListChangedInRegistry()
  close_ahk_global_txt()
}

check_wrong_ActionLists(){
  isWrong := 1
  while(isWrong){
    if(A_Index > 3){
      setRegistry_ActionList("notWorkingFileAdress18-03-31_09-19")
#Include,RegWrite181031.ahk
      return
    }
      
    RegRead, ActionList, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionList ; todo: 02.03.2018 12:55 18-03-02_12-55
    isWrong := (InStr(ActionList,"\_global.") || InStr(ActionList,"\_ahk_global."))
    if(isWrong){
      tip= Msgbox,wrong . we dont want loadet "\_global." `n (%A_LineFile%~%A_LineNumber%) 
      ToolTip3sec(tip) 
      Sleep,3000
    }
  }
}
close_ActionListChangedInRegistry(){
  SetTitleMatchMode,1
  IfWinNotExist,ActionListChangedInRegistry ahk_class #32770
  {
    RegRead, ActionList, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionList ; todo: 02.03.2018 12:55 18-03-02_12-55
    if(InStr(ActionList,"\Selected_tab.")) {
      ; strange, but this is disturbing.
      tip:= "strange but this is disturbing. `n \Selected_tab. `n ==> lets wait a little `n (" A_LineNumber   " "   RegExReplace(A_LineFile,".*\\") ") "
      ToolTip3sec(tip) 
      ;setRegistry_ActionList("notWorkingFileAdress18-03-31_09-19")
#Include,RegWrite181031.ahk
      ; run,..\start.ahk
      Sleep,800
      
      IfWinExist,Selected tab
        MsgBox,strange but this is disturbing. 1
      IfWinExist,Selected_tab
        MsgBox,strange but this is disturbing. 2
    }
    if(InStr(ActionList,"_ahk")) ; probably big wordklist blocking this script ==> wait for message box
      WinWait,ActionListChangedInRegistry ahk_class #32770 ,, 2
  }
  IfWinExist,ActionListChangedInRegistry ahk_class #32770
  {
    winCloseTry("ActionListChangedInRegistry ahk_class #32770")
    ;WinClose,ActionListChangedInRegistry ahk_class #32770
    IfWinExist,ActionListChangedInRegistry ahk_class #32770
    {
      Msgbox,:( `n ActionListChangedInRegistry `n found `n (%A_LineFile%~%A_LineNumber%)
    }
    return
  }
  
}


close_tstamp(){
  SetTitleMatchMode,2
  FormatTime, timestampyyMMdd , %A_now%,yyMMdd
  timestampyyMMdd := "tstamp_" timestampyyMMdd
  ;Msgbox,%timestampyyMMdd% `n (%A_LineFile%~%A_LineNumber%) 
  winCloseTry(timestampyyMMdd)
  IfWinExist,%timestampyyMMdd% ; ahk_class #32770
    g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
    ;Msgbox,:( `n %ActionListChangedInRegistry% `n found `n (%A_LineFile%~%A_LineNumber%)
}
close_ahk_global_txt(){
  SetTitleMatchMode,2
  t:="\ActionLists\_globalActionListsGenerated\_ahk_global.ahk"
  winCloseTry(t)
  IfWinNotExist,% t
    return t
  ;Msgbox,:( `n %t% `n found `n (%A_LineFile%~%A_LineNumber%) 
  g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
}




open_ActionList_first_time( openInputBoxTitle ){
  IfWinNotExist,% openInputBoxTitle
    Msgbox,:( `n WinNotExist %openInputBoxTitle% `n found `n (%A_LineFile%~%A_LineNumber%) 
  
  Sleep,100
  if(isActionListFileExist(openInputBoxTitle))
    menuNr := 3
  else
    menuNr := 1
  
  ;########## we inside: open_ActionList_first_time
  
    SetTitleMatchMode,2
    Loop,29
    {
      IfWinExist,.ahk
        WinClose
      WinWaitClose,.ahk,,1
      IfWinNotExist,.ahk
        break
    } 
    IfWinExist,.ahk
    {
      Msgbox,:( `n %t% `n  found `n  (%A_ThisFunc%> %A_LineFile%~%A_LineNumber%) 
      return False
    }

  ;########## we inside: open_ActionList_first_time
  
  ;Msgbox,%openInputBoxTitle% ==> %menuNr% `n (%A_LineFile%~%A_LineNumber%) 
  
  ;ToolTip,% SubStr(t,1,5) "...`n (" A_LineNumber   " "   RegExReplace(A_LineFile,".*\\") ")"
  
  
  t := openInputBoxTitle ".ahk"
  address :=""
  Loop,19
  {
    runMenu("__",menuNr, openInputBoxTitle ) ; create or/and open
    Sleep,300 ; importand to check fast, becouse 1 later opens anoter ActionList. so hurry 18-03-31_18-56
    
    ;MsgBox,openInputBoxTitle = %openInputBoxTitle%
    if(menuNr==1 && address := isActionListFileExist(openInputBoxTitle)) ; warten bis erstellt ist
    {
      ; break ; return t
      ;Sleep,200
      ;menuNr := 3
      menuNr := "" ; warten
    }
    if(menuNr==1)
      Sleep,200

    SetTitleMatchMode,2
    excludetTitle := A_ScriptName
    If(WinExist(t,"", excludetTitle )) {
      ;WinActivate,% t
      ;Msgbox,`n (%A_LineFile%~%A_LineNumber%) 
      break
    }
  }  

  if(!address){
    address := isActionListFileExist(openInputBoxTitle) ; warten bis erstellt ist
  if(menuNr==1){
    while(!address && A_Index < 10){ ; warten bis erstellt ist
      ;ToolTip,!address = %address% `n openInputBoxTitle = %openInputBoxTitle%
      address := isActionListFileExist(openInputBoxTitle) ; warten bis erstellt ist
      Sleep,100
    }
    if(address)
      ToolTip,:) found`, maybe not opend  (%A_ThisFunc% %A_LineFile%~%A_LineNumber%) 
  }}
  ;########## we inside: open_ActionList_first_time

  if(winWaitLoop(t))
    return t
  
  ; quick and dirty
  if(address)
    run,% address ; todo: quick and dirty 31.03.2018 20:02 18-03-31_20-02
  
  if(winWaitLoop(t))
    return t

  g_error_log .= ":( " t " not exist `n ( " A_ThisFunc ", line=" A_LineNumber ") `n"
  Msgbox,% g_error_log
  return 


;Msgbox,what do you see?? `n (%A_LineFile%~%A_LineNumber%) 

  IfWinNotExist, % t
  {
    WinActivate,openInputBoxTitle
    menuNr := 5
    t := openInputBoxTitle ".ahk"
    Loop,4
    {
      runMenu("__",menuNr, openInputBoxTitle ) ; open new ahk
      SetTitleMatchMode,2
      WinWait,% t,,3
      IfWinExist,% t
        break
    }  
  }
  
  ;########## we inside: open_ActionList_first_time
  
  if(winWaitLoop(t))
    return t
  ;Msgbox,:( `n %t% `n NOT found `n (%A_LineFile%~%A_LineNumber%) 
  
    g_error_log .= ":( " t " not exist `n ( " A_ThisFunc ", line=" A_LineNumber ") `n"
}




sendAeUeLines(t){
  t1 := t
  onlyName := RegExReplace(t, ".*(tstamp_[^\.]+).*","$1")
  lineAe := "helloEurope|r|helloWorld`n"
  lineAe .= "___open generated|rr||ahk|openInEditor," onlyName ".txt._Generated.ahk`n`n"
  lineAe .= "hi MsgBox|rr||ahk|MsgBox,hi World`n`n"
  lineAe .= "aaaaae|r|" chr(228) "`n"
  lineAe .= "uuuuue|r|" chr(252) "`n" 

  ; prob nr 5 then
  SendLevel 0
  IfWinNotExist,% t
  {
    Msgbox,:( IfWinNotExist %t% `n (%A_ThisFunc%, %A_LineFile%~%A_LineNumber%) 
    ExitApp
  }
  ;t:= RegExReplace(t,"^.*?([\w\d_]+\.txt).*?$","$1") ; looks little more pretty, morre readable 
  ;SendMode Input ; Recommended for new scripts due to its superior speed and reliability"
  SetTitleMatchMode,2

  SetMouseDelay,30

  WinActivateTry(t,9)
  WinGetActiveTitle,tSavedTitle

loop,9
{
  if(1){
    tSomeTXT := ".ahk"
    t := ".ahk"
  }
  WinActivateTry(t,9)
  WinGetPos,x,x,w,h,% t
  MouseClick,left,% x + (w/2),% y + (h/2)
  Sleep,2000
  WinActivateTry(t,9)
  IfWinNotActive,% t
  {
    Msgbox,:( WinNotActive %t% `n (%A_ThisFunc%, %A_LineFile%~%A_LineNumber%) 
    ExitApp
  }


    ;ControlSend, Scintilla1, ^{End}{Enter}, % t  ; Send directly 
    ;IfWinActive,% t
    ;{
  ;SetKeyDelay,80,20
  ;SetKeyDelay,-1
  ;Send,^{End}{Enter}
  Send,{CtrlDown}{End}{CtrlUp}{Enter}
  ;Send,{down 20}
  Send,% "{raw}" lineAe
  Sleep,150
  
  IfWinNotActive,% t
    break
  WinGetActiveTitle,tActive
  if(tSavedTitle<>tActive)
    break
}
;    Msgbox,text addet ???? to `n '''%t%''' `n (%A_ThisFunc%, %A_LineNumber%) 
    ;ControlSend, Scintilla1, ^{End}{Enter 3}, % t  ; Send directly 
    ;ControlSendRaw, Scintilla1, % "||`n", % t  ; Send directly 
    ;ControlSendRaw, Scintilla1, % "aaaaae\\||\\|r||" chr(124) "`n", % t  ; Send directly 
    ;ControlSend, Scintilla1, % "{raw}" lineAe lineUe, % t  ; Send directly 
    ;ControlSendRaw, Scintilla1, % lineBoth, % t  ; Send directly 
    ;ControlSendRaw, Scintilla1, % lineBoth, % t  ; Send directly 
    ;ControlSend, Edit1, {b down}{b up}, Untitled - Notepad
    ; *E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere-Nightly-Build\ActionLists\32770\tstamp_180329210641.txt - Notepad++ [Administrator] ahk_class Notepad++ ; mouseWindowTitle=0xb7057e  ;
}





winCloseTry(t){
  SetTitleMatchMode,2
  Loop,9
  {
    WinClose,% t
    WinWaitClose,% t,,1
    IfWinNotExist,% t
      break
  }
  IfWinExist,% t
  Loop,9
  {
    WinKill,% t
    IfWinNotExist,% t
      break
  }
  IfWinExist,% t
    g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
}

exitFunc(){
  feedbackMsgBox("deleteAll_tstamp_in_32770_folder", A_LineNumber . " , " . A_ScriptName,1,1)
  restoreClosedAHK() 
  deleteAll_tstamp_in_32770_folder()
  ExitApp
}

isActionListFileExist(fileNamePrefix){
  ; E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere-Nightly-Build\ActionLists\32770
    address := "..\ActionLists\32770\" RegExReplace(fileNamePrefix,"\.ahk.*","") ".ahk"
    
    if(FileExist(address))
      return address

    loopFilePattern := "..\ActionLists\32770\ " RegExReplace(fileNamePrefix,"\.txt.*","") "*.ahk"
    ;Msgbox,loopFilePattern = %loopFilePattern%`n (%A_LineFile%~%A_LineNumber%) 
  	Loop, %loopFilePattern%, , 0
    {
        return A_LoopFileFullPath
    }
    ;ToolTip1sec(A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
    ;ToolTip,%address% = address`n (%A_LineFile%~%A_LineNumber%) 
    ;ToolTip,(A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")   " "   Last_A_This)
    return false    
}

deleteAll_tstamp_in_32770_folder(){ ; ActionLists\32770
  FormatTime, timestampyyMMdd , %A_now%,yyMMdd
  loopFilePattern := "..\ActionLists\32770\tstamp_" timestampyyMMdd "*.ahk"
  Loop, %loopFilePattern%, , 1
  {
      FileDelete,% A_LoopFileFullPath
  }
}

setStatus_created_token:
  Msgbox,not working. this window is to fast`n (%A_LineFile%~%A_LineNumber%) 
    global g_created_token
    IfExist,% "created_token_17-08-10_16-17"
    {
      g_created_token := true
      SetTimer,setStatus_created_token,Off
    }
    ;else
      ;g_created_token := false
    ToolTip,g_created_token = "%g_created_token%"
return


;/¯¯¯¯ restoreClosedAHK ¯¯ 181204162841 ¯¯ 04.12.2018 16:28:41 ¯¯\
;/¯¯¯¯ restoreClosedAHK ¯¯ 181204162841 ¯¯ 04.12.2018 16:28:41 ¯¯\
;/¯¯¯¯ restoreClosedAHK ¯¯ 181204162841 ¯¯ 04.12.2018 16:28:41 ¯¯\
; global g_closedAHKlist := []
restoreClosedAHK() {
  global g_closedAHKlist
  loop, % g_closedAHKlist.MaxIndex()  
  {
    run,% g_closedAHKlist[A_Index] 
  }
}
;\____ restoreClosedAHK __ 181204162845 __ 04.12.2018 16:28:45 __/
;\____ restoreClosedAHK __ 181204162845 __ 04.12.2018 16:28:45 __/
;\____ restoreClosedAHK __ 181204162845 __ 04.12.2018 16:28:45 __/
;\____ restoreClosedAHK __ 181204162845 __ 04.12.2018 16:28:45 __/




;/¯¯¯¯ closeAllOtherAHK ¯¯ 181204162710 ¯¯ 04.12.2018 16:27:10 ¯¯\
;/¯¯¯¯ closeAllOtherAHK ¯¯ 181204162710 ¯¯ 04.12.2018 16:27:10 ¯¯\
;/¯¯¯¯ closeAllOtherAHK ¯¯ 181204162710 ¯¯ 04.12.2018 16:27:10 ¯¯\
; global g_closedAHKlist := []
closeAllOtherAHK(){
  global g_closedAHKlist
text:="it's highly recommended to close all other autohotkey script before run this test. should we close oterher autohotkey script now?"
DetectHiddenWindows On
WinGet, WList,List,ahk_class AutoHotkey ; <== the anonymous then are without .ahk extension

;msgbox, % WList.count() "`n" WList
if(WList>=3) {
  doCloseAllAhk := true
  if(!InStr(A_ComputerName,"SL5")){
      MsgBox, 4, close all other AHK? and restart them later? time out in 5 seconds then all ahk will closed, % text, 5
    IfMsgBox Timeout
        doCloseAllAhk := true
    else IfMsgBox No
        doCloseAllAhk := false
  }
  if(doCloseAllAhk){
    lastIndex:=0
    arrayCount := 0
    Loop %WList%
    {
      Id:=% "WList" A_Index
      WinGetTitle, Title, % "ahk_id " %Id%  
      ;MsgBox,% A_ScriptFullPath
      if(InStr(Title, A_ScriptFullPath))
        continue
      if(InStr(Title,"Toolbar.ahk" ))
        continue
      if(InStr(Title,"Toolbar.ahk" ))
        continue
      if(InStr(Title,"TillaGoto" ))
        continue
      if(InStr(Title,"highlight_activeWindow.ahk" ))
        continue
      if(!InStr(Title,".ahk")){
        WinClose,% Title
        m=Title = %Title%`n 
        m=%m% fAddress = %fAddress%`n (%A_LineFile%~%A_LineNumber%) 
        ;MsgBox, %m%
        continue
      }
      arrayCount += 1
      ; g_closedAHKlist.Push(Title) ; dont work 
      
      if(Title){
        fAddress:=Title
        fAddress := RegExReplace(fAddress,"\.ahk.*",".ahk")
        g_closedAHKlist[arrayCount] := fAddress
        ;Msgbox,Title = %Title%`n (%A_LineFile%~%A_LineNumber%) 
        ;Msgbox,fAddress = %fAddress%`n (%A_LineFile%~%A_LineNumber%) 
        WinClose,% Title
      }
    }
  }
}
DetectHiddenWindows,off
}
;\____ closeAllOtherAHK __ 181204162719 __ 04.12.2018 16:27:19 __/
;\____ closeAllOtherAHK __ 181204162719 __ 04.12.2018 16:27:19 __/
;\____ closeAllOtherAHK __ 181204162719 __ 04.12.2018 16:27:19 __/






;<<<<<<<< SoundbeepGameOver <<<< 170814130442 <<<< 14.08.2017 13:04:42 <<<<
SoundbeepGameOver(){
pitch := 750
while(--pitch > 350 ){
	pitch -= 40
	ToolTip, % pitch
	SoundBeep, % pitch, 150 ; Play a higher pitch for half a second.
}
	SoundBeep, % pitch + 180, 550 ; Play a higher pitch for half a second.
}
;>>>>>>>> SoundbeepGameOver >>>> 170814130447 >>>> 14.08.2017 13:04:47 >>>>

;<<<<<<<< SoundbeepMissionImpossibleTheme <<<< 170814103348 <<<< 14.08.2017 10:33:48 <<<<
SoundbeepMissionImpossibleTheme(){
    global g_doSound
    if(!g_doSound)

AHKcode =
(
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 659, 75
Soundbeep, 699, 75
Soundbeep, 740, 75
Soundbeep, 784, 75
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 932, 150
sleep, 150
Soundbeep, 523, 150
sleep, 150
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 699, 150
sleep, 150
Soundbeep, 740, 150
sleep, 150
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 932, 150
sleep, 150
Soundbeep, 523, 150
sleep, 150
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 699, 150
sleep, 150
Soundbeep, 740, 150
sleep, 150
Soundbeep, 932, 150
Soundbeep, 784, 150
Soundbeep, 587, 1200
sleep, 75
Soundbeep, 932, 150
Soundbeep, 784, 150
Soundbeep, 554, 1200
sleep, 75
Soundbeep, 932, 150
Soundbeep, 784, 150
Soundbeep, 523, 1200
sleep, 150
Soundbeep, 466, 150
Soundbeep, 523, 150
)
DynaRun(AHKcode)
return
}
;>>>>>>>> SOUNDBEEPMissionImpossibleTheme >>>> 170814103354 >>>> 14.08.2017 10:33:54 >>>>
;<<<<<<<< SoundbeepNoACK <<<< 170814140127 <<<< 14.08.2017 14:01:27 <<<<
SoundbeepNoACK(){
    global g_doSound
    if(!g_doSound)
        return
    SoundbeepGameOver()
}
;>>>>>>>> SoundbeepNoACK >>>> 170814140131 >>>> 14.08.2017 14:01:31 >>>>

;<<<<<<<< SoundbeepACK <<<< 170814140035 <<<< 14.08.2017 14:00:35 <<<<
SoundbeepACK(){
    global g_doSound
    if(!g_doSound)
        return
    ; SoundbeepMissionImpossibleTheme()
    SoundBeep,500,5000 ; high, timemilli 14.08.2017 09:43
}
;>>>>>>>> SoundbeepACK >>>> 170814140038 >>>> 14.08.2017 14:00:38 >>>>



#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_glo1bal_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk













;send2inputBox("hel",1,openInputBoxTitle)
send2inputBox(text,nr,openInputBoxTitle){
 if(!openInputBoxTitle){
    Msgbox,:( `n (%A_LineFile%~%A_LineNumber%)
    return false
  }
  tWL := openInputBoxTitle ".ahk"
  
;############## we inside: send2inputBox
 ; next step open it again
    ;close_tstamp()   ; first close it
     ; Msgbox,all txt now closed ????????????????? `n %t% `n  found `n (%A_LineFile%~%A_LineNumber%) 
    
;############## we inside: send2inputBox
    
    openInputBox(openInputBoxTitle)
    ;WinActivateTry(openInputBoxTitle,9)
    ;WinActivate,openInputBoxTitle
    menuNr := nr
    t := openInputBoxTitle ".ahk"
    Loop,24
    {
      WinActivateTry(openInputBoxTitle,9)
      runMenu(text,menuNr, openInputBoxTitle ) ; open new ahk
      SetTitleMatchMode,2
      WinWait,% t,,3
      IfWinExist,% t
        break
      if(A_Index > 1 && Mod(A_Index, 4) == 0){
        ;ToolTip4sec(":( freezed ?? ==> start.ahk `n " A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
        ToolTip4sec(":( freezed ??  `n " A_LineNumber ==>  " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
        Send,{AltDown}{Tab 3}{AltUp}
        ;run,..\start.ahk1
        close_ActionListChangedInRegistry()
        Sleep,3100
      }
    }  
    SetTitleMatchMode,2
    WinWait,% t, ,16 ; use 9 sec bevor. that was to short 
    IfWinExist,% t
      return t
    
    Msgbox,:( `n %t% `n not found `n (%A_LineFile%~%A_LineNumber%) 
  g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
}





ae(openInputBoxTitle,aa:="hal",ae:="hallo"){
    msg := "try: action ae.. in inputbox ", A_LineNumber . " , " . A_ScriptName
    Msgbox,,% msg,,4 ; thats a dirty bug fix. helps script changeing ActionLists 31.03.2018 17:55 18-03-31_17-55
    ;feedbackMsgBox("try: action ae.. in inputbox ", A_LineNumber . " , " . A_ScriptName,1,1)    
    openInputBox(openInputBoxTitle)
    Sleep,2500
    Loop,14
    {
      WinActivateTry(openInputBoxTitle,25)
      ;send2inputBox(aa,1,openInputBoxTitle)
      send2inputBox_OLD2(aa,1,openInputBoxTitle)
      Sleep, 1000 ; 1 Sekunde
      ControlGetText,inputBoxtext,Edit1,% openInputBoxTitle
      
      if(InStr(inputBoxtext,ae))
        break
      if( Mod(A_Index, 4) == 0) {
        Send,{AltDown}{Tab 2}{AltUp}
              close_ActionListChangedInRegistry()
        Sleep,3100
      }

      Sleep, 1200 ; 1 Sekunde
    }
    if(!InStr(inputBoxtext,ae))
        g_error_log .= ":( `n !InStr(inputBoxtext,ae) " A_ThisFunc " (line=" A_LineNumber ") `n"    


}



send2inputBox_OLD2(text,nr := 1,t:=""){ ; of https://github.com/sl5net/global-IntelliSense-everywhere
  if(!t){
    Msgbox,:( `n !t parameter empty `n found `n (%A_LineFile%~%A_LineNumber%) 
    return false
  }
  
  SetTitleMatchMode,2
  ;closeDisturbingWindows_without_tstamp_18()
  close_ActionListChangedInRegistry()

if(1){ ; may better do this
  SendLevel 0
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
  SendLevel 9
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
}

  SendLevel 9
  SetCapsLockState,Off
  
  ;SetKeyDelay,180,120
  global g_DelayMilliSec
  global g_PressDuration
  SetKeyDelay,% g_DelayMilliSec,% g_PressDuration ; sometimes helpful 28.03.2018 23:17
  ;SetKeyDelay,80,320 ; works much better !!! :)

  WinActivate,% t
  WinWaitActive,% t, , 1


  IfWinNotActive,% t
    return false
  IfWinActive,% t ".ahk"
    return false

  SendRaw,% text
  Sleep,800
  
  IfWinNotActive,% t
    return false
  IfWinActive,% t ".ahk"
    return false
  
  SendRaw,% nr ; open ActionList / entry one
  ;Sleep,900
  return true
}


    trickyUglySendTextWorkaround2inputBox(textSend,textExpected , openInputBoxTitle){
    run,..\start.ahk ; dirty bugFix. becourse late in the evening. TODO ceckit out 18-03-31_23-46    
    msg := "try: action " text ".. in inputbox ", A_LineNumber . " , " . A_ScriptName
    Msgbox,,% msg,,4 ; thats a dirty bug fix. helps script changeing ActionLists 31.03.2018 17:55 18-03-31_17-55
    ;feedbackMsgBox("try: action ae.. in inputbox ", A_LineNumber . " , " . A_ScriptName,1,1)    
    openInputBox(openInputBoxTitle)
    Sleep,2500
    Loop,8
    {
      WinActivateTry(openInputBoxTitle,25)
      send2inputBox(textSend,1,openInputBoxTitle)
      Sleep, 1000 ; 1 Sekunde
      ControlGetText,inputBoxtext,Edit1,% openInputBoxTitle
      if(InStr(inputBoxtext,textExpected))
        return true
      if( Mod(A_Index, 4) == 0) {
        Send,{AltDown}{Tab 2}{AltUp}
              close_ActionListChangedInRegistry()
        Sleep,3100
      }

      Sleep, 1200 ; 1 Sekunde
    }
    if(!InStr(inputBoxtext,ae))
        g_error_log .= ":( `n !InStr(inputBoxtext,ae) " A_ThisFunc " (line=" A_LineNumber ") `n"    
    return false
}
