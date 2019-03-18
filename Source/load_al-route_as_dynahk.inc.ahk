
; toolTipGui("a: " actionListNEW "`n(" RegExReplace(A_LineFile, ".*\\") ")" ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Orange",,1)  ; x will be offset if y is symbolic

/* this dynAhk-source calls at the end this function:

if(substr(actionListDir,1,1) == "\")
    MsgBox,% "ups actionListDir `n has a linux absolute Path`n = `n`n" actionListDir "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

	actionListNEWactivate( actionListDir , actionListNEW, actionListActive, gi_everywhereSourcePath, activeClass , activeTitle)  

	and is latter executed about 200lines bevore the end of file:
	FileWriteAndRun( ahkSource , A_ThisFunc A_LineNumber ".temp.ahk" ) ; TODO: wozu ? 13.08.2017 10:52
	===> if disable this line list is never changing. you always the same list.
*/


mvarInjectsAHKcode := mvarInjects(actionListDir, actionList
,activeTitle,activeClass,controlName
,alTitle,alClass,alControl)

if(!mvarInjectsAHKcode)
    MsgBox,% "ups !mvarInjectsAHKcode  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"


ahkSource := ";" "this file was generated from " A_ScriptName ">" A_LineFile " `n"
ahkSource .= "g_lineNumberFeedback=" A_LineFile "~" A_ThisFunc "~" A_LineNumber " token902192129 `n"
ahkSource .= "#" "SingleInstance, force"   " `n"
ahkSource .= "#" "NoTrayIcon"  " `n"
ahkSource .= "SetWorkingDir, " A_ScriptDir " `n"
; ahkSource .= demoData   " `n"
; ahkSource .= "#" "Include, " actionListFilterPath . "  `; thats the subfolder  wordlost inside class `n"
ahkSource .= "actionListFilterPath2 = " actionListFilterPath2  " `n"
ahkSource .= "actionListFilterPath2Abs = " actionListFilterPath2Abs  " `n"
ahkSource .= "fileEx := FileExist ( actionListFilterPath2Abs ) `n"
; ahkSource .= "KeyWait Control  `; Wartet darauf, dass sowohl STRG als auch ALT losgelassen wird. `n"

ahkSource .= "if( !fileEx ) { `n"
ahkSource .= "   message = :(  ``n '%actionListFilterPath2%'  ``n '%actionListFilterPath2Abs%'  ``n existiert nicht ( `%fileEx%` = fileEx ) `n"

; . ``n ``n message with id (1704171514) was copied to the Clipboard. Sor you probably could find this source code little bit easier. ``n (from: %A_LineFile%~%A_LineNumber%) `n "

ahkSource .= "   tooltip, `%message`%=m , 1,1 `n "
; ahkSource .= "Clipboard = `%message`%  `n "
; ahkSource .= "Msgbox,4 , :( al-route.inc.ahk not found , `%message`% , 4  `n "
; ahkSource .= "tooltip,:( al-route.inc.ahk not found : `%message`% , 1,1  `n "
ahkSource .= "   Sleep, 4000 `n"
ahkSource .= "   ExitApp  `n"
ahkSource .= "} `; endOf if( !fileEx ) `n"

; toolTipGui("a: " actionListNEW " `n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Purple",,1)  ; x will be offset if y is symbolic

/* (actionList
  ,activeTitle,activeClass,controlName
  , stop_list_change
  , actionListDirBase
*/
; alTitle,alClass,alControl
ahkSource .= mvarInjects(actionListDir, actionList
,activeTitle,activeClass,controlName
,alTitle,alClass,alControl) " `n"
; OLD ================== (before 2019 > ahkSource .= mvarInjects(actionListDir, actionListNEW, activeClass, activeTitle) " `n"

actionList_inClassFolder_Exist  := fileExist(actionListFilterPath2Abs)

; toolTipGui(actionList_inClassFolder_Exist ":" actionListFilterPath2Abs "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Purple",,1)  ; x will be offset if y is symbolic

if(actionList_inClassFolder_Exist)
	ahkSource .= "#" "Include " actionListFilterPath2Abs "  `; thats the subfolder actionList inside class `n"
;    ahkSource .= "#" "Include *i " actionListFilterPath2Abs "  `; thats the subfolder actionList inside class `n"
 ;   ahkSource .= "#" "Include *i " actionListFilterPath2 . "  `; thats the subfolder  wordlost inside class `n"

if(!actionListNEW && InStr(A_ComputerName,"SL5")){
    msg =
    (
    ERROR
    !actionListNEW
    actionListNEW =
    <%actionListNEW%>=<`%actionListNEW`%>
    )
    msg .= "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    msgbox,msg `n `n 19-02-08_19-42
    ToolTip,% "(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")", 250,1,17
    Speak("Hallo " A_LineNumber,"PROD")
    sleep,3000
}
; ahkSource .= "actionListOLD = " actionListOLD  " `n"
; ahkSource .= "gi_everywhereSourcePath = "  gi_everywhereSourcePath  " `n"
; ahkSource .= "actionListActive = "  actionListActive   " `n"
;/¯¯¯¯ ahkSourceTemp ¯¯ 190209052303 ¯¯ 09.02.2019 05:23:03 ¯¯\
ahkSourceTemp .= "#" "Include," A_ScriptDir "\RegWrite181031.ahk `n"
;                                     \Source\RegWrite181031.ahk
;\____ ahkSourceTemp __ 190209052339 __ 09.02.2019 05:23:39 __/

; feedbackMsgBox("ahkSourceTemp (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), ahkSourceTemp, 1, 1, 6 )

activeTitle_short := substr(activeTitle,1,50) "... "
msg := "al=" RegExReplace(actionListNEW, ".*\\") " <== "
msg .= "c=" activeClass " \ t=" activeTitle_short
; toolTipGui(msg " (" A_ThisFunc ":" A_LineNumber ")" ,0,,"|_",A_LineNumber,"Orange",,1)  ; x will be offset if y is symbolic

ahkSource .= "`n actionListNEWactivate( actionListDir , actionListNEW, actionListActive, gi_everywhereSourcePath, activeClass , activeTitle)"  " `n"
if(debugIt)
	ahkSource .= "MsgBox, , debugIt , `% varInjects1 . "" ``n "" varInjects2 . "" ``n actionListNEW = '"" actionListNEW . ""'  ``n (lineCaller:" A_LineNumber . ") ``n "" ,9 `n"
ahkSource .= "ExitApp"  " `n"
; \Source\create_al_Address.inc.ahk
ahkSource .= "#" "Include, " A_ScriptDir "\create_al_Address.inc.ahk  `; `n"
ahkSource .= "`; ENDOF dynahk 19-02-19_10-52 `n"

#Include keyWaitReleased.ahk ;  ; Source\
DetectHiddenWindows,On
SetTitleMatchMode,2
IfWinNotExist,temp.ahk ahk_class #32770
{
	if(activeTitle == "giListSELECT" && InStr(A_ComputerName,"SL5") )
		MsgBox,% ahkSource "`n" actionList "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	FileWriteAndRun( ahkSource , A_ThisFunc A_LineNumber ".temp.ahk" ) ; TODO: wozu ? 13.08.2017 10:52
} else {
	Tooltip, WinWaitClose temp ahk `n (from: %A_LineFile%~%A_LineNumber%)
	WinWaitClose,temp.ahk ahk_class #32770,,1
	Tooltip,
	IfWinExist,temp.ahk ahk_class #32770
	{
		msg=:-O WinExist temp.ahk `n `n %A_LineFile%~%A_LineNumber% ==> WinWaitClose
		SetTitleMatchMode,2
		WinWaitClose,temp.ahk ahk_class #32770
		if(1 || !InStr(A_ComputerName,"SL5") )
			winclose,temp.ahk ahk_class #32770
		if(1 && InStr(A_ComputerName,"SL5") ){
			if(!WinExist(":Oops"))
				feedbackMsgBox("Oops ",msg,1,1)
		}
		return A_LineNumber ; continue
	}
}
DetectHiddenText,Off
