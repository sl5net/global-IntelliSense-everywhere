#Include %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
global g_error_log := ""
if(1){ ; may better do this
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
}

if(0){
    tWL := ".txt"
    WinActivateTry(tWL,9)
    tWLbackup := tWL
    sendAeUeLines(tWLbackup)
    ExitApp
}


tests()
return
SetTitleMatchMode,2
#IfWinActive,g-IntelliSense_unitTests
f10::tests()
;return

;<<<<<<<< tests <<<< 180329000517 <<<< 29.03.2018 00:05:17 <<<<
tests(){
  feedbackMsgBoxCloseAllWindows()______________

  SetTitleMatchMode,2
  if(0){ ; its not working
    DetectHiddenWindows,On
    name=TypingAid.ahk 
    name=TypingAid - Active ahk_class AutoHotkey
    WinShow,% name
    IfWinExist,% name
      Msgbox,`n (%A_LineFile%~%A_LineNumber%) 
    if(WinExist(name))
      Msgbox,`n (%A_LineFile%~%A_LineNumber%) 
    return
    
    DetectHiddenWindows,on
    WinWait,TypingAid - Active,,12
    if(!winWaitLoop("TypingAid - Active"))
      return
    DetectHiddenWindows,Off

  }
  run,..\start.ahk
  Sleep,2000
  ;feedbackMsgBox("hi :) lets make some tests now. ", A_LineNumber . " , " . A_ScriptName,1,1)
  SetTitleMatchMode,2

  closeDisturbingWindows()

  feedbackMsgBox("create window never existed before", A_LineNumber . " , " . A_ScriptName,1,1)
  openInputBoxTitle := create_a_window_never_existed_before()
  Sleep,4500 ; give script time to genere new list address
  close_wordlistChangedInRegistry()
  
  feedbackMsgBox("open wordlist first time", A_LineNumber . " , " . A_ScriptName,1,1)
  tWL := open_wordlist_of_the_window_never_existed_before( openInputBoxTitle )
  WinActivateTry(tWL,9)
  WinGetActiveTitle, tWL
  ; now new list is created :) that wunderful :) 

  if(g_error_log) {
    Msgbox,%g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%) 
    return
  }

  ;run,..\start.ahk
  ;Sleep,3500
  ;feedbackMsgBox("hi :) lets make some tests now. ", A_LineNumber . " , " . A_ScriptName,1,1)
  
  feedbackMsgBox("open wordlist second time", A_LineNumber . " , " . A_ScriptName,1,1)
  tWLbackup := tWL
  tWL := open_for_second_time_wordlist_of_this_new_window(openInputBoxTitle)
  WinGetActiveTitle, tWL
  if(tWLbackup <> tWL)
    Msgbox,:( `ntWLbackup <> tWL `n%tWLbackup% <> %tWL% `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber%) 
  ; now list is reopend :) that wunderful :) 

  if(g_error_log) {
    Msgbox,%g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%) 
    return
  }
  if(true){
    feedbackMsgBox("aaaaae 2 wordlist now", A_LineNumber . " , " . A_ScriptName,1,1)
    WinActivateTry(tWL,9)
    IfWinNotExist,% tWL
      Msgbox,:( `n WinNotExist %tWL% `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber% )    
    IfWinNotActive,% tWL
      Msgbox,:( `n WinNotActive %tWL% `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber% )
    tWLbackup := tWL
    Loop,9
    {
      sendAeUeLines(tWLbackup)
      Sleep,60
      WinGetActiveTitle, tWLunsaved
      if(StrLen(tWLunsaved)-1 == StrLen(tWLbackup))
        break
    }
    if(StrLen(tWLunsaved) == StrLen(tWLbackup))
      Msgbox,:( `ntWLbackup == tWLunsaved `n %tWLbackup% ? %tWLunsaved% `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber%) 
    WinActivateTry(tWLunsaved,9)
      send,^s ; save the changes 
    IfWinExist,% tWLunsaved
      Msgbox,:( `n IfWinExist `n%tWLunsaved% `n not saved (%A_LineFile%~%A_LineNumber%) 
      ;Msgbox,:( `ntWLbackup <> tWL `n%tWLbackup% <> %tWL% `n not saved (%A_LineFile%~%A_LineNumber%) 
    
    Msgbox,saved ?? `n (%A_LineFile%~%A_LineNumber%) 
    
    IfWinNotActive,% t
      g_error_log := ":( " A_ThisFunc " (line=" A_LineNumber ") `n"    
    winCloseTry(t)
  }
    
    feedbackMsgBox("aaaaa 2 inputbox ", A_LineNumber . " , " . A_ScriptName,1,1)    
    openInputBox(openInputBoxTitle)
    WinActivateTry(openInputBoxTitle,9)
    Sleep,4000    
    sendAaaa2inputBox(1,openInputBoxTitle)

  if(Trim(g_error_log)) 
    Msgbox,%g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%) 
  else
    Msgbox, :-) all tests run without errors  :-) `n (%A_LineFile%~%A_LineNumber%) 

  Msgbox,rerun ? `n (%A_LineFile%~%A_LineNumber%) 
  Reload
  
  ;Msgbox, :-) all tests run without errors  :-) `n (%A_LineFile%~%A_LineNumber%) 
  ;close_tstamp()  
}
;>>>>>>>> tests >>>> 180329000537 >>>> 29.03.2018 00:05:37












open_for_second_time_wordlist_of_this_new_window(openInputBoxTitle){
 if(!openInputBoxTitle){
    Msgbox,:( `n (%A_LineFile%~%A_LineNumber%)
    return false
  }

 ; next step open it again
    ;close_tstamp()   ; first close it
    SetTitleMatchMode,2
    Loop,9
    {
      IfWinExist,.txt
        WinClose
      IfWinExist,.txt
        break
    }
    openInputBox(openInputBoxTitle)
    ;WinActivateTry(openInputBoxTitle,9)
    ;WinActivate,openInputBoxTitle
    menuNr := 4
    t := openInputBoxTitle ".txt"
    Loop,5
    {
      runMenu(menuNr, openInputBoxTitle ) ; open new txt
      SetTitleMatchMode,2
      WinWait,% t,,3
      IfWinExist,% t
        break
    }  
    Sleep,1000
    IfWinExist,% t
      return t
    
    ;Msgbox,:( `n %t% `n not found `n (%A_LineFile%~%A_LineNumber%) 
  g_error_log := ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
}









  winWaitLoop(t, maxLoops:=9,s :=100){
    SetTitleMatchMode,2
    Loop,%maxLoops%
    {
      WinWait,% t,,1
      IfWinExist,% t
        return true
      Sleep,% s
    }
    IfWinExist,% t
      return t
      ; Msgbox,:( `n %t% `n not found `n (%A_LineFile%~%A_LineNumber%) 
    g_error_log := ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
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
  WinWait, % timestampyyMMddHHmmss, , 3
  IfWinNotExist,% timestampyyMMddHHmmss
  {
    Msgbox,:( `n %timestampyyMMddHHmmss% `n not found `n (%A_LineFile%~%A_LineNumber%) 
    g_error_log := ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
    return
  }
  close_wordlistChangedInRegistry()
  return timestampyyMMddHHmmss
}





sendAaaa2inputBox(nr := 1,t:=""){ ; of https://github.com/sl5net/global-IntelliSense-everywhere
  if(!t){
    Msgbox,:( `n !t parameter empty `n found `n (%A_LineFile%~%A_LineNumber%) 
    return false
  }
  
  SetTitleMatchMode,2
  ;closeDisturbingWindows_without_tstamp_18()
  close_wordlistChangedInRegistry()

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
  
  SetKeyDelay,180,120

  WinActivate,% t
  WinWaitActive,% t, , 1


  IfWinNotActive,% t
    return false
  IfWinActive,% t ".txt"
    return false

  SendRaw,aaa
  Sleep,785
  
  IfWinNotActive,% t
    return false
  IfWinActive,% t ".txt"
    return false
  
  SendRaw,% nr ; open wordlist / entry one
  Sleep,433
  return true
}





runMenu(nr := 1,t:=""){ ; of https://github.com/sl5net/global-IntelliSense-everywhere
  if(!t){
    Msgbox,:( `n !t parameter empty `n found `n (%A_LineFile%~%A_LineNumber%) 
    return false
  }
  
  SetTitleMatchMode,2
  ;closeDisturbingWindows_without_tstamp_18()
  close_wordlistChangedInRegistry()

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
  
  DelayMilliSec := 50
  PressDuration := 20
  ; SetKeyDelay, DelayMilliSec, PressDuration ; sometimes helpful 28.03.2018 23:17
  SetKeyDelay,180,120

  WinActivate,% t
  WinWaitActive,% t, , 1


  IfWinNotActive,% t
    return false
  IfWinActive,% t ".txt"
    return false

  ;send,%nr%{space}
  ;send,%nr%
  ControlSend, , % nr, % t  ; Send directly 

  IfWinNotActive,% t
    return false
  SendRaw,___
  ;ControlSendRaw, , ____, % t  ; Send directly 
  ;ControlSend, , ____, % t  ; Send directly 
  Sleep,785
  
  IfWinNotActive,% t
    return false
  IfWinActive,% t ".txt"
    return false
  
  ;ControlSend, , % nr, % t  ; Send directly 
  ; send,% nr ; open wordlist / entry one
  SendRaw,% nr ; open wordlist / entry one
  Sleep,433
  return true
}

closeDisturbingWindows_without_tstamp_18(){
  close_wordlistChangedInRegistry()
  close_ahk_global_txt()
}
closeDisturbingWindows(){
  close_tstamp()
  close_wordlistChangedInRegistry()
  close_ahk_global_txt()
}

close_wordlistChangedInRegistry(){
  SetTitleMatchMode,1
  winCloseTry("wordlistChangedInRegistry ahk_class #32770")
  ;WinClose,wordlistChangedInRegistry ahk_class #32770
  IfWinExist,wordlistChangedInRegistry ahk_class #32770
  {
    Msgbox,:( `n wordlistChangedInRegistry `n found `n (%A_LineFile%~%A_LineNumber%) 
  }
}
close_tstamp(){
  SetTitleMatchMode,2
  FormatTime, timestampyyMMdd , %A_now%,yyMMdd
  timestampyyMMdd := "tstamp_" timestampyyMMdd
  ;Msgbox,%timestampyyMMdd% `n (%A_LineFile%~%A_LineNumber%) 
  winCloseTry(timestampyyMMdd)
  IfWinExist,%timestampyyMMdd% ; ahk_class #32770
    g_error_log := ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
    ;Msgbox,:( `n %wordlistChangedInRegistry% `n found `n (%A_LineFile%~%A_LineNumber%) 
}
close_ahk_global_txt(){
  SetTitleMatchMode,2
  t:="\Wordlists\_globalWordListsGenerated\_ahk_global.txt"
  winCloseTry(t)
  IfWinNotExist,% t
    return t
  ;Msgbox,:( `n %t% `n found `n (%A_LineFile%~%A_LineNumber%) 
  g_error_log := ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
}




open_wordlist_of_the_window_never_existed_before( openInputBoxTitle ){
  IfWinNotExist,% openInputBoxTitle
    Msgbox,:( `n WinNotExist %openInputBoxTitle% `n found `n (%A_LineFile%~%A_LineNumber%) 
  
  menuNr := 1
  t := openInputBoxTitle ".txt"
  ToolTip,% SubStr(t,1,5) "...`n (" A_LineNumber   " "   A_LineFile ")"
  Loop,4
  {
    runMenu(menuNr, openInputBoxTitle ) ; create or/and open
    SetTitleMatchMode,2
    WinWait,% t,,3
    IfWinExist,% t
      break
    IfExist,% "created_token_17-08-10_16-17"
      break
  }  

;Msgbox,what do you see?? `n (%A_LineFile%~%A_LineNumber%) 

  IfWinNotExist, % t
  {
    WinActivate,openInputBoxTitle
    menuNr := 5
    t := openInputBoxTitle ".txt"
    Loop,4
    {
      runMenu(menuNr, openInputBoxTitle ) ; open new txt
      SetTitleMatchMode,2
      WinWait,% t,,3
      IfWinExist,% t
        break
    }  
  }
  
  if(winWaitLoop(t))
    return t
  ;Msgbox,:( `n %t% `n NOT found `n (%A_LineFile%~%A_LineNumber%) 
  
    g_error_log := ":( " t " not exist `n ( " A_ThisFunc ", line=" A_LineNumber ") `n"
}




sendAeUeLines(t){
  t1 := t
  lineAe := "aaaaae|r|" chr(228) "`n"
  lineUe := "uuuuue|r|" chr(252) "`n" 
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
loop,9
{
  WinActivateTry(t,9)
  WinGetPos,x,x,w,h,% t
  MouseClick,left,% x + (w/2),% y + (h/2)
  Sleep,2000
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
  send,{enter}
  Send,% "{raw}" lineUe
  Sleep,150
  IfWinNotActive,% t
    break
}
    Msgbox,text addet ???? to `n '''%t%''' `n (%A_ThisFunc%, %A_LineNumber%) 
    ;ControlSend, Scintilla1, ^{End}{Enter 3}, % t  ; Send directly 
    ;ControlSendRaw, Scintilla1, % "||`n", % t  ; Send directly 
    ;ControlSendRaw, Scintilla1, % "aaaaae\\||\\|r||" chr(124) "`n", % t  ; Send directly 
    ;ControlSend, Scintilla1, % "{raw}" lineAe lineUe, % t  ; Send directly 
    ;ControlSendRaw, Scintilla1, % lineBoth, % t  ; Send directly 
    ;ControlSendRaw, Scintilla1, % lineBoth, % t  ; Send directly 
    ;ControlSend, Edit1, {b down}{b up}, Untitled - Notepad
    ; *E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere-Nightly-Build\Wordlists\32770\tstamp_180329210641.txt - Notepad++ [Administrator] ahk_class Notepad++ ; mouseWindowTitle=0xb7057e  ; 
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
  IfWinActive,% t
    g_error_log := ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
}



#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_glo1bal_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
