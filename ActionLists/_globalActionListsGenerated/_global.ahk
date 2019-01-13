; #Include ..\_globalActionLists\examplesForBeginners.ahk

; !! importand: never delte this line or this file! with this line you are able to usa a special project configuaratioin 09.08.2017 20:07 17-08-09_20-07
___create own project dir or this 1|rr||ahk|run,..\..\Source\createOwnProjectDirOrThis.ahk
; if this german au is readable your UTF8 is probalby correct: ä

___info project dir|rr||ahk|WinGetClass,activeClass, A `n activeClass := RegExReplace( activeClass, "[\W_]+", "") `n d1 = %A_ScriptDir%\..\%activeClass% `n send, %d1%
; if this german au is readable your UTF8 is probalby correct: ä

; ___create own project dir or this|rr||ahk|WinGetClass,activeClass, A `n activeClass := RegExReplace( activeClass, "[\W_]+", "") `n d1 = %A_ScriptDir%\%activeClass% `n  FileCreateDir, %d1% `n run, %d1%

___global generated open|rr||ahk|openInEditor,..\_globalActionListsGenerated\_global.ahk
; if this german au is readable your UTF8 is probalby correct: ä

