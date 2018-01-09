getSelectionFROMclipBoard( sleepDelay := 1){
return copySelectionFROMclipBoard( sleepDelay )
}
copySelectionFROMclipBoard( sleepDelay := 1){
    clipboardBackup:=clipboard
    c:=copySelection2clipBoard( sleepDelay )
    clipboard:=clipboardBackup
    return c
}


;<<<<<<<< copyWord2clipBoard <<<< 171120165205 <<<< 20.11.2017 16:52:05 <<<<
copyWord2clipBoard(doSelectLine:=true){
;msgbox,not implemented 17-08-08_17-58
   if(doSelectLine){
      Suspend,on
        ;Send,{Blind} ; ^w^f
      ;Send,{left 5}
      MouseGetPos,mouseX,mouseY,mouseWin
      SetMouseDelay,0
      MouseMove,% A_CaretX, % A_CaretY,2
      SetMouseDelay,20
      SetKeyDelay,50,50
      MouseClick,left,% A_CaretX - 5 , % A_CaretY,2
      SetMouseDelay,0
      MouseMove,% mouseX,% mouseY
      Suspend,Off
   }
   ;Sleep,1200
   sleepDelay:=10
   c:=copySelection2clipBoard(sleepDelay)
   return c
}
;>>>>>>>> copyWord2clipBoard >>>> 171120165211 >>>> 20.11.2017 16:52:11 >>>>


;<<<<<<<< copySelection2clipBoard <<<< 170826094939 <<<< 26.08.2017 09:49:39 <<<<
copySelection2clipBoard( sleepDelay := 1){
   ; version-timestamp of this function: 13.08.2017 11:56 17-08-13_11-56
   ClipboardBackup := Clipboard
   Clipboard:=""
   a_TimeIdleStart := A_TimeIdle
   loopCounter:=0
   ; Msgbox, '%c%' `n =c `n '%Clipboard%' `n =Clipboard `n (copySelection2clipBoard...ahk~%A_LineNumber%)
   while(!clipboard && loopCounter < 100){
      ;~ IfWinNotActive,%at%
      ;~ return
      ; be sure that cursor not aut of the carret this shortime
      if(a_TimeIdleStart > A_TimeIdle){
         ; Msgbox, '%c%' `n =c `n '%Clipboard%' `n =Clipboard `n (copySelection2clipBoard...ahk~%A_LineNumber%)
         return
      }
      Send,^c
      ;:1:2: 3
      loopCounter += 1
      Sleep, %sleepDelay%
   }
   c=%Clipboard%
   Clipboard := ClipboardBackup
   Suspend,Off
   if(!c){
      return false
   }
   ; Msgbox, '%c%' `n =c `n (copySelection2clipBoard...ahk~%A_LineNumber%)

   return c ;
}
;>>>>>>>> copySELECTION"CLIPBoard >>>> 170826094949 >>>> 26.08.2017 09:49:49 >>>>"


getLineOrWordFROMclipBoard(doSelectLine){
    return copyLineOrWordFROMclipBoard(doSelectLine)
}
copyLineOrWordFROMclipBoard(doSelectLine){
    clipboardBackup:=clipboard
    c:=copyLineOrWord2clipBoard(doSelectLine)
    clipboard:=clipboardBackup
    return c
}
;<<<<<<<< copyLineOrWord2clipBoard <<<< 171103235019 <<<< 03.11.2017 23:50:19 <<<<
copyLineOrWord2clipBoard(doSelectLine){
   Suspend,on
   if(doSelectLine){
      Send,{Home}{ShiftDown}
      Send,{ShiftDown}{End}
   }else  {
      Send,^{Left 3}{ShiftDown}  
      Send,{ShiftDown}^{Right 3}
   }
   Send,{ShiftUp}
   c:=copySelection2clipBoard()
   return c
}
;>>>>>>>> copyLineOrWord2clipBoard >>>> 171103235025 >>>> 03.11.2017 23:50:25 >>>>

;<<<<<<<< copyLineOrWord2clipBoard <<<< 171103235019 <<<< 03.11.2017 23:50:19 <<<<
copyDocumentText2clipBoard(){
    Suspend,on
    Send,{CtrlDown}{Home}
    Send,{ShiftDown}
    Send,^{End}
    Send,{ShiftUp}{CtrlUp}
    c:=copySelection2clipBoard()
    Suspend,off
    return c
}
;>>>>>>>> copyLineOrWord2clipBoard >>>> 171103235025 >>>> 03.11.2017 23:50:25 >>>>
