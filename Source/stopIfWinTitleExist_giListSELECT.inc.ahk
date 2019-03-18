;/¯¯¯¯ stopIfWinTitleExist_giListSELECT ¯¯ 190118021718 ¯¯ 18.01.2019 02:17:18 ¯¯\
; its does something like: WinWaitClose,% activeTitle
stopIfWinTitleExist_giListSELECT(activeTitle,detectHidden := "", excludetTitle := "AHK Studio -"){
	flagTitle_giListSELECT := "giListSELECT" ; 09.01.2019 11:26 19-01-09_11-26
	flagTitle_giListSELECT_running := " (" flagTitle_giListSELECT ")" ; 09.01.2019 11:26 19-01-09_11-26

    ; ToolTip9sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
	if(detectHidden){
		run,https://www.autohotkey.com/boards/viewtopic.php?f=76&t=60875
		MsgBox,262160,% "not working for some reasons:(`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":(`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

        ; excludetTitle := ".ahk"
		DetectHiddenWindows,On
        ; DetectHiddenText,On
		SetTitleMatchMode,2
        ; WinGetTitle, activeTitle ,% flagTitle_giListSELECT, , % excludetTitle ;  Retrieves the title of the specified window.
        ; WinGetTitle, activeTitle, ahk_class tooltips_class32
		WinGetTitle, activeTitle, % flagTitle_giListSELECT
		UniqueID := WinExist("giListSELECT")
		if(UniqueID){ ; , WinText, ExcludeTitle, ExcludeText)){
			msgbox,% UniqueID activeTitle "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
		}
        ; WinGetPos, x, y, w, h, ahk_class tooltips_class32
        ; WinGetTitle, OutputVar , WinTitle        , WinText, ExcludeTitle, ExcludeText
		ToolTip9sec(activeTitle "`n(" RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
		if(activeTitle)
			msgbox,% activeTitle "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
	}

	if(!activeTitle)
		return false

	if(!instr(activeTitle, excludetTitle ) && RegExMatch(activeTitle,"i)\b" flagTitle_giListSELECT)){
		activeTitleOLD := activeTitle
	    ; giListSELECT actionList FROM actionLists WHERE actionList Like 'g_Word' AND actionList NOT Like 'isNotAProject.ahk' order by actionList
		activeTitle := RegExReplace(activeTitle, "[\(\s]*\b[\(]*" flagTitle_giListSELECT "[\)\s]*") flagTitle_giListSELECT_running
	    ; clipboard  := activeTitle
	    ;  actionList FROM actionLists WHERE actionList Like 'g_Word' AND actionList NOT Like 'isNotAProject.ahk' order by actionList () (giListSELECT)

		activeTitle := RegExReplace(activeTitle, "i)(\bLike\b[^']+')([^']+)'" , "`n$1%$2%'") ; add wildcardd
		WinSetTitle,% activeTitleOLD,,% activeTitle
	    ; msgbox,% activeTitle "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
		if(0 && InStr(A_ComputerName,"SL5"))
			ToolTip, % "WinWait:`n`nWinSetTitle:`n" activeTitleOLD "`n=>`n" activeTitle " `n`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ,1 , 200, 20
		WinWait, %activeTitle%, , 9000,2

        ; inside: stopIfWinTitleExist_giListSELECT
		while(1){ ; while loop becouse we have casese of false with WinWaitClose 19-01-17_17-25
			; or? dont need it ?? 19-01-17_17-49
			if(1 && InStr(A_ComputerName,"SL5"))
				ToolTip, % "WinWaitClose, " substr(activeTitle,1,4) "'" substr(activeTitle,4) "`n`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") ,1 , 1, 8
    	    ; DetectHiddenWindows,On
			WinWaitClose,% activeTitle
			sleep,150
			ifwinNotExist,% activeTitle
				break
		}
		ToolTip, , , , 8
        ; MsgBox,262208,% ":) really closed???`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_permanentSELECT, % ""

		ToolTip,  ,1 , 200, 20
		ToolTip,  ,1 , 200, 8

		stop_list_change := ""
		return true
	}
}
;\____ stopIfWinTitleExist_giListSELECT __ 190118021743 __ 18.01.2019 02:17:43 __/
