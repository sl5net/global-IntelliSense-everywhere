;/¯¯¯¯ restoreClosedAHK ¯¯ 181204162841 ¯¯ 04.12.2018 16:28:41 ¯¯\
;/¯¯¯¯ restoreClosedAHK ¯¯ 181204162841 ¯¯ 04.12.2018 16:28:41 ¯¯\
;/¯¯¯¯ restoreClosedAHK ¯¯ 181204162841 ¯¯ 04.12.2018 16:28:41 ¯¯\
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
