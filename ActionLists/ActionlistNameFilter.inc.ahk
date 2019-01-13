; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
; GLOBAL FILTER / ROUTING
; this file was generated 20170308151813 by: 
; if you want you could update it by yourself. it will not overwritten by Typing_Aid_everywhere_multi_clone.ahk
; if you delete it it will be generated again.
; you could use it as a global filter/routing called from your special .../className/ActionListNameFilter.inc.ahk

#SingleInstance, force
CoordMode, ToolTip, Screen

; if you want you could use the follwong global variables for calculating you new ActionListNEW : ActionListDir, ActionListNEW, ActiveClass, activeTitle

if (!ActionListNEW && 1){
	; 02.11.2018 12:55 attention!! : This is redundant code when changing please consider the other posts also !!
	ActiveClass := "_globalActionListsGenerated"
	; activeTitle := "_global" ; used till 07.10.2018 10:12 18-10-07_10-12
	
	ActionList_isNotAProject_withoutExt  := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\ActionLists\_globalActionListsGenerated\isNotAProject" )
	ActionList_isNotAProject  := global ActionList_isNotAProject_withoutExt ".ahk"
	
	activeTitle := ActionList_isNotAProject ; isNotAProject.ahk ; todo: not very pretty silly. 28.10.2018 11:33

	ActionListNEW := ActionList_isNotAProject ; isNotAProject.ahk ; todo: not very pretty silly. 28.10.2018 11:33
	ToolTip9sec( "Oops (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"  )
	if(1 && InStr(A_ComputerName,"SL5"))
	    sleep,5000
	exitapp
}

if (!ActionListNEW && 0){
	m := "ERROR ActionListNEW is EMPTY.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ") `n (token293)"
	ToolTip9sec(m "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"  )
	msgbox, % m
    ; tooltip,%activeTitle%
}

; REMEMBER: activeTitle should not be changed inside of this file :) please :) 12.08.2017 10:11
; toh-5 - [D:\downloads\toh-5] - ...\src\app\app.component.ts - PhpStorm 2016.3.3 ahk_class SunAwtFrame


; ActionListDir_backupTopOfTempAHL := ActionListDir


isSlowMotion := false
; isSlowMotion := true
if(A_ScriptName == "ActionListNameFilter.inc.ahk" ) { ; thats developer mode. this script is not includet. 08.03.2017 09:14
	activeTitle  = I would like to hire a PHP Developer | Codeigniter | CSS | HTML5 | JSON | PHP - Google Chrome
	activeTitle  = (Unbenannt) * SciTE4AutoHotkey [5 von 5] ahk_class SciTEWindow 
	activeTitle  = (Unbenannt) * SciTE4AutoHotkey [6 von 6]
	activeTitle  = Threema Web - Google Chrome
	
	activeTitle  = dingsbums.ahk
	ActionListDir  := "..\ActionLists\SciTEWindow"
	
	if(!ActionListNEW)
		ActionListNEW := A_ScriptName
	ActionListNEW := activeTitle
	
	isSlowMotion := true
} ; demo Mode ende. ( A_ScriptName == "ActionListNameFilter.inc.ahk" )

; playground | Piratenpad - Google Chrome TOP ahk_class Chrome_WidgetWin_1
; if DeskPins-reloaded-from-SL5net_alwaysOnTop.ahk change the title i would use anyway old list
ActionListNEW := regexreplace(ActionListNEW, " TOP ")


if (!ActionListNEW && 1){
	m := "ERROR ActionListNEW is EMPTY.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ") `n (token293)"
	if(0 && InStr(A_ComputerName,"SL5")){
		ToolTip9sec(m "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"  )
		msgbox, % m
	}
}

if(!ActionListDir)
	ActionListDir := A_ScriptDir
if(!scriptDir)
	scriptDir := ActionListDir


;ToolTip,`n (%A_LineFile%~%A_LineNumber%)
;Sleep,2000

if (!ActionListNEW && 1){
	m := "ERROR ActionListNEW is EMPTY.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ") `n (token293)"
	if(0 && InStr(A_ComputerName,"SL5")){
		ToolTip9sec(m "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"  )
		msgbox, % m
	}
}

