A_Space|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Space|r|A_Space ;  This variable contains a single space character. See AutoTrim for details.
A_Tab|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Tab|r|A_Tab ;  This variable contains a single tab character. See AutoTrim for details.
A_Args|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Args|r|A_Args ;  A_WorkingDir	The script's current working directory, which is where files will be accessed by default. The final backslash is not included unless it is the root directory. Two examples: C:\ and C:\My Documents. Use SetWorkingDir to change the working directory.
A_ScriptDir|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ScriptDir|r|A_ScriptDir ;  The full path of the directory where the current script is located. The final backslash is omitted (even for root directories).
A_ScriptName|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ScriptName|r|A_ScriptName ;  The file name of the current script, without its path, e.g. MyScript.ahk.
A_ScriptFullPath|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ScriptFullPath|r|A_ScriptFullPath ;  The combination of the above two variables to give the complete file specification of the script, e.g. C:\My Documents\My Script.ahk
A_ScriptHwnd|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ScriptHwnd|r|A_ScriptHwnd ;  A_LineNumber	
A_LineFile|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_LineFile|r|A_LineFile ;  The full path and name of the file to which A_LineNumber belongs, which will be the same as A_ScriptFullPath unless the line belongs to one of a non-compiled script's #Include files.
A_ThisFunc|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ThisFunc|r|A_ThisFunc ;  A_ThisLabel
A_AhkVersion|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_AhkVersion|r|A_AhkVersion ;  In versions prior to 1.0.22, this variable is blank. Otherwise, it contains the version of AutoHotkey that is running the script, such as 1.0.22. In the case of a compiled script, the version that was originally used to compile it is reported. The formatting of the version number allows a script to check whether A_AhkVersion is greater than some minimum version number with > or >= as in this example: if A_AhkVersion >= 1.0.25.07.
A_AhkPath|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_AhkPath|r|A_AhkPath ;  A_IsUnicode	
Contains|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
Contains|r|Contains ;  1 if strings are Unicode (16-bit) and an empty string (which is considered false) if strings are ANSI (8-bit). The format of strings depends on the version of AutoHotkey.exe which is used to run the script, or if it is compiled, which bin file was used to compile it.
A_IsCompiled|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_IsCompiled|r|A_IsCompiled ;  Contains 1 if the script is running as a compiled EXE and an empty string (which is considered false) if it is not.
A_ExitReason|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ExitReason|r|A_ExitReason ;  The most recent reason the script was asked to terminate. This variable is blank unless the script has an OnExit subroutine and that subroutine is currently running or has been called at least once by an exit attempt. See OnExit for details.
A_YYYY|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_YYYY|r|A_YYYY ;  A_MM	Current 2-digit month (01-12). Synonymous with A_Mon.
A_DD|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_DD|r|A_DD ;  Current 2-digit day of the month (01-31). Synonymous with A_MDay.
A_MMMM|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_MMMM|r|A_MMMM ;  Current month's full name in the current user's language, e.g. July
A_MMM|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_MMM|r|A_MMM ;  Current month's abbreviation in the current user's language, e.g. Jul
A_DDDD|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_DDDD|r|A_DDDD ;  Current day of the week's full name in the current user's language, e.g. Sunday
A_DDD|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_DDD|r|A_DDD ;  Current day of the week's abbreviation in the current user's language, e.g. Sun
A_WDay|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_WDay|r|A_WDay ;  Current 1-digit day of the week (1-7). 1 is Sunday in all locales.
A_YDay|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_YDay|r|A_YDay ;  Current day of the year (1-366). The value is not zero-padded, e.g. 9 is retrieved, not 009. To retrieve a zero-padded value, use the following: FormatTime, OutputVar,, YDay0.
A_YWeek|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_YWeek|r|A_YWeek ;  Current year and week number (e.g. 200453) according to ISO 8601. To separate the year from the week, use StringLeft, Year, A_YWeek, 4 and StringRight, Week, A_YWeek, 2. Precise definition of A_YWeek: If the week containing January 1st has four or more days in the new year, it is considered week 1. Otherwise, it is the last week of the previous year, and the next week is week 1.
A_Hour|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Hour|r|A_Hour ;  Current 2-digit hour (00-23) in 24-hour time (for example, 17 is 5pm). To retrieve 12-hour time as well as an AM/PM indicator, follow this example: FormatTime, OutputVar, , h:mm:ss tt
A_Min|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Min|r|A_Min ;  A_Sec	Current 2-digit second (00-59).
A_MSec|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_MSec|r|A_MSec ;  Current 3-digit millisecond (000-999). To remove the leading zeros, follow this example: Milliseconds := A_MSec + 0.
A_Now|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Now|r|A_Now ;  A_NowUTC	The current Coordinated Universal Time (UTC) in YYYYMMDDHH24MISS format. UTC is essentially the same as Greenwich Mean Time (GMT).
A_TickCount|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_TickCount|r|A_TickCount ;  A_IsSuspended	Contains 1 if the script is suspended and 0 otherwise.
A_IsPaused|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_IsPaused|r|A_IsPaused ;  A_IsCritical
A_BatchLines|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_BatchLines|r|A_BatchLines ;  (synonymous with A_NumBatchLines) The current value as set by SetBatchLines. Examples: 200 or 10ms (depending on format).
A_ListLines|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ListLines|r|A_ListLines ;  A_TitleMatchMode	The current mode set by SetTitleMatchMode: 1, 2, 3, or RegEx.
A_TitleMatchModeSpeed|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_TitleMatchModeSpeed|r|A_TitleMatchModeSpeed ;  The current match speed (fast or slow) set by SetTitleMatchMode.
A_DetectHiddenWindows|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_DetectHiddenWindows|r|A_DetectHiddenWindows ;  The current mode (On or Off) set by DetectHiddenWindows.
A_DetectHiddenText|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_DetectHiddenText|r|A_DetectHiddenText ;  The current mode (On or Off) set by DetectHiddenText.
A_AutoTrim|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_AutoTrim|r|A_AutoTrim ;  The current mode (On or Off) set by AutoTrim.
A_StringCaseSense|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_StringCaseSense|r|A_StringCaseSense ;  The current mode (On, Off, or Locale) set by StringCaseSense.
A_FileEncoding|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_FileEncoding|r|A_FileEncoding ;  [v1.0.90+]: Contains the default encoding for various commands; see FileEncoding.
A_FormatInteger|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_FormatInteger|r|A_FormatInteger ;  The current integer format (H or D) set by SetFormat. [v1.0.90+]: This may also contain lower-case h.
A_FormatFloat|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_FormatFloat|r|A_FormatFloat ;  The current floating point number format set by SetFormat.
A_SendMode|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_SendMode|r|A_SendMode ;  [v1.1.23+]: The current mode (Event, Input, Play or InputThenPlay) set by SendMode.
A_SendLevel|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_SendLevel|r|A_SendLevel ;  [v1.1.23+]: The current SendLevel setting (an integer between 0 and 100, inclusive).
A_StoreCapsLockMode|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_StoreCapsLockMode|r|A_StoreCapsLockMode ;  [v1.1.23+]: The current mode (On or Off) set by SetStoreCapsLockMode.
A_KeyDelay|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_KeyDelay|r|A_KeyDelay ;  A_KeyDuration	The current delay or duration set by SetKeyDelay (always decimal, not hex). A_KeyDuration requires [v1.1.23+].
A_KeyDelayPlay|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_KeyDelayPlay|r|A_KeyDelayPlay ;  A_KeyDurationPlay	The current delay or duration set by SetKeyDelay for the SendPlay mode (always decimal, not hex). Requires [v1.1.23+].
A_WinDelay|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_WinDelay|r|A_WinDelay ;  The current delay set by SetWinDelay (always decimal, not hex).
A_ControlDelay|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ControlDelay|r|A_ControlDelay ;  The current delay set by SetControlDelay (always decimal, not hex).
A_MouseDelay|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_MouseDelay|r|A_MouseDelay ;  A_MouseDelayPlay	The current delay set by SetMouseDelay (always decimal, not hex). A_MouseDelay is for the traditional SendEvent mode, whereas A_MouseDelayPlay is for SendPlay. A_MouseDelayPlay requires [v1.1.23+].
A_DefaultMouseSpeed|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_DefaultMouseSpeed|r|A_DefaultMouseSpeed ;  The current speed set by SetDefaultMouseSpeed (always decimal, not hex).
A_CoordModeToolTip|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_CoordModeToolTip|r|A_CoordModeToolTip ;  A_CoordModePixel
A_CoordModeMouse|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_CoordModeMouse|r|A_CoordModeMouse ;  A_CoordModeCaret
A_CoordModeMenu|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_CoordModeMenu|r|A_CoordModeMenu ;  [v1.1.23+]: The current mode (Window, Client or Screen) set by CoordMode.
A_RegView|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_RegView|r|A_RegView ;  [v1.1.08+]: The current registry view as set by SetRegView.
A_IconHidden|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_IconHidden|r|A_IconHidden ;  Contains 1 if the tray icon is currently hidden or 0 otherwise. The icon can be hidden via #NoTrayIcon or the Menu command.
A_IconTip|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_IconTip|r|A_IconTip ;  Blank unless a custom tooltip for the tray icon has been specified via Menu, Tray, Tip -- in which case it's the text of the tip.
A_IconFile|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_IconFile|r|A_IconFile ;  Blank unless a custom tray icon has been specified via Menu, tray, icon -- in which case it's the full path and name of the icon's file.
A_IconNumber|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_IconNumber|r|A_IconNumber ;  Blank if A_IconFile is blank. Otherwise, it's the number of the icon in A_IconFile (typically 1).
A_TimeIdle|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_TimeIdle|r|A_TimeIdle ;  The number of milliseconds that have elapsed since the system last received keyboard, mouse, or other input. This is useful for determining whether the user is away. Physical input from the user as well as artificial input generated by any program or script (such as the Send or MouseMove commands) will reset this value back to zero. Since this value tends to increase by increments of 10, do not check whether it is equal to another value. Instead, check whether it is greater or less than another value. For example: IfGreater, A_TimeIdle, 600000, MsgBox, The last keyboard or mouse activity was at least 10 minutes ago.
A_TimeIdlePhysical|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_TimeIdlePhysical|r|A_TimeIdlePhysical ;  Similar to above but ignores artificial keystrokes and/or mouse clicks whenever the corresponding hook (keyboard or mouse) is installed; that is, it responds only to physical events. (This prevents simulated keystrokes and mouse clicks from falsely indicating that a user is present.) If neither hook is installed, this variable is equivalent to A_TimeIdle. If only one hook is installed, only its type of physical input affects A_TimeIdlePhysical (the other/non-installed hook's input, both physical and artificial, has no effect).
A_TimeIdleKeyboard|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_TimeIdleKeyboard|r|A_TimeIdleKeyboard ;  [v1.1.28+]	If the keyboard hook is installed, this is the number of milliseconds that have elapsed since the system last received physical keyboard input. Otherwise, this variable is equivalent to A_TimeIdle.
A_TimeIdleMouse|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_TimeIdleMouse|r|A_TimeIdleMouse ;  A_DefaultGui [v1.1.23+]	The name or number of the current thread's default GUI.
A_DefaultListView|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_DefaultListView|r|A_DefaultListView ;  [v1.1.23+]	The variable name or HWND of the ListView control upon which the ListView functions operate. If the default GUI lacks a ListView, this variable is blank.
A_DefaultTreeView|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_DefaultTreeView|r|A_DefaultTreeView ;  [v1.1.23+]	The variable name or HWND of the TreeView control upon which the TreeView functions operate. If the default GUI lacks a TreeView, this variable is blank.
A_Gui|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Gui|r|A_Gui ;  The name or number of the GUI that launched the current thread. This variable is blank unless a Gui control, menu bar item, or event such as GuiClose/GuiEscape launched the current thread.
A_GuiControl|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_GuiControl|r|A_GuiControl ;  The name of the variable associated with the GUI control that launched the current thread. If that control lacks an associated variable, A_GuiControl instead contains the first 63 characters of the control's text/caption (this is most often used to avoid giving each button a variable name). A_GuiControl is blank whenever: 1) A_Gui is blank; 2) a GUI menu bar item or event such as GuiClose/GuiEscape launched the current thread; 3) the control lacks an associated variable and has no caption; or 4) The control that originally launched the current thread no longer exists (perhaps due to Gui Destroy).
A_GuiWidth|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_GuiWidth|r|A_GuiWidth ;  A_GuiHeight	These contain the GUI window's width and height when referenced in a GuiSize subroutine. They apply to the window's client area, which is the area excluding title bar, menu bar, and borders. [v1.1.11+]: These values are affected by DPI scaling.
A_GuiX|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_GuiX|r|A_GuiX ;  A_GuiY	These contain the X and Y coordinates for GuiContextMenu and GuiDropFiles events. Coordinates are relative to the upper-left corner of the window. [v1.1.11+]: These values are affected by DPI scaling.
A_GuiEvent|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_GuiEvent|r|A_GuiEvent ;  or A_GuiControlEvent	
DoubleClick|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
DoubleClick:|r|DoubleClick: ;  The event was triggered by a double-click. Note: The first click of the click-pair will still cause a Normal event to be received first. In other words, the subroutine will be launched twice: once for the first click and again for the second.

RightClick|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
RightClick:|r|
RightClick|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
RightClick: ;  Occurs only for GuiContextMenu, ListViews, and TreeViews.
A_EventInfo|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_EventInfo|r|A_EventInfo ;  OnMessage()
RegisterCallback|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
RegisterCallback()|r|RegisterCallback() ;  A_GuiControl, 
A_GuiX|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_GuiX/Y,|r|A_GuiX/Y, ;  A_GuiEvent, 
A_EventInfo|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_EventInfo.|r|A_EventInfo. ;  A_ThisMenuItem	The name of the most recently selected custom menu item (blank if none).
A_ThisMenu|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ThisMenu|r|A_ThisMenu ;  The name of the menu from which A_ThisMenuItem was selected.
A_ThisMenuItemPos|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ThisMenuItemPos|r|A_ThisMenuItemPos ;  A_ThisHotkey	
A_ThisLabel|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ThisLabel|r|A_ThisLabel ;  A_PriorHotkey	Same as above except for the previous hotkey. It will be blank if none.
A_PriorKey|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_PriorKey|r|A_PriorKey ;  [v1.1.01+]: The name of the last key which was pressed prior to the most recent key-press or key-release, or blank if no applicable key-press can be found in the key history. All input generated by AutoHotkey scripts is excluded. For this variable to be of use, the keyboard or mouse hook must be installed and key history must be enabled.
A_TimeSinceThisHotkey|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_TimeSinceThisHotkey|r|A_TimeSinceThisHotkey ;  The number of milliseconds that have elapsed since A_ThisHotkey was pressed. It will be -1 whenever A_ThisHotkey is blank.
A_TimeSincePriorHotkey|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_TimeSincePriorHotkey|r|A_TimeSincePriorHotkey ;  The number of milliseconds that have elapsed since A_PriorHotkey was pressed. It will be -1 whenever A_PriorHotkey is blank.
A_EndChar|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_EndChar|r|A_EndChar ;  The ending character that was pressed by the user to trigger the most recent non-auto-replace hotstring. If no ending character was required (due to the * option), this variable will be blank.
ComSpec|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
ComSpec|r|ComSpec ;  [v1.0.43.08+]
A_ComSpec|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ComSpec|r|A_ComSpec ;  [v1.1.28+]	
A_Temp|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Temp|r|A_Temp ;  A_OSType	The type of operating system being run. Since AutoHotkey 1.1 only supports NT-based operating systems, this is always WIN32_NT. Older versions of AutoHotkey return WIN32_WINDOWS when run on Windows 95/98/ME.
A_OSVersion|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_OSVersion|r|A_OSVersion ;  A_Is64bitOS	[v1.1.08+]: Contains 1 (true) if the OS is 64-bit or 0 (false) if it is 32-bit.
A_PtrSize|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_PtrSize|r|A_PtrSize ;  [v1.0.90+]: Contains the size of a pointer, in bytes. This is either 4 (32-bit) or 8 (64-bit), depending on what type of executable (EXE) is running the script.
A_Language|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Language|r|A_Language ;  The system's default language, which is one of these 4-digit codes.
A_ComputerName|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ComputerName|r|A_ComputerName ;  The name of the computer as seen on the network.
A_UserName|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_UserName|r|A_UserName ;  The logon name of the user who launched this script.
A_WinDir|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_WinDir|r|A_WinDir ;  The Windows directory. For example: C:\Windows
A_ProgramFiles|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ProgramFiles|r|A_ProgramFiles ;  ProgramFiles	
A_AppData|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_AppData|r|A_AppData ;  A_AppDataCommon
A_Desktop|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Desktop|r|A_Desktop ;  A_DesktopCommon	
A_StartMenu|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_StartMenu|r|A_StartMenu ;  A_StartMenuCommon	
A_Programs|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Programs|r|A_Programs ;  A_ProgramsCommon	
A_Startup|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Startup|r|A_Startup ;  A_StartupCommon	
A_MyDocuments|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_MyDocuments|r|A_MyDocuments ;  A_IsAdmin	
A_ScreenWidth|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ScreenWidth|r|A_ScreenWidth ;  A_ScreenHeight
A_ScreenDPI|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_ScreenDPI|r|A_ScreenDPI ;  [v1.1.11+]	Number of pixels per logical inch along the screen width. In a system with multiple display monitors, this value is the same for all monitors. On most systems this is 96; it depends on the system's text size (DPI) setting. See also Gui -DPIScale.
A_IPAddress1|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_IPAddress1|r|A_IPAddress1 ;  through 4	The IP addresses of the first 4 network adapters in the computer.
A_Cursor|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Cursor|r|A_Cursor ;  A_CaretX
A_CaretY|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_CaretY|r|A_CaretY ;  Persistent
Clipboard|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
Clipboard|r|Clipboard ;  Read/write: The contents of the OS's clipboard, which can be read or written to. See the Clipboard section.
ClipboardAll|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
ClipboardAll|r|ClipboardAll ;  The entire contents of the clipboard (such as formatting and text). See ClipboardAll.
ErrorLevel|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
ErrorLevel|r|ErrorLevel ;  Read/write: See ErrorLevel.
A_LastError|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_LastError|r|A_LastError ;  The result from the OS's GetLastError() function or the last COM object invocation. For details, see DllCall() and Run/RunWait.
True|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
True|r|True ;  False	
A_Index|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_Index|r|A_Index ;  This is the number of the current loop iteration (a 64-bit integer). For example, the first time the script executes the body of a loop, this variable will contain the number 1. For details see Loop or While-loop.
A_LoopFileName|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_LoopFileName,|r|A_LoopFileName, ;  etc.	This and other related variables are valid only inside a file-loop.
A_LoopRegName|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_LoopRegName,|r|A_LoopRegName, ;  etc.	This and other related variables are valid only inside a registry-loop.
A_LoopReadLine|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_LoopReadLine|r|A_LoopReadLine ;  See file-reading loop.
A_LoopField|rr||ahk|clipboard:=key `n run,..\..\Source\plugins\ahk\QuickSearch4Autohotkey.ahk
A_LoopField|r|A_LoopField ;  See parsing loop.