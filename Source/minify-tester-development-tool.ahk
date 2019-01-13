#SingleInstance,Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, ToolTip,Screen
while(1){
	update_configMinify_incAhkFile()
	; Sleep,1000
	configMinifyIncAhkAddress := "\config.minify.inc.ahk"
	configMinifyDIR := A_ScriptDir "\inc_ahk\minify\"
	configMinifyIncAhkAddress := configMinifyDIR configMinifyIncAhkAddress	
	FileRead, configContent , % configMinifyIncAhkAddress
	if(0 && A_index == 1)
		ToolTip, % configContent "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",500,1,19 
	FileGetTime, modifiedTime_configMinify, % configMinifyIncAhkAddress
	if(modifiedTime_configMinifyOLD <> modifiedTime_configMinify){
		ToolTip, % configContent "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",500,1,19 
		if(A_index > 1)
			reload
	}
	modifiedTime_configMinifyOLD := modifiedTime_configMinify
	Sleep,1000
}

~^s::
Reload
return

#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk ; A_ScriptDir
