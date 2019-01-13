#SingleInstance, force
#Include .\..\ActionLists\ChromeWidgetWin1\..\ActionListNameFilter.inc.ahk ; global ActionList . pleas dont delete this line! 17-03-06_10-59
ActionListFilterPath = .\..\ChromeWidgetWin1\AutoHotkeyGUI\ActionListNameFilter.inc.ahk 

if(!ActionListNEW)
	msgbox, % "ERROR ActionListNEW is EMPTY.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

if(0 && InStr(A_ComputerName,"SL5"))
    clipboard := A_scriptDir ; ...\Source


; ActionListNEW := "global.ahk" ; 26.09.2018 07:46 if you has to many files
if(false){ ; needet becouse later we use else if very often 28.09.2018 09:12
	noop:=0
}
#Include *i %A_ScriptDir%\..\ActionLists\ChromeWidgetWin1\PRIVATE_ActionListNameFilter.inc.ahk
; #Include PRIVATE_ActionListNameFilter.inc.ahk
else if ( instr( activeTitle , "Benachrichtigung:")  &&  RegExMatch( activeTitle , "Gmail")   )
	ActionListNEW := "Benachrichtigung_Google_Chrome"
	
else if ( RegExMatch( activeTitle , "i)\b(Gmail|Google Contacts|Google Kalender)\b"  )    ){
	ActionListNEW := "Gmail_Google_Chrome"
	; msgbox,% activeTitle " => " ActionListNEW
}
else if ( FALSE && RegExMatch( activeTitle , "i)\b(AutoHotkey Community)\b"  )    ){
	ActionListNEW := "..\_globalActionLists\AutoHotkey_Community"
	
}


else if (RegExMatch( activeTitle , "(\.ahk)" ) ){
	if(false && activeClass == "ChromeWidgetWin1") {  ; want to know that. debugging 26.4.218 12:18}
        ; need to be discussed: https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-22
		; tooltip,% activeTitle activeClass
		ToolTip4sec(activeTitle activeClass "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
		clipboard := activeTitle activeClass
		sleep,9000
		log =
        (
        https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-22
        blabla.ahk - AutoHotKey - Visual Studio Code [Administrator]
        ahk_class Chrome_WidgetWin_1
        ahk_exe Code.exe
        )
	}
    ;ActionListNEW := "..\_globalActionListsGenerated\_ahk_global.ahk._Generated" ; seems works not 18-04-26_12-44
	ActionListNEW := "..\_globalActionListsGenerated\_ahk_global.ahk._Generated.ahk" ; seems works not 18-04-26_12-44
}
if( SubStr( ActionListNEW , -3 ) <> ".ahk" ) ; thats corect i proofed it. 11.04.2017 15:47
	ActionListNEW .= ".ahk"
	
if(!ActionListNEW)
	msgbox, % "ERROR ActionListNEW is EMPTY.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
ActionListNEW := maybeSuperglobalActionList(ActionListNEW, ActionListNEW_time_between , ActiveClass )
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; if you want you could use the follwong global variables fot calculating you new ActionListNEW : ActionListDir, ActionListNEW, ActiveClass, activeTitle
if (!ActionListNEW ){
	m := "ERROR ActionListNEW is EMPTY 17-03-19_11-51. ActionList=" ActionList "`n(" A_LineNumber " " A_LineFile ")" 
	ToolTip9sec(m "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"  )
	msgbox, % m " :((( "
	; Clipboard := ActionListNEW
}

