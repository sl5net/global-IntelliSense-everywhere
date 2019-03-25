;/¯¯¯¯ dontChangeRoute ¯¯ 190218174123 ¯¯ 18.02.2019 17:41:23 ¯¯\
dontChangeRoute(actionList
,activeTitle,activeClass,controlName
, stop_list_change ){

; if(stop_list_change)
;	FALSEstring := A_LineNumber ;

; if(activeTitleOLD == activeTitle && activeClassOLD == activeClass )
;	FALSEstring := A_LineNumber ;

; WinWaitNotActive,- Everything , , 9 ; ahk_class EVERYTHING
if(activeClass == "EVERYTHING" ) ; RegExMatch(activeTitle,"- Everything\b")
	FALSEstring := A_LineNumber ;

else if(activeClass == "tooltips_class32" )
	FALSEstring := A_LineNumber ;

else if(RegExMatch(activeTitle,"^\d:.+")){
	FALSEstring := A_LineNumber ; continue
}

else if(RegExMatch(activeTitle,"\bCopyQ\b")){
	FALSEstring := A_LineNumber ; continue
}

; i dont want catch the tooltips: " ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe"
else if(activeClass == "AutoHotkeyGUI" && WinActive(" ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe") ){ ; RegExMatch(activeTitle,"^\d:.+")){
	FALSEstring := A_LineNumber ; continue
}

else if(instr(activeTitle,"actionListChangedInRegistry")){ ; Position 1 is the first character; this is because 0 is synonymous with "false"
	tooltip,WinWaitNotActive xxyyzzee
	WinWaitNotActive,actionListChangedInRegistry ahk_class AutoHotkeyGUI
	tooltip,
	if(0 && InStr(A_ComputerName,"SL5")){
		ToolTip,% "(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")", 250,1,17
		Speak("Hallo " A_LineNumber,"PROD")
	}
	sleep,500
	FALSEstring := A_LineNumber ; continue
}

else if(!activeTitle && !activeClass && !controlName) {
	FALSEstring := A_LineNumber " !activeTitle && !activeClass && !controlName " ; reload
}

else if(!activeTitle) {
	FALSEstring := A_LineNumber " !activeTitle " ; reload
}

if(FALSEstring){
    msg =
    (
    FALSEstring: %lineNumberFrom%
    a = %actionList%
    t,c,l = %activeTitle%,%activeClass%,%controlName%
    %lineNumberFrom%
    )
    ;toolTipGui("lineNumberFrom: " lineNumberFrom " . . . . . . . . . . . . . " ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Red",,1)  ; x will be offset if y is symbolic
	; MsgBox,% msg "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	return FALSEstring ; reload
}

return false
}
;\____ dontChangeRoute __ 190218174128 __ 18.02.2019 17:41:28 __/



;/¯¯¯¯ create_al_Address_getParametersCheckErrorMsg ¯¯ 190218174858 ¯¯ 18.02.2019 17:48:58 ¯¯\
create_al_Address_getParametersCheckErrorMsg(actionList
,activeTitle,activeClass,controlName
, stop_list_change
, actionListDirBase ){
; plausibility check of function parameters

if(substr(actionListDirBase,1,1) == "\"){
	MsgBox,% A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
	;actionListDirBase := A_ScriptDir actionListDirBase
} else if(!actionListDirBase){
    FALSEstring := A_LineNumber " !activeTitle && !activeClass && !controlName"
} else if(!activeTitle && !activeClass && !controlName)
    FALSEstring := A_LineNumber " !activeTitle && !activeClass && !controlName"
else if(0 && !activeTitle)
    FALSEstring := A_LineNumber " !activeTitle"
else if(0 && !activeClass)
    FALSEstring := A_LineNumber " !activeClass"
if(FALSEstring){
    msg =
    (
    FALSEstring: %lineNumberFrom%
    a = %actionList%
    t,c,l = %activeTitle%,%activeClass%,%controlName%
    %lineNumberFrom%
    )
    ;toolTipGui("lineNumberFrom: " lineNumberFrom " . . . . . . . . . . . . . " ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Red",,1)  ; x will be offset if y is symbolic
	; MsgBox,% msg "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	return FALSEstring ; reload
}
}
;\____ create_al_Address_getParametersCheckErrorMsg __ 190218174900 __ 18.02.2019 17:49:00 __/



;/¯¯¯¯ createIfFileNotExist_al_route_InNewDir ¯¯ 181023081846 ¯¯ 23.10.2018 08:18:46 ¯¯\
createIfFileNotExist_al_route_InNewDir(actionListDir, actionListFilterPath,ahkCode){
	global g_lineNumberFeedback
	if(FileExist( actionListFilterPath ) )
		return true
	g_lineNumberFeedback  := "(" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\") ")"
	if(!FileExist(actionListDir)){
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
		FileCreateDir, % actionListDir
        ;~ FileAppend, , % actionListFilterPath
	}
	g_lineNumberFeedback  := "(" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\") ")"
	if(1 && InStr(A_ComputerName,"SL5"))
		tooltip,% "FileAppend " g_lineNumberFeedback
	if(1 && InStr(A_ComputerName,"SL5") )
		RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
	FileAppend, % ahkCode , % actionListFilterPath
	return true
}
;\____ createIfFileNotExist_al_route_InNewDir __ 181023081850 __ 23.10.2018 08:18:50 __/








;/¯¯¯¯ actionListNEWactivate( ¯¯ 181012014107 ¯¯ 12.10.2018 01:41:07 ¯¯\
; hier wird das active ueberschrieben: 12.07.2017 21:33
; here the current list will be overwritten
actionListNEWactivate( ByRef actionListDir
        , ByRef actionListNEW
        , ByRef actionListActive
        , ByRef gi_everywhereSourcePath
        , activeClass := ""
        , activeTitle := "" ) {
; return, 1 ; return spielt keine rolle, quasi void 30.07.2017 12:52 17-07-30_12-52
		SetTitleMatchMode,2
		global g_lineNumberFeedback


        if(actionListDir == A_ScriptDir)
            MsgBox,% "ups actionListDir ==A_ScriptDir =`n" A_ScriptDir "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"


        if(substr(actionListDir,1,1) == "\")
            MsgBox,% "ups actionListDir `n has a linux absolute Path`n = `n`n" actionListDir "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"


		postFixGenerated := "._Generated.ahk"
		thisPostFix := SubStr(rtrim(actionListNEW), - StrLen(postFixGenerated) + 1 )
		itsAGeneratedList := ( postFixGenerated == thisPostFix )
		if(itsAGeneratedList){
			actionListNEW := SubStr(rtrim(actionListNEW), 1, - StrLen(postFixGenerated)  )
		; msgbox, % actionListNEW "`n`n("A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

			tip =
		(
		statement:
		why do I do this?
		currently there was a problem.
		Only the address of the generated list was passed on.
		and even this list has been checked for updates.
		changes sollen ja nur in the non-generated list done by the user.
		So the script has to look somewhere and create the new one.
		in this function is currently the place where the generated is created.
		The starting point, however, can not naturally be the generated list itself.
		18-11-16_19-21 16.11.2018 19:21
		)

		}



;Msgbox,n (%A_LineFile%~%A_LineNumber%)

		if(1)
			lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,":) _______________ Hello inside " RegExReplace(A_LineFile,".*\\") )
    ; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,":) _______________ Hello inside temp.ahk _____________"  )

    ; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"START function: actionListNEWactivate"  )


		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		if( SubStr( actionListNEW , -3 ) <> ".ahk" ) ; 08.11.2018 01:23 maybe its right pace. maybe useless.
			actionListNEW .= ".ahk"


		if(FileExist(actionListNEW)) ; feature update 08.04.2017 19:43
			actionListNEWarchivePath := actionListNEW
		else{
			regExAbsolutePath := "i)^\w\:" ; addet 01.11.2018 11:36
			foundPosAbsolutePath := RegexMatch( actionListNEW, regExAbsolutePath, matchsPath)
			if(foundPosAbsolutePath)
				actionListNEWarchivePath = % actionListNEW
			else
				actionListNEWarchivePath = % actionListDir "\" actionListNEW
		}
   ; From here we only use actionListNEWarchivePath
   ; Next time this variable is used here: simplifyNameOfActionListNEWstep1( actionListNEW ) {  in line 256   12.07.2017 21:07

		if(0 && InStr(A_ComputerName,"SL5") && !WinExist("1:" )){
			msg =
(
actionListNEWarchivePath = '%actionListNEWarchivePath%'
actionListDir = '%actionListDir%'
'%A_LineNumber%' = A_LineNumber
'%A_ScriptDir%' = A_ScriptDir
'%A_LineFile%' = A_ScriptName
'%A_ThisFunc%' = A_ThisFunc
)
			feedbackMsgBox(msg,msg,1,1)
		}


		global g_doSaveLogFiles
		if(Instr(actionListNEWarchivePath,"\EVERYTHING\")){
			g_doSaveLogFiles := false
			lll(A_LineNumber, A_LineFile,A_ThisFunc ": "    "g_doSaveLogFiles := true" )
		}else{
			g_doRunLogFiles := false
		}


		if(!actionListNEWarchivePath)
			Msgbox,Oops !actionListNEWarchivePath `n (create_al_Address.inc.ahk~%A_ThisFunc%~%LineNumber%) `

   ; actionListActivePath := gi_everywhereSourcePath .  "\" . actionListActive
		actionListActivePath := A_ScriptDir . "\" . actionListActive

		if(0 && InStr(A_ComputerName,"SL5")){
            clipboard := A_ThisFunc ": actionListActivePath= " actionListActivePath
            clipboard .= "`n actionListNEW= " actionListNEW
            exampleLog =
            (
            G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\Source\
            actionListActivePath= G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\Source\
            actionListNEWactivate: actionListActivePath= G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\Source\
             actionListNEW= ..\_globalActionListsGenerated\_ahk_global.ahk
            )
		}

		if(!FileExist(actionListActivePath)){
			msg =
			(
			:(
			'%actionListActivePath%' = actionListActivePath
			token:1801-20_17-12 and copied to clipboard
			)
			msg .= "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
			clipboard := msg
		    ToolTip4sec( msg ,1,300,8 )
			MsgBox, % msg
        }
; The active path, that the complete address of the file inc dir, has to be always present. if not then that is an error. 12.07.2017 21:10




	;/¯¯¯¯ !FileExist(actionListNEWarchivePath) ¯¯ 181012011354 ¯¯ 12.10.2018 01:13:54 ¯¯\

		RegRead, CreatedDir, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, CreatedDir
		if(CreatedDir){

			Speak("CreatedDir found in " RegExReplace(A_LineFile,".*\\") )
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, CreatedDir, % "" ; RegWrite , RegSave , Registry

			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_ScriptName, % A_ScriptName ; RegWrite , RegSave , Registry
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite ,
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite ,
			run,gi-everywhere.ahk ; 01.11.2018 23:50
		}



		fileAddress_projectFlag := actionListDir "\_create_own_project.flag"
		isFileExist_create_own_projectFlag := (FileExist(fileAddress_projectFlag) && !InStr(FileExist(fileAddress), "D"))
    ; isFileExist_create_own_projectFlag deprecated. probably to slow
		if(!FileExist(actionListNEWarchivePath) && (CreatedDir || isFileExist_create_own_projectFlag )) {

			FIleDelete,  % fileAddress_projectFlag ; then you need alway generae it explizit via generate project links 23.10.2018 11:29

		; So hear it's possibly a good idea to generate a new one by using a template. 12.07.2017 21:12
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			WinGetActiveTitle,at
			strLen_actionListNEWar := StrLen(actionListNEWarchivePath)
			if(strLen_actionListNEWar < 5)
				MsgBox, :-( '%strLen_actionListNEWar%' = strLen_actionListNEWar  `n (line:%A_LineNumber%) `n
		  ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		  ; Let's generate a pretty short 80 signs long name. 12.07.2017 21:14
			if(strLen_actionListNEWar>70) {
				global g_lineNumberFeedback
				g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

				actionListNEWarchivePath80 := "... " . SubStr(actionListNEWarchivePath, -70 )
      ; MsgBox, '%actionListNEWarchivePath80%' = actionListNEWarchivePath80  `n (line:%A_LineNumber%) `n
			} else {
				actionListNEWarchivePath80 := actionListNEWarchivePath
			}
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			initialActionList := ltrim(getInitialActionList(actionListNEWarchivePath,actionListNEW,at))
		; _%actionListNEWarchivePath%|r|Here you could find your library

			StringReplace, lineFileRelative, A_LineFile , % A_ScriptDir,Source, All
		;Msgbox,%LineFileRelative%`n (%A_LineFile%~%A_LineNumber%) )

			calledFromStr := A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			Include := "Include"

			if(1 && InStr(A_ComputerName,"SL5"))
				RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")

			FileAppend, % initialActionList , % actionListNEWarchivePath
; 		 Sleep,400
			fileexist := false
			while(!fileexist && A_index < 99){
				Sleep,80 ; why sleeping ? todo sleeping?
				fileexist := fileexist(actionListNEWarchivePath) && !InStr(FileExist(actionListNEWarchivePath), "D")
			}
			if(!fileexist){
				msgbox,% "ERROR NOT exist: `n" actionListNEWarchivePath "`n ("  A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
			}
		; End of: if(!FileExist(actionListNEWarchivePath))
			lll(A_LineNumber, A_LineFile,A_ThisFunc ": "    "saved first time: >" . actionListNEWarchivePath . "< = Now the new examples-template should be saved" )
		; Now the new examples-template is saved inside of this file: actionListNEWarchivePath

			was_a_Editor_open_command1 := openInEditorFromIntern(actionListNEW)
			was_a_Editor_open_command2 := openInEditorFromIntern(actionListNEWarchivePath)
			if(!was_a_Editor_open_command1 && !was_a_Editor_open_command2)
				msgbox,% "ERROR (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"



		;\____ !FileExist(actionListNEWarchivePath) __ 181012011424 __ 12.10.2018 01:14:24 __/
		} else {
		; No example template was used. The content is already there. Inside on this file. And don't need to be generated. 12.07.2017 21:36
			msg:=A_ThisFunc ": "    "startREADING: >" . actionListNEWarchivePath . "< = actionListNEWarchivePath"
			lll(A_LineNumber, A_LineFile,msg)
		;Msgbox,%msg%`n (%A_LineFile%~%A_LineNumber%)

;/¯¯¯¯ startREADING ¯¯ 181012011928 ¯¯ 12.10.2018 01:19:28 ¯¯\
		; read #include commands
			exist_includeFilePath := 0
			includeFileSContent := ""
			actionListGeneratedPath := ""
			isIncludeFileInside := false
			includeFileSContentWillBeNeedsSaved := false
			includeFilePathArray := Object()
			lineInRegExArray := Object()

		; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . actionListGeneratedPath . "' = actionListGeneratedPath `n'" . actionListNEWarchivePath . " = actionListNEWarchivePath " )

			if(1 && !WinExist("1:" )){
				msg =
(
actionListNEWarchivePath = '%actionListNEWarchivePath%'
actionListDir = '%actionListDir%'
'%A_LineNumber%' = A_LineNumber
'%A_ScriptDir%' = A_ScriptDir
'%A_LineFile%' = A_ScriptName
'%A_ThisFunc%' = A_ThisFunc
)
; feedbackMsgBox(msg,msg,1,1)
				lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,msg )
			}

		;/¯¯¯¯ Loop,read,%actionListNEWarchivePath ¯¯
			Loop,read, % actionListNEWarchivePath
			{
           ; Beispiel:
; #Include .\..\actionLists\Notepad\_global.ahk
; #Include ..\_globalActionLists\Bewerbung\Firmware_Entwicklung.txt
; #Include *i _global.ahk

;           regEx := "i)^\s*#include\s*( |,)\s*([^|!]+)\s*(?:((\||\!))\s*(.+))?\s*"
; include[ ]*(?:,|\s)[ ]*([^|!\n]+)[ ]*(?:((\||\!))[ ]*([^\n]+))?[ ]*
            ; ?: is used to denote non capturing group.
				; regEx := "i)^[ ]*#include[ ]*(?:,| )[ ]*([^|!\n]+)[ ]*(?:((\||\!))[ ]*([^\n]+))?[ ]*"
				; regEx := "i)^[ ]*#include[ ]*( \*i )?(?:,|[ ]+)[ ]*([^|!\n]+)(?:((\||\!))[ ]*([^\n]+))?[ ]+"
				;foundPos := RegexMatch( A_LoopReadLine, regEx, matchs) ; later matchs1 is used 04.10.2018 09:04 18-10-04_09-04
                ; #include .._globalWordLists\pfade.txt | i)^[ab]+
				; https://regexr.com/47kom

                		matchsIgnore := "", matchsPfad := "", matchsPipeType := "", matchsPipeVal := ""
						regEx := "i)^[ ]*#include[ ]*(?P<Ignore> \*i\b)?(?:,|[ ]+)[ ]*(?P<Pfad>[^|!\n]+)(?:(?P<PipeType>(\||\!))[ ]*(?P<PipeVal>[^\n]+))?"
                		foundPos := RegexMatch( A_LoopReadLine, regEx, matchs) ; later matchs1 is used 04.10.2018 09:04 18-10-04_09-04
                		matchsIgnore := trim(matchsIgnore," ")
                		tooltip,% "matchsIgnore = >" matchsIgnore "< Pfad= >" matchsPfad "< PipeType= >" matchsPipeType "< matchsPipeVal= >", 80, 1
                		; tooltip,% "A_LoopReadLine =" A_LoopReadLine ; " Pfad=" matchsPfad " PipeType=" matchsPipeType  " matchsPipeVal=" matchsPipeVal, 80, 1
                		; msgbox,% "matchsIgnore = >" matchsIgnore "< Pfad= >" matchsPfad "< PipeType= >" matchsPipeType "< matchsPipeVal= >" matchsPipeVal "<"

				examples =
(
#include dir\something.ahk
#Include *i _global.ahk
)

				msg := "#include foundPos = >" foundPos "< in `n" actionListNEWarchivePath "`n"
				msg .= ">" matchsIgnore "< =  matchsIgnore `n"
				msg .= ">" matchsPfad "< =  matchsPfad `n"
				msg .= ">" matchsPipeType "< =  matchsPipeType `n"
				msg .= ">" matchsPipeVal "< =  matchsPipeVal `n"
				msg .= ">" A_LoopReadLine "< =  A_LoopReadLine `n"
				msg .= A_WorkingDir " = A_WorkingDir `n"
				msg .= A_ScriptDir " = A_ScriptDir `n"
				msg .= A_ScriptFullPath " = A_ScriptFullPath `n"
				lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,msg )
            ;Msgbox,%msg%`n (%A_LineFile%~%A_LineNumber%)

			;/¯¯¯¯ isIncludeFileInside ¯¯ 181012004940 ¯¯ 12.10.2018 00:49:40 ¯¯\
				if(foundPos){
					isIncludeFileInside := true ; is_IncludeFileInside


					regExAbsolutePath := "i)^\w\:" ; addet 01.11.2018 11:36
					foundPosAbsolutePath := RegexMatch( matchsPfad, regExAbsolutePath, matchsPath)
					if(foundPosAbsolutePath)
						includeFilePath     := trim(matchsPfad)
					else
						includeFilePath     := actionListDir "\" trim(matchsPfad)

                    msg =
                    (
                    actionListDir = %actionListDir%
                    includeFilePath = %includeFilePath%
                    )
                    ;toolTipGui(msg " . . . . . . . . . . . . . " ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Green",,1)


					includeFilePath := RegExReplace(includeFilePath ,";[^\n\r]+$") ; removes comments

				; includeFilePath := RegExReplace(includeFilePath ,"(\\[^\\]+\\\.\.)+") ; works. removes all symbolic links 24.02.2018  cleanPath
					includeFilePath := removesSymbolicLinksFromFileAdress(includeFilePath) ; same as above -^

                ; Msgbox,%includeFilePath%`n (%A_LineFile%~%A_LineNumber%)

; Toolt too

					exist_includeFilePath := (FileExist(includeFilePath)) ? 1 : 0
					if(!exist_includeFilePath){ ; 11.03.201:23 new style/format of adress writing, but try stay compativle to old scripts. TODO deletie it.
						includeFilePathAbs := removesSymbolicLinksFromFileAdress(A_ScriptDir "\" includeFilePath)
						exist_includeFilePathAbs := (FileExist(includeFilePathAbs)) ? 1 : 0
						msg .= ":( includeFile NOT exist here: `n"  includeFilePath "`n`n"
						msg .= ">" includeFilePathAbs "<`n exist =" exist_includeFilePathAbs "`n`n"
						msg .= ">" matchsIgnore "< =  matchsIgnore `n"
						msg .= ">" matchsPfad "< =  matchsPfad `n"
						msg .= ">" A_LoopReadLine "< =  A_LoopReadLine `n"
						msg .= actionListDir " =  actionListDir `n"
						msg .= A_WorkingDir " = A_WorkingDir `n"
						msg .= A_ScriptDir " = A_ScriptDir `n"
						msg .= A_ScriptFullPath " = A_ScriptFullPath `n"
						msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
						lll(A_LineNumber, RegExReplace(A_LineFile,".*\\"), msg )


						includeFilePath := RegExReplace(includeFilePath ,"^\.\." , "..\actionLists")
    ; includeFilePath := "actionLists\" includeFilePath
						exist_includeFilePath := (FileExist(includeFilePath)) ? 1 : 0
						if(!exist_includeFilePath){

							msg .= "`n`n :( includeFile NOT exist here: "  includeFilePath " = includeFilePath (token:1902191904) `n"
							msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
							if(substr(includeFilePath,1)=="\"){
    							msg .= "Oops starts with a slash. whey ???`n"
							}
							msg .= "A_ScriptDir=" A_ScriptDir
							msg .= "`n====>pause"
							lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,msg )
							; matchsPipeVal
							if(matchsIgnore <> "*i" && ( 1 || !RegExMatch(includeFilePath , "i)private"  ) ) ) {
							    feedbackMsgBox(RegExReplace(A_LineFile,".*\\(.*?)\.ahk","$1") ">" A_LineNumber, msg, 1,1 ) ; temp.ahk is often ignored by config 05.10.2018 08:46
							    MsgBox,% "ups !exist_includeFilePath`n`n" msg "`n`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
							    pause
							}
						}
						; clipboard := includeFilePathAbs
						; msgbox,% msg "(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
					}

				;/¯¯¯¯ NOT exist_includeFilePath ¯¯ 181012005821 ¯¯ 12.10.2018 00:58:21 ¯¯\
					if(!exist_includeFilePath){ ; Backwords compatibible 06.03.2018 11:35 allows old include path; TODO: clean that a day in future. Priority: low. really low TODO: change default. default is inside the if
						msg := ":( " includeFilePath " = includeFilePath `n"
						msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
						includeFilePath := RegExReplace(includeFilePath, "^\.\.\\","") ; ..\ deleted 06.03.2018 11:34
						includeFilePath := removesSymbolicLinksFromFileAdress( actionListDir "\" includeFilePath) ; user should could includes direcly from his ahk actionList, without editing the address 05.03.2018 08:15
						exist_includeFilePath := (FileExist(includeFilePath)) ? 1 : 0

						msg .= includeFilePath " = includeFilePath  `n"
						msg .= A_WorkingDir " = A_WorkingDir `n"
						msg .= A_ScriptDir " = A_ScriptDir `n"
						msg .= A_ScriptFullPath " = A_ScriptFullPath `n"
						msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
                ;msgbox,% msg "(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
						lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,msg )
                ;exitapp
				;\____ NOT exist_includeFilePath __ 181012005935 __ 12.10.2018 00:59:35 __/
					}else{
					;/¯¯¯¯ exist_includeFilePath ¯¯ 181012010005 ¯¯ 12.10.2018 01:00:05 ¯¯\
						msg := ":) " includeFilePath " = includeFilePath  `n"
						msg .= A_WorkingDir " = A_WorkingDir `n"
						msg .= A_ScriptDir " = A_ScriptDir `n"
						msg .= A_ScriptFullPath " = A_ScriptFullPath `n"
						msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
                ;msgbox,% msg "(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
						lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,msg )
					;\____ exist_includeFilePath __ 181012010010 __ 12.10.2018 01:00:10 __/
					}



					if(0){
						feedbackMsgBox("isIncludeFileInside = " isIncludeFileInside,A_LineNumber . " " .  A_LineFile,1,1)
						global g_ignReg
						g_ignReg["feedbackMsgBox"]["tit"]  =.^
						g_ignReg["feedbackMsgBox"]["text"] =.^
						feedbackMsgBox("isIncludeFileInside = " isIncludeFileInside,A_LineNumber . " " .  A_LineFile,1,1)
						msg='%actionListNEWarchivePath%' = actionListNEWarchivePath `n '%foundPos%' = foundPos  `n '%includeFilePath%' = includeFilePath  `n '%exist_includeFilePath%' = exist_includeFilePath `n  actionListDir = '%actionListDir%' `n (line:%A_LineFile%~%A_LineNumber%)
						ToolTip5sec(msg  . " `n " . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") " " Last_A_This)
						msgbox,% msg
					}

					; lineInRegEx         := (matchs4) ? matchs3 . matchs4 : "|.*"
					lineInRegEx         := (matchs5) ? matchs4 matchs3 : "|.*"
					; ^--- | ist a positvie rule. alle matching lines goes inside the new file.
					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "  matchsIgnore "," matchsPfad "," matchs3 "," matchs4 "," matchs5 )
					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "lineInRegEx=>" . lineInRegEx . "<" )



            ; Msgbox,'%lineInRegEx%' = lineInRegEx  n (line:%A_LineNumber%) n
					lineInRegExArray.Insert(lineInRegEx)
					if(!exist_includeFilePath){
						msg =:-( ERROR %exist_includeFilePath% = exist_includeFilePath `n actionListDir = %actionListDir% `n includeFilePath = %includeFilePath% `n  >%actionListNEWarchivePath%< = actionListNEWarchivePath (from: %A_LineFile%~%A_LineNumber%)
						Tooltip,%msg%
						g_doSaveLogFiles := true
						lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   msg)
					}
				; ___ __ open __ open __
					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   ":| exist_includeFilePath =" . exist_includeFilePath . "   '" . actionListNEWarchivePath . "' = actionListNEWarchivePath ")

					lll( A_ThisFunc ":" A_LineNumber , A_LineFile , ":| exist_includeFilePath =" . exist_includeFilePath . "   '" . actionListNEWarchivePath . "' = actionListNEWarchivePath ")

;<<<<<<<<<<<<<<  if(exist_includeFilePath)  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					if(exist_includeFilePath){
						actionListNEWarchivePathBackup := actionListNEWarchivePath

						postFixGenerated := "._Generated.ahk"
						thisPostFix := SubStr(rtrim(actionListGeneratedPath), - StrLen(postFixGenerated) + 1 )
						itsAGeneratedList := ( postFixGenerated == thisPostFix )
						if(!itsAGeneratedList){
							actionListGeneratedPath := actionListNEWarchivePath postFixGenerated
                        ;Msgbox,Oops already geraated list lklkjlkjlkjl 555444 (line:%A_LineNumber%) n
						}

						lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"'" . actionListGeneratedPath . "' = actionListGeneratedPath `n'" . actionListNEWarchivePath . " = actionListNEWarchivePath ")

						lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . actionListGeneratedPath . "' = actionListGeneratedPath `n'" . actionListNEWarchivePath . " = actionListNEWarchivePath " )
						lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . actionListGeneratedPath . "' = actionListGeneratedPath `n'" . actionListNEWarchivePath . " = actionListNEWarchivePath " )


						exist_actionListGeneratedPath := FileExist(actionListGeneratedPath)

						FileGetTime, actionListNEWarchivePathBackupModifiedTime, %actionListNEWarchivePathBackup%
						FileGetTime, includeFileModifiedTime, %includeFilePath%

					; Pause,On
						msg=%actionListNEWarchivePathBackup%`n=actionListNEWarchivePathBackup `n (%A_LineFile%~%A_LineNumber%)
					;feedbackMsgBox(msg)


						actionListGeneratedModifiedTime := 0
						if(exist_actionListGeneratedPath)
							FileGetTime, actionListGeneratedModifiedTime, %actionListGeneratedPath%

						isActionListNewer_as_Generated := (actionListNEWarchivePath > actionListGeneratedModifiedTime)
						isIncludeFileNewer_as_Generated := (includeFileModifiedTime > actionListGeneratedModifiedTime)

						msg= '%actionListNEWarchivePathBackupModifiedTime%' > '%actionListGeneratedModifiedTime%' (actionListNEWarchivePathBackupModifiedTime > actionListGeneratedModifiedTime)  `n' isIncludeFileNewer_as_Generated=%isIncludeFileNewer_as_Generated%  `n' isActionListNewer_as_Generated=%isActionListNewer_as_Generated% `n '%includeFilePath%' = '%includeFilePath%' `n`n(A_LineNumber, A_LineFile)
						lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   msg)
 ; msgbox, % msg

						if( false
                || !exist_actionListGeneratedPath
                || actionListNEWarchivePathBackupModifiedTime > actionListGeneratedModifiedTime
                || includeFileModifiedTime > actionListGeneratedModifiedTime ){
							includeFileSContentWillBeNeedsSaved := true
							m =
(
includeFileSContentWillBeNeedsSaved := %includeFileSContentWillBeNeedsSaved%
|| !%exist_actionListGeneratedPath%=exist_actionListGeneratedPath
|| %actionListNEWarchivePathBackupModifiedTime% > %actionListGeneratedModifiedTime%
|| %includeFileModifiedTime% > %actionListGeneratedModifiedTime% )

actionListGeneratedModifiedTime =
%actionListGeneratedModifiedTime%
)
							if(0 && InStr(A_ComputerName,"SL5"))
								msgbox,% m "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"

                     ; continue ; include is old. older.
						}{



                  ; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"includeFilePathArray.Insert(" . includeFilePath . " `n 17-07-29_12-01" )
							includeFilePathArray.Insert(includeFilePath)
						}

					} ; endo of if(exist_includeFilePath)
				;\____ isIncludeFileInside __ 181012005024 __ 12.10.2018 00:50:24 __/

				} else
					break
;>>>>>>>>>>>>>>>>> if(exist_includeFilePath)  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

				lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . actionListGeneratedPath . "' = actionListGeneratedPath `n'" . actionListNEWarchivePath . " = actionListNEWarchivePath " )

			}
		;\____ Loop,read,%actionListNEWarchivePath __ 181012012859 __ 12.10.2018 01:28:59 __/


; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   includeFileSContentWillBeNeedsSaved . " = includeFileSContentWillBeNeedsSaved `n" . actionListNEWarchivePath . " = actionListNEWarchivePath `n" . "17-07-16_17-07")


			if(includeFileSContentWillBeNeedsSaved ) {
; loop throw alls include files
; Loop % Array.MaxIndex()   ; More traditional approach.

				if(InStr(A_ComputerName,"SL5"))
					tooltip,% actionList ": Message for SL5: includeFileSContentWillBeNeedsSaved(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"

				for fileId, includeFilePath in includeFilePathArray ; Recommended approach in most cases.
				{ ; for fileId, includeFilePath in includeFilePathArray

					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "  includeFilePath)

					lineInRegEx := lineInRegExArray[fileId]
					regEx := SubStr( lineInRegEx , 2 )
					regExPREFIX := SubStr( lineInRegEx  , 1 , 1 ) ; its a | ir a bit !

					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "lineInRegEx=" . lineInRegEx)
					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "regEx=" . regEx)


					includeFileContent := ""
					if(lineInRegEx == "|.*"){
						FileRead, includeFileContent, %includeFilePath%
						includeFileContent .= "`n"
					}else{
						Loop, read, %includeFilePath%
						{
							foundPos := RegExMatch( A_LoopReadLine , regEx  )

							if( ( regExPREFIX =="|" && foundPos ) || ( regExPREFIX == "!" && !foundPos ) )
								includeFileContent .= RTrim(A_LoopReadLine) . "`n"
						} ; END loop
					} ; END else
					if(includeFileContent)
						includeFileSContent .= includeFileContent
				}
			} ; END if(includeFileSContentWillBeNeedsSaved )
			else{

			}


; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . includeFileSContentWillBeNeedsSaved . "' = includeFileSContentWillBeNeedsSaved" )

; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . actionListGeneratedPath . "' = actionListGeneratedPath `n'" . actionListNEWarchivePath . " = actionListNEWarchivePath " )

			if(includeFileSContentWillBeNeedsSaved ){
				if(0 && InStr(A_ComputerName,"SL5"))
					msgbox,% "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
				save_actionListGeneratedPath(actionListGeneratedPath,includeFileSContent,actionListNEWarchivePath)
			}

; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . actionListGeneratedPath . "' = actionListGeneratedPath `n'" . actionListNEWarchivePath . " = actionListNEWarchivePath " )

			if(isIncludeFileInside && actionListGeneratedPath){
				actionListNEWarchivePath := actionListGeneratedPath ; that it will be used as your actionlist with all sugestions :) 12.07.2017 22:58

				ExitAPP_if_NOT_actionListGeneratedPath (A_LineNumber, A_ThisFunc, actionListNEWarchivePath, actionListGeneratedPath , actionListNEW)
            ;ExitAPP_if_NOT_actionListNEWarchivePath_and_NOT_actionListNEW(A_LineNumber, A_ThisFunc, actionListNEWarchivePath, actionListGeneratedPath , actionListNEW)
			}else if(!isIncludeFileInside){ ;  && actionListGeneratedPath
				if( FileExist(actionListNEWarchivePath postFixGenerated) )
					FileDelete,% actionListNEWarchivePath postFixGenerated ; it is less confusing when unnecessary files disappear 18-12-24_01-34
				tip := " is NOT Include File Inside "
				tip =
(
actionListGeneratedPath = %actionListGeneratedPath%
actionListGeneratedPath = %actionListNEWarchivePath% %postFixGenerated%
actionListNEWarchivePath = %actionListNEWarchivePath%
)
		    ; speak(tip,"PROD")
		    ; msgbox,%tip% `n(%A_LineFile%~%A_LineNumber%)
		    ; feedbackMsgBox(A_ScriptName,tip ">" A_LineNumber,1,1)
		    ; Sleep, 5000
            if(false){ ; for some reasons ...
		    			    msg =
            			    (
            for some reasons ist highly recommended for the moment to us your list with a include command.
            may include a nearly empty file. thanks bb
            			    )
            				tip =
            				(
            includeFileSContentWillBeNeedsSaved = %includeFileSContentWillBeNeedsSaved%
            actionListNEW = %actionListNEW%
            actionListActive = %actionListActive%
            				)
                    WinGetActiveTitle,wintit ;  Retrieves the title of the active window.
                    sleep,55
            			    tooltip,% msg "`n" tip,1,1
            			    ; feedbackMsgBox(msg,msg "`n" tip,1,1)
            				lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   tip )
                    sleep,700
                    ;winactivateTry(wintit,19)
                    sleep,5000
            } ; for some reasons ...


			}
;>>>>>>>>>>>>>>>>>> includeFileSContentWillBeNeedsSaved >>>>>>>>>>>>>>>>>>>>>>>>>>>
		} ; EndOf: Loop, read, % actionListNEWarchivePath

; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . actionListGeneratedPath . "' = actionListGeneratedPath `n'" . actionListNEWarchivePath . " = actionListNEWarchivePath " )

  ; All we have to do know is to  use this file. therefore we only copying it to the active used file. it will be overwritten. 12.07.2017 21:31

		ExitAPP_if_NOT_actionListNEWarchivePath_and_NOT_actionListNEW(A_LineNumber, A_ThisFunc, actionListNEWarchivePath, actionListGeneratedPath , actionListNEW)
		if(0){ ; deprecated 21.03.2018 11:00
			Msgbox,%actionListNEWarchivePath% 2 %actionListActivePath% `n (%A_LineFile%~%A_LineNumber%)
			lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,actionListNEWarchivePath " FileCopy too " actionListActivePath)
			FileCopy, % actionListNEWarchivePath, % actionListActivePath  , 1
		}
		if(0){
			tip =
				(
includeFileSContentWillBeNeedsSaved = %includeFileSContentWillBeNeedsSaved%
actionListNEW = %actionListNEW%
actionListActive = %actionListActive%
				)
			lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   tip )
		}
		return, 1
		} ; EndOf function actionListNEWactivate( actionListDir , actionListNEW, actionListActive , gi_everywhereSourcePath )
;\____ actionListNEWactivate( __ 181012023243 __















	;/¯¯¯¯ restoreOldClipboard ¯¯ 190209053411 ¯¯ 09.02.2019 05:34:11 ¯¯\
	restoreOldClipboard(idBackup, ClipboardBackup) {

		disableCopyQ() ; enableCopyQ() ;


		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		MsgBox, 17-03-10_08-06
   ; by restoring we cant us a token or id becouse we dont know what the real value of clipboard was. 07.03.2017 08:08
		l := StrLen(idBackup)
		i:=0
		iMax:=99
		while(i++ < iMax )
		{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			result:=SubStr(ClipboardBackup,l+1)
			Clipboard := result
			if(Clipboard <> ClipboardBackup)
				break
			ToolTip, '%Clipboard%' = Clipboard  `n '%result%' = result  `n  '%idBackup%' = idBackup  `n '%ClipboardBackup%' = ClipboardBackup  `n (line:%A_LineNumber%) `n
			Sleep,5 ; inside restoreOldClipboard
		}
		if(i == iMax )
			MsgBox, :( '%iMax%' = '%iMax%' = iMax  `n (line:%A_LineNumber%) `n
		Sleep, 3000 ; the time of the clipboard could get its real clipboard content. shorter maxes mor performant longer less errors 07.03.2017 09:39
   ;      MsgBox, '%Clipboard%' = Clipboard  `n (line:%A_LineNumber%) `n
		enableCopyQ()
		return, 1
	}
	;\____ restoreOldClipboard __ 190209053433 __ 09.02.2019 05:34:33 __/


	;/¯¯¯¯ actionListOLDbackup ¯¯ 190209053441 ¯¯ 09.02.2019 05:34:41 ¯¯\
	actionListOLDbackup( actionListDir , actionListOLD){
		if(!actionListDir) ; TODO dirty bugFix 21.03.2018 11:36
			Return
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,actionListDir actionListOLD " FileCopy too " actionListDir actionListOLD . ".backup.ahk")
		FileCopy, % actionListDir . "\" . actionListOLD , % actionListDir . "\" . actionListOLD . ".backup.ahk", 1
    ;Msgbox,`n (%A_LineFile%~%A_LineNumber%)
		return 1
	}
	;\____ actionListOLDbackup __ 190209053444 __ 09.02.2019 05:34:44 __/



	actionListOLDdisable( gi_everywhereSourcePath, actionListActive){
		Return 1 ; Todo: dirtyBugFix  , deprecated 21.03.2018 11:33
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		actionListActive = % gi_everywhereSourcePath . "\" . actionListActive
		actionListDisable = % gi_everywhereSourcePath . "\" . actionListActive ".backup.ahk"
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,actionListActive " FileCopy too " actionListDisable)
		FileCopy, % actionListActive  , % actionListDisable , 1
		return 1
	}
	rungi_everywhereAHKifNotExist( gi_everywhereAHK ){
		DetectHiddenWindows,on
		SetTitleMatchMode,2
		IfWinNotExist,gi-everywhere.ahk
		{
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
			IfWinNotExist,gi-everywhere
			{
				g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

        ;   MsgBox,16,gi-everywhere  is running, :( `n are you sure gi-everywhere  is running? `n  IfWinNotExist gi-everywhere  `n (line:%A_LineNumber%) `n   lets try start it   automatically, 2
        ; lets wait and try again. maybe its reload its self and needs only a second
				Sleep, 2000 ; 1 Sekunde
				IfWinNotExist,gi-everywhere
				{

                ; gosub,couldIfindMyself
					msg := "Run, gi_everywhereAHK"
                ; Run, % gi_everywhereAHK
					if(0){
						MsgBox, run gi-everywhere `n  `n (%A_LineFile%~%A_LineNumber%)
						RunAs,Administrator, % gi_everywhereAHK
					}
					tooltip, '%msg%' = msg  `n (line:%A_LineNumber%)
					global g_doSaveLogFiles

					lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,msg )

				}

				g_tooltipText = WinWait gi-everywhere.ahk
				g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
				tooltip, % "Wait 3 seconds before EXIT `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
				WinWait,gi-everywhere.ahk,, 3
				IfWinNotExist,gi-everywhere.ahk
				{
					global g_doSaveLogFiles

					lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"IfWinNotExist,gi-everywhere -> exitapp")
					exitapp
				}
			}
		}
		return
	}
	checkFilePathExistens1704291222(actionListDir, destinDir, sourceDir, gi_everywhereAHK ){


		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		DetectHiddenWindows,on
		SetTitleMatchMode,1
		IfWinNotExist,gi-everywhere.ahk
		{
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
			IfWinNotExist,gi-everywhere
			{
				g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

;   MsgBox,16,gi-everywhere  is running, :( `n are you sure gi-everywhere  is running? `n  IfWinNotExist gi-everywhere  `n (line:%A_LineNumber%) `n lets try start it automatically, 2
; lets wait and try again. maybe its reload its self and needs only a second
				Sleep, 2000 ; 1 Sekunde
				IfWinNotExist,gi-everywhere
				{
        ; gosub,couldIfindMyself
					Run, % gi_everywhereAHK
;        lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"Run, % gi_everywhereAHK")
					global g_doSaveLogFiles

					lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"Debuggging!  NOT Run % gi_everywhereAHK " )

				}
				g_tooltipText = WinWait gi-everywhere.ahk
				g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
 				tooltip, % "Wait" A_LineNumber " " RegExReplace(A_LineFile,".*\\")
				; msgbox, % "Wait" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " A_LineFile=" A_LineFile
				WinWait,gi-everywhere,, 3
				tooltip,
				IfWinNotExist,gi-everywhere
				{
					global g_doSaveLogFiles

					lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"IfWinNotExist,gi-everywhere -> exitapp")
					exitapp
				}
			}
		}

		; __ open msgb


		DetectHiddenWindows,On
		SetTitleMatchMode,2
		IfWinNotExist,gi-everywhere
		{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			MsgBox,16,NotExist?, :( IfWinNotExist '%gi_everywhereAHK%' = gi_everywhereAHK  `n (line:%A_LineNumber%) `n , 2
		}

		if(! FileExist(actionListDir) )
		{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			FileCreateDir, % actionListDir
			Sleep,100
		}
		if(! FileExist(actionListDir) )
		{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip1sec(A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") " " Last_A_This) ;
			msg =
   (
   :-(
   `n '%actionListDir%' = actionListDir
   do not exist.
   )
			MsgBox,% ":( =>Reload  `n  ! Exist(" actionListDir ") " msg "`n("A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

			Reload
		}
		if(! FileExist(sourceDir) )
		{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip1sec(A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") " " Last_A_This) ;
			msg_sourceDir = `n '%sourceDir%' = sourceDir  `n (line:%A_LineNumber%) `n
			MsgBox, :(  `n  ! Exist(sourceDir) %msg_sourceDir%
		}
		return
	}







	simplifyNameOfActionListNEWstep1( actionListNEW ) {
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

;   actionListNEW := "superSimple" . ".txt"
		return actionListNEW ;

		FoundPos := InStr(actionListNEW, "\",0,-1 )
		if( FoundPos )
			actionListNEW:=SubStr(actionListNEW,1,FoundPos) . "_" . SubStr(actionListNEW,FoundPos)
		actionListNEW := RegExReplace(  actionListNEW, "(\w)[^\\]+\\", "$1")  ; ChromeWidgetWin1\GmailGoogleChrome.ahk - Notepad++ ahk_class Notepad++ ==> EfpHAtTWCGmailGoogleChrome_txt_Notepad_.ahk

 ;~ MsgBox, '%actionListNEW%' = actionListNEW  `n (line:%A_LineNumber%) `n
		actionListNEW := RegExReplace(  actionListNEW , "\s*\[[^\[\]]+\]+", "")  ; clone.ahk * SciTE4AutoHotkey [2 von 2]
		actionListNEW := RegExReplace(  actionListNEW, "[\W_]+", "_")  . ".ahk"
; MsgBox,'%activeClass%' = activeClass  `n (line:%A_LineNumber%) `n



		actionListNEW := "dummiTestFromLine" . A_LineNumber . ".ahk"
		return actionListNEW
	}


	encodeAHKchars( s ){
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		s := RegExReplace( s , "(""|``)", "$1$1")
		s := RegExReplace( s , "(``n|`%|\(|\))", "``$1")
		return s
	}
	encodeAHKcharsOLD( s ){
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		s := RegExReplace( s , "(""|``)", "$1$1")
;   hi3 := RegExReplace( s , "(``)", "$1$1")
		s := RegExReplace( s , "`n", "``n")
		return s
	}


	selfPerformanceTest()
	{
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		disableCopyQ() ; enableCopyQ() ;

		ClipboardBackup1703061259 := Clipboard
		ahkCode =
(
Clipboard = selfPerformanceTest
)
   ; test how long it takes , that clipboard will updated at this computer 06.03.2017 16:00
   ; ergebniss log:
 ; Sleep 156 ; millisec 20170306165639
 ; Sleep 62 ; millisec 17-03-06_17-29

		TickCount1 := A_TickCount ; YYYYMMDDHH24MISS
		Loop,9
		{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			i := 0
			while(i++ < 99){
				global g_lineNumberFeedback
				g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

				Sleep,10
				result := DynaRunGetClipboard(ahkCode)
				if ( i > 100 || "selfPerformanceTest" == result)
					break
			    msgbox,% A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			}
			if ( "selfPerformanceTest" == result)
				break
		}
		millisec := A_TickCount - TickCount1
		Clipboard := "`; Sleep " . millisec . " `; millisec " . A_Now . " , line= " . A_LineNumber
		if ( "selfPerformanceTest" <> result)
			MsgBox, %   ":-( ERROR wrong result " . Clipboard
		else {
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

; MsgBox, % ":-)  " .  Clipboard
		}

		Clipboard := ClipboardBackup1703061259

		enableCopyQ() ; enableCopyQ() ;
		return result
	}

    ;/¯¯¯¯ DynaRunGetClipboard2 ¯¯ 190209053914 ¯¯ 09.02.2019 05:39:14 ¯¯\
	DynaRunGetClipboard2(ahkCode){

		disableCopyQ() ; enableCopyQ() ;

		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		MsgBox, that function is obsolte now 11.03.2017 16:57 `n  '%ahkCode%' = ahkCode  `n (line:%A_LineNumber%) `n
		ClipboardBackup1703061259 := Clipboard
		Loop,9
		{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			DynaRun(ahkCode)
			i := 0
			while(i++ < 99){
				global g_lineNumberFeedback
				g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

				Sleep,10
				result  = %Clipboard%
				if ( i > 100 || ClipboardBackup1703061259 <> result )
					break
			}
			if ( ClipboardBackup1703061259 <> result )
				break
		}
		Clipboard := ClipboardBackup1703061259
		return result
	}
	;\____ DynaRunGetClipboard2 __ 190209053921 __ 09.02.2019 05:39:21 __/


	;/¯¯¯¯ selfPerformanceTest2 ¯¯ 190209053933 ¯¯ 09.02.2019 05:39:33 ¯¯\
	selfPerformanceTest2(){
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		ClipboardBackup1703061259 := Clipboard
		ahkCode =
(
Clipboard = selfPerformanceTest2
)
   ; test how long it takes , that clipboard will updated at this computer 06.03.2017 16:00
   ; ergebniss log:
   ; Sleep 47 ; millisec 20170306171409
   ; Sleep 1623 ; millisec , now= 20170306172251, result=17-03-06_12-56, line:433
   ; Sleep 47 ; millisec , now= 20170306172412, result=17-03-06_12-56, line:431
   ; Sleep 47 ; millisec , now= 20170306172500, result=17-03-06_12-56, line:432
   ; Sleep 47 ; millisec , now= 20170306172844, result=17-03-06_12-56, line:450

		TickCount1 := A_TickCount ; YYYYMMDDHH24MISS
		Loop,9
		{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			DynaRun(ahkCode)
			i := 0
			while(i++ < 99){
				global g_lineNumberFeedback
				g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

				Sleep,10
				result  = %Clipboard%
				if ( i > 100 || "selfPerformanceTest2" == result)
					break
			}
;    if ( i > 100 || "selfPerformanceTest2" == result)

			if ( "selfPerformanceTest2" == result)
				break
		}
		millisec := A_TickCount - TickCount1
		Clipboard := "`; Sleep " . millisec . " `; millisec , now= " . A_Now . ", result=" . result . ", line:" . A_LineNumber
		if ( "selfPerformanceTest2" <> result)
			MsgBox, ERROR !!! :-( `n %Clipboard% `n (line:%A_LineNumber%) `n
		else{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			m = %Clipboard% `n (line:%A_LineNumber%) `n
			ToolTip4sec(m)
		}
		MsgBox, 17-03-10_08-04
		Clipboard := ClipboardBackup1703061259
		enableCopyQ() ; enableCopyQ() ;
		return result
	}
	;\____ selfPerformanceTest2 __ 190209053957 __ 09.02.2019 05:39:57 __/



    ;/¯¯¯¯ FileDeleteAsyncDynaRun ¯¯ 190209054010 ¯¯ 09.02.2019 05:40:10 ¯¯\
	FileDeleteAsyncDynaRun(fileAbsAdress , waitMiliBefore=3000){
		ahkCode =
  (
  Sleep, %waitMiliBefore%
  FIleDelete, %fileAbsAdress%
  exitapp
  )
		DynaRun(ahkCode)
		return
	}
	;\____ FileDeleteAsyncDynaRun __ 190209054023 __ 09.02.2019 05:40:23 __/






	;/¯¯¯¯ DynaRunENDarrsldkjfarrsldkjfl ¯¯ 190209054046 ¯¯ 09.02.2019 05:40:46 ¯¯\
	DynaRunENDarrsldkjfarrsldkjfl(TempScript, pipename="") {
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		static _:="uint",@:="Ptr"
		If pipename =
			name := "AHK" A_TickCount
		Else
			name := pipename
		__PIPE_GA_ := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
		__PIPE_    := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
		if (__PIPE_=-1 or __PIPE_GA_=-1)
			Return 0
   ; gosub,couldIfindMyself
;IfNotExist, %A_AhkPath% "\\.\pipe\%name%"
;    Return 0
		Run, %A_AhkPath% "\\.\pipe\%name%",,UseErrorLevel HIDE, PID
		If ErrorLevel
			tooltip, % "Could not open file:`n" __AHK_EXE_ """\\.\pipe\" name """"
		DllCall("ConnectNamedPipe",@,__PIPE_GA_,@,0)
		DllCall("CloseHandle",@,__PIPE_GA_)
		DllCall("ConnectNamedPipe",@,__PIPE_,@,0)
		script := (A_IsUnicode ? chr(0xfeff) : (chr(239) . chr(187) . chr(191))) TempScript
		if !DllCall("WriteFile",@,__PIPE_,"str",script,_,(StrLen(script)+1)*(A_IsUnicode ? 2 : 1),_ "*",0,@,0)
			Return A_LastError,DllCall("CloseHandle",@,__PIPE_)
		DllCall("CloseHandle",@,__PIPE_)
		while(WinExist(substr(name,1,-5)) && A_Index < 9)
			WinClose,

		Return PID
	}
	;\____ DynaRunENDarrsldkjfarrsldkjfl __ 190209054101 __ 09.02.2019 05:41:01 __/




	;/¯¯¯¯ FileWriteAndRun ¯¯ 190209054130 ¯¯ 09.02.2019 05:41:30 ¯¯\
	FileWriteAndRun(sayHelloCode, sayHelloFunctionInc){
		return DynaRunFROMAhkSudio190322(sayHelloCode,Wait:=false,name:="Untitled")

		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
		DetectHiddenWindows,On
		SetTitleMatchMode,2
		winTC := sayHelloFunctionInc . " ahk_class AutoHotkey"
		if(winExist(winTC)){
			WinClose,% winTC
            if(1 && InStr(A_ComputerName,"SL5") ){
                tip := "Wait WinWaitClose`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
                tooltip, % tip , 1,1
			}
			WinWaitClose,% winTC,,1
			tooltip,
		}
		if(winexist(winTC)){
			ToolTip,DONT WANT RUN '%winTC%'. its already exist. `n (line:%A_LineNumber%) `n 18-02-15_13-00bbb
			WinKill,% winTC
			tooltip, % "Wait" A_LineNumber " " RegExReplace(A_LineFile,".*\\")
			WinWaitClose,% winTC,,2
			tooltip,
			return false
		}

		isFileExist := false
   ;feedbackMsgBox(sayHelloCode . "`n`n`n" . sayHelloFunctionInc,A_LineNumber . " create_al_Address.inc.ahk")
		FileWrite(sayHelloCode, sayHelloFunctionInc)
		Loop,200 ;
		{
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			if(GetKeyState("Ctrl", "P"))
				KeyWait Control  ; Wartet darauf, dass sowohl STRG als auch ALT losgelassen wird.

			if(FileExist(sayHelloFunctionInc)){
				g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%
				isFileExist := true
				break
			}
			Sleep,20
		}

   ;gosub,couldIfindMyself
		if(FileExist(sayHelloFunctionInc)){
   try{
        run, % sayHelloFunctionInc
    ;   MsgBox, '%sayHelloFunctionInc%' = sayHelloFunctionInc  `n (line:%A_LineNumber%) `n
		return isFileExist
   }
   catch e
   {
            tooltip,
            ; https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-142
            sleep,1800 ; <== maybe a good idea 19-03-20_08-20
   }
   }
   }
	;\____ FileWriteAndRun __ 190209054144 __ 09.02.2019 05:41:44 __/


    ;/¯¯¯¯ FileWrite ¯¯ 190219170622 ¯¯ 19.02.2019 17:06:22 ¯¯\
	FileWrite(sayHelloCode, sayHelloFunctionInc){
        tempFileAddress := A_ScriptDir "\" A_TickCount ".temp." A_ThisFunc ".txt"
        FileAppend, % sayHelloCode, % tempFileAddress
        FileCopy,% tempFileAddress, % sayHelloFunctionInc, 1
		; FileAppend, % sayHelloCode, % sayHelloFunctionInc
		sleepMilli := 1
		while(A_Index < 100){
            if(FileExist(tempFileAddress)){
                ; msgbox,% A_Index * sleepMilli ; ==> 19-02-19_17-22 interesting it shows ist takes only 0 millisecond. so already done
                break
            }
            Sleep,% sleepMilli
        }
        FileDelete,% tempFileAddress
		return 1
	}
    ;\____ FileWrite __ 190219170625 __ 19.02.2019 17:06:25 __/




	;/¯¯¯¯ varInjects ¯¯ 190208220508 ¯¯ 08.02.2019 22:05:08 ¯¯\
	; mvarInjects(actionListDir, actionListNEW, activeClass, activeTitle){
	mvarInjects(actionListDir, actionListNEW
	,activeTitle,activeClass,controlName
	,alTitle,alClass,alControl){

		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

    activeTitle := RegExReplace(activeTitle,"""","""""")
    activeTitle := RegExReplace(activeTitle,"[\n\r\s]+"," ")


    rootAbs := RegExReplace(actionListDirAbs,"\\actionLists\\.*", "")
    ; actionLists\

		varInjects =
   (
   actionListDir := "%actionListDir%"
   rootAbs := "%rootAbs%"
   actionListNEW := "%actionListNEW%"

   activeTitle := "%activeTitle%"
   activeClass := "%activeClass%"
   controlName := "%controlName%"

   alTitle := "%alTitle%"
   alClass := "%alClass%"
   alControl := "%alControl%"
   `n
   )
		return varInjects
	}
	;\____ varInjects __ 190208220459 __ 08.02.2019 22:04:59 __/




	getWelcomeMsg(){
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		msg =
(
this `n `n  %A_LineFile% `n

if you try to find which file belongs to your actionList type _____ it hopefully helps

descriptions:
<word>|d|<description>
"Word descriptions can be added to 'actionList .ahk' that will appear in the actionList next to the word. These descriptions should be in the form of
<word>|d|<description>, e.g., Tylenol|d|Pain Reliever.
This could be used for things like definitions, translation aids, or function arguments. When Fixed Width fonts are used in the actionList, the description columns will be tabbed evenly so they line up."
04.03.017 16:16 from https://github.com/ManiacDC/gi-everywhere

replacements:
<word>|rr|<description> todo: descrip

<word>|r|<description>
"Word replacements can be added to 'actionList.ahk' that will appear in the actionList next to the word. These replacements should be in the form of
<word>|r|<description>, e.g., fire|r|fuego.
When the word is chosen, it will be backspaced out and replaced with the new word. If Case Correction is off, the first letter will be changed to match the case of the word being replaced. This could be used for spelling replacements, text expansion, or translation aids. Multiple replacements can be defined for a word (put each on a separate line)."
04.03.017 16:16 from https://github.com/ManiacDC/gi-everywhere

problems:
may have problems with cooding. may save your actionLists as UTF-8 or convert it. for e.g. with notepad. codierung > convert to UTF-8
hint from hints: http://stackoverflow.com/questions/2527269/any-tool-to-convert-bulk-php-files-to-utf-8-without-bom :
Before trying this, you must make a backup of your files.
You need to create a macro that does this:
Convert the currently opened file to UTF-8 w/o BOM;
Select all the text in your file, and copy it (why this? it looks like a bug. if you won't do this, your file will be replaced with your current clipboard content...);
Save the current file;
Close the current file.
Save this macro.
Now, open your files, and run it with the "Run a Macro Multiple Times..." command. If you opened 100 files, let it run for 100 times.

its not a bug, its a feature ;)
you may think first letters want replace. yes thats true. thats a feature ;) not a bug. you could choose by yourself to write it upper or lowercase. 05.03.2017 02:11

05.03.2017 01:26
)
		return msg
	}



;/¯¯¯¯ getAhkCodeInsideFile ¯¯ 181023081117 ¯¯ 23.10.2018 08:11:17 ¯¯\
	getAhkCodeInsideFile(actionListDir, actionListFilterPath ) {
		global g_lineNumberFeedback
		g_lineNumberFeedback  := "(" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\") ")"

fileExist_class_actionListFilter  := fileExist(actionListFilterPathNEW)
; toolTipGui(fileExist_class_actionListFilter ":" actionListFilterPathNEW " = actionListFilterPathNEW (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,,"|¯",A_LineNumber,"Purple",,1)  ; x will be offset if y is symbolic


; toolTipGui(actionListDir " = actionListDir (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,-200 + 80*(toolTipGui_yOffsetNr++),"_|",A_LineNumber,"Purple")  ; x will be offset if y is symbolic

if(fileExist_class_actionListFilter)
    al_route_fileAddress := actionListFilterPath
else
    al_route_fileAddress := removesSymbolicLinksFromFileAdress(actionListDir "\..\al-route.inc.ahk")
; al_route_fileAddress := RegExReplace(actionList ,"(\\[^\\]+\\\.\.)+") ; works. removes all symbolic links 24.02.2018  cleanPath
; clipboard := al_route_fileAddress
; tooltip,% al_route_fileAddress
; return
;
; ahkCodeInsideFile
; ahkCodeInsideFileahkCodeInsideFileahkCodeInsideFile
;
;/¯¯¯¯ ahkCodeInsideFile ¯¯ 190208164922 ¯¯ 08.02.2019 16:49:22 ¯¯\
ahkCodeInsideFile =
(
#SingleInstance, force
`; dontDeleteThisPlaceholder %g_lineNumberFeedback%
#Include %al_route_fileAddress% `; global actionList . pleas dont delete this line! 17-03-06_10-59
actionListFilterPath = %al_route_fileAddress% `n ; (line:`%A_LineNumber`%) `n

clipboard = :-] `%actionListNEW`% = actionListNEW
tooltip, actionListNEW: `%actionListNEW`%,,,2

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
actionListNEW_time_between := actionListNEW
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

`; if you want you could use the follwong global variables fot calculating you new actionListNEW : actionListDir, actionListNEW, activeClass, activeTitle
if `(!actionListNEW `){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

    tooltip, ERROR actionListNEW is EMPTY 17-03-19_11-51
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, ERROR , %A_ThisFunc%: %A_LineNumber% ERROR actionListNEW is EMPTY 17-03-19_11-51
    exitapp
}
if `(!actionListDir `){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

    msgbox, ERROR actionListDir is EMPTY 17-03-19_11-52
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, ERROR , %A_ThisFunc%: %A_LineNumber% ERROR ERROR actionListDir is EMPTY 17-03-19_11-52
    exitapp
}

; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
if(0 && !RegExMatch(trim(actionListNEW),"\.ahk$")) ; dirty bug fix TODO: not pretty
    actionListNEW .= ".ahk"
if( SubStr( actionListNEW , -3 ) <> ".ahk" ) ; 06.03.2018 13:09
    actionListNEW .= ".ahk"
) ; endOf ahkCodeInsideFile
;\____ ahkCodeInsideFile __ 190208164915 __ 08.02.2019 16:49:15 __/
        ; clipboard := ahkCodeInsideFile
		return ahkCodeInsideFile
	}
;\____ getAhkCodeInsideFile __ 181023081130 __ 23.10.2018 08:11:30 __/




;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	DynaRunGetClipboard(value){
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		disableCopyQ() ; enableCopyQ() ;

		MsgBox, 17-03-10_08-06
   ; if you make much clipboard work during the test, you could see its not working fine :( 07.03.2017 01:05
;   id = 17-03-07_00-32 ; without this nummer you get some 1000 without any false, some with some false 07.03.2017 00:49
		id := A_TickCount . "_line_" . A_LineNumber ; ; first teset no error with value
      ;~ value := RegExReplace(value,"(Clipboard\s*:=)\s*(\w+)", "$1" . " . """ . id . """ " . "$2" )  ; Clipboard := actionListNEW
      ;~ value := RegExReplace(value,"(Clipboard\s*:=)\s*(\w+)", "$1" . " . """ . id . """ " . "$2" )  ; Clipboard := actionListNEW
		if(RegExMatch(value, "Clipboard\s*:?=") ) {
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			ahkCode  := RegExReplace(value,"(Clipboard\s*:=)\s*(\w+)", "$1" . " """ . id . """ . " . "$2" )  ; Clipboard := actionListNEW
   ;~ Clipboard := ahkCode ; debugging only
   ;~ MsgBox, '%Clipboard%' = Clipboard  `n (line:%A_LineNumber%) `n  ; debugging only
		}
		else{
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			yesValueShouldGetEqualResult := true
			token = %id%%value%
			ahkCode =
(
Clipboard =  %token%
)
		}
; Clipboard := ahkCode  ; debugging reasons 17-03-07_19-14
; MsgBox, '%ahkCode%' = ahkCode  `n (line:%A_lineNumber%) `n
		k := 0
		while( k++ < 1000) {
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%


			idBackup := A_TickCount  . "_line_" . A_LineNumber
			ClipboardBackup1703061255 =%idBackup%%Clipboard% ; this only allows text clipboard 07.03.2017 09:15


			result := DynaRunGetClipboard2(ahkCode)
			restoreOldClipboard(idBackup, ClipboardBackup1703061255 )
;      Clipboard := ClipboardBackup1703061255 ; sometimes this not turn to old value :( 07.03.2017 01:01
    ;  ToolTip, % result
			if(foundPos:=InStr(result,id)) ; usually its the first try. if there is no user action all are ok. if you act every 100 it could one false
				break
			Sleep,10 ; its needet. if you chunk your clipboad it takes a  little time (few seconds) sometimes, till the script runs again. 07.03.2017 00:57
   ;restoreOldClipboard(idBackup, ClipboardBackup1703061255 ) ; Clipboard := ClipboardBackup1703061255 ; sometimes not work :( 07.03.2017
		}
		if(foundPos){
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

               result:=SubStr(result , StrLen(id)+1)
		}  else
			MsgBox, :( id not found `n  '%id%' = id  `n`n   result= '%result%' `n `n  token = '%token%'  `n (line:%A_LineNumber%) `n
		if( yesValueShouldGetEqualResult && result <> value )
			MsgBox, :( '%id%' = id  `n  result= '%result%' <> '%token%'  `n (line:%A_LineNumber%) `n ; and sometimes it happens anyway . id was not wiped out 07.03.2017 08:18



;Sleep,100
;   restoreOldClipboard(idBackup, ClipboardBackup1703061255 )

; sure id cant be inside. or not?
		if(foundPos:=InStr(result, id )) ; usually its the first try. if there is no user action all are ok. if you act every 100 it could one false
			MsgBox, :( '%id%' = id   `n  '%result%' = result  `n (line:%A_LineNumber%) `n

		enableCopyQ() ; enableCopyQ() ;

		return result
	}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	selfTestLoop1000(loopMax){
		global g_lineNumberFeedback
		g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

		MsgBox, 17-03-10_08-04
   ; if you make much clipboard work during the test, you could see its not working fine :( 07.03.2017 01:05
		i := 0
;   id = 17-03-07_00-32 ; without this nummer you get some 1000 without any false, some with some false 07.03.2017 00:49
		while( i++ < loopMax)    {
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineNumber%~%A_LineFile%~%A_ThisFunc%

			ToolTip, %i% < %loopMax%
			value = selfTest1703061808i%i%
      ;ahkCode := "Clipboard . " = "" . value . """"
			result :=  DynaRunGetClipboard(value)

		}
		if(result <> value )
			MsgBox, :( value = '%value%' <> '%result%' = result  `n (line:%A_LineNumber%) `n
		return result
	}

;<<<<<<<<<<<<<<<<<<< getInitialActionList <<<<<<<<<<<<<<<<<<<<<<<<<<<
	getInitialActionList(actionListNEWarchivePath,actionListNEW,at){
; Start filling the template variable with useful examples 12.07.2017 21:18

		if(!actionListNEWarchivePath)
			Msgbox,Oops !actionListNEWarchivePath `n (create_al_Address.inc.ahk~%A_ThisFunc%~%A_`LineNumber%) `

		actionListFileName := RegExReplace(actionListNEWarchivePath,".*\\([^\\]+)$","$1") ; 20.03.2018 00:15

		calledFromStr := A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		Include := "Include"
		initialActionList =
(
#%Include% _global.ahk
; #%Include% ..\_globalActionLists\_actionListHelp.ahk ; delete the comment (;), if you want help by creating your actionList
; '%at%' .  Only meta info (not importand): %calledFromStr%
___open actionList|rr||ahk|openInEditor,%actionListFileName%
; if you could read this germen special character (umlaute) your file format is correct (please use UTF8)
; ä = thats a au
)
; EndOf filling the template variable with useful examples 12.07.2017 21:18


		return initialActionList
	}
;>>>>>>>>>>>>>>>>>>>>> getInitialActionList >>>>>>>>>>>>>>>>>>>>>>>>>
; 1377
	#include, inc_ahk\openInEditor_actionList.inc.ahk

	#Include %A_ScriptDir%\inc_ahk\soundBeep.inc.ahk

; 	#Include *i inc_ahk\functions_global.inc.ahk

	#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise müsen ans Dateiende
	#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk


;/¯¯¯¯ ExitAPP_if_NOT_actionListNEWarchivePath_and_NOT_actionListNEW ¯¯ 181023104727 ¯¯ 23.10.2018 10:47:27 ¯¯\
	ExitAPP_if_NOT_actionListNEWarchivePath_and_NOT_actionListNEW(ALineNumber, AThisFunc, actionListNEWarchivePath, actionListGeneratedPath , actionListNEW){

		return ; todo: thats only for testing. 23.10.2018 10:50
    ;


		if( !FileExist(actionListNEWarchivePath) ) {
			global g_lineNumberFeedback
			g_lineNumberFeedback=create_al_Address.inc.ahk / %A_LineFile% ~%AThisFunc%~%ALineNumber%
			msg = :( !FileExist(%actionListNEWarchivePath%)) `n token82 `n '%actionListNEWarchivePath%' = actionListNEWarchivePath  `n '%actionListGeneratedPath%' = actionListGeneratedPath  `n actionListNEW= %actionListNEW% `n ==> ExitAPP 17-08-11_01-01
			tooltip,%msg% `n`n ( %g_lineNumberFeedback% )

			lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  msg)


    ; lll(AThisFunc . "~" . ALineNumber, A_ScriptName, msg)
			Sleep,3000 ; function actionListNEWactivate ??? right ??
			ExitAPP
		}
		return
	}
;\____ ExitAPP_if_NOT_actionListNEWarchivePath_and_NOT_actionListNEW __ 181023104733 __ 23.10.2018 10:47:33 __/


;<<<<<<<<<<<<<<<<<< ExitAPP_if_NOT_actionListGeneratedPath <<<<<<<<<<<<<<<<<<<<<<<<<<<<
	ExitAPP_if_NOT_actionListGeneratedPath(ALineNumber, AThisFunc, actionListNEWarchivePath, actionListGeneratedPath , actionListNEW){
		if(!FileExist(actionListGeneratedPath)) {
			global g_doSaveLogFiles
			g_doSaveLogFiles := 1
			global g_lineNumberFeedback
    ;g_lineNumberFeedback=%A_LineFile%~%AThisFunc%~%ALineNumber%
			g_lineNumberFeedback=create_al_Address.inc.ahk / %A_LineFile% ~%AThisFunc%~%ALineNumber%
			msg = :( !FileExist(%actionListNEWarchivePath%)) `n token05 `n  `n '%actionListNEWarchivePath%' = actionListNEWarchivePath  `n '%actionListGeneratedPath%' = actionListGeneratedPath  `n actionListNEW= %actionListNEW% `n ==> ExitAPP 17-08-11_00-00 `n %g_lineNumberFeedback%
			tooltip,% msg


			lll_if_g_doSaveLogFiles(ALineNumber, A_ScriptName, msg)

    ;lll(AThisFunc . "~" . ALineNumber, A_ScriptName, msg)
			Sleep,3000 ; function actionListNEWactivate ??? right ??
			ExitAPP
		}
		return
	}
;>>>>>>>>>>>>>> ExitAPP_if_NOT_actionListGeneratedPath >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



;/¯¯¯¯ lll_if_g_doSaveLogFiles ¯¯ 190317163201 ¯¯ 17.03.2019 16:32:01 ¯¯\
	lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,msg ){
		lll(AThisFunc . "~" . ALineNumber, "create_al_Address.inc.ahk" , msg)
    ; llll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"")
; Msgbox,'%g_doSaveLogFiles%' = g_doSaveLogFiles   (%A_LineFile%~%A_LineNumber%) `
		return
	}
;\____ lll_if_g_doSaveLogFiles __ 190317163206 __ 17.03.2019 16:32:06 __/




; actionListNEWarchivePath
    ;/¯¯¯¯ save_actionListGeneratedPath ¯¯ 190317163148 ¯¯ 17.03.2019 16:31:48 ¯¯\
	save_actionListGeneratedPath(actionListGeneratedPath,includeFileSContent,actionListNEWarchivePath) {

		if(!actionListNEWarchivePath){
			Tooltip, >%fileContent%< =fileContent `n (from: %A_LineFile%~%A_LineNumber%)
    ; msgbox,cant read  >%fileContent%< =fileContent `n  becouse !actionListNEWarchivePath `n (from: %A_LineFile%~%A_LineNumber%)

			global g_doSaveLogFiles
			g_doSaveLogFiles := 1
			global g_lineNumberFeedback

			g_lineNumberFeedback=create_al_Address.inc.ahk / %A_LineFile% ~%A_ThisFunc%~%A_LineNumber%

			msg=:( !fileContent `n `n ==> ExitApp  `n `n (g_lineNumberFeedback)
			tooltip,% msg
			lll_if_g_doSaveLogFiles(A_LineNumber, A_ScriptName, msg)
			ExitApp
		}

		ExitAPP_if_NOT_actionListGeneratedPath (A_LineNumber, A_ThisFunc, actionListNEWarchivePath, actionListGeneratedPath , actionListNEW)
    ;ExitAPP_if_NOT_actionListGeneratedPath (A_LineNumber, A_ThisFunc, actionListNEWarchivePath, actionListGeneratedPath , actionListNEW)

		if(FileExist(actionListGeneratedPath))
			FileDelete, %actionListGeneratedPath%
		Sleep,60
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"FileAppend too " actionListGeneratedPath)
		if(1 && InStr(A_ComputerName,"SL5") )
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		FileAppend,% includeFileSContent, % actionListGeneratedPath
    ; Sleep,20
		FileRead, fileContent, %actionListNEWarchivePath%
    ;Sleep,20
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"FileAppend too " actionListGeneratedPath)
		if(1 && InStr(A_ComputerName,"SL5") )
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		FileAppend,% fileContent, % actionListGeneratedPath
		if(false)lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"SAVED: " . actionListGeneratedPath)
			Sleep,60
		return
	} ;\____ save_actionListGeneratedPath __ 190317163141 __ 17.03.2019 16:31:41 __/



    ;/¯¯¯¯ lll_if_g_doSaveLogFiles_matches ¯¯ 190317163121 ¯¯ 17.03.2019 16:31:21 ¯¯\
	lll_if_g_doSaveLogFiles_matches(ALineNumber, AThisFunc, matchs1,matchs2,matchs3,matchs4){
		if(0){
			lll:=";<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<", "matchs1: " . matchs1
			tooltip,'%lll%' = lll    (line:%A_LineNumber%)
			lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  lll)
			lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  "matchs2=" . matchs2)
			lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  "matchs3=" . matchs3)
			lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  "matchs4=" . matchs4)
			lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  ";>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
		}
		return
	}
	;\____ lll_if_g_doSaveLogFiles_matches __ 190317163125 __ 17.03.2019 16:31:25 __/



