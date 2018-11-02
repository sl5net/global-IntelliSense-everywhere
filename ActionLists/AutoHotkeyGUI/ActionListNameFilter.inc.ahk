#SingleInstance, force
; dontDeleteThisPlaceholder
#Include .\..\ActionLists\AutoHotkeyGUI\..\ActionListNameFilter.inc.ahk ; global ActionList . pleas dont delete this line! 17-03-06_10-59
ActionListFilterPath = .\..\ActionLists\AutoHotkeyGUI\ActionListNameFilter.inc.ahk 
 ; (line:%A_LineNumber%) 


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
ActionListNEW_time_between := ActionListNEW
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; if you want you could use the follwong global variables fot calculating you new ActionListNEW : ActionListDir, ActionListNEW, ActiveClass, activeTitle
if (!ActionListNEW ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere-Nightly-Build\Source\inc_ahk\Typing_Aid_everywhere_multi_clone.inc.ahk~getAhkCodeInsideFile~969

    tooltip, ERROR ActionListDir is EMPTY 17-03-19_11-51
    exitapp
}
if (!ActionListDir ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere-Nightly-Build\Source\inc_ahk\Typing_Aid_everywhere_multi_clone.inc.ahk~getAhkCodeInsideFile~969

    tooltip, ERROR ActionListDir is EMPTY 17-03-19_11-52
    exitapp
}

; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
if(0 && !RegExMatch(trim(ActionListNEW),"\.ahk$")) ; dirty bug fix TODO: not pretty
    ActionListNEW .= ".ahk"
if( SubStr( ActionListNEW , -3 ) <> ".ahk" ) ; 06.03.2018 13:09
    ActionListNEW .= ".ahk"





; Clipboard := ActionListNEW    we dont need that anymore. becouse now we work without the clipboard 09.03.2017 21:21 isInternMsgTransportIsClipboard := false ; false. then using fileSystem: readfile, include copyfile
; Clipboard := ActionListNEW `n E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere-Nightly-Build\Source\inc_ahk\Typing_Aid_everywhere_multi_clone.inc.ahk~getAhkCodeInsideFile~969 `n we dont need that anymore. becouse now we work without the clipboard 09.03.2017 21:21 isInternMsgTransportIsClipboard := false ; false. then using fileSystem: readfile, include copyfile
; tooltip,%Clipboard% = Clipboard 123496854