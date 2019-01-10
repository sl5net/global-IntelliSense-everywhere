; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#Include *i init_global.init.inc.ahk

;~ GLOBAL_lllog_only_this_scriptName=ToolTipSec.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ examples:
;~ ToolTip5sec("wwwww`nwwwww`nwwww`n", A_ScreenWidth - 100, A_ScreenHeight - 100)
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; lll(A_LineNumber, "ToolTipSec.inc.ahk","test")
#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
; lll(A_LineNumber, "ToolTipSec.inc.ahk","line behind #Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk")



;~ global jumperVariable6573546378345:=true
;~ jumperVariable6573546378345:=true
;~ LabeljumperVariable6573546378345:

ToolTip1sec(t,x=123,y=321, layer1to20:=1){
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ;~ lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
  ToolTipSec(t,x,y,1000, layer1to20)
  return
}


ToolTip2sec(t,x=123,y=321, layer1to20:=1){
Last_A_This:=A_ThisFunc . A_ThisLabel
  ;~ lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
  ToolTipSec(t,x,y,2000, layer1to20)
  return
}

ToolTip3sec(t,x=123,y=321, layer1to20:=1){
Last_A_This:=A_ThisFunc . A_ThisLabel
  ;lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)

  ToolTipSec(t,x,y,3000, layer1to20)
  return
}

ToolTip4sec(t,x=123,y=321, layer1to20:=1){
Last_A_This:=A_ThisFunc . A_ThisLabel
  ;lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)

  ToolTipSec(t,x,y,4000, layer1to20)
  return
}

ToolTip5sec(t,x=123,y=321, layer1to20:=1){
  ToolTipSec(t,x,y,5000, layer1to20)
  Last_A_This:=A_ThisFunc . A_ThisLabel
  lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
  return
}

ToolTip6sec(t,x=123,y=321, layer1to20:=1){
  ToolTipSec(t,x,y,6000, layer1to20)
  Last_A_This:=A_ThisFunc . A_ThisLabel
  lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
  return
}

ToolTip7sec(t,x=123,y=321, layer1to20:=1){
  ToolTipSec(t,x,y,7000, layer1to20)
  Last_A_This:=A_ThisFunc . A_ThisLabel
  lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
  return
}

ToolTip8sec(t,x=123,y=321, layer1to20:=1){
  ToolTipSec(t,x,y,8000, layer1to20)
  Last_A_This:=A_ThisFunc . A_ThisLabel
  lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
  return
}

;/¯¯¯¯ ToolTip9sec ¯¯ 190110154202 ¯¯ 10.01.2019 15:42:02 ¯¯\
ToolTip9sec(t,x=123,y=321, layer1to20:=1){
  ToolTipSec(t,x,y,9000, layer1to20)
  Last_A_This:=A_ThisFunc . A_ThisLabel
  lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
  return
}
;\____ ToolTip9sec __ 190110154205 __ 10.01.2019 15:42:05 __/


;/¯¯¯¯ ToolTipSec ¯¯ 190110154314 ¯¯ 10.01.2019 15:43:14 ¯¯\
ToolTipSec(t,x=123,y=321,sec=1000,layer1to20:=1)
{
    Last_A_This:=A_ThisFunc . A_ThisLabel
   ; lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)

    MouseGetPos,xMouse,yMouse
    ; t := regexReplace(t,",",".") ;
    ; t := regexReplace(t,"+","#") ;
  if( x=123 AND y=321 )
  {
  	ToolTip, %t% , 0, % yMouse + 10, layer1to20
   ; lll(A_LineNumber, "ToolTipSec.inc.ahk")
  }
  else
  {
    ;  lll(A_LineNumber, "ToolTipSec.inc.ahk")
      if(abs(yMouse - y ) < 90 ){
        y := ( y < 500 ) ? (y+150) : (y-150)
      }
	  ToolTip, %t%,%x%,%y%, layer1to20
      ;~ MsgBox,ToolTip %t% %x% %y%
      ;
  }


  ; http://www.autohotkey.com/board/topic/81732-try-catch-doesnt-work/
  ;~ .. but here's how to suppress load-time "function not found" errors:
  blank := ""
  ;~ commaBlank := ", "
  ;~ if(isFunc("RemoveToolTip") )
  ;~ RemoveToolTip%blank%( sec )
  ; SetTimer,RemoveToolTip%layer1to20%,%sec%
  SetTimer,RemoveToolTip_level%layer1to20%,%sec%
  ;~ kkk
  ;~ RemoveToolTip( sec )
  ;~ ; jj
  
  ;~ empty:="Timer"
  ;~ Set%empty%,
  return
}

; lll(A_LineNumber, "ToolTipSec.inc.ahk", "line before #Include,inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk")
#Include *i %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
; lll(A_LineNumber, "ToolTipSec.inc.ahk" , -"line behind #Include,inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk")

