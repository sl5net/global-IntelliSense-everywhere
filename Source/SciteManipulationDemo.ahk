; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#SingleInstance,force

SciTE_Output("hello :-)")  
SciTE_Output("1+1=" . 1+1,0,0)  
SciTE_Output("1+1=" . 1+1,0,1,1)  
return  
  
;https://autohotkey.com/boards/viewtopic.php?f=7&t=20397  
SciTE_Output(Text,Clear=1,LineBreak=1,Exit=0){  
SciObj := ComObjActive("SciTE4AHK.Application") ;get pointer to active SciTE window  
IfEqual,Clear,1,SendMessage,SciObj.Message(0x111,420) ;If clear=1 Clear output window  
IfEqual, LineBreak,1,SetEnv,Text,`r`n%text% ;If LineBreak=1 prepend text with `r`n  
SciObj.Output(Text) ;send text to SciTE output pane  
IfEqual, Exit,1,MsgBox, 36, Exit App?, Exit Application? ;If Exit=1 ask if want to exit application  
IfMsgBox,Yes, ExitApp ;If Msgbox=yes then Exit the appliciation  
}  



#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk

#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
