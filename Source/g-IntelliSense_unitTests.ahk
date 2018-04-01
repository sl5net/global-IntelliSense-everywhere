; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
isDevellopperMode:=true ; enth�llt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
;ToolTip5sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
; DetectHiddenWindows,on
if(1){ ; may better do this
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
}
tests()
return

#IfWinActive,g-IntelliSense_unitTests.ahk
f10::
tests()
return

;<<<<<<<< tests <<<< 180329000517 <<<< 29.03.2018 00:05:17 <<<<
tests(){
  
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
    
      SendLevel 0
  DetectHiddenWindows,on
  WinWait,TypingAid - Active,,12
  if(!winWaitLoop("TypingAid - Active"))
    return
  DetectHiddenWindows,Off

  }
  run,..\start.ahk
  Sleep,4000
  SetTitleMatchMode,2

  closeDisturbingWindows()




  WinActivate,g-IntelliSense_unitTests.ahk
  WinWaitActive,g-IntelliSense_unitTests.ahk

  if(!winWaitLoop("g-IntelliSense_unitTests.ahk"))
    return

  send,^{End}
  SendLevel 9
  send,^{End}{enter}`; 
  
  t:="\Wordlists\_globalWordListsGenerated\_ahk_global.txt"
  Loop,6
  {
    runMenu(1,"g-IntelliSense_unitTests.ahk") ; open already existing list
    SetTitleMatchMode,2
    WinWait,% t,,1
    IfWinExist,% t
      break
  }
  if(!winWaitLoop(t))
    return
  
  close_ahk_global_txt()

  openInputBoxTitle := openInputBox()

  Sleep,4500 ; give script time to genere new list address
  close_wordlistChangedInRegistry()
  
  menuNr := 1
  t := openInputBoxTitle ".txt"
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
  
  
 ; next step open it again
    openInputBox(openInputBoxTitle)
    close_tstamp()   ; first close it
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
  


  
  if(!winWaitLoop(t))
    return
  ; now new list is created :) that wunderful :) 
  Msgbox, :-) all tests run without errors  :-) `n (%A_LineFile%~%A_LineNumber%) 
  close_tstamp()  
}
;>>>>>>>> tests >>>> 180329000537 >>>> 29.03.2018 00:05:37 >>>>

















  winWaitLoop(t, maxLoops:=9,s :=100){
    SetTitleMatchMode,2
    Loop,%maxLoops%
    {
      WinWait,% t,,1
      IfWinExist,% t
        return true
      Sleep,% s
    }
    IfWinNotExist,% t
      Msgbox,:( `n %t% `n not found `n (%A_LineFile%~%A_LineNumber%) 
    return false
  }





create_a_window__never_existed_before(){
  wn := openInputBox()
  return wn
}

openInputBox(timestampyyMMddHHmmss:=""){
  if(!timestampyyMMddHHmmss){
    FormatTime, timestampyyMMddHHmmss , %A_now%,yyMMddHHmmss
    timestampyyMMddHHmmss := "tstamp_" timestampyyMMddHHmmss 
    FormatTime, timestampyyMMddHHmmssPretty, %A_now%,yy:MM:dd HH:mm:ss 
  }else{
    WinActivate,% timestampyyMMddHHmmss
    return
  }
  AHKcode = InputBox, UserInput, %timestampyyMMddHHmmss%, dymmy text , , 340, 80
  DynaRun(AHKcode) ; wait for user decision
  SetTitleMatchMode,3
  WinWait, % timestampyyMMddHHmmss, , 3
  IfWinNotExist,% timestampyyMMddHHmmss
  {
    Msgbox,:( `n %timestampyyMMddHHmmss% `n not found `n (%A_LineFile%~%A_LineNumber%) 
    return
  }
  close_wordlistChangedInRegistry()
  return timestampyyMMddHHmmss
}





runMenu(nr := 1,t:=""){ ; of https://github.com/sl5net/global-IntelliSense-everywhere
  if(!t)
    Msgbox,:( `n !t parameter empty `n found `n (%A_LineFile%~%A_LineNumber%) 
  
  SetTitleMatchMode,2
  ;closeDisturbingWindows_without_tstamp_18()
  close_wordlistChangedInRegistry()

if(1){ ; may better do this
  send,{Shiftup}
  send,{AltUp}
  send,{CtrlUp}
}

  
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

  
  send,%nr%{space} ; open wordlist / entry one
  send,____ ; open menu of https://github.com/sl5net/global-IntelliSense-everywhere
  Sleep,785
  
  IfWinNotActive,% t
    return false
  IfWinActive,% t ".txt"
    return false
  
  send,% nr ; open wordlist / entry one
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
  WinClose,wordlistChangedInRegistry ahk_class #32770
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
  Loop,99 ; may need only 1
  {
    WinClose,%timestampyyMMdd% ; ahk_class #32770
    ;WinKill,%timestampyyMMdd% ; ahk_class #32770
    IfWinNotExist,%timestampyyMMdd%
      break
    Sleep,50
  }
  IfWinExist,%timestampyyMMdd% ; ahk_class #32770
  {
    Msgbox,:( `n %wordlistChangedInRegistry% `n found `n (%A_LineFile%~%A_LineNumber%) 
  }
}
close_ahk_global_txt(){
  SetTitleMatchMode,2
  t:="\Wordlists\_globalWordListsGenerated\_ahk_global.txt"
  WinClose,% t
  WinWaitClose,% t,,4
  IfWinExist,% t
  {
    Msgbox,:( `n %t% `n found `n (%A_LineFile%~%A_LineNumber%) 
    return
  }
}


#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_glo1bal_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk


; 1____11__ 1_
; 1___1 1____1 1____1 1___1 1____1 1___1
; 1____11____1 1__1____1__1____
;1___1 1__1____1____11____11____1
;1____1 1____1 1___1 1____1 1___1 1____1
; 1____11____1 1____1 1____1 1___1 1____1