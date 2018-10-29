#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

NewAHKScript("ObjRegisterActive", "SomeCode", "Lexikos")				; no license/terms of use --> "Maximum protection (set by the state)" applies
NewAHKScript("ObjRegisterActive", "SomeCode", "Lexikos", "WTFPL")		; WTFPL  --> "WTFPL" applies
return

NewAHKScript(Name, Code, Author, License="Maximum protection (set by the state)") {
	MsgBox,% Code
}

#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk

#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
