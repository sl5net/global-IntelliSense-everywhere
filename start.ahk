#NoTrayIcon
SetWorkingDir %A_ScriptDir%\Source

WinClose,%A_ScriptDir%\Source\Typing_Aid_everywhere_multi_clone.ahk
WinKill,%A_ScriptDir%\Source\Typing_Aid_everywhere_multi_clone.ahk
WinClose,%A_ScriptDir%\Source\TypingAid.ahk
WinKill,%A_ScriptDir%\Source\TypingAid.ahk

run,TypingAid.ahk,%A_ScriptDir%\Source
Sleep,2000
run,Typing_Aid_everywhere_multi_clone.ahk,%A_ScriptDir%\Source


