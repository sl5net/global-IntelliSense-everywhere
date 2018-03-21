; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
#SingleInstance,force

FileRead,TypingAidContentStatus, TypingAid_programmCounter_LineAndTime.txt

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
      WinWait, TypingAid - Active wait4sec
      IfWinExist, TypingAid - Active wait4sec
      {
         WinClose, TypingAid - Active wait4sec
         RunWait,TypingAid.ahk
      }
   }
      ; WinClose, TypingAid - active
}


; Msgbox,`n (%A_LineFile%~%A_LineNumber%)
