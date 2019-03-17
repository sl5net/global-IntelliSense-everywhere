/* this file will be automatic precompiled before it is used by autohotkey 14.01.2019 12:09
*/
; recomandet for g_min_searchWord_length is: 1 or 2 maybe 0
; if u use 0 it maybe not work always at the moment (works if word match or if you have a fresh window change) (19-01-19_10-44)
; therfore its not recomandet to use 0
; please send your feedback to SL5net
; BTW its stored in regitry: RegRead, g_min_searchWord_length, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_min_searchWord_length

g_actionListDBfileAdress := A_ScriptDir "\actionListLearned.db"
g_actionListDBfileAdress := (InStr(A_ComputerName,"540P-SL5NET"))
	? "G:\fre\private\sql\sqlite\actionList.db" 
	: A_ScriptDir "\actionListLearned.db" 


g_min_searchWord_length := 0

g_config.listBoxGui := { 
	tipps: { 
		show: true,
		durationMilliseconds: 3500
	}
}

g_config.ScriptDir := A_ScriptDir
g_config.actionListDirBase := "..\actionLists" ; down from source upt to actionLists

; it takes the first existing editor, from the follwoing list.
; very first time it uses the smallest, most simpliest editor (notepad.exe not to be confused with notepad++.exe)
g_config.editor := [ 
	A_ProgramFiles "\Microsoft VS Code\Code.exe",
	 "C:\Program Files\Microsoft VS Code\Code.exe",
	 "C:\Program Files\Microsoft VS Code\bin\code.cmd",
	 "C:\Users\lauffer\AppData\Local\Programs\Microsoft VS Code\Code.exe",
	 A_ScriptDir "\..\AHK-Studio\AHK-Studio.ahk",
	 "C:\Program Files\Notepad++\notepad++.exe",
	 A_ScriptDir "\..\AutoGUI\AutoGUI.ahk"
]  ; above the list of the editors, which is gone through alphabetically up to the first find (fileAdress exists).

g_doAskBevoreChangingActionList := false ; <== buggy dont know whey 19.03.2018 23:50
g_doAskBevoreChangingActionList := true ; <== works preetty nice :) 19.03.2018 23:51
g_minBytesNeedetToAskBevoreChangingActionList := 812345 ; <== Minimum bytes. then will be asked before the change 20.03.2018 18:22
 
g_ListBoxFontSize := 16 ; works
g_ListBoxFontSize := 2 ; work but its so small i could not read 
g_ListBoxFontSize := 8 
g_FLAGmsgbox := false
g_doSound := false
; g_isListBoxDisabled := false ; toggeled by: ~ctrl::

; to#AllowSameLineComments#IfWinExist

g_min_MonitorBound_right := 70 ; used in: ForceWithinMonitorBounds
g_method := "Clipboard"
g_fontColor := "cGreen"
g_regExReplaceInVisibleLine := "^([\w\d_-]+).*" ; show only first text , numers _ or -  ; https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-24
g_regExReplaceInVisibleLine := "^([^|]+).*" ; the string only before the first "|"  ; https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-24
g_regExReplaceInVisibleLine := "^[_]*([^|\n]+)[^\.\n]*?([^|\n]{3,})$" ; https://autohotkey.com/boards/viewtopic.php?p=215425#p215425 https://regex101.com/r/GQjPg0/1
g_regExReplaceInVisibleLine := "^[_]*([^|\n]+)[^\.\n]*?([^|\n]{3,})?$" ; 18-06-10_09-34 https://autohotkey.com/boards/viewtopic.php?p=215425#p215425 https://regex101.com/r/GQjPg0/1 ; the string only before the first "|"


actionList_isNotAProject_withoutExt  := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\actionLists\_globalActionListsGenerated\isNotAProject" )
actionList_isNotAProject  := actionList_isNotAProject_withoutExt ".ahk"
;	tryThisEditorFirst: "AHKStudio",

g_config.Send := { RealisticDelayDynamic: false } ; RealisticDelayDynamic: 2
g_config.list := { 
	change: { stopRexExTitle: false } 
}
g_config.sql := {
	select: { 
		ignReg: "m)^((?!\bActionListID\b\s*[><=]).)*$" ,
		ignIfWhereIsWithoutListID : false,
		showFilePrefix : false 
	},
	DB_Browser: A_ProgramFiles " (x86)\DB Browser for SQLite\DB Browser for SQLite.exe"
} 
; showFilePrefix useful if you want find out which select data supplies

g_config.FuzzySearch := {
	enable: true,
	MAXlines : 87654, 
	keysMAXperEntry : 6,
	minKeysLen: 4,
	doValueCopy : false
}
g_config.sql.template := {
	dir: A_ScriptDir "\sql\template"
}

; you do not need these runners. these are just examples:
; C:\php731NTS>php.exe helloWorld.php
g_config.codeRunner := {
	code_AutoHotkey_Community: 
	A_ScriptDir "\..\actionLists\_globalActionLists\incDynAhk\AutoHotkey_Community\in_commandLine_send_modified_clipboard.ahk",
	helloCommandLine: A_ScriptDir "\plugins\ahk\helloCommandLine.ahk",
	everything: A_ProgramFiles "\_\Everything\Everything.exe",
	everythingEs: A_ProgramFiles "\_\Everything\ES\es.exe",
	javascript: "node",
	php731NTS: "C:\php731NTS\php.exe", 
	php: "C:\php\php.exe",
	python: "python",
	perl: "perl",
	ruby: "C:\Ruby23-x64\bin\ruby.exe",
	go: "go run",
	html: "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
	java: "cd $dir && javac $fileName && java $fileNameWithoutExt",
	c: "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
	kotlinc: A_ScriptDir "\..\actionLists\_kts\kotlinc\bin\kotlinc"
}



; difficult to implement symlink copy for not rr lines doValueCopy. todo: issue . doValueCopy : false  is not fully implemented
; g_config["sql"["select"]["ignIfWhereIsWithoutListID"]
; is matching some at the end: at the moment SQL Nr 6,7 and the magic selects later are without ListID 11.01.2019 23:05
; g_config["sql"["select"]["ignReg"] not implemented yet 19-01-11_21-39
; the regEx .^ never match anything. 
; the regEx . ignore all
; select: { ignReg: ".^" } 
; select: { ignReg: ".^" } 
; select: { ignReg: "m)^((?!\bActionListID\b\s*[><=]).)*$" ; <= try to ignore all selects without actioinList in where condition
 