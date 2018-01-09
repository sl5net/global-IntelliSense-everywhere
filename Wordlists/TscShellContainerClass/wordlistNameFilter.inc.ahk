#SingleInstance, force
; dontDeleteThisPlaceholder
#Include .\Wordlists\TscShellContainerClass\..\wordlistNameFilter.inc.ahk ; global wordlist . pleas dont delete this line! 17-03-06_10-59
wordlistFilterPath = .\Wordlists\TscShellContainerClass\wordlistNameFilter.inc.ahk 
 ; (line:%A_LineNumber%) 


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
wordlistNEW_time_between := wordlistNEW
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; if you want you could use the follwong global variables fot calculating you new wordlistNEW : wordlistDir, wordlistNEW, ActiveClass, activeTitle
if (!wordlistNEW ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.ahk~getAhkCodeInsideFile~801

    MsgBox, ERROR wordlistNEW is EMPTY 17-03-05_14-51
    exitapp
}

Microsoft_Visual_Basic_BAWVerwaltung_BAWODBC_Code.txt
wordlistNEW := RegExReplace(wordlistNEW,"Microsoft_Visual_Basic_", "VBA_") ; fehlerkorrektur. kommt selten aber manchmal vor 27.11.2017 08:40

if (instr(wordlistNEW,"Textfeld" ))
	wordlistNEW:="Textfeld_.txt"

if (instr(wordlistNEW,"Bezeichnungsfeld" ))
	wordlistNEW:="Bezeichnungsfeld.txt"





if (!wordlistDir ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.ahk~getAhkCodeInsideFile~801

    MsgBox, ERROR wordlistDir is EMPTY 17-03-19_11-52
    exitapp
}

; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
wordlistNEW := maybeSuperglobalWordList(wordlistNEW, wordlistNEW_time_between , ActiveClass, activeTitle )



; Clipboard := wordlistNEW    we dont need that anymore. becouse now we work without the clipboard 09.03.2017 21:21 isInternMsgTransportIsClipboard := false ; false. then using fileSystem: readfile, include copyfile