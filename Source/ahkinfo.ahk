#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



info =
(
A_OSVersion||%A_OSVersion%
A_Is64bitOS||%A_Is64bitOS% ;  A_Is64bitOS	[v1.1.08+]: Contains 1 (true) if the OS is 64-bit or 0 (false) if it is 32-bit.
A_AhkVersion||%A_AhkVersion% ;  prior to 1.0.22, its blank
A_ComputerName||%A_ComputerName%



)
clipboard := info
ToolTip,% info
MsgBox,% info



resultsLog =
(
Win10 18-12-25_12-51:
A_OSVersion||WIN_8
A_Is64bitOS||1 ;  A_Is64bitOS	[v1.1.08+]: Contains 1 (true) if the OS is 64-bit or 0 (false) if it is 32-bit.
A_AhkVersion||1.1.30.01 ;  prior to 1.0.22, its blank



React 18-12-25_12-51:
A_OSVersion||WIN_2003
A_Is64bitOS||0 ;  A_Is64bitOS	[v1.1.08+]: Contains 1 (true) if the OS is 64-bit or 0 (false) if it is 32-bit.
A_AhkVersion||1.1.30.01 ;  prior to 1.0.22, its blank



)