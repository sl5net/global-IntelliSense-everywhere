
;/¯¯¯¯ getActionListNEW173129simplify ¯¯ 190210130850 ¯¯ 10.02.2019 13:08:50 ¯¯\
getActionListNEW173129simplify( actionListNEW, doCutOffExtension := true ) { ; , doCutOffExtension := false )
	if( SubStr( activeTitle , 1, 3 ) == "..\" ) ; for example "..\SciTEWindow\_global"
		return actionListNEW
	actionListNEW := RegExReplace( actionListNEW, "^.+\\([^\\]+)$" , "$1") ; cut away folder name
	if(A_ScriptName == "al-route.inc.ahk" )   ; thats developer mode. this script is not includet. 08.03.2017 09:14
		actionListNEW := RegExReplace( actionListNEW, "(SciTE4AutoHotkey|PhpStorm).+" , "") ; cut away ...
	if(doCutOffExtension)
	    actionListNEW := RegExReplace( actionListNEW, "\.(ahk|txt|htm|pdf).+" , "")  ; cut away ...

	actionListNEW := RegExReplace( actionListNEW, "i)[^\w\d_-]+" , "_")  ; underscore instead some special chars
	actionListNEW := RegExReplace( actionListNEW, "[_-]{2,}" , "_") ; to many undersocre... use onle one

  ; are limited to 255 characters, and the total path length is limited to approximately 32,000 characters. However, you should generally try to limit path lengths to below 260 characters
  ; It's 257 characters. To be precise: NTFS itself does impose a maximum filename-length of several thousand characters (around 30'000 something). However, Windows imposes a 260 maximum length for the Path+Filename. The drive+folder takes up at least 3 characters, so you end up with 257.
	actionListNEW := subStr( actionListNEW ,1, 150)
  ; http://stackoverflow.com/questions/265769/maximum-filename-length-in-ntfs-windows-xp-and-windows-vista

	return actionListNEW
} ; EndOf getActionListNEW173129simplify
;\____ getActionListNEW173129simplify __ 190210130909 __ 10.02.2019 13:09:09 __/


;/¯¯¯¯ getActionListNEW_relativePath ¯¯ 190126041338 ¯¯ 26.01.2019 04:13:38 ¯¯\
getActionListNEW_relativePath(activeTitle, activeClass, actionListNEW, actionListDir ) {
	
	;tempPlaygournd := "tempPlaygournd2"
	;return tempPlaygournd
	
 ; 'Q-Dir 6.49.7 [3]' = at  
 ; Bild Ã¶ffnen ahk_class #32770 
 ; Exportieren ahk_class #32770 aus openoffice zu pdf 01.07.2017 20:22
 ; Select Path SunAwtDialog
 ; Open File or Project ahk_class SunAwtDialog
 ; Anhang speichern ahk_class #32770
;
	if(1 && InStr(A_ComputerName,"SL5")){
        ; Sourcetree ahk_class HwndWrapper[SourceTree.exe;;2705bdea-7ac8-4b39-b851-91e598ce9055] ; mouseWindowTitle=0xd508d8
		tip=%activeTitle% = activeTitle`n %activeClass% = activeClass`n
		tip .= "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		ToolTip,%tip% , 1,1
		if(instr(activeTitle,"isNotAProject"))
			sleep,1000
        ; t
        ;Clipboard := tip
	}
	if(!activeTitle && !activeClass){
		Msgbox,%tip% this should never happens `n (%A_LineFile%~%A_LineNumber%) 
	}
	if(0 && !activeTitle){
		Msgbox,%tip% this should never happens `n (%A_LineFile%~%A_LineNumber%) 
	}
; E:\fre\private\HtmlDevelop\Human-Connection\WebApp ahk_class VirtualConsoleClassGhost 
	if (0 && !RegExMatch( activeClass , "(AutoHotKey|Chrome|Notepad)" ) ) { ; thats only for a bug i search actually 18-05-08_13-03
		tip =
      (
            %activeClass%=activeClass
            %activeTitle%=activeTitle
      )
		temp =
      (
            _globalActionListsGenerated=activeClass
            _global=activeTitle
      )
      ; tooltip,%tip% = tip `n (%A_LineFile%~%A_LineNumber%) 
		clipboard := tip
		Msgbox,%tip% `n (%A_LineFile%~%A_LineNumber%) 
	}
	
	if(activeClass == "EVERYTHING")
		return "_globalActionLists\EVERYTHING"

; WinMove,cmd (Admin) ahk_class VirtualConsoleClass ,, 879,824, 1218,384
	; if ( RegExMatch( activeTitle , "\bcmd\b" ) && activeClass == "VirtualConsoleClass" )
	if (false && activeClass == "VirtualConsoleClass" )
		return "VirtualConsoleClass\cmd"
	
; AHK Studio - \.ahk;  ahk_class AutoHotkeyGUI ,, 2221,290, 1198,846
	Banking_4W:
	if ( RegExMatch( activeTitle , "^Banking 4W" ) )
		return "_globalActionLists\Banking_4W"
	
	Smarty:
	if (1 && RegExMatch( activeTitle , "\bSmarty\b" ) )
		return "_globalActionLists\Smarty"
	
	
	StackOverflow:
	if (0 && RegExMatch( activeTitle , "Stack Overflow\b" ) )
		return "_globalActionLists\Stack_Overflow"
	
	AHKStudio:
	if ( RegExMatch( activeTitle , "^AHK Studio -.+\.ahk" ) )
		return "_globalActionLists\AHK_Studio"
	
	DocumentEditor:
	if ( activeClass == "OpusApp" && RegExMatch( activeTitle , "\- Microsoft Word" ) )
		return "_globalActionLists\DocumentEditor"
	
	
	VirtualConsoleHumanConnection:
	if (0 && RegExMatch( activeClass , "VirtualConsole" ) ) {
		tip =
      (
         %activeClass%=activeClass
         %activeTitle%=activeTitle
      )
		
		Msgbox,%tip% `n (%A_LineFile%~%A_LineNumber%)
		return "_globalActionLists\VirtualConsoleClassGhost\Human-Connection"
	}
	
	g_ActionList_PRIVATE := "G:\fre\private\actionLists\"
	if(false){
	}
	#Include *i .\..\actionLists\PRIVATE_al-route.inc.ahk
	
	
	HumanConnection:
	if (activeClass == "VirtualConsoleClassGhost" && RegExMatch( activeTitle , "Human-Connection" ) ) {
        ; https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-27 dirty bugFix
		tip =
      (
            %activeClass%=activeClass
            %activeTitle%=activeTitle
            ..\VirtualConsoleClassGhost\Human-Connection
      )
     ; clipboard := tip 
     ; tooltip,%tip% `n (%A_LineFile%~%A_LineNumber%) 
		return "VirtualConsoleClassGhost\Human-Connection"
	}
	
	VirtualConsoleClassGhost:
	if (0 && activeClass == "VirtualConsoleClassGhost"  ) {
		tip =
      (
            %activeClass%=activeClass
            %activeTitle%=activeTitle
            ..\VirtualConsoleClassGhost\Human-Connection
      )
     ; clipboard := tip 
     ; tooltip,%tip% `n (%A_LineFile%~%A_LineNumber%) 
		return "VirtualConsoleClassGhost\_global"
	}
	
	SourceTree:
	if ( RegExMatch( activeClass , "i)SourceTree" )  ) {
	  ; Msgbox,%activeClass%=activeClass`n (%A_LineFile%~%A_LineNumber%)
		return "_globalActionLists\SourceTree"
	}
	
	docker:
	if ( RegExMatch( activeTitle , "\b(docker)\b" ) ) 
		return "_globalActionLists\docker"
	
	
; Select File - AHK-Studio.ahk ahk_class #32770 ; mouseWindowTitle=0x1604f6  ;
; 	WinMerge Dateien oder_Ordner_ausw_hlen
; WinMerge - [Dateien oder Ordner auswählen] ahk_class WinMergeWindowClassW
	
	pfade:
	if ( RegExMatch( activeTitle , "(Export|Ordner ausw|Double Commander|FreeCommander|Q-Dir \d|Datei öffnen|Bild öffnen|Anhang speichern|Datei speichern|Speichern|Speichern unter|ffnen|Dateien/Ordner suchen|Exportieren|Dokument speichern|Select Path|Open File|Open File or Project|Select File)" ) ) 
		return "_globalActionLists\pfade"
;Speichern is used with ToDoList_c_AbstractSpoon

	; To Tool

	AutoHotkey_Community: ; AHK_Community
	if (1 && RegExMatch( activeTitle , "(AutoHotkey Community)" ) )
		return "_globalActionLists\AutoHotkey_Community"
;Speichern is used with ToDoList_c_AbstractSpoon
	
    ahk_global:
	if (RegExMatch( activeTitle , "(\.ahk)" ) ){
	    ; MsgBox, , activeTitle , % ">" activeTitle  "<`n = activeTitle `n`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
	    ; clipboard := activeTitle
	    ; clipboard := A_ThisFunc
		return "_globalActionListsGenerated\_ahk_global.ahk._Generated"
	}

; g_IntelliSense-everywhere - AutoHotkey Community - Google Chrome ahk_class Chrome_WidgetWin_1
	ahk_globalAhk_Generated:
	if (1 && RegExMatch( activeClass , "\b(Notepad)\b" ) && RegExMatch( activeTitle , "(\.ahk)" ) ){
		if(false && activeClass == "ChromeWidgetWin1") {  ; want to know that. debugging 26.4.218 12:18}
        ; need to be discussed: https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-22
			tooltip,% activeTitle activeClass
			
			clipboard := activeTitle activeClass " (18-12-26_11-08)"
			sleep,9000
			log =
        (
        https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-22
        blabla.ahk - AutoHotKey - Visual Studio Code [Administrator]
        ahk_class Chrome_WidgetWin_1
        ahk_exe Code.exe
        )
		}
		return "_globalActionListsGenerated\_ahk_global.ahk._Generated" ; seems works not 18-04-26_12-44
		return "_globalActionListsGenerated\_ahk_global.ahk._Generated.ahk" ; seems works not 18-04--26_12-44
	}
	
	; ll ll ppp ppp ppp ppp
	
	SetTitleMatchMode,2 ; 2: A window's title can contain WinTitle anywhere inside it to be a match.
	
	if( instr( activeTitle , "\actionLists\")  ) {
;      Msgbox, `n (%A_LineFile%~%A_LineNumber%) 
; if( RegExMatch( activeTitle  , "i)(\.ahk)" ) || instr( activeTitle , "\actionLists\")  ) {
		
		wLGeneratedDIRname = _globalActionListsGenerated
		wLGeneratedDIR := scriptDIR . "\" . wLGeneratedDIRname
		wlRelativePath := "SciTEWindow\_global" ; relative old
		wlRelativePath := "" . wLGeneratedDIRname ; relative newd
		wlRelative := "" . wLGeneratedDIRname . "\_ahk_global.ahk"
		wl := wLGeneratedDIR . "\_ahk_global.ahk"
		sciteAhkGlobal = actionLists\SciTEWindow\_global.ahk
		if(!Fileexist(wl)){
			if(!Fileexist(wLGeneratedDIR))   {
				FileCreateDir, % wLGeneratedDIR
				Sleep, 60
			}
			if(1 && InStr(A_ComputerName,"SL5"))
				RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			FileAppend, _____global generated lib|r|%wl%`n , % wl
			FileAppend, _____global generated lib|rr||ahk|openInEditor,%wl%`n, % wl
			FileAppend, _____global generated lib|rr||ahk|openInEditor,..\_globalActionListsGenerated\_ahk_global.ahk`n, % wl
			
			Sleep, 100
			
			if(!FileExist(scriptDIR)){
				MsgBox, :-( !FileExist(%scriptDIR% = scriptDIR) `n token07 `n  => exitApp (17-03-19_15-16 )
				ExitApp
			}
			
			f :=  scriptDIR . "\_global.ahk"
			if(!FileExist(f)){
				MsgBox, :-( !FileExist(f=%f%) 17-03-19_15-23  `n=> exitApp
				ExitApp
			}
			Fileread, fileContent1 , % f
			Sleep,100
			if(!fileContent1){
				MsgBox, :-( !fileContent `n f=%f% `n 17-03-19_15-21 `n=>  exitApp
				ExitApp
			}
      ;FileCopy,% scriptDIR . "\_global.ahk", % wl
			f = ..\..\foundFunctionsActionList.ahk
			Fileread,fileContent2, % f
			Sleep,100
			if(!fileContent2){
				MsgBox, :-( !fileContent `n f=%f% `n 17-03-19_15-21 exitApp
				ExitApp
			}
			RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
			FileAppend, % fileContent1 . fileContent2  ,% wl
			Sleep, 300
		}
		return ,% wlRelative
	}
	
	if(!RegExMatch(actionListNEW,"_global$")) {
		actionListNEW := RegExReplace( actionListNEW, "^[_-]+" , "")
		actionListNEW := RegExReplace( actionListNEW, "[_-]+$" , "")
	}
	return actionListNEW
} ; endOf: getActionListNEW_relativePath

add_fileExtension_ifNotExist(ByRef actionListNEW, defaultExt := "ahk" ){
	if( SubStr( actionListNEW , -3 ) <> ".ahk" )
		actionListNEW .= "." defaultExt
}




ToolTipSlowMotion(actionListNEW, LineNumber){
	global isSlowMotion
	if(!isSlowMotion)
		return
	ToolTip,%actionListNEW% `n  '%LineNumber%' = LineNumber  `n (line:%A_LineNumber%) `n
	Sleep,500
}

; Clipboard := actionListNEW ;  we dont transport usually inside this global file via clipboard 06.03.2017 19:41
;  MsgBox,  '%actionListNEW%' = actionListNEW  `n  17-03-06_18-48 `n `n ( line: %A_LineNumber%)
if(A_ScriptName == "al-route.inc.ahk" ) {  ; thats developer mode. this script is not includet. 08.03.2017 09:14
; Clipboard := actionListNEW ;  we dont transport usually inside this global file via clipboard 06.03.2017 19:41
	MsgBox,4, %actionListNEW%, '%actionListNEW%' = actionListNEW  `n '%actionListDir%' = actionListDir `n  `n %activeClass% = activeClass `n  17-03-06_18-48 `n `n ( line: %A_LineNumber%), 50
 ;MsgBox,4 ,Titel, 5Sek (from: %A_LineFile%~%A_LineNumber%), 5
}
;\____ getActionListNEW_relativePath __ 190126041357 __ 26.01.2019 04:13:57 __/



fileCreateDirS(dir,addSecondDir) {
	growingPath := ""
	Loop, parse, dir, \
	{
		if(A_Index > 1)
			growingPath := growingPath . "\" . A_LoopField
		if(A_Index = 1)
		{
			growingPath := A_LoopField
			if(!FileExist(growingPath))
			{
				MsgBox, %A_Index%: !FileExist(%growingPath%)
				ExitApp
			}
			if(StrLen(addSecondDir)>0)
				growingPath := growingPatPath . "\" . addSecondDir
			backUpFolderRoot:=growingPath
		}
		if(!FileExist(growingPath))
		{
			;~ MsgBox, %A_Index% is %growingPath%.
			FileCreateDir,%growingPath%
		}
	}
	;~ MsgBox, %growingPath%.
	backUpFolder := growingPath
	return,backUpFolderRoot
}

;

line4spaces( s ) {
   ; this funktion adds lines. it founds space sepearted text and adds it to the end. spearte line for the first word and seperate line for the rest of the line. it works recursive. some lines are ignoared. for e.g. comments. 08.04.2017 23:36
	s := RegExReplace(s,"\n\W+","`n") ; no lieading spaces and no llieading not words 
	OutputVarCount   :=1
	startPos :=1
	while( pos := RegExMatch(s , "iP)\n([^/`;_\s]+[^\s]*)([ ]+)([^\n]+)" , m, startPos)){ ; works
;while( pos := RegExMatch(s , "iP)\n([^`;_\s]+[^\s]*)([ ]+)([^\n]+)" , m, startPos)){ ; works
; while( pos := RegExMatch(s , "iP)([^\s]+)([ ]+)([^\n]+)" , m, startPos)){ ; works
;while( pos := RegExMatch(s , "iP)([^\s]+)([^a-z\d\n]+)([^\n]+)" , m, startPos)){
		startPos := pos + mLen1 + mLen2 + mLen3
		m1 := SubStr(s, mPos1 ,  mLen1 )
		m3 := SubStr(s, mPos3 ,  mLen3 )
		reg := "i)^[^a-z]+(.*)\s*"
		m1 := RegExReplace(m1,reg,"$1")
      ;m1 := RegExReplace(m1,"i)\W+(.*)","$1")
		m3 := RegExReplace(m3,reg,"$1")
      ; MsgBox, %m%:`n >%m1%< >%m3%<
		s .= "`n" . m1 . "`n" . m3
	}
	return s 
}


maybeSuperglobalActionList(actionListNEW, ActionListNEW_time_between , activeClass, activeTitle := "" ){
	if( SubStr( actionListNEW , -3 ) <> ".ahk" ) ; 06.03.2018 13:09
		actionListNEW .= ".ahk"
     if(actionListNEW <> ActionListNEW_time_between)
          return, % actionListNEW
	ActionListNEWAddress := "actionLists\" . activeClass . "\" . actionListNEW
     if(FileExist(ActionListNEWAddress)){
          return, % actionListNEW
	}

	RegRead, CreatedDir, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, CreatedDir

	; ActionList_isNotAProject_withoutExt  := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\actionLists\_globalActionListsGenerated\isNotAProject" )
	ActionList_isNotAProject_withoutExt   := RegExReplace(A_ScriptDir "\actionLists\_globalActionListsGenerated\isNotAProject" ,"(\\[^\\]+\\\.\.)+") ; works. removes all symbolic links 24.02.2018  cleanPath
	if(!CreatedDir){
		if(false){
			clipboard := ActionListNEWAddress " (18-12-26_11-07)"
			tooltip,% ActionListNEWAddress " uiuiuiuiuiuiu"
			Pause,On
		}
		return, % ActionList_isNotAProject_withoutExt
	}
        ; return, % actionListNEW

     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_ScriptName, % A_ScriptName ; RegWrite , RegSave , Registry
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite ,
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite ,

     if(0 && !FileExist("..\actionLists\" . activeClass . "\_create_own_project.flag")){
           ; tooltip,ActionListNEWAddress = %ActionListNEWAddress% `n `n (%A_LineFile%~%A_LineNumber%) )
           ; MsgBox,% "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ; happend 07.10.2018 10:33 18-10-07_10-33 inside notepad. dont knoow whey
          return, % "_globalActionListsGenerated\_global.ahk" ; ; i think it doesent makes since in some cases 13.05.2018 17:19
     }


          ; created token=17-08-10_16-17
	if(1 && InStr(activeTitle, "token=17-08-10_16-17")){
		msg= :( script was to slow with updating the `n action rejacted. reload `n 17-08-10_16-27
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,msg )
		ToolTip,%msg% 17-08-10_16-33
		Msgbox,%msg%`n (%A_LineFile%~%A_LineNumber%) )
		SetTitleMatchMode, 2
		WinWaitNotActive,% activeTitle
		Reload
		return
	}



     FileDelete, % "..\actionLists\" activeClass "\_create_own_project.flag"

; %activeTitle% <=== leider nicht verfügbar 18-12-29_18-04
	contend =
(
#Include ..\_globalActionLists\_global.ahk
#Include ..\%activeClass%\_global.ahk

; #Include ..\_globalActionLists\examplesForBeginners.ahk
___open window library |rr||ahk|openInEditor,%actionListNEW%
; if this german au is readable your UTF8 is probalby correct: ä

)
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")

	FileAppend,% "",   % "..\actionLists\" . activeClass . "\_global.ahk"

	if( FileExist("..\actionLists\" . activeClass . "\" . actionListNEW) ){
		Msgbox,ups actionListNEW = %actionListNEW% exist already ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
		EXIT
	}
	if( !FileExist("..\actionLists\" . activeClass . "\_global.ahk") ){
		Msgbox,ups ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
		EXIT
	}
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
	FileAppend,% contend,   % "..\actionLists\" . activeClass . "\" . actionListNEW
	if( !FileExist("..\actionLists\" . activeClass . "\" . actionListNEW) ){
		Msgbox,:-( ups !FileExist %actionListNEW% ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
		EXIT
	}
     Sleep,100
     ; msgbox,%actionListNEW% = actionListNEW ,`%actionListNEW`% = actionListNEW 18-03-06_13-31 `n (%A_LineFile%~%A_LineNumber%)

     ; run,                    % "..\actionLists\" . activeClass . "\" . actionListNEW
     ; isInEditorSoon := openInEditor("..\actionLists\" . activeClass, true, "run," actionListNEW, true, true, true)
     ; openInEditor(ActionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib)
	; if(!isInEditorSoon)
    ; msgbox, ,please open your new ActionList by using __  `n (%A_LineFile%~%A_LineNumber%), 2

     return, % actionListNEW
} ; ENDof: maybeSuperglobalActionList
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
