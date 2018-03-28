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
f9::
f10::
tests()
return

;<<<<<<<< tests <<<< 180329000517 <<<< 29.03.2018 00:05:17 <<<<
tests(){
  run,..\start.ahk
  

  SetTitleMatchMode,2

  closeDisturbingWindows()
  t:="\Wordlists\_globalWordListsGenerated\_ahk_global.txt"
  WinClose,% t,,4
  Sleep,4000

  WinActivate,g-IntelliSense_unitTests.ahk
  WinWaitActive,g-IntelliSense_unitTests.ahk

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
  Sleep,200
  SetTitleMatchMode,2
  IfWinNotExist,% t
  {
    Msgbox,:( `n %t% `n not found `n (%A_LineFile%~%A_LineNumber%) 
    return
  }
  WinClose,% t

  FormatTime, timestampyyMMddHHmmss , %A_now%,yyMMddHHmmss
  timestampyyMMddHHmmss := "tstamp_" timestampyyMMddHHmmss 
  FormatTime, timestampyyMMddHHmmssPretty, %A_now%,yy:MM:dd HH:mm:ss 
  AHKcode = InputBox, UserInput, %timestampyyMMddHHmmss%, dymmy text , , 340, 180
  DynaRun(AHKcode) ; wait for user decision
  SetTitleMatchMode,3
  WinWait, % timestampyyMMddHHmmss, , 3
  IfWinNotExist,% timestampyyMMddHHmmss
  {
    Msgbox,:( `n %timestampyyMMddHHmmss% `n not found `n (%A_LineFile%~%A_LineNumber%) 
    return
  }


  Sleep,4500 ; give script time to genere new list address
  menuNr := 1
  t := timestampyyMMddHHmmss ".txt"
  Loop,9
  {
    SetTitleMatchMode,3
    WinActivate,% timestampyyMMddHHmmss
    IfWinActive,% timestampyyMMddHHmmss
      runMenu(menuNr,timestampyyMMddHHmmss) ; create or/and open
    SetTitleMatchMode,2
    WinWait,% t,,2
    IfWinExist,% t
    {
      break
    }
    Sleep,500
  }
  
  ; ;____1____1____1DetectHiddenWindows,1
  SetTitleMatchMode,2
  IfWinNotExist,% t
  {
    Msgbox,:( `n %t% `n not found `n (%A_LineFile%~%A_LineNumber%) 
    return
  }
  
  ; now new list is created :) that wunderful :) 

  
  Msgbox, :-) all tests run without errors  :-) `n (%A_LineFile%~%A_LineNumber%) 

  return

}
;>>>>>>>> tests >>>> 180329000537 >>>> 29.03.2018 00:05:37 >>>>














runMenu(nr := 1,t:=""){ ; of https://github.com/sl5net/global-IntelliSense-everywhere
  
  SetTitleMatchMode,2
  closeDisturbingWindows_without_tstamp_18()
  
  DelayMilliSec := 50
  PressDuration := 20
  SetKeyDelay, DelayMilliSec, PressDuration ; sometimes helpful 28.03.2018 23:17
  send,____ ; open menu of https://github.com/sl5net/global-IntelliSense-everywhere
  Sleep,785
  
  IfWinNotActive,% t
    return
  
  send,% nr ; open wordlist / entry one
  Sleep,433
}

closeDisturbingWindows_without_tstamp_18(){
  SetTitleMatchMode,2
  
  WinClose,wordlistChangedInRegistry ahk_class #32770
  IfWinExist,wordlistChangedInRegistry ahk_class #32770
  {
    Msgbox,:( `n wordlistChangedInRegistry `n found `n (%A_LineFile%~%A_LineNumber%) 
  }
  
  WinClose,wordlistChangedInRegistry ahk_class #32770
  IfWinExist,wordlistChangedInRegistry ahk_class #32770
  {
    Msgbox,:( `n wordlistChangedInRegistry `n found `n (%A_LineFile%~%A_LineNumber%) 
  }

  if(0){
  t:="\Wordlists\_globalWordListsGenerated\_ahk_global.txt"
  WinClose,% t
  WinWaitClose,% t,,4
  IfWinExist,% t
  {
    Msgbox,:( `n %t% `n found `n (%A_LineFile%~%A_LineNumber%) 
    return
  }
  }

}


closeDisturbingWindows(){
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
  
  WinClose,wordlistChangedInRegistry ahk_class #32770
  IfWinExist,wordlistChangedInRegistry ahk_class #32770
  {
    Msgbox,:( `n wordlistChangedInRegistry `n found `n (%A_LineFile%~%A_LineNumber%) 
  }
  
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
