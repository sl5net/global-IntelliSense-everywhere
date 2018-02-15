#NoTrayIcon
SetWorkingDir %A_ScriptDir%\Source

WinClose,Typing_Aid_everywhere_multi_clone.ahk  ahk_class AutoHotkey
WinKill,Typing_Aid_everywhere_multi_clone.ahk ahk_class AutoHotkey
WinClose,TypingAid.ahk ahk_class AutoHotkey
WinKill,TypingAid.ahk ahk_class AutoHotkey

run,TypingAid.ahk,%A_ScriptDir%\Source
Sleep,2000
run,Typing_Aid_everywhere_multi_clone.ahk,%A_ScriptDir%\Source