#Include,.\..\ActionLists\activeClassManipulation.inc.ahk

if (!ActionListNEW && 1){
	m := "ERROR ActionListNEW is EMPTY.  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ") `n (token293)"
	if(0 && InStr(A_ComputerName,"SL5")){
		ToolTip9sec(m "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"  )
		msgbox, % m
	}
}


; ToolTipSlowMotion(ActionListNEW, A_LineNumber)

ActionListNEW := getActionListNEW173129simplify( ActionListNEW )
ToolTipSlowMotion(ActionListNEW, A_LineNumber)

ActionListNEW := getActionListNEW173129( activeTitle, ActiveClass, ActionListNEW, ActionListDir )
ToolTipSlowMotion(ActionListNEW, A_LineNumber)

ActionListNEW := getActionListNEW173129addFileExtension(ActionListNEW )
ToolTipSlowMotion(ActionListNEW, A_LineNumber)


; #Include,.\..\ActionLists\activeClassManipulation.inc.ahk


getActionListNEW173129( activeTitle, ActiveClass, ActionListNEW, ActionListDir ) {
	
	
 ; 'Q-Dir 6.49.7 [3]' = at  
 ; Bild Ã¶ffnen ahk_class #32770 
 ; Exportieren ahk_class #32770 aus openoffice zu pdf 01.07.2017 20:22
 ; Select Path SunAwtDialog
 ; Open File or Project ahk_class SunAwtDialog
 ; Anhang speichern ahk_class #32770
;
	if(1 && InStr(A_ComputerName,"SL5")){
        ; Sourcetree ahk_class HwndWrapper[SourceTree.exe;;2705bdea-7ac8-4b39-b851-91e598ce9055] ; mouseWindowTitle=0xd508d8
		tip=%activeTitle% = activeTitle`n %ActiveClass% = ActiveClass`n
		tip .= "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		ToolTip,%tip% , 1,1
		if(instr(activeTitle,"isNotAProject"))
			sleep,1000
        ; t
        ;Clipboard := tip
	}
	if(!activeTitle && !ActiveClass){
		Msgbox,%tip% this should never happens `n (%A_LineFile%~%A_LineNumber%) 
	}
	if(0 && !activeTitle){
		Msgbox,%tip% this should never happens `n (%A_LineFile%~%A_LineNumber%) 
	}
; E:\fre\private\HtmlDevelop\Human-Connection\WebApp ahk_class VirtualConsoleClassGhost 
	if (0 && !RegExMatch( ActiveClass , "(AutoHotKey|Chrome|Notepad)" ) ) { ; thats only for a bug i search actually 18-05-08_13-03
		tip =
      (
            %ActiveClass%=ActiveClass
            %activeTitle%=activeTitle
      )
		temp =
      (
            _globalActionListsGenerated=ActiveClass
            _global=activeTitle
      )
      ; tooltip,%tip% = tip `n (%A_LineFile%~%A_LineNumber%) 
		clipboard := tip
		Msgbox,%tip% `n (%A_LineFile%~%A_LineNumber%) 
	}
	
	
; AHK Studio - \.ahk;  ahk_class AutoHotkeyGUI ,, 2221,290, 1198,846
	Banking_4W:
	if ( RegExMatch( activeTitle , "^Banking 4W" ) )
		return "..\_globalActionLists\Banking_4W"
	
	Smarty:
	if (1 && RegExMatch( activeTitle , "\bSmarty\b" ) )
		return "..\_globalActionLists\Smarty"
	
	
	StackOverflow:
	if (0 && RegExMatch( activeTitle , "Stack Overflow\b" ) )
		return "..\_globalActionLists\Stack_Overflow"
	
	AHKStudio:
	if ( RegExMatch( activeTitle , "^AHK Studio -.+\.ahk" ) )
		return "..\_globalActionLists\AHK_Studio"
	
	DocumentEditor:
	if ( ActiveClass == "OpusApp" && RegExMatch( activeTitle , "\- Microsoft Word" ) )
		return "..\_globalActionLists\DocumentEditor"
	
	
	VirtualConsoleHumanConnection:
	if (0 && RegExMatch( ActiveClass , "VirtualConsole" ) ) {
		tip =
      (
         %ActiveClass%=ActiveClass
         %activeTitle%=activeTitle
      )
		
		Msgbox,%tip% `n (%A_LineFile%~%A_LineNumber%)
		return "..\_globalActionLists\VirtualConsoleClassGhost\Human-Connection"
	}
	
	g_ActionList_PRIVATE := "G:\fre\private\ActionLists\"	
	if(false){
	}
	#Include *i .\..\ActionLists\PRIVATE_ActionListNameFilter.inc.ahk
	
	
	HumanConnection:
	if (ActiveClass == "VirtualConsoleClassGhost" && RegExMatch( activeTitle , "Human-Connection" ) ) {
        ; https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-27 dirty bugFix
		tip =
      (
            %ActiveClass%=ActiveClass
            %activeTitle%=activeTitle
            ..\VirtualConsoleClassGhost\Human-Connection
      )
     ; clipboard := tip 
     ; tooltip,%tip% `n (%A_LineFile%~%A_LineNumber%) 
		return "..\VirtualConsoleClassGhost\Human-Connection"
	}
	
	VirtualConsoleClassGhost:
	if (0 && ActiveClass == "VirtualConsoleClassGhost"  ) {
		tip =
      (
            %ActiveClass%=ActiveClass
            %activeTitle%=activeTitle
            ..\VirtualConsoleClassGhost\Human-Connection
      )
     ; clipboard := tip 
     ; tooltip,%tip% `n (%A_LineFile%~%A_LineNumber%) 
		return "..\VirtualConsoleClassGhost\_global"
	}
	
	SourceTree:
	if ( RegExMatch( ActiveClass , "i)SourceTree" )  ) {
	  ; Msgbox,%ActiveClass%=ActiveClass`n (%A_LineFile%~%A_LineNumber%) 
		return "..\_globalActionLists\SourceTree"
	}
	
	docker:
	if ( RegExMatch( activeTitle , "\b(docker)\b" ) ) 
		return "..\_globalActionLists\docker"
	
	
; Select File - AHK-Studio.ahk ahk_class #32770 ; mouseWindowTitle=0x1604f6  ;
; 	WinMerge Dateien oder_Ordner_ausw_hlen
; WinMerge - [Dateien oder Ordner auswählen] ahk_class WinMergeWindowClassW
	
	pfade:
	if ( RegExMatch( activeTitle , "(Ordner ausw|Double Commander|FreeCommander|Q-Dir \d|Bild öffnen|Anhang speichern|Datei speichern|Speichern|Speichern unter|ffnen|Dateien/Ordner suchen|Exportieren|Dokument speichern|Select Path|Open File or Project|Select File)" ) ) 
		return "..\_globalActionLists\pfade"
;Speichern is used with ToDoList_c_AbstractSpoon
	
	AutoHotkey_Community: ; AHK_Community
	if (1 && RegExMatch( activeTitle , "(AutoHotkey Community)" ) )
		return "..\_globalActionLists\AutoHotkey_Community"
;Speichern is used with ToDoList_c_AbstractSpoon
	
	
	
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
		return "..\_globalActionListsGenerated\_ahk_global.ahk._Generated" ; seems works not 18-04-26_12-44
		return "..\_globalActionListsGenerated\_ahk_global.ahk._Generated.ahk" ; seems works not 18-04--26_12-44
	}
	
	; ll ll ppp ppp ppp ppp
	
	SetTitleMatchMode,2 ; 2: A window's title can contain WinTitle anywhere inside it to be a match.
	
	if( instr( activeTitle , "\ActionLists\")  ) {
;      Msgbox, `n (%A_LineFile%~%A_LineNumber%) 
; if( RegExMatch( activeTitle  , "i)(\.ahk)" ) || instr( activeTitle , "\ActionLists\")  ) {
		
		wLGeneratedDIRname = _globalActionListsGenerated
		wLGeneratedDIR := scriptDIR . "\..\" . wLGeneratedDIRname
		wlRelativePath := "..\SciTEWindow\_global" ; relative old
		wlRelativePath := "..\" . wLGeneratedDIRname ; relative newd 
		wlRelative := "..\" . wLGeneratedDIRname . "\_ahk_global.ahk"
		wl := wLGeneratedDIR . "\_ahk_global.ahk"
		sciteAhkGlobal = ..\ActionLists\SciTEWindow\_global.ahk
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
				MsgBox, :-( !FileExist(%scriptDIR% = scriptDIR) `n=> exitApp (17-03-19_15-16 )
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
	
	if(!RegExMatch(ActionListNEW,"_global$")) {
		ActionListNEW := RegExReplace( ActionListNEW, "^[_-]+" , "")
		ActionListNEW := RegExReplace( ActionListNEW, "[_-]+$" , "")
	}
	return ActionListNEW
} ; endOf: getActionListNEW173129

getActionListNEW173129addFileExtension(ActionListNEW ){
	if( SubStr( ActionListNEW , -3 ) <> ".ahk" )
		ActionListNEW .= ".ahk"
	return ActionListNEW
}
getActionListNEW173129simplify( ActionListNEW ) {
	if( SubStr( activeTitle , 1, 3 ) == "..\" ) ; for example "..\SciTEWindow\_global"
		return ActionListNEW
	ActionListNEW := RegExReplace( ActionListNEW, "^.+\\([^\\]+)$" , "$1") ; cut away folder name
	if(A_ScriptName == "ActionListNameFilter.inc.ahk" )   ; thats developer mode. this script is not includet. 08.03.2017 09:14
		ActionListNEW := RegExReplace( ActionListNEW, "(SciTE4AutoHotkey|PhpStorm).+" , "") ; cut away ...
	ActionListNEW := RegExReplace( ActionListNEW, "\.(ahk|txt|htm|pdf).+" , "")  ; cut away ...
	ActionListNEW := RegExReplace( ActionListNEW, "i)[^\w\d_-]+" , "_")  ; underscore instead some special chars
	ActionListNEW := RegExReplace( ActionListNEW, "[_-]{2,}" , "_") ; to many undersocre... use onle one
	
  ; are limited to 255 characters, and the total path length is limited to approximately 32,000 characters. However, you should generally try to limit path lengths to below 260 characters
  ; It's 257 characters. To be precise: NTFS itself does impose a maximum filename-length of several thousand characters (around 30'000 something). However, Windows imposes a 260 maximum length for the Path+Filename. The drive+folder takes up at least 3 characters, so you end up with 257.
	ActionListNEW := subStr( ActionListNEW ,1, 99)
  ; http://stackoverflow.com/questions/265769/maximum-filename-length-in-ntfs-windows-xp-and-windows-vista
	
	return ActionListNEW
} ; EndOf getActionListNEW173129simplify

ToolTipSlowMotion(ActionListNEW, LineNumber){
	global isSlowMotion
	if(!isSlowMotion)
		return
	ToolTip,%ActionListNEW% `n  '%LineNumber%' = LineNumber  `n (line:%A_LineNumber%) `n
	Sleep,500
}

; Clipboard := ActionListNEW ;  we dont transport usually inside this global file via clipboard 06.03.2017 19:41
;  MsgBox,  '%ActionListNEW%' = ActionListNEW  `n  17-03-06_18-48 `n `n ( line: %A_LineNumber%)
if(A_ScriptName == "ActionListNameFilter.inc.ahk" ) {  ; thats developer mode. this script is not includet. 08.03.2017 09:14
; Clipboard := ActionListNEW ;  we dont transport usually inside this global file via clipboard 06.03.2017 19:41
	MsgBox,4, %ActionListNEW%, '%ActionListNEW%' = ActionListNEW  `n '%ActionListDir%' = ActionListDir `n  `n %ActiveClass% = ActiveClass `n  17-03-06_18-48 `n `n ( line: %A_LineNumber%), 50
 ;MsgBox,4 ,Titel, 5Sek (from: %A_LineFile%~%A_LineNumber%), 5
}




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

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into here... i want first to activate the superglobal 10.08.2017 09:29
if( SubStr( ActionListNEW , -3 ) <> ".ahk" ) ; 06.03.2018 13:09
	ActionListNEW .= ".ahk"

maybeSuperglobalActionList(ActionListNEW, ActionListNEW_time_between , ActiveClass, activeTitle := "" ){
	if( SubStr( ActionListNEW , -3 ) <> ".ahk" ) ; 06.03.2018 13:09
		ActionListNEW .= ".ahk"
     if(ActionListNEW <> ActionListNEW_time_between)
          return, % ActionListNEW
	ActionListNEWAddress := "..\ActionLists\" . ActiveClass . "\" . ActionListNEW
     if(FileExist(ActionListNEWAddress)){
          return, % ActionListNEW
	}
	
	RegRead, CreatedDir, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, CreatedDir
	
	ActionList_isNotAProject_withoutExt  := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\ActionLists\_globalActionListsGenerated\isNotAProject" )
	if(!CreatedDir){
		if(false){
			clipboard := ActionListNEWAddress " (18-12-26_11-07)"
			tooltip,% ActionListNEWAddress " uiuiuiuiuiuiu"
			Pause,On
		}
		return, % ActionList_isNotAProject_withoutExt
	}
        ; return, % ActionListNEW
	
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_ScriptName, % A_ScriptName ; RegWrite , RegSave , Registry
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite ,
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite ,
	
     if(0 && !FileExist("..\ActionLists\" . ActiveClass . "\_create_own_project.flag")){
           ; tooltip,ActionListNEWAddress = %ActionListNEWAddress% `n `n (%A_LineFile%~%A_LineNumber%) )
           ; MsgBox,% "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ; happend 07.10.2018 10:33 18-10-07_10-33 inside notepad. dont knoow whey
          return, % "..\_globalActionListsGenerated\_global.ahk" ; ; i think it doesent makes since in some cases 13.05.2018 17:19
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



     FileDelete, % "..\ActionLists\" ActiveClass "\_create_own_project.flag"
	
; %activeTitle% <=== leider nicht verfügbar 18-12-29_18-04
	contend =
(
#Include ..\_globalActionLists\_global.ahk
#Include ..\%ActiveClass%\_global.ahk

; #Include ..\_globalActionLists\examplesForBeginners.ahk
___open window library |rr||ahk|openInEditor,%ActionListNEW%
; if this german au is readable your UTF8 is probalby correct: ä

)
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
	
	FileAppend,% "",   % "..\ActionLists\" . ActiveClass . "\_global.ahk"
	
	if( FileExist("..\ActionLists\" . ActiveClass . "\" . ActionListNEW) ){
		Msgbox,ups ActionListNEW = %ActionListNEW% exist already ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
		EXIT
	}
	if( !FileExist("..\ActionLists\" . ActiveClass . "\_global.ahk") ){
		Msgbox,ups ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
		EXIT
	}
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
	FileAppend,% contend,   % "..\ActionLists\" . ActiveClass . "\" . ActionListNEW
	if( !FileExist("..\ActionLists\" . ActiveClass . "\" . ActionListNEW) ){
		Msgbox,:-( ups !FileExist %ActionListNEW% ==> EXIT `n (%A_LineFile%~%A_LineNumber%) )
		EXIT
	}
     Sleep,100
     ; msgbox,%ActionListNEW% = ActionListNEW ,`%ActionListNEW`% = ActionListNEW 18-03-06_13-31 `n (%A_LineFile%~%A_LineNumber%)
	
     ; run,                    % "..\ActionLists\" . ActiveClass . "\" . ActionListNEW
     ; isInEditorSoon := openInEditor("..\ActionLists\" . ActiveClass, true, "run," ActionListNEW, true, true, true)
     ; openInEditor(ActionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib)
	; if(!isInEditorSoon)
    ; msgbox, ,please open your new ActionList by using __  `n (%A_LineFile%~%A_LineNumber%), 2
	
     return, % ActionListNEW
} ; ENDof: maybeSuperglobalActionList
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
; thats like a backup, bevore ... \className\ActionListNameFilter.inc.ahk will include this file :) and change ActionListNEW but reuse ActionListNEW_time_between  at  the end :)  12.08.2017 09:44
ActionListNEW_time_between := ActionListNEW
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; # Include ..\Source\inc_ahk\openInEditor_actionList.inc.ahk