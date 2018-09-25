; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#Include *i init_global.init.inc.ahk
;~ GLOBAL_lllog_only_this_scriptName=ToolTipSec_RemoveToolTip.inc.ahk
RemoveToolTip(){
  gosub,RemoveToolTip
}
;~ l;~ ll
RemoveToolTip:
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ToolTip,
  SetTimer, RemoveToolTip, Off
  ;lll(A_LineNumber, "ToolTipSec_RemoveToolTip.inc.ahk",Last_A_This)
return
; lll(A_LineNumber, "ToolTipSec_RemoveToolTip.inc.ahk",Last_A_This)
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
; lll(A_LineNumber, "ToolTipSec_RemoveToolTip.inc.ahk",Last_A_This)
