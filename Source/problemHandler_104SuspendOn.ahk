; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#SingleInstance,force

FileRead,gi-everywhereContentStatus, gi-everywhere_programmCounter_LineAndTime.txt

loop,9999
{
   Sleep,4000
   
   if(!FileExist(timestampyyMMddHHmmss))
      ExitApp 
   
   FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
   secondsProgrammIsNotMoving := timestampyyMMddHHmmss
   
   if(secondsProgrammIsNotMoving > 4) {
Msgbox,ist not moving since %secondsProgrammIsNotMoving% sec :-( `n (%A_LineFile%~%A_LineNumber%) 
   }

   if(false){
      DetectHiddenWindows,On
      WinWait, gi-everywhere - Active wait4sec
      IfWinExist, gi-everywhere - Active wait4sec
      {
         WinClose, gi-everywhere - Active wait4sec
         RunWait,gi-everywhere.ahk
      }
   }
      ; WinClose, gi-everywhere - active
}


; Msgbox,`n (%A_LineFile%~%A_LineNumber%)
