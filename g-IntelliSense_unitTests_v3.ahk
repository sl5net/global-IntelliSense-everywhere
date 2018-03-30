#Include %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
global g_error_log := ""
if(1){ ; may better do this
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
}

if(0){
    tSomeTXT := ".txt"
    WinActivateTry(tSomeTXT,9)
    sendAeUeLines(tSomeTXT)
    ExitApp
}

  ;SetTimer,lbsFastTime,100
  tWL := tests()
  feedbackMsgBox("deleteAll_tstamp_in_32770_folder", A_LineNumber . " , " . A_ScriptName,1,1)
  deleteAll_tstamp_in_32770_folder()
return


SetTitleMatchMode,2
#IfWinActive,g-IntelliSense_unitTests
f10::tests()
;return

  deleteAll_tstamp_in_32770_folder(){
  ; E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere-Nightly-Build\Wordlists\32770
    FormatTime, timestampyyMMdd , %A_now%,yyMMdd
    timestampyyMMdd := "tstamp_" timestampyyMMdd
    loopFilePattern := "..\Wordlists\32770\tstamp_" timestampyyMMdd "*.txt"
  	Loop, %loopFilePattern%, , 1
	{
		; A_LoopFileDir, m_subFolderNameForBackUps))
        ; this_ext := fileExtensionArray%a_index%
        ;A_LoopFileExt
        ;Msgbox,%A_LoopFileFullPath% `n (%A_LineFile%~%A_LineNumber%) 
        FileDelete,% A_LoopFileFullPath
    }
  }

;<<<<<<<< tests <<<< 180329000517 <<<< 29.03.2018 00:05:17 <<<<
tests(){
  ToolTip,
;

text:="it's highly recommended to close all other autohotkey script before run this test. should we close oterher autohotkey script now?"
DetectHiddenWindows On
WinGet, WList,List,ahk_class AutoHotkey
;msgbox, % WList.count() "`n" WList
if(WList>=3) {
  doCloseAllAhk := true
  MsgBox, 4, close alle AHK? time out in 5 seconds then all ahk will closed, % text, 5
  IfMsgBox Timeout
      doCloseAllAhk := true
  else IfMsgBox No
      doCloseAllAhk := false
  if(doCloseAllAhk){
    lastIndex:=0
    Loop %WList%
    {
      Id:=% "WList" A_Index
      WinGetTitle, Title, % "ahk_id " %Id%  
      if(InStr(Title, A_ScriptFullPath))
        continue
      WinClose,% Title
    }
  }
}
DetectHiddenWindows,off

