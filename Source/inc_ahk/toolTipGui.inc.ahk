toolTipGui(text		; 1
, x := 1 			; 2
, y := 1 			; 3
, crosshair := "" 	; 4
, hiddenTitle := "" ; 5
, bgColor := "" 	; 6
, fontSize := 0 	; 7
, MonitorNr :=0){ 	; 8
	; also possible usage: 
 
 
	; toolTipGui(text, crosshair := "", hiddenTitle := "", bgColor := "", fontSize := 0, MonitorNr :=0)
	; example: toolTipGui("hi world ", crosshair := "|-")

	; toolTipGui(text, y, crosshair := "", hiddenTitle := "", bgColor := "", fontSize := 0, MonitorNr :=0)
	; example: toolTipGui("hi all ", 200, crosshair := "|-")

isXcrosshair := (x && !RegExMatch(x,"\d"))
if(isXcrosshair) ;  Determines if x is not a number whether a string contains a pattern (regular expression).
{
	crosshair := x
	x := 1
	
	
	if(y)
		hiddenTitle := y
	
	if(bgColor)		
		MonitorNr := bgColor
	
	if(crosshair)
		bgColor := crosshair
	
	if(hiddenTitle)
		fontSize := hiddenTitle
	
	if(crosshair)
		bgColor := crosshair
		y := 1
}
else
if(y && !RegExMatch(y,"\d")) ;  Determines if x is not a number whether a string contains a pattern (regular expression).
{
	if(fontSize)
		MonitorNr := fontSize
	if(bgColor)
		fontSize := bgColor
	if(hiddenTitle)
		bgColor := hiddenTitle
	if(crosshair)
		hiddenTitle := crosshair
	crosshair := y
		; hiddenTitle := y
	y := (x) ? x : 1
	x := 1
		; pause
}
if(!y)
	y := 1


/* 
	MonitorNr :=0 ; is the first monitor
	
	start crosshair v) writes vertically: https://www.autohotkey.com/boards/viewtopic.php?p=263885#p263885
	its much slower! about factor 50 or so! 19-02-17_10-05
	
	BTW may interesting:
	AHK GUI Edit Control vertical centering? https://www.autohotkey.com/boards/viewtopic.php?f=76&t=62095&p=263950#p263950
	
	Custom Msgbox https://www.autohotkey.com/boards/viewtopic.php?f=76&t=62081&p=263949#p263924
	
	discussion about 
	https://en.wikipedia.org/wiki/Function_overloading#Rules_in_function_overloading
	https://www.autohotkey.com/boards/viewtopic.php?f=13&t=62119&p=264071#p264071
*/

;/¯¯¯¯ toolTipGui( ¯¯ 190214201449 ¯¯ 14.02.2019 20:14:49 ¯¯\
; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=62024&p=263617#p263617
; GuiControl,  , % Gui1.HTXT, 11111111
;^--- works
; ControlSetText, Static1, % text, % "ahk_id " HGUI
;^--- works
; ToolTip, Text, X, Y, WhichToolTip




seepMili4debugSlowMotion  := 0
	; if(!y)
		; y := 1

SysGet, Mon_, Monitor,0 ; MsgBox, Left: %Mon_Left% -- Top: %Mon_Top% -- Right: %Mon_Right% -- Bottom %Mon_Bottom%.
if(crosshair){
	if(substr(crosshair,1,2)=="v)"){
		itsVerticalText := true
		crosshair := substr(crosshair,3)
			;msgbox,itsVerticalText
	}
	
		; yBackup := y
	yTemp := crosshair
	y1 := substr(yTemp,1,1)
	if(y1 == "|"){
		x := (x) ? x : 1
		yTemp := substr(yTemp,2)
	}
	else if(y1 == "/" || y1 == "\"){
			; SysGet, Mon_, Monitor,0 ; MsgBox, Left: %Mon_Left% -- Top: %Mon_Top% -- Right: %Mon_Right% -- Bottom %Mon_Bottom%.
		if(itsVerticalText)
			x := Mon_Left + Ceil(( Mon_Right - Mon_Left ) / 4)
		else
			x := -155 + Mon_Left + Ceil(( Mon_Right - Mon_Left ) / 4)
		yTemp := substr(yTemp,2)
	}
	else
		if(yTemp == "_" || yTemp == "¯" || yTemp == "-"){
			if(!Mon_)
					; SysGet, Mon_, Monitor,0 ; MsgBox, Left: %Mon_Left% -- Top: %Mon_Top% -- Right: %Mon_Right% -- Bottom %Mon_Bottom%.
				if(itsVerticalText)
					xMiddle := Mon_Left + Ceil(( Mon_Right - Mon_Left ) / 2)
			else
				xMiddle := -155 + Mon_Left + Ceil(( Mon_Right - Mon_Left ) / 2)
			x += xMiddle
		}
	
	y1 := substr(yTemp,1,1)
	if(y1=="¯"){
		y := (y) ? y : 1
	}
	else if(y1=="_"){
			; SysGet, Mon_, Monitor,0
			; SysGet, Mon2, Monitor, 2
			; MsgBox, Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.
		temp :=  Mon_Bottom - 20
		y := (y) ? y + temp : temp
		if(!y)
			msgbox,%y%=y, %Mon_Bottom%=Mon_Bottom ERROR 19-02-16_10-57
	}
	else if(y1=="-"){
			; SysGet, Mon_, Monitor,0
		temp := ((Mon_Bottom - Mon_Top)/2)  - 20
		y := (y) ? y + temp : temp
		if(!y)
			msgbox,%y%=y ERROR 19-02-16_10-57 ln: %A_Linenumber%
	}
		;pause
	yTemp := substr(yTemp,2)
	
		; if(yTemp)
	if(yTemp=="|"){
			; SysGet, Mon_, Monitor,0
		if(itsVerticalText)
			x +=  Mon_Right - 20
		else
			x +=  Mon_Right - 150
		if(!x)
			msgbox,ERROR 19-02-16_11-12
			; msgbox,% "45:" yTemp " # " x "," y " # " yBackup " =yBackup   #   " y1 "  ==y1"
	}
	else if(yTemp == "/" || yTemp == "\"){
			; SysGet, Mon_, Monitor,0 ; MsgBox, Left: %Mon_Left% -- Top: %Mon_Top% -- Right: %Mon_Right% -- Bottom %Mon_Bottom%.
		xTemp := -155 + Mon_Left + Ceil(( Mon_Right - Mon_Left ) / 4 * 3)
		x := (x) ? x + xTemp : xTemp
		yTemp := substr(y,2)
	}
		; msgbox,% "47:" yTemp " # x,y=" x "," y " # " yBackup " = yBackup # " y1 "  ==y1"
}
if(!x){
	x := -155 + Mon_Left + Ceil(( Mon_Right - Mon_Left ) / 2)
		; msgbox,%x% 19-02-16_11-12
}

if(MonitorNr)
	x += MonitorNr * Mon_Right

if(!hiddenTitle)
	hiddenTitle := "hiddenTitle1902121943"
if(!bgColor)
	bgColor := "Green"
if(bgColor=="Red")
	bgColor := "Fuchsia"
if(bgColor=="Orange")
	bgColor := "Maroon"
		; bgColor := "Blue"
if(!fontSize)
	fontSize := 10




DetectHiddenWindows,Off
settitlematchmode,3
	; ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
	; UniqueID := WinExist(WinTitle , WinText, ExcludeTitle, ExcludeText)
titleClass := hiddenTitle " ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe"
If( HGUI := WinExist( titleClass )){ ; returns the Unique ID (HWND)
	ControlSetText, Static1, % text, % "ahk_id " HGUI
		;^--- works
	
	if(!itsVerticalText && !regExMatch(text,"[\n\r]")) ;<=== regExMatch may not very performant
		WinMove, % "ahk_id " HGUI, , % x , % y , , 20 ; -  - 30
	else{
		if(itsVerticalText){
			global wb
			winclose,% hiddenTitle ;<=== not very performant. better solution ????????????????????
			verticalText(wb,text,x,y,hiddenTitle)
		}else
			WinMove, % "ahk_id " HGUI, , % x , % y
	}
		; WinMove, % "ahk_id " hwnd2,,x,y,w,h
		;^--- works
		; WinMove, % titleClass, , % x , % y - 30 ; - 15
		;^--- works
	Gui1 := {HGUI: HGUI, HTXT: text}
	if(seepMili4debugSlowMotion){
		CoordMode, ToolTip, Screen
		toolTip,%yBackup% ==> %x%`,%y%   ,300,55
		sleep,% seepMili4debugSlowMotion
	}
	return {HGUI: HGUI, HTXT: text}
}
	;msgbox, % HGUI " was NOT: " titleClass " at x,y ? " x "," y

	; Gui, New, +AlwaysOnTop +ToolWindow -SysMenu +HwndHGUI
Gui, New, +AlwaysOnTop +ToolWindow -SysMenu -Caption +HwndHGUI
	; Gui, New, +ToolWindow -SysMenu -Caption +HwndHGUI
Gui, Color, %bgColor%

/*
	Black
	Silver
	Gray
	White
	Black
	Silver
	Gray
	White
	Maroon
	Red
	Purple
	Fuchsia
	Green
	Lime
	Olive
	Yellow
	Navy
	Blue
	Teal
	Aqua
*/
if(bgColor == "Yellow" || bgColor == "Fuchsia" || bgColor == "White")
	fontColor:="Black"
else
	fontColor:="White"

if(itsVerticalText){
	global wb
	verticalText(wb,text,x,y,hiddenTitle)
	;msgbox,% hiddenTitle
	return
}

Gui, Font, c%fontColor% s%fontSize% q1, Arial Narrow ;red ; changed s11 to s10
Gui, Add, Text, y0 hwndHTXT, %text%
	; Return {HGUI: HGUI, HTXT: HTXT} ; Gui1 := toolTipGui()
Gui1 := {HGUI: HGUI, HTXT: HTXT}
Gui, % Gui1.HGUI . ":Show", NoActivate x%x% y%y% , % hiddenTitle
	;tooltip,WinWait4564213
	;WinWait,% hiddenTitle
	;tooltip,

	;return

if(seepMili4debugSlowMotion){
	CoordMode, ToolTip, Screen
	toolTip,%yBackup% ==> %x%`,%y%   ,300,55
	sleep,% seepMili4debugSlowMotion
}


;msgbox,% hiddenTitle

return Gui1 ; older:
}
;\____ toolTipGui __ 190214201453 __ 14.02.2019 20:14:53 __/




; verticalText(wb,"test",100)
; verticalText(wb,"wow",400)
; 	x:= 100, y:= 100

;		verticalText(wb,text,x,y,hiddenTitle)


verticalText(ByRef wb,text,x, y,hiddenTitle,fontSize := 16,fontFamily := "Arial Narrow",width := 184,height := 18){
	top := (width - height )//2
	left := -top
	
	html =
(
<!doctype html>
<html>
<head>
   <style>
      div {
         background-color: #088;
         position: absolute;
         left: %left%px;
         top: %top%px;
         width: %width%px;
         height: %height%px;
         transform: rotate(-90deg);
      }
      p {
         margin: 0;
         position: relative;
         top: 57`%;
         transform: translateY(-50`%);
         color: white;
         text-align: center;
         font-size: %fontSize%px;
         font-family: %fontFamily%;
         cursor: default;
      }
   </style>
</head>
<body>
   <div><p>%text%</p></div>
</body>
</html>
)
	
	Gui, New, -Caption +ToolWindow +AlwaysOnTop -DPIScale
	Gui, Margin, 0, 0
	Gui, Add, ActiveX, w%height% h%width% vWB, about:<meta http-equiv="X-UA-Compatible" content="IE=edge">
	wb.document.write(html)
	wb.refresh()
	; Gui, Show
	; X and Y are GUI coordinates, they must be here:
	; Gui, % Gui1.HGUI . ":Show", NoActivate x%x% y%y% , % hiddenTitle
	Gui, Show, x%x% y%y% , % hiddenTitle
	OnMessage(0x201, "WM_LBUTTONDOWN")
	Return
}

;/¯¯¯¯ toolTipGui ¯¯ 190217113244 ¯¯ 17.02.2019 11:32:44 ¯¯\
;part of toolTipGui
; should help moving the toolTipGuis by the mouse. seems works not in this context
WM_LBUTTONDOWN() {
	PostMessage, WM_NCLBUTTONDOWN := 0xA1, HTCAPTION := 2
}
;toolTipGui("just started (-:",,80*(toolTipGui_yOffsetNr++),"v)|¯",A_LineNumber,"",,0)  ; x will be offset if y is symbolic
; ^--- moving the boxes works only if a active x box (here only the vertical ones is active).
; ^--- so you need one vertical active for enable moving feater of the oter toolTipGuis
;\____ toolTipGui __ 190217113248 __ 17.02.2019 11:32:48 __/

