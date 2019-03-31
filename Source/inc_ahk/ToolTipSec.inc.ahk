; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=63211

; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
; #Include *i init_global.init.inc.ahk

;~ GLOBAL_lllog_only_this_scriptName=ToolTipSec.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ examples:
;~ ToolTip5sec("wwwww`nwwwww`nwwww`n", A_ScreenWidth - 100, A_ScreenHeight - 100)
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; lll(A_LineNumber, "ToolTipSec.inc.ahk","test")
; #Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
; lll(A_LineNumber, "ToolTipSec.inc.ahk","line behind #Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk")



;~ global jumperVariable6573546378345:=true
;~ jumperVariable6573546378345:=true
;~ LabeljumperVariable6573546378345:

ToolTip1sec(t,x=123, y := 0, layer1to20:=0){
	Last_A_This:=A_ThisFunc . A_ThisLabel
  ;~ lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	ToolTipSec(t,x,y,1000, layer1to20)
	return
}


ToolTip2sec(t,x=123, y := 0, layer1to20:=0){
	Last_A_This:=A_ThisFunc . A_ThisLabel
  ;~ lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	ToolTipSec(t,x,y,2000, layer1to20)
	return
}

ToolTip3sec(t,x=123, y := 0, layer1to20:=0){
	Last_A_This:=A_ThisFunc . A_ThisLabel
  ;lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	
	ToolTipSec(t,x,y,3000, layer1to20)
	return
}

ToolTip4sec(t,x=123, y := 0, layer1to20:=0){
	Last_A_This:=A_ThisFunc . A_ThisLabel
  ;lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	
	ToolTipSec(t,x,y,4000, layer1to20)
	return
}

ToolTip5sec(t,x=123, y := 0, layer1to20:=0){
	ToolTipSec(t,x,y,5000, layer1to20)
	Last_A_This:=A_ThisFunc . A_ThisLabel
	lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	return
}

ToolTip6sec(t,x=123, y := 0, layer1to20:=0){
	ToolTipSec(t,x,y,6000, layer1to20)
	Last_A_This:=A_ThisFunc . A_ThisLabel
	lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	return
}

ToolTip7sec(t,x=123, y := 0, layer1to20:=0){
	ToolTipSec(t,x,y,7000, layer1to20)
	Last_A_This:=A_ThisFunc . A_ThisLabel
	lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	return
}

ToolTip8sec(t,x=123, y := 0, layer1to20:=0){
	ToolTipSec(t,x,y,8000, layer1to20)
	Last_A_This:=A_ThisFunc . A_ThisLabel
	lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	return
}

;/���� ToolTip9sec �� 190110154202 �� 10.01.2019 15:42:02 ��\
ToolTip9sec(t,x=123, y := 0, layer1to20:=0){
	ToolTipSec(t,x,y,9000, layer1to20)
	Last_A_This:=A_ThisFunc . A_ThisLabel
	lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	return
}
;\____ ToolTip9sec __ 190110154205 __ 10.01.2019 15:42:05 __/


;/¯¯¯¯ ToolTipSec ¯¯ 190329184309 ¯¯ 29.03.2019 18:43:09 ¯¯\
; if y is empty a outomativally offset ist produced
; y could be a offset. then wrute as a string "+55" of "-55" means "+-number"
; if layer1to20 its outomativally counted plus 1
ToolTipSec(t, x := 123, y := 0, sec := 1000, layer1to20 := 0)  {
	global layer1to20_lastUsed1903291808
	global abs_y_lastUsed1903291808
	global strlen_lastUsed1903291808
	
	if(!abs_y_lastUsed1903291808)
		abs_y_lastUsed1903291808 := 0
	if(y){
		y1 := substr(y,1,1)
		if(y1=="+" || y1=="-")
			y_offset := y
		y := 0
	}
	if(!y){
		if(!y_offset)
			y_offset := (strlen_lastUsed1903291808 < 100) ? 25 : 50
		y := (abs_y_lastUsed1903291808) ? abs_y_lastUsed1903291808 + y_offset : 1
		if(y > A_ScreenHeight - y_offset)
			y := 1
		abs_y_lastUsed1903291808 := y ; if y was empty not set by attribute
	}
	
	if(!layer1to20_lastUsed1903291808)
		layer1to20_lastUsed1903291808 := 0
	if(!layer1to20){
		if(layer1to20_lastUsed1903291808 < 20)
			layer1to20 := layer1to20_lastUsed1903291808 + 1
		else
			layer1to20 := 1
	}
	layer1to20_lastUsed1903291808 := layer1to20
	
	strlen_lastUsed1903291808 := StrLen(t)
	
	; Last_A_This:=A_ThisFunc . A_ThisLabel
   ; lll(A_LineNumber, "ToolTipSec.inc.ahk",Last_A_This)
	
	if(0){
		MouseGetPos,xMouse,yMouse
    ; t := regexReplace(t,",",".") ;
    ; t := regexReplace(t,"+","#") ;
		if(x=123 && y=321 )
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
      ;~ MsgBox,ToolTip %t% %x% %y%
      ;
		}
	}else
		ToolTip, %t%,%x%,%y%, layer1to20
	
  ; http://www.autohotkey.com/board/topic/81732-try-catch-doesnt-work/
  ;~ .. but here's how to suppress load-time "function not found" errors:
	blank := ""
  ;~ commaBlank := ", "
  ;~ if(isFunc("RemoveToolTip") )
  ;~ RemoveToolTip%blank%( sec )
  ; SetTimer,RemoveToolTip%layer1to20%,%sec%
	
		; [v1.0.46.16+]: If Period is negative, the timer will run only once. For example, specifying -100 would run the timer 100 ms from now then disable the timer as though SetTimer, Label, Off had been used.
		; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=63211&p=270560#p270560
	SetTimer,RemoveToolTip_level%layer1to20%,-%sec%
	; RemoveToolTip_level1Obj := Func("RemoveToolTip_level" layer1to20)
  	; pause
  	; dont need: this happens inside the romove tooltip call: SetTimer, % RemoveToolTip_level1Obj, ,Off
	
  ;~ kkk
  ;~ RemoveToolTip( sec )
  ;~ ; jj
	
  ;~ empty:="Timer"
  ;~ Set%empty%,
	return
}
;\____ ToolTipSec __ 190328093749 __ 28.03.2019 09:37:49 __/
		
; lll(A_LineNumber, "ToolTipSec.inc.ahk", "line before #Include,inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk")
#Include *i %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
; lll(A_LineNumber, "ToolTipSec.inc.ahk" , -"line behind #Include,inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk")

