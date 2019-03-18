#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



; https://github.com/Maximus5/ConEmu/issues/1552#issuecomment-388609504



#IfWinActive,ahk_class FreeCommanderXE
#IfWinActive,ahk_class FreeCommanderXE.SingleInst.1
F4::
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ToolTip1sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\") " " Last_A_This)
  Send,!g
return  
~^d::
  WinGetActiveTitle,at
  Suspend,on
  Send,% at
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ToolTip1sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\") " " Last_A_This)
  ;msgbox,%at%?



  titel := "FreeCommander ahk_class #32770"
  text := "Das System kann den angegebenen Pfad nicht finden"
  settitlematchmode,2
  WinWait, % titel, % text,3
  WinClose
  WinWaitClose,% titel, % text,2
  loop,9
  {
    sleep,50
    WinWaitActive,ahk_class VirtualConsoleClass
    ; WinMove,cmd (Admin) ahk_class VirtualConsoleClassGhost ,, 2411,597, 728,308
    WinSetTitle, , , % at
    WinWaitActive,% at,,1
    ifwinactive, % at
      continue
    ;WinSetTitle, , , % at
  }
  Suspend,off
return  
