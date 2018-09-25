; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#SingleInstance, force
; dontDeleteThisPlaceholder
; #Include .\..\ActionLists\_globalActionListsGenerated\ActionListNameFilter.inc.ahk ; global ActionList . pleas dont delete this line! 17-03-06_10-59
#Include .\..\ActionLists\ActionListNameFilter.inc.ahk ; global ActionList . pleas dont delete this line! 17-03-06_10-59
ActionListFilterPath := ".\..\ActionLists\_globalActionListsGenerated\ActionListNameFilter.inc.ahk"
 ; (line:%A_LineNumber%) 

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
ActionListNEW := maybeSuperglobalActionList(ActionListNEW, ActionListNEW_time_between , ActiveClass )
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; if you want you could use the follwong global variables fot calculating you new ActionListNEW : ActionListDir, ActionListNEW, ActiveClass, activeTitle
if (!ActionListNEW ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.ahk~getAhkCodeInsideFile~794

    MsgBox, ERROR ActionListNEW is EMPTY 17-03-05_14-51
    exitapp
}

if (!ActionListDir ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.ahk~getAhkCodeInsideFile~794

    MsgBox, ERROR ActionListDir is EMPTY 17-03-19_11-52
    exitapp
}
; Clipboard := ActionListNEW    we dont need that anymore. becouse now we work without the clipboard 09.03.2017 21:21 isInternMsgTransportIsClipboard := false ; false. then using fileSystem: readfile, include copyfile
