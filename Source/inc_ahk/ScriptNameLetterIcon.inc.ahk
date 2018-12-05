; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
ScriptNameLetter := SubStr(A_ScriptName, 1 , 1)
ScriptNameLetter2 := SubStr(A_ScriptName, 1 , 2)
;~ tatam
if(!iconAdress)
	iconAdress=%HardDriveLetter%:\fre\public\Graf-Bilder\icon\abc123\%ScriptNameLetter2%.ico

if(!FileExist(iconAdress))
	iconAdress=%HardDriveLetter%:\fre\public\Graf-Bilder\icon\abc123\%ScriptNameLetter%.ico
; C:\fre\public\Graf-Bilder\icon\abc123

; Checks for the existence of a file or folder.
ifexist,%iconAdress%
Menu, Tray, Icon, %iconAdress%
else
	ToolTip,http://www.branchenbuch-weltweit.dk/img/abc/a.png

  ; probably very good icon programm: http://www.mitec.cz/iconex.html

  ;~ May useful : http://antifavicon.com/
  ; http://www.grsites.com/generate/group/9000/ hübsch? aber sicher?
  ; batch pix to icon http://www.axialis.com/tutorials/tutorial-iw001.html

;~ http://pcwizkidstechtalk.com/index.php/win7-icons.html
;~ Menu, Tray, Icon, shell32.dll, 44 ; thats a pretty star
;~ Menu, Tray, Icon, shell32.dll, 2 ; a ide or floppy
;~ Menu, Tray, Icon, shell32.dll, 250 ; pretty green stick
;~ Menu, Tray, Icon, shell32.dll, 250 ; pretty black stick

;~ Menu, Tray, Icon, shell32.dll, 240 ; pretty green clock
;~ Menu, Tray, Icon, shell32.dll, 266 ; pretty black clock

;~ There are some icons built into the operating system's DLLs and CPLs that might be useful.
;~ For example: Menu, Tray, Icon, Shell32.dll, 174 ; Omits the DLL's path so that it works on Windows 9x too.

;/¯¯¯¯ isNearTrayMenue ¯¯ 181204185532 ¯¯ 04.12.2018 18:55:32 ¯¯\
isNearBorder(){
	MouseGetPos,mousex,mousey
	SysGet, VirtualWidth, 78 ; https://autohotkey.com/docs/Variables.htm
	SysGet, VirtualHeight, 79 ; https://autohotkey.com/docs/Variables.htm
	result := ( abs(VirtualHeight - mousey) < 111
		||  abs(VirtualWidth - mousex) < 111
		||  mousey < 111
		||  mousex < 111 )
	return result
	m =
(
%A_ScreenWidth% , %A_ScreenHeight%
%VirtualWidth% , %VirtualHeight%
%mousex% , %mousey%
)
}
;\____ isNearTrayMenue __ 181204185536 __ 04.12.2018 18:55:36 __/

;/¯¯¯¯ showTempTrayIf_isNearTrayMenue ¯¯ 181204193517 ¯¯ 04.12.2018 19:35:17 ¯¯\

;/���� isNearTrayMenue �� 181204185532 �� 04.12.2018 18:55:32 ��\
isNearTrayMenue(){
	MouseGetPos,mousex,mousey
	SysGet, VirtualWidth, 78 ; https://autohotkey.com/docs/Variables.htm
	SysGet, VirtualHeight, 79 ; https://autohotkey.com/docs/Variables.htm
	isNearTrayMenue := ( abs(VirtualHeight - mousey) < 111 &&  abs(VirtualWidth - mousex) < 800 )
	return isNearTrayMenue
	m =
(
%A_ScreenWidth% , %A_ScreenHeight%
%VirtualWidth% , %VirtualHeight%
%mousex% , %mousey%
)
}
;\____ isNearTrayMenue __ 181204185536 __ 04.12.2018 18:55:36 __/



;/���� showTempTrayIf_isNearTrayMenue �� 181204193517 �� 04.12.2018 19:35:17 ��\
showTempTrayIf_isNearTrayMenue(iconAdress){
	; trayName :=  := RegExReplace(A_ScriptName, "\..*","") "_icon"
	trayName := RegExReplace(A_ScriptName , ".*\\([\w\s\._]+)\.\w+$", "$1") "_icon"
	; isNearTrayMenue := isNearTrayMenue() ; thtas buggy if you move it to a nother Border
	isNearTrayMenue := isNearBorder()
	if(isNearTrayMenue, A_IconHidden ){
		; Msgbox, % A_IconHidden
		ahkCode =
			(
#Persistent
#SingleInstance,Force
realAScriptName = %A_ScriptName%
ifExist,%iconAdress%
	Menu, Tray, Icon, %iconAdress%
else
  ToolTip,http://www.branchenbuch-weltweit.dk/img/abc/a.png
Menu, Tray, Tip , `% Chr(8203) ; i dont want text there. The tray icon's tooltip is displayed when the mouse hovers over it.
Menu, Tray, add
Menu, Tray, add, Reload Script (parent), lbl_reload
Menu, Tray, add, Edit Script (parent), lbl_edit
Menu, Tray, add, ExitApp (parent), lbl_ExitApp
return
lbl_reload:
	Run, "%A_ScriptFullPath%"
return
lbl_edit:
	Run, edit "%A_ScriptFullPath%"
return
lbl_ExitApp:
	MsgBox,ExitApp %A_ScriptName%
	ExitApp
	DetectHiddenWindows,On
	SetTitleMatchMode,2
	while(WinExist("%A_ScriptName%")){
		WinClose, %A_ScriptName%
		WinKill, %A_ScriptName%
	}
return

			)
		; ahkCode .= "#" "Include " A_ScriptDir "\inc_ahk\ScriptNameLetterIcon.inc.ahk"
		;

		; Clipboard := ahkCode

		SetTitleMatchMode,2
		DetectHiddenWindows,On
		If(!WinExist(trayName))
			DynaRun(ahkCode,trayName)
			;reload
	}else{
		SetTitleMatchMode,2
		DetectHiddenWindows,On
		while(WinExist(trayName)){
			WinClose, % trayName
			WinKill, % trayName
		}
	}
	return trayName
}
;\____ showTempTrayIf_isNearTrayMenue __ 181204193522 __ 04.12.2018 19:35:22 __/
