; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
#SingleInstance, force
; dontDeleteThisPlaceholder
; #Include .\..\Wordlists\_globalWordListsGenerated\wordlistNameFilter.inc.ahk ; global wordlist . pleas dont delete this line! 17-03-06_10-59
#Include .\..\Wordlists\wordlistNameFilter.inc.ahk ; global wordlist . pleas dont delete this line! 17-03-06_10-59
wordlistFilterPath := ".\..\Wordlists\_globalWordListsGenerated\wordlistNameFilter.inc.ahk"
 ; (line:%A_LineNumber%) 

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
wordlistNEW := maybeSuperglobalWordList(wordlistNEW, wordlistNEW_time_between , ActiveClass )
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; if you want you could use the follwong global variables fot calculating you new wordlistNEW : wordlistDir, wordlistNEW, ActiveClass, activeTitle
if (!wordlistNEW ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.ahk~getAhkCodeInsideFile~794

    MsgBox, ERROR wordlistNEW is EMPTY 17-03-05_14-51
    exitapp
}

if (!wordlistDir ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.ahk~getAhkCodeInsideFile~794

    MsgBox, ERROR wordlistDir is EMPTY 17-03-19_11-52
    exitapp
}
; Clipboard := wordlistNEW    we dont need that anymore. becouse now we work without the clipboard 09.03.2017 21:21 isInternMsgTransportIsClipboard := false ; false. then using fileSystem: readfile, include copyfile
