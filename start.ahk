#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%\Source  ; Ensures a consistent starting directory.

run,Typing_Aid_everywhere_multi_clone.ahk,%A_ScriptDir%\Source
run,TypingAid.ahk,%A_ScriptDir%\Source