feedbackMsgBoxCloseAllWindows()

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

  feedbackMsgBox("try: create window never existed before", A_LineNumber . " , " . A_ScriptName,1,1)
  openInputBoxTitle := create_a_window_never_existed_before()
  Sleep,4500 ; give script time to genere new list address
  close_wordlistChangedInRegistry()
  
  if(1){
  feedbackMsgBox("try: open wordlist first time", A_LineNumber . " , " . A_ScriptName,1,1)
  tWL := open_wordlist_of_the_window_never_existed_before( openInputBoxTitle )
  WinActivateTry(tWL,9)
  WinGetActiveTitle, tWL
  ; now new list is created :) that wunderful :) 
  if(g_error_log) {
    Msgbox,%g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%) 
    return tWL
  }
  }else
    Sleep,1000

  ;run,..\start.ahk
  ;Sleep,3500
  ;feedbackMsgBox("hi :) lets make some tests now. ", A_LineNumber . " , " . A_ScriptName,1,1)
  
  feedbackMsgBox("try: open wordlist second time", A_LineNumber . " , " . A_ScriptName,1,1)
  tWLbackup := tWL
  tWL := open_for_second_time_wordlist_of_this_new_window(openInputBoxTitle)
  if(!tWL || !InStr(tWLbackup,tWL)){ ; tWL is maybe only the file name. thats ok
    Msgbox,:( `ntWLbackup <> tWL `n%tWLbackup% <> %tWL% `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber%) 
    return tWL
  }
  WinActivateTry(tWL,9)
  ;WinGetActiveTitle, tWL
  ; now list is reopend :) that wunderful :) 

  if(g_error_log) {
    Msgbox,%g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%) 
    return tWL
  }
  if(true){
    feedbackMsgBox("try: ae,ue 2 wordlist now", A_LineNumber . " , " . A_ScriptName,1,1)
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
      if(StrLen(tWLunsaved) <> StrLen(tWLbackup))
        break
    }
    if(StrLen(tWLunsaved) == StrLen(tWLbackup))
      Msgbox,:( `ntWLbackup == tWLunsaved `n %tWLbackup% ? %tWLunsaved% `n ( %A_ThisFunc%, %A_LineFile%~%A_LineNumber%) 
    WinActivateTry(tWLunsaved,9)
    while(true){
      send,^s ; save the changes 
      If(!WinExist(tWLunsaved) && winExist(tWLbackup))
        break ; its saved :)
  }
    IfWinExist,% tWLunsaved
      Msgbox,:( `n IfWinExist `n%tWLunsaved% `n not saved (%A_LineFile%~%A_LineNumber%) 
      ;Msgbox,:( `ntWLbackup <> tWL `n%tWLbackup% <> %tWL% `n not saved (%A_LineFile%~%A_LineNumber%) 
    
    ;Msgbox,saved ?? `n (%A_LineFile%~%A_LineNumber%) 
    
    IfWinNotActive,% t
      g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"    
    winCloseTry(t)
  }
    
    feedbackMsgBox("try: action ae, action ue 2 inputbox ", A_LineNumber . " , " . A_ScriptName,1,1)    
    openInputBox(openInputBoxTitle)
    WinActivateTry(openInputBoxTitle,9)
    Sleep,4000
    Loop,9
    {
      send2inputBox("aaa",1,openInputBoxTitle)
      ControlGetText,inputBoxtext,Edit1,% openInputBoxTitle
      ae := chr(228) ; lineAe := "aaaaae|r|" chr(228) "`n"
      if(InStr(inputBoxtext,ae))
        break
    }
    if(!InStr(inputBoxtext,ae))
        g_error_log .= ":( `n !InStr(inputBoxtext,ae) " A_ThisFunc " (line=" A_LineNumber ") `n"    
    else Loop,9
    {
      send2inputBox("uuu",1,openInputBoxTitle)
      ControlGetText,inputBoxtext,Edit1,% openInputBoxTitle
      ue := chr(252) ; lineUe := "uuuuue|r|" chr(252) "`n" 
      if(InStr(inputBoxtext,ue))
        break
    }
    if(!InStr(inputBoxtext,ue))
        g_error_log .= ":( `n !InStr(inputBoxtext,ue) " A_ThisFunc " (line=" A_LineNumber ") `n"    

  if(Trim(g_error_log)) 
    Msgbox,%g_error_log% `n = g_error_log (%A_LineFile%~%A_LineNumber%) 
  else
    Msgbox, :-) all tests run without errors  :-) `n (%A_LineFile%~%A_LineNumber%) 

  return tWL

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
  g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
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
    g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
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
    g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
    return
  }
  close_wordlistChangedInRegistry()
  return timestampyyMMddHHmmss
}





send2inputBox(text,nr := 1,t:=""){ ; of https://github.com/sl5net/global-IntelliSense-everywhere
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

  SendRaw,% text
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

  close_wordlistChangedInRegistry()
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
  ;Send,{space}
  SendRaw, ___
  ;ControlSendRaw, , ____, % t  ; Send directly 
  ;ControlSend, , ____, % t  ; Send directly 
  Sleep,785
  close_wordlistChangedInRegistry()
  
  IfWinNotActive,% t
    return false
  IfWinActive,% t ".txt"
    return false
  
  ;ControlSend, , % nr, % t  ; Send directly 
  ; send,% nr ; open wordlist / entry one
  close_wordlistChangedInRegistry()
  SendRaw,% nr ; open wordlist / entry one
  Sleep,433
  return true
}

lbsFastTime:
  close_wordlistChangedInRegistry()
return

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
    g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
    ;Msgbox,:( `n %wordlistChangedInRegistry% `n found `n (%A_LineFile%~%A_LineNumber%) 
}
close_ahk_global_txt(){
  SetTitleMatchMode,2
  t:="\Wordlists\_globalWordListsGenerated\_ahk_global.txt"
  winCloseTry(t)
  IfWinNotExist,% t
    return t
  ;Msgbox,:( `n %t% `n found `n (%A_LineFile%~%A_LineNumber%) 
  g_error_log .= ":( " A_ThisFunc " (line=" A_LineNumber ") `n"
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
  
    g_error_log .= ":( " t " not exist `n ( " A_ThisFunc ", line=" A_LineNumber ") `n"
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

  WinActivateTry(t,9)
  WinGetActiveTitle,tSavedTitle

loop,9
{
  if(1){
    tSomeTXT := ".txt"
    t := ".txt"
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
  send,{enter}
  Send,% "{raw}" lineUe
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

; too too __ too too ms msg too __

#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_glo1bal_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
