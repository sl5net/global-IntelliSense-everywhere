/* this file will be automatic precompiled before it is used by autohotkey 14.01.2019 12:09
*/
g_config.ScriptDir := A_ScriptDir
g_config.editor := { 
	1 : A_ProgramFiles "\Microsoft VS Code\Code.exe",
	2 : "C:\Program Files\Microsoft VS Code\Code.exe",
	3 : "C:\Program Files\Microsoft VS Code\bin\code.cmd",
	4 : "C:\Users\lauffer\AppData\Local\Programs\Microsoft VS Code\Code.exe",
	5 : A_ScriptDir "\..\AHK-Studio\AHK-Studio.ahk",
	6 : "C:\Program Files\Notepad++\notepad++.exe",
	7 : A_ScriptDir "\..\AutoGUI\AutoGUI.ahk"
} ; above the list of the editors, which is gone through alphabetically up to the first find (fileAdress exists).

;RegRead, g_min_searchWord_length, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_min_searchWord_length
g_min_searchWord_length := 1

g_doAskBevoreChangingActionList := false ; <== buggy dont know whey 19.03.2018 23:50
g_doAskBevoreChangingActionList := true ; <== works preetty nice :) 19.03.2018 23:51
g_minBytesNeedetToAskBevoreChangingActionList := 812345 ; <== Minimum bytes. then will be asked before the change 20.03.2018 18:22
 
g_ListBoxFontSize := 16 ; works
g_ListBoxFontSize := 2 ; work but its so small i could not read 
g_ListBoxFontSize := 8 
g_FLAGmsgbox := false
g_doSound := true
; g_isListBoxDisabled := false ; toggeled by: ~ctrl::
 
g_config.listBoxGui := { 
	tipps: { 
		show: true,
		durationMilliseconds: 3000
	}
}

g_min_MonitorBound_right := 70 ; used in: ForceWithinMonitorBounds
g_method := "Clipboard"
g_fontColor := "cGreen"
g_regExReplaceInVisibleLine := "^([\w\d_-]+).*" ; show only first text , numers _ or -  ; https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-24
g_regExReplaceInVisibleLine := "^([^|]+).*" ; the string only before the first "|"  ; https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-24
g_regExReplaceInVisibleLine := "^[_]*([^|\n]+)[^\.\n]*?([^|\n]{3,})$" ; https://autohotkey.com/boards/viewtopic.php?p=215425#p215425 https://regex101.com/r/GQjPg0/1
g_regExReplaceInVisibleLine := "^[_]*([^|\n]+)[^\.\n]*?([^|\n]{3,})?$" ; 18-06-10_09-34 https://autohotkey.com/boards/viewtopic.php?p=215425#p215425 https://regex101.com/r/GQjPg0/1 ; the string only before the first "|"
g_actionListDBfileAdress := A_ScriptDir "\actionListLearned.db"
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
	DB_Browser: "C:\Program Files (x86)\DB Browser for SQLite\DB Browser for SQLite.exe"
} ; showFilePrefix useful if you want find out which select data supplies
g_config.FuzzySearch := {
	enable: true,
	MAXlines : 87654, 
	keysMAXperEntry : 6,
	minKeysLen: 4,
	doValueCopy : false
}

; follwing is not yet implemented:
g_config.codeRunner.executorMap := {
        javascript: "node",
        php: "C:\php\php.exe",
        python: "python",
        perl: "perl",
        ruby: "C:\Ruby23-x64\bin\ruby.exe",
        go: "go run",
        html: "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
        java: "cd $dir && javac $fileName && java $fileNameWithoutExt",
        c: "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
		kotlinc: A_ScriptDir "\..\ActionLists\_kts\kotlinc\bin\kotlinc"
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
 