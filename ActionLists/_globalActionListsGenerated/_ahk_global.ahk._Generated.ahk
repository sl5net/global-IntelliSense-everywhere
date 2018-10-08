
chat:|r|https://autohotkey.com/boards/viewtopic.php?f=5&t=59
Server IRQ: chat.freenode.net
Port IRQ: 6667 (6697 for SSL)
Channel IRQ: #ahk

ActionLists
Source

MsgBox lineFileName|rr|MsgBox,% ":( ERROR: " msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"|ahk|Send,{CtrlDown}{left 14}{CtrlUp}
ToolTip2sec lineFileName|rr|ToolTip2sec(msg " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip2sec lineFileName|rr|ToolTip2sec(msg " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip4sec lineFileName|rr|ToolTip4sec(msg " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip5sec lineFileName|rr|ToolTip5sec(msg " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}

MsgBox|rr|MsgBox, %msg% (%A_LineFile%~%A_LineNumber%)|ahk|Send,{shift down}{left 33}{shift up}
ToolTip2sec|rr|ToolTip2sec(msg " (" A_LineNumber " " A_LineFile " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip2sec|rr|ToolTip2sec(msg " (" A_LineNumber " " A_LineFile " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip4sec|rr|ToolTip4sec(msg " (" A_LineNumber " " A_LineFile " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip5sec|rr|ToolTip5sec(msg " (" A_LineNumber " " A_LineFile " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTipSec(t,x=123,y=321,sec=1000)
Tooltip, `n (from: %A_LineFile%~%A_LineNumber%)

lineFileName := RegExReplace(A_LineFile,".*\\")


ToolTipSec(t,x=123,y=321,sec=1000)
Tooltip, `n (from: %A_LineFile%~%A_LineNumber%)

#include,testInclude.ahk | i)^[ae]+
#include,testInclude.ahk ! i)^[abcdefg]+

___generated open|rr||ahk|run,..\_globalActionListsGenerated\_ahk_global.ahk.Generated.ahk
; if this german au is readable your UTF8 is probalby correct: ?

regEx find AHK functios definitions|r|^[ ]*?\w[\w\d_]{5,}\s*\([^()+<>]+\)[\s\S]{0,5}?\{


Trim(String)
LTrim(String)
RTrim(String)


FileAppend, Text, Filename, Encoding|rr|FileAppend, |ahk|m=Text, Filename, Encoding`n ll:=strlen(m)+1 `n lr:=4 `n send, %m% {left %ll%}{shift down}{right %lr%}{shift up}

; TypingAid-master\Source\TypingAid.ahk
FileAppend dynAhk|rr|; FileAppend .. HelloWorld2.ahk|ahk|FileAppend, msgbox`, HelloWorld (from: %A_LineFile%~%A_LineNumber%)``n , incDynAhk\HelloWorld2.ahk
AHKdyn Example run|rr||ahk|f=incDynAhk\HelloWorld3.ahk `n if(Fileexist(f)) `n run,%f%


timestamp yy:MM:dd HH:mm:ss|r|FormatTime, timestampyyMMddHHmmss, %A_now%,yy:MM:dd HH:mm:ss
timestamp dd.MM.yy HH:mm Uhr|r|FormatTime, ddMMyyHHmm, %A_now%,dd.MM.yy HH:mm Uhr; MsgBox,%ddMMyyHHmm% `n = ddMMyyHHmm (%A_LineFile%~%A_LineNumber%)
timestampyyMMddHHmmss|r|FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
timestampHHmmss|r|FormatTime, timestampHHmmss, %A_now%,HH:mm:ss

#IfWinActive
#IfWinExist
#include dos-fenster-abschiessen.ahk 
#InstallKeybdHook
#InstallMouseHook
#AllowSameLineComments
#ClipboardTimeout
#CommentFlag
#ErrorStdOut
#EscapeChar
#HotkeyInterval
#HotkeyModifierTimeout
#Hotstring
#KeyHistory
#MaxHotkeysPerInterval
#MaxMem
#MaxThreads
#MaxThreadsBuffer
#MaxThreadsPerHotkey
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases. 
#NoTrayIcon
#Persistent
#SingleInstance
#UseHook
#WinActivateForce
_Addref
_Clone
_Getaddress
_Getcapacity
_Haskey
_Insert
_Maxindex
_Minindex
_Newenum
_Release
_Remove
_Setcapacity

A_AhkVersion
A_AppData
A_AppDataCommon
A_AutoTrim
A_BatchLines
A_CaretX
A_CaretY
A_ComputerName
A_ControlDelay
A_Cursor
A_DDD
A_DDDD
A_DefaultMouseSpeed
A_Desktop
A_DesktopCommon
A_DetectHiddenText
A_DetectHiddenWindows
A_EndChar
A_EventInfo
A_ExitReason
A_FormatFloat
A_FormatInteger
A_Gui
A_GuiControl
A_GuiControlEvent
A_GuiEvent
A_GuiHeight
A_GuiWidth
A_GuiX
A_GuiY
A_Hour
A_IconFile
A_IconHidden
A_IconNumber
A_IconTip
A_Index
A_IPAddress1
A_IPAddress2
A_IPAddress3
A_IPAddress4
A_ISAdmin
A_IsCompiled
A_IsCritical
A_IsPaused
A_IsSuspended
A_KeyDelay
A_Language
A_LastError
A_LineFile
A_LineNumber
A_LoopIndex|r|A_Index
A_LoopField
A_LoopFileAttrib
A_LoopFileDir
A_LoopFileExt
A_LoopFileFullPath ; path and name of file/folder
A_LoopFileLongPath
A_LoopFileName
A_LoopFileShortName
A_LoopFileShortPath
A_LoopFileSize
A_LoopFileSizeKB
A_LoopFileSizeMB
A_LoopFileTimeAccessed
A_LoopFileTimeCreated
A_LoopFileTimeModified
A_LoopReadLine
A_LoopRegKey
A_LoopRegName
A_LoopRegSubkey
A_LoopRegTimeModified
A_LoopRegType
A_MDAY
A_Min
A_MMM
A_MMMM
A_Mon
A_MouseDelay
A_MSec
A_MyDocuments
A_Now
A_NowUTC
A_NumBatchLines
A_OSType
A_OSVersion
A_PriorHotkey
A_ProgramFiles
A_Programs
A_ProgramsCommon
A_ScreenHeight
A_ScreenWidth
A_ScriptDir
A_ScriptFullPath
A_LineFile
A_Sec
A_Space
A_StartMenu
A_StartMenuCommon
A_Startup
A_StartupCommon
A_StringCaseSense
A_Tab
A_Temp
A_ThisFunc
A_ThisHotkey



A_ThisLabel
A_ThisMenu
A_ThisMenuItem
A_ThisMenuItemPos
A_TickCount
A_TimeIdle
A_TimeIdlePhysical
A_TimeSincePriorHotkey
A_TimeSinceThisHotkey
A_TitleMatchModeSpeed
A_UserName
A_WDay
A_WinDelay
A_WinDir
A_WorkingDir
A_YDay
A_Year
A_YWeek
A_YYYY
%A_AhkVersion%
%A_AppData%
%A_AppDataCommon%
%A_AutoTrim%
%A_BatchLines%
%A_CaretX%
%A_CaretY%
%A_ComputerName%
%A_ControlDelay%
%A_Cursor%
%A_DD%
%A_DDD%
%A_DDDD%
%A_DefaultMouseSpeed%
%A_Desktop%
%A_DesktopCommon%
%A_DetectHiddenText%
%A_DetectHiddenWindows%
%A_EndChar%
%A_EventInfo%
%A_ExitReason%
%A_FormatFloat%
%A_FormatInteger%
%A_Gui%
%A_GuiControl%
%A_GuiControlEvent%
%A_GuiEvent%
%A_GuiHeight%
%A_GuiWidth%
%A_GuiX%
%A_GuiY%
%A_Hour%
%A_IconFile%
%A_IconHidden%
%A_IconNumber%
%A_IconTip%
%A_Index%
%A_IPAddress1%
%A_IPAddress2%
%A_IPAddress3%
%A_IPAddress4%
%A_ISAdmin%
%A_IsCompiled%
%A_IsCritical%
%A_IsPaused%
%A_IsSuspended%
%A_KeyDelay%
%A_Language%
%A_LastError%
%A_LineFile%
%A_LineNumber%
%A_LoopField%
%A_LoopFileAttrib%
%A_LoopFileDir%
%A_LoopFileExt%
%A_LoopFileFullPath%
%A_LoopFileLongPath%
%A_LoopFileName%
%A_LoopFileShortName%
%A_LoopFileShortPath%
%A_LoopFileSize%
%A_LoopFileSizeKB%
%A_LoopFileSizeMB%
%A_LoopFileTimeAccessed%
%A_LoopFileTimeCreated%
%A_LoopFileTimeModified%
%A_LoopReadLine%
%A_LoopRegKey%
%A_LoopRegName%
%A_LoopRegSubkey%
%A_LoopRegTimeModified%
%A_LoopRegType%
%A_MDAY%
%A_Min%
%A_MM%
%A_MMM%
%A_MMMM%
%A_Mon%
%A_MouseDelay%
%A_MSec%
%A_MyDocuments%
%A_Now%
%A_NowUTC%
%A_NumBatchLines%
%A_OSType%
%A_OSVersion%
%A_PriorHotkey%
%A_ProgramFiles%
%A_Programs%
%A_ProgramsCommon%
%A_ScreenHeight%
%A_ScreenWidth%
%A_ScriptDir%
%A_ScriptFullPath%
%A_LineFile%
%A_Sec%
%A_Space%
%A_StartMenu%
%A_StartMenuCommon%
%A_Startup%
%A_StartupCommon%
%A_StringCaseSense%
%A_Tab%
%A_Temp%
%A_ThisFunc%
%A_ThisHotkey%
%A_ThisLabel%
%A_ThisMenu%
%A_ThisMenuItem%
%A_ThisMenuItemPos%
%A_TickCount%
%A_TimeIdle%
%A_TimeIdlePhysical%
%A_TimeSincePriorHotkey%
%A_TimeSinceThisHotkey%
%A_TitleMatchMode%
%A_TitleMatchModeSpeed%
%A_UserName%
%A_WDay%
%A_WinDelay%
%A_WinDir%
%A_WorkingDir%
%A_YDay%
%A_Year%
%A_YWeek%
%A_YYYY%
Abort
ahk_class
ahk_group
ahk_id
ahk_pid
Alnum
Alpha
Altdown
AltSubmit
AltTab
AltTabAndMenu
AltTabMenu
AltTabMenuDismiss
Altup
AlwaysOnTop
Appskey
Array
MaxIndex()
AutoTrim, Off 
Background
BackgroundTrans
Backspace
Between
BitAnd
BitNot
BitOr
BitShiftLeft
BitShiftRight
BitXOr
Blind
BlockInput MouseMove 
border(win) { 
Bottom
break                      ; (will be a multiple of the buffer size, if the file is not smaller; trim if neccessary) 
Browser_back
Browser_favorites
Browser_forward
Browser_home
Browser_refresh
Browser_search
Browser_stop
Button
Buttons
ByRef
Cancel
Capacity
Capslock
caption(win) { 
Center
CharP
Check
Check3
Checkbox
Checked
CheckedGray
Choose Install Location 
ChooseString
Click  ; Click left mouse button at mouse cursor's current position. 
Clipboard
ClipboardAll
ClipWait 1, 1              ; restore clipboard if no data 
close TypingAid and 
Color
ComboBox
Comobjactive
Comobjarray
Comobjconnect
Comobjcreate
Comobjenwrap
ComObjError(false) 
Comobjflags
Comobjget
Comobjmissing
Comobjparameter
Comobjquery
Comobjtype
Comobjunwrap
Comobjvalue
ComSpec
contains(var, matchlist) { 
continue  ; Start a new iteration to move on to the next component type. 
Control, Choose, 1, SysListView321, %MainWnd% 
ControlClick , ,  ahk_class Notepad 
ControlFocus, Edit1 
ControlGet, ControlHwnd, Hwnd,, %ControlID%, ahk_id %WindowUniqueID% 
ControlGetFocus, ControlID, ahk_id %WindowUniqueID% 
ControlGetPos, ControlX, ControlY, ControlWidth, ControlHeight, %ControlID%, ahk_id %WindowUniqueID% 
ControlGetText, ControlText%A_Index%, %ControlID%, ahk_id %WindowUniqueID% 
ControlList
ControlMove,,,, iW,, ahk_id %htxtSearch% 
ControlSend,, !f{down}, %tFull% 
ControlSendRaw,ahk_pid 001D097A, TEST TEST TEST TEST 
ControlSetText, Edit1, 
CoordMode, Mouse, Screen 
Count(pdic) {      ; #entries 
Critical Off 
Ctrlbreak
Ctrldown
Ctrlup
DateTime
Default
delete ActionListLearned.db 
DeleteAll
Delimiter
Deref
Destroy
DetectHiddenText,On 
AHK_Window_Info_v1.7.ahk|ahk|lc:=41 `n Send, {shift down}{left %lc%}{shift up}
Digit
Disable
Disabled
DllCall(VTable(pdic,18), UInt,pdic, Int,nCompMode) ; Set compare mode 
Double-click a row to select that item and switch to it. 
DoubleP
Drive
DriveGet, list, list 
DrivespaceFree, free, %folder% 
DropDownList
Eject
Enable
Enabled
Endrepeat
Enter
EnvAdd, lcs, 1 
EnvDiv, capacity, 1024 ; umrechnen... 
Envget
Envmult
EnvSet, MyItemList, %MyItemList% %Title% 
EnvSub,difticks,%oldticks% 
Envupdate
error("No hh.", "$lostStars") 
ErrorLevel
escape( esc, l ) 
ExitApp 
ExStyle, Selected, CurrentCol, CurrentLine, LineCount, Choice, 
False
FileAppend, %ExportString%, %FileNameForExport% 
FileCopy, %monitoredfile%, %BackUpFolderSubDirectory%\%name_no_ext% %A_YYYY%_%A_MM%_%A_DD% %A_Hour%_%A_Min%.%ext%, 0 
FileCopyDir, %A_ScriptDir%\..\newuser, %A_MyDocuments%\AutoHotkey\SciTE, 1 
FileCreateDir, %BackUpFolderSubDirectory% 
FileCreateShortcut, %selectedfile%, %A_Scriptdir%\%sname%.lnk 
FileDelete, %FileNameForExport% 
FileDelete|rr|FileDelete,|ahk|m=C:\Temp-Dateien\*.tmp`n lm:=strlen(m)+1 `n send, %m% {left %lm%}`% {shift down}{right %lm%}{shift up}
FileEncoding, UTF-8 
FileExist(fileAddress) && !InStr(FileExist(fileAddress), "D") 
FileExist(fExist), "D"|rr| InStr(FileExist(fExist), "D")|ahk|lc:=30 `n Send, {shift down}{left %lc%}{shift up}
FileExist(wokingAbsDir_file1 ) 
FileExist(wokingAbsDir_file1 ) 
FileGetAttrib,attribs,%A_ScriptFullPath% 
FileGetShortcut, %A_Loopfilelongpath%, OutTarget, OutDir, OutArgs, OutDesc, OutIcon, OutIconNum, OutRunState 
FileGetSize,fSize, % A_LoopFileFullPath ; in bytes 
FileGetTime, sourceModifiedTime, %f%  ; Retrieves the modification time by default. 
Filegetversion
Fileinstall
FileMove,% wokingAbsDir_file1 , % wokingAbsDir . file2 
FileMoveDir,% wokingAbsDir_file1 , % wokingAbsDir . file2 
Fileopen
FileRead,LocalSettingsContent,% LocalSettingsAdr 
FileReadLine, line, %f%, %A_Index% 
Filerecycle
Filerecycleempty
Fileremovedir
FileSelectFile, SelectedFile, S18, %StartFolder%, Select file for %Text%, Text file (*.ahk) 
FileSelectFolder, SelectedFolder, , 3 
FileSetAttrib,-A,%A_ScriptFullPath% 
Filesettime
FileSystem
Flash
Float
FloatFast
FloatP
Floor
Focus
FormatTime, timestampCSVinsert , %A_now%,yyMMddHHmmss 
GetKeyState, LshiftState, Lshift, P 
Global hCurs 
Gosub, GetText 
Group
Groupactivate
GroupAdd, HiddenWindows, ahk_id %hwnd% 
GroupBox
Groupclose
Groupdeactivate
GuiControl, Choose, Tab1, %Tab1% 
GuiControlGet, Content, , %A_GuiControl% ;get controls content 
Hidden
Hideautoitwin
HKEY_CLASSES_ROOT
HKEY_CURRENT_CONFIG
HKEY_CURRENT_USER
HKEY_LOCAL_MACHINE
HKEY_USERS
HotKey, %HtkPauseAction%, PauseAction, On 
Hours
HScroll
IDLast
IfEqual, ExtChk, .exe 
IfExist, %A_ScriptDir%\%ListFile% 
ifGreater, pos, 0, {         ; pos > 0 counted from left 
IfGreaterOrEqual, A_Index, 25, Break 
IfInString,attribs,A 
ifLess pos, 0, { 
Iflessorequal
IfMsgBox,yes 
ifNotEqual, x,, tooltip,%text%, %x%, %y% 
IfNotExist, %IniFile% 
IfNotInString, new, %Needle% 
IfWinActive,Gehe zu ahk_class #32770 
IfWinExist, DragonPad 
IfWinNotActive, SQLServer2005 to SQLscript for SQLServer2000, , WinActivate, SQLServer2005 to SQLscript for SQLServer2000, 
IfWinNotExist, %t% 
Ignore
IL_Add(BildlisteID, "onlineico.ico") 
Il_create
Il_destroy
ImageSearch, XPos, YPos, 0, 0, A_ScreenWidth, A_ScreenHeight, %e_fre_private_HtmlD% 
IniDelete, %IniFile%, Handles, %hWnd% 
IniRead, PathList, %IniFile%, Settings, PathList, %A_MyDocuments%|%A_ProgramFiles% 
IniWrite, %A_Index%    , %IniFile%, Settings, SelectedRadList 
Input,key,M B C V I L1 T1,{BackSpace}{Space}{WheelDown}{WheelUp}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{F13}{F14}{F15}{F16}{F17}{F18}{F19}{F20}{F21}{F22}{F23}{F24}{ENTER}{ESCAPE}{TAB}{DELETE}{INSERT}{UP}{DOWN}{LEFT}{RIGHT}{HOME}{END}{PGUP}{PGDN}{CapsLock}{ScrollLock}{NumLock}{APPSKEY}{SLEEP}{Numpad0}{Numpad0}{Numpad1}{Numpad2}{Numpad3}{Numpad4}{Numpad5}{Numpad6}{Numpad7}{Numpad8}{Numpad9}{NumpadDot}{NumpadEnter}{NumpadMult}{NumpadDiv}{NumpadAdd}{NumpadSub}{NumpadDel}{NumpadIns}{NumpadClear}{NumpadUp}{NumpadDown}{NumpadLeft}{NumpadRight}{NumpadHome}{NumpadEnd}{NumpadPgUp}{NumpadPgDn}{BROWSER_BACK}{BROWSER_FORWARD}{BROWSER_REFRESH}{BROWSER_STOP}{BROWSER_SEARCH}{BROWSER_FAVORITES}{BROWSER_HOME}{VOLUME_MUTE}{VOLUME_DOWN}{VOLUME_UP}{MEDIA_NEXT}{MEDIA_PREV}{MEDIA_STOP}{MEDIA_PLAY_PAUSE}{LAUNCH_MAIL}{LAUNCH_MEDIA}{LAUNCH_APP1}{LAUNCH_APP2}{PRINTSCREEN}{CTRLBREAK}{PAUSE} 
InputBox, UserInput, Click in Seconds, Please enter a Seconds to wait, , 640, 480,,,,%timeout%,%default1% 
Insert
Instr
Int64
Int64P
Integer
IntegerFast
Interrupt
Isfunc
Islabel
Isobject
Joy10
Joy11
Joy12
Joy13
Joy14
Joy15
Joy16
Joy17
Joy18
Joy19
Joy20
Joy21
Joy22
Joy23
Joy24
Joy25
Joy26
Joy27
Joy28
Joy29
Joy30
Joy31
Joy32
Joyaxes
Joybuttons
Joyinfo
Joyname
Joypov
Keyhistory
KeyWait, LButton, D T4 ; seconds 
Label
LastFound
Launch_app1
Launch_app2
Launch_mail
Launch_media
Lbutton
LControl|RControl|LShift|RShift|LAlt|RAlt|LWin|RWin" 
Lctrl
Limit
Listbox functions | 
Listhotkeys
ListLines, Off 
Listvars
ListView
local Content 
Logoff
Lower(string){ 
Lowercase
Lshift
LTrim
LV_Add("" 
LV_Delete()                                      ;clear controls 
Lv_deletecol
Lv_getcount
Lv_getnext
LV_GetText(Text, Row , A_Index) 
lv_insert(row+2, options) 
Lv_insertcol
LV_Modify(Row, "Col" . A_Index, CSV_Row%Row%_Col%A_Index%) 
LV_ModifyCol(1, 100) 
LV_SetImageList(ImageListID1) 
Lwindown
Lwinup
MainWindow
Margin
Maximize
MaximizeBox
Mbutton
Media_next
Media_play_pause
Media_prev
Media_stop
Minimize
MinimizeBox
MinMax
MinSize
Minutes
MonthCal
Mouse wheel over the taskbar scrolls the list - Middle button selects a window in this mode. 
MouseClick,left 
MouseClickDrag, Left, 0, 0, 40, 50, 20, R 
MouseGetPos, MouseScreenX, MouseScreenY, MouseWindowUID, MouseControlID 
MouseMove, %mX%, %mY% , 0 
abc|rr||ahk|Send, ``n  ```n 
rundIfNotExist(m_r , m_WinTitle = "",m_category="")|rr|rundIfNotExist(m_r , m_WinTitle = "",m_category="")|ahk|send,{shift down}{left 36}{shift up}}
MsgBox|rr|MsgBox,(`%A_LineFile`%~`%A_LineNumber`%)|ahk|Send,{shift down}{left 33}{shift up}
MsgBox,4 ,Titel, 5Sek (from: %A_LineFile%~%A_LineNumber%), 5
Multi
NoActivate
NoDefault
NoHide
NoIcon
NoMainWindow
NoStandard
NoTab
NoTimers
Number
Numget
Numlock
Numpad0|NumpadIns| 
Numpad1|NumpadEnd| 
Numpad2|NumpadDown| 
Numpad3|NumpadPgDn| 
Numpad4|NumpadLeft| 
Numpad5|NumpadClear| 
Numpad6|NumpadRight| 
Numpad7|NumpadHome| 
Numpad8|NumpadUp| 
Numpad9|NumpadPgUp| 
NumpadAdd|NumpadSub| 
Numpadclear
Numpaddel
NumpadDiv|NumpadMult| 
NumpadDot|NumpadDel| 
Numpaddown
Numpadend
NumpadEnter| 
Numpadhome
Numpadins
Numpadleft
Numpadmult
Numpadpgdn
Numpadpgup
Numpadright
Numpadsub
Numpadup
NumPut( "0x" . SubStr(Hex,2*A_Index-1,2), IconData, A_Index-1, "Char" ) 
Objaddref
Objclone
Object
Objgetaddress
Objgetcapacity
Objhaskey
Objinsert
Objmaxindex
Objminindex
Objnewenum
Objrelease
Objremove
Objsetcapacity
OnExit, ExitSub 
OnMessage(WM_MBUTTONDOWN, "ToggleOnTopGui1") 
Outputdebug
OwnDialogs
Owner
Parse
Password
Pause ;  ; 
Picture
Pixel
PixelGetColor, MouseColorRGB, %MouseScreenX%, %MouseScreenY%, RGB 
PixelSearch, Px, Py, %x1%,%y1%, %x2%,%y2%, 0x00BA7F, 3, Fast 
PostMessage, 0x111, 34338,,,ahk_class DgnBarMainWindowCls 
Printscreen
Priority
Process Name, Hidden, Title or Text, X, Y, Width, Height, Style, 
ProcessName
ProgramFiles
Progress, b h%A_ScreenHeight% w%with%, , , %spT1% 
Radio
Random,sleepRand,10,100 
Rbutton
Rcontrol
Rctrl
ReadOnly
Redraw
REG_BINARY
REG_DWORD
REG_DWORD_BIG_ENDIAN
REG_EXPAND_SZ
REG_FULL_RESOURCE_DESCRIPTOR
REG_LINK
REG_MULTI_SZ
REG_QWORD
REG_RESOURCE_LIST
REG_RESOURCE_REQUIREMENTS_LIST
REG_SZ
Regdelete
RegexMatch|r|foundPos := RegExMatch( "str" , "i)" )
RegexMatch|r|foundPos := RegExMatch(Haystack, regEx, matchs, StartingPosition)
RegexReplace|r|newStr := RegExReplace("abc", "i)")
Region
Registercallback
regread,editcommand,HKey_Classes_root,Autohotkeyscript\shell\edit\command 
Regwrite
Relative
Reload      ; Script wird neu geladen,neu ausgef?hrt 
Rename(pdic, "Result1", "Result3") 
Repeat
Resize
Restore
Retry
Return pdic 
Right
Round
Rshift
Rtrim
RunAs  ; Reset to normal behavior. 
RunWait, %comspec% /c %command%, , Hide 
Rwindown
Rwinup
Sb_seticon
sb_setParts( ( a_guiwidth/3 )*2, ( a_guiwidth/3 ) ) 
sb_setText("  " file, 1) 
Screen
ScrollLock|CapsLock|NumLock| 
Seconds
Section
SendEvent,{CtrlDown}{ShiftDown}a{ShiftUp}{CtrlUp} 
SendInput,{ENTER} 
SendMessage, 0xD, ControlTextSize, &ControlText,, ahk_id %ControlHWND%  ; 0xD is WM_GETTEXT. 
SendMode Input ; Recommended for new scripts due to its superior speed and reliability. 
sendPlay,%np% 
SendRaw,%content% 
Serial
SetBatchLines, -1 
SetCapsLockState, Off 
SetControlDelay,0 
SetDefaultMouseSpeed,0 
SetEnv,x1,%x% 
setformat,integer,hex 
SetKeyDelay, DelayMilliSec, PressDuration, Play ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
SetKeyDelay, 0, -1 ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
SetKeyDelay, 0, -1 ; -1 for no delay
SetLabel
SetMouseDelay, 0 
SetNumLockState, Off 
SetScrollLockState, Off 
SetStoreCapslockMode, off 
SetTimer, UpdateInfo, %CbbUpdateInterval% 
SetTitleMatchMode,regEx
SetWinDelay, 100
SetWorkingDir, %A_ScriptDir% 
Shift
ShiftAltTab
Shiftdown
Shiftup
Short
ShortP
Shutdown,4 
Single
Sleep,200 
Slider
SoundBeep,n ,200 ; high beep 
SoundGet, Setting,,, %CurrMixer% 
Soundgetwavevolume
SoundPlay, %A_WinDir%\Media\Windows Ding.wav 
SoundSet, +%vol_Step%, Wave 
Soundsetwavevolume
Space|AppsKey| 
SplashImage, DeskPinsSpeedMode.bmp, b W20 H20,,,%SplashImageTitle% 
SplashTextOff,Pls click Recorder 
SplashTextOn,,,Updated script, 
SplitPath, A_LineFile, , , , OutNameNoExt 
Standard
static   buffer_state, old_x, old_y, old_w, old_h 
Status
StatusBar
StatusBarGetText, StatusBarText, %A_Index%, ahk_id %WindowUniqueID% 
Statusbarwait
StatusCD
Strget
StringCaseSense, Off 
StringGetPos, posi , clipboard,Spenden Sie jetzt, R1 
StringLeft, Content, Content, 200 
StringLen, len, s 
StringLower,type,type,T 
StringMid, MouseColorR, MouseColorRGB, 3, 2 
StringReplace, Content, Content, x, neu, All  
StringRight, ExtChk, A_ScriptFullPath, 4 
StringSplit, Dim, CbbColorPickDim, x    ;prepare color picker dimensions 
StringTrimLeft, RecentList, RecentList, 1 
StringTrimRight, InfoString, InfoString, 1    ;remove last `n 
StringUpper, HEX, HEX 
Strlen
Strput
Style
Submit
SubStr( ActionListNEW , -3 ) <> ".ahk" `)|rr|SubStr( ActionListNEW , -3 ) <> ".ahk" `)|ahk|Send,{shift down}{left 30}{shift up}
Suspend,On 
Sysget, ScreenWidth, 78   ; get screen size from virtual screen 
SysMenu
TabStop
Theme
Thread,Interrupt,0,0 
ToggleCheck
ToggleEnable
Tooltip,(from: %A_LineFile%~%A_LineNumber%)|rr|Tooltip, |ahk|m =``n (from: `%A_LineFile`%~`%A_LineNumber`%) `n lm:=strlen(m)+1 `n send, %m% {left %lm%}{shift down}{right %lm%}{shift up}
ToolTip1sec(msg " (" A_LineNumber   " "   A_LineFile   " "   Last_A_This) |rr|ToolTip1sec|ahk|m =(A_LineNumber   " "   A_LineFile   " "   Last_A_This)`n ll:=strlen(m) `n lr:=strlen(m)-2 `n send, %m% {left %ll%}{shift down}{right %lr%}{shift up}
ToolTip2sec|rr|ToolTip2sec|ahk|m =(A_LineNumber   " "   A_LineFile   " "   Last_A_This)`n ll:=strlen(m) `n lr:=strlen(m)-2 `n send, %m% {left %ll%}{shift down}{right %lr%}{shift up}
ToolTip3sec|rr|ToolTip3sec|ahk|m =(A_LineNumber   " "   A_LineFile   " "   Last_A_This)`n ll:=strlen(m) `n lr:=strlen(m)-2 `n send, %m% {left %ll%}{shift down}{right %lr%}{shift up}
ToolTip4sec|rr|ToolTip4sec|ahk|m =(A_LineNumber   " "   A_LineFile   " "   Last_A_This)`n ll:=strlen(m) `n lr:=strlen(m)-2 `n send, %m% {left %ll%}{shift down}{right %lr%}{shift up}
ToolTip5sec|rr|ToolTip5sec|ahk|m =(A_LineNumber   " "   A_LineFile   " "   Last_A_This)`n ll:=strlen(m) `n lr:=strlen(m)-2 `n send, %m% {left %ll%}{shift down}{right %lr%}{shift up}
; ToolTip1sec(msg " (" A_LineNumber   " "   A_LineFile   " "   Last_A_This) ;
ToolWindow
Topmost
TransColor
Transform y, ASC, %x%   ; ASCII code of 1st char, 15 < y < 256 
Transparent
TrayTip, 
TreeView
Tv_add
tv_delete(item), tv_add(txt, p, h%x%) 
Tv_get
Tv_getchild
Tv_getcount
Tv_getnext
Tv_getparent
Tv_getprev
Tv_getselection
tv_getText(var, id) 
tv_modify(item, "select") 
UChar
UCharP
UInt64
UInt64P
UIntP
UnCheck
Unicode
Unlock
UpDown
Upper
Uppercase
Urldownloadtofile
UseErrorLevel
UShort
UShortP
UStrP
VarSetCapacity(CLSID, 16) 
Visible
Volume_down
Volume_mute
Volume_up
VScroll
WaitClose
WantReturn
Wheeldown
Wheelleft
Wheelright
WheelUp|WheelDown| 
while(1) 
WinActivate, %tFull% 
Winactivatebottom
Winactive
WinClose,%t%  ahk_class AutoHotkey|rr|WinClose,%t%  ahk_class AutoHotkey|ahk|lc:=48 `n Send, {shift down}{left %lc%}{shift up}
WinClose,keysEveryWhere.ahk ahk_class AutoHotkey
WinExist("ahk_id" lobbyStars()) 
WinGet, WindowUniqueID, ID, A 
WinGetActiveStats, at, Width, Height, X, Y 
Wingetactivetitle, ActiveTitle
WinGetClass, WindowClass, ahk_id %MouseWindowUID% 
WinGetPos, PosX, PosY, SizeW, SizeH, %WinNameGui1% 
WinGetText,WinText , %tc% 
WinGetTitle, WindowTitle, ahk_id %MouseWindowUID% 
WinHide, %titel% 
WinKill ; use the window found above 
WinMaximize,%t% 
WinMenuSelectItem,,, 5&, 17& 
WinMinimize, AVG  7.5 Update 
Winminimizeall
Winminimizeallundo
WinMove, %titel%,,%imgX%, %imgY% 
WinRestore, ahk_id %LV_winId% 
WinSet, TransColor, Black 
WinSetTitle, ahk_id %Gui1UniqueID%, , %CurrentTitle% 
WinShow, %titel% 
WinWait, Dokumentation_BBP.ard.de-Java.doc - Microsoft Word, Dokumentation_BBP.ar 
WinWaitActive,Gehe zu ahk_class #32770,,1 
WinWaitClose,%needle% 
WinWaitNotActive, SQLServer2005 to SQLscript for SQLServer2000, 
Xbutton1
Xbutton2
Xdigit
AutoTrim|r|AutoTrim, off 
BlockInput|r|BlockInput, on 
Break|r|Break 
Click|r|Click ; Klickt mit der linken Maustaste einmal auf die aktuelle Position des Mauszeigers. 
ComObjArray|r| arr := ComObjArray(VT_VARIANT:=12, 3) 
ComObjConnect|r|  ComObjConnect (ie, "IE_") 
ComObjCreate|r|ie :=  ComObjCreate ("InternetExplorer.Application") 
ComObjFlags|r| if ComObjFlags(arr) & 1 
ComObjGet|r| wmi :=  ComObjGet ("winmgmts:") 
ComObjQuery|r| if !(pci := ComObjQuery(obj, IID_IProvideClassInfo))
ComObjType|r| Variablentyp := ComObjType(d) ; Immer 9 bei script-aufrufbare Objekte. 
Continue|r| ; Bei den ersten 5 Durchl?ufen veranlasst der Continue-Befehl 
Control|r|Control, HideDropDown, , ComboBox1, Beliebiger Fenstertitel
ControlClick|r|ControlClick, OK, Beliebiger Fenstertitel ; Klickt den OK-Button
ControlFocus|r|ControlFocus, OK, Beliebiger Fenstertitel ; Setzt den Fokus auf den OK-Button
ControlGet|r|ControlGet, AusgabeVar, Line, 1, Edit1, Beliebiger Fenstertitel
ControlGetFocus|r|ControlGetFocus, AusgabeVar, Unbenannt - Editor
ControlGetPos|r| ControlGetPos, x, y, w, h, %BestimmtesSteuerelement%, ahk_id %BestimmtesFenster%
ControlGetText|r|ControlGetText, AusgabeVar, Edit1, Unbenannt -
ControlMove|r|SetTimer, ControlMoveTimer
ControlSend|r|ControlSend, Edit1, Das ist eine Textzeile im Editor-Fenster., Unbenannt
ControlSetText|r|ControlSetText, Edit1, Neuer Text, Unbenannt -
CoordMode|r|CoordMode, ToolTip, Screen ; Platziert ToolTips auf absolute Bildschirmkoordinaten:
Critical|r| Critical 
DetectHiddenText|r|DetectHiddenText, off
DetectHiddenWindows,On ; if this is off it does not find in tray 27.04.2017|rr|DetectHiddenWindows,On ; if this is off it does not find in tray 27.04.2017|ahk|lc:=52 `n Send, {shift down}{left %lc%}{shift up}
DetectHiddenWindows,Off; if this is off it does not find in tray 27.04.2017|rr|DetectHiddenWindows,Off; if this is off it does not find in tray 27.04.2017|ahk|lc:=52 `n Send, {shift down}{left %lc%}{shift up}




WelcherButton := DllCall("MessageBox", "Int", "0", "Str", "Ja oder Nein dr?cken", "Str", "Titel der Box", "Int", 4)
Drive|r|Drive, Label, D:, Backup-Laufwerk
DriveGet|r| DriveGet, Liste, list
DriveSpaceFree|r|DriveSpaceFree, FreeSpace, c:\
Edit|r|Edit ; Das Script wird zur Bearbeitung ge?ffnet.
Else|r|Else 
EnvAdd|r|EnvAdd, MeineZ?hlung, 2
EnvDiv|r|EnvDiv, MeineZ?hlung, 2 
EnvGet|r|EnvGet, AusgabeVar, LogonServer
EnvMult|r|EnvMult, MeineZ?hlung, 2 
EnvSet|r|EnvSet, AutGUI, Beliebiger Text f?r die Variable.
EnvSub|r|EnvSub, MeineZ?hlung, 2 
EnvUpdate|r|EnvUpdate
Exit|r|Exit MsgBox, Diese MsgBox wird aufgrund von EXIT nie erscheinen. 
ExitApp|r|#x::ExitApp ; Weise einen Hotkey zu, um diesen Script zu beenden.
FileAppend|r|FileAppend, Eine weitere Zeile.`n, C:\Meine Dokumente\Test.ahk
FileCopy|r|FileCopy, C:\Meine Dokumente\Liste1.ahk, D:\Backup\ ; Macht eine Kopie, aber beh?lt den originalen Namen.
FileCopyDir|r|FileCopyDir, C:\Mein Ordner, C:\Kopie von Mein Ordner
FileCreateDir|r|FileCreateDir, C:\Test1\Meine Bilder\Ordner2
FileCreateShortcut|r| FileCreateShortcut, Notepad.exe, %A_Desktop%\Meine Verkn?pfung.lnk, C:\, "%A_ScriptFullPath%", Meine Beschreibung, C:\Mein Icon.ico, i
FileDelete|r|FileDelete, C:\Temp-Dateien\*.tmp
FileGetAttrib|r|FileGetAttrib, AusgabeVar, C:\Neuer Ordner
FileGetShortcut|r| FileGetShortcut, %Datei%, Ziel, Verzeichnis, Parameter, Beschreibung, Icon, Iconnummer, Ausf?hrungsstatus
FileGetSize|r|FileGetSize, AusgabeVar, C:\Meine Dokumente\test.doc ; Ermittelt die Gr??e in Bytes.
FileGetTime|r|FileGetTime, AusgabeVar, C:\Meine Dokumente\test.doc ; Ermittelt standardm??ig das ?nderungsdatum.
FileGetVersion|r|FileGetVersion, version, C:\Meine Anwendung.exe
FileInstall|r|FileInstall, C:\Meine Dokumente\Meine Datei.ahk, %A_ProgramFiles%\Meine Anwendung\Readme.ahk, 1
FileMove|r|FileMove, C:\Meine Dokumente\Liste1.ahk, D:\Backup\ ; Verschiebt die Datei, ohne sie umzubenennen.
FileMoveDir|r|FileMoveDir, C:\Mein Ordner, D:\Mein Ordner ; Verschiebt den Ordner auf ein neues Laufwerk.
FileOpen|r| File := FileOpen(Dateiname, "w")
FileRead|r| FileRead, AusgabeVar, C:\Meine Dokumente\Meine Datei.ahk
FileReadLine|r| FileReadLine, Zeile, C:\Meine Dokumente\Kontaktliste.ahk, %A_Index%
FileRecycle|r|FileRecycle, C:\Temp-Dateien\*.tmp
FileRecycleEmpty|r|FileRecycleEmpty, C:\
FileRemoveDir|r|FileRemoveDir, C:\Download-Temp
FileSelectFile|r|FileSelectFile, Ausgew?hlteDatei, 3, , Datei ?ffnen, Text-Dokumente (*.ahk; *.doc)
FileSelectFolder|r|FileSelectFolder, AusgabeVar, , 3
FileSetAttrib|r|FileSetAttrib, +RH, C:\MeineDateien\*.*, 1 ; +RH ist identisch mit +R+H
FileSetTime|r| FileSetTime, , C:\temp\*.ahk
Finally|r|Finally
For|r| For k, v in Farben
Format|r| s .= Format("{2}, {1}!`r`n", "Welt", "Hallo")
FormatTime|r|FormatTime, Zeitstring
GetKeyState|r| GetKeyState, Status, RButton ; Rechte Maustaste.
Gosub|r|Gosub, Label1 
Goto|r|Goto, MeinLabel 
GroupActivate|r|GroupActivate, MeineGruppe, R
GroupAdd|r| GroupAdd, MSIE, ahk_class IEFrame ; F?gt nur den Internet Explorer zur Gruppe hinzu. 
GroupClose|r|GroupClose, MeineGruppe, R
GroupDeactivate|r|GroupDeactivate, MeineLieblingsfenster ; Besucht nicht-favorisierte Fenster zum Aufr?umen desktops.
Gui|r| Gui, +AlwaysOnTop +Disabled -SysMenu +Owner ; +Owner verhindert einen Button in der Taskleiste.
GuiControl|r|GuiControl,, MeineListBox, |Rot|Gr?n|Blau ; Ersetzt die aktuelle Liste mit einer neuen Liste.
GuiControlGet|r|GuiControlGet, MeinEdit 
Hotkey|r|Hotkey, ^!z, MeinLabel 
IfExist|r|IfExist, D:\
IfInString|r| IfInString, Heuhaufen, %Nadel% 
IfMsgBox|r| IfMsgBox, No 
ImageSearch|r|ImageSearch, XPos, YPos, 40,40, 300, 300, C:\Meine Bilder\test.bmp
IniDelete|r|IniDelete, C:\Temp\MeineDatei.ini, Sektion2, Key
IniRead|r|IniRead, AusgabeVar, C:\Temp\MeineDatei.ini, Sektion2, Key 
IniWrite|r|IniWrite, Das ist ein neuer Wert, C:\Temp\MeineDatei.ini, Sektion2, Key
Input|r| Input, Einzeltaste, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause} 
InputBox|r|InputBox, Passwort, Bitte Passwort eingeben, (Ihre Eingabe wird versteckt), hide 
KeyHistory|r|KeyHistory ; Zeigt den Tastenverlauf in einem Fenster an.
KeyWait|r| KeyWait, a ; Warten, bis die A-Taste losgelassen wird.
ListHotkeys|r|ListHotkeys
ListLines|r|ListLines
ListVars|r|ListVars
ListView|r| ; Erstellt die ListView und ihre Spalten:

Loop, Count
Loop, FilePattern [, IncludeFolders?, Recurse?]
Loop, Parse, InputVar [, Delimiters|CSV, OmitChars]
Loop, Read, InputFile [, OutputFile]
Loop, HKLM|HKU|HKCU|HKCR|HKCC [, Key, IncludeSubkeys?, Recurse?]

Loop|r|Loop, 3 
LoopFile|r| MsgBox, 4, , Dateiname = %A_LoopFileFullPath%`n`nWeiter? 
LoopReg|r| if a_LoopRegType = key 
Menu|r| Menu, Tray, Add ; Erstellt eine Trennlinie. 
MouseClick|r| MouseClick, left 
MouseClickDrag|r|MouseClickDrag, left, 0, 200, 600, 400 
MouseGetPos|r|MouseGetPos, xpos, ypos 
MouseMove|r| MouseMove, 200, 100
MsgBox|r|MsgBox Das ist der Einzelparametermodus. Kommas (,) m?ssen nicht mit einem Escapezeichen versehen werden.
ObjAddRef|r| ObjAddRef(ptr) 
OnExit|r| OnExit, ExitSub 
OnMessage|r| OnMessage(0x201, "WM_LBUTTONDOWN") 
OutputDebug|r|OutputDebug, %A_Now%: Das Fenster "%ZielFensterTitel%" nicht vorhanden war, wurde der Vorgang abgebrochen.
Pause|r|Pause::Pause ; Verbindet die Toggle-Funktion von Pause mit der PAUSE-Taste ... 
PixelSearch|r|PixelSearch, Px, Py, 200, 200, 300, 300, 0x9d6346, 3, Fast 
PostMessage|r| PostMessage, 0x50, 0, 0x4090409,, A ; 0x50 ist WM_INPUTLANGCHANGEREQUEST.
Process|r| Process, priority, %NeuePID%, High 
Progress|r|Progress, b w200, Mein Untertext, Mein Haupttext, Mein Titel 
Random|r|Random, rand, 1, 10 
RegDelete|r|RegDelete, HKEY_LOCAL_MACHINE, Software\BeliebigeAnwendung, Testwert
RegExMatch|r|Fundposition := RegExMatch("xxxabc123xyz", "abc.*xyz") ; Gibt 4 zur?ck, weil das die Position ist, auf der die ?bereinstimmung gefunden wurde. 
RegExReplace|r|NeuerStr := RegExReplace("abc123123", "123$", "xyz") ; Gibt "abc123xyz" zur?ck, weil durch $ eine ?bereinstimmung nur am Ende vorkommen darf. 
RegRead|r| RegRead, AusgabeVar, HKEY_LOCAL_MACHINE<span class="red">,  SOFTWARE\Microsoft\Windows\CurrentVersion, ProgramFilesDir 
RegWrite|r|RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\Testkey, MeinWertname, Testwert 
RegisterCallback|r| ; Aus Performance- und Speichergr?nden wird RegisterCallback() nur einmal f?r einen bestimmten Callback aufgerufen:
Reload|r|^!r::Reload ; Verwendet STRG+ALT+R als Hotkey zum Neustarten des Scripts.
Return|r|  Return  
Run|r|Run, Notepad.exe, C:\Meine Dokumente, max 
RunAs|r|RunAs, Administrator, MeinPasswort 
Send|r|Send Mit freundlichen Gr??en,{enter}John Smith ; Schreibt eine zweizeilige Signatur.
SendLevel|r|SendLevel 1
SendMode|r|SendMode Input 
SetBatchLines|r|SetBatchLines, 10ms 
SetControlDelay|r|SetControlDelay, 0
SetDefaultMouseSpeed|r|SetDefaultMouseSpeed, 0 ; Bewegt die Maus sofort.
SetFormat|r| SetFormat, float, 6.2 
SetKeyDelay|r|SetKeyDelay, 0
SetMouseDelay|r|SetMouseDelay, 0
SetRegView|r| SetRegView 32
SetStoreCapslockMode|r|SetStoreCapslockMode, off
SetTimer|r| SetTimer, MailWarnungenSchlie?en, 250
SetTitleMatchMode|r|SetTitleMatchMode 2 
SetWinDelay|r|SetWinDelay, 10
SetWorkingDir|r|SetWorkingDir %A_ScriptDir% 
Shutdown|r| Shutdown, 6
Sleep|r|Sleep, 1000 ; 1 Sekunde
Sort|r|  Sort  MeineVar, N D, ; Numerisch sortieren und Komma als Trennzeichen verwenden. 
SoundBeep|r|SoundBeep ; Abspielen der Standard-Tonh?he und -dauer. 
SoundGet|r|SoundGet, master_volume 
SoundGetWaveVolume|r|SoundGetWaveVolume, AusgabeVar 
SoundPlay|r|SoundPlay, %A_WinDir%\Media\ding.wav 
SoundSet|r| SoundSet, 50 ; Setzt die Gesamtlautst?rke auf 50% 
SoundSetWaveVolume|r|SoundSetWaveVolume, 50 ; Setzt auf halbe Lautst?rke. 
SplashTextOn|r|SplashTextOn, , , Zeigt nur die Titelleiste an. 
SplitPath|r| SplitPath, KompletterDateiname, Dateiname 
StatusBarGetText|r|StatusBarGetText, AbgerufenerText, 1, Suchergebnisse 
StatusBarWait|r|  StatusBarWait, gefunden, 30  
StringCaseSense|r|StringCaseSense Locale
StringGetPos|r| StringGetPos, Pos, Heuhaufen, %Nadel% 
StringLeft|r| StringLeft, AusgabeVar, String, 3 ; Speichert den String "Das" in AusgabeVar. 
StringLen|r| StringLen, L?nge, EingabeVar 
StringLower|r| StringLower, String2, String2 
StringMid|r| StringMid, Wort_das, Quelle, 7, 3 
StringReplace|r| StringReplace, Clipboard, Clipboard, `r`n, , All
StringSplit|r| StringSplit, wort_array, TestString, %A_Space%, . ; Punkte weglassen. 
StringTrimLeft|r| StringTrimLeft, AusgabeVar, String, 4 ; Speichert den String "ist ein Test." in AusgabeVar. 
Suspend|r|^!s::Suspend ; Weist einem Hotkey die Umschaltfunktion von Suspend zu.
SysGet|r| SysGet, Maustastenanzahl, 43
Thread|r|Thread, priority, 1 ; Setzt die Priorit?t des aktuellen Threads etwas h?her als normal.
Transform|r|Transform, AusgabeVar, Asc, A ; Ermittelt den ASCII-Code des Buchstaben A.
TrayTip|r|TrayTip, Mein Titel, Mehrzeiliger`nText, 20, 17
TreeView|r| ; Es erstellt und zeigt eine TreeView an, die alle Startmen?ordner von allen Benutzer enth?lt. Wenn der
Trim|r| MsgBox % "Ohne Trim:`t '" Text "'" 
Try|r|Try ; Beispiel #1: Das Grundkonzept von try/catch/throw. 
URLDownloadToFile|r|URLDownloadToFile, http://ahkscript.org/download/1.1/version.ahk, C:\Aktuellste AutoHotkey-Version.ahk
VarSetCapacity|r| VarSetCapacity(MeineVar, 10240000) ; ~10 MB 
While|r|While  GetKeyState("LButton") 
WinActivate|r| WinActivate ; zuletzt gefundenes Fenster verwenden 
WinActivateBottom|r| WinActivateBottom, - Microsoft Internet Explorer 
WinActive|r|UniqueID := WinActive("WinTitle", "WinText", "ExcludeTitle", "ExcludeText")
WinActive|r|IfWinActive, Unbenannt - Editor
WinClose|r| WinClose ; zuletzt gefundenes Fenster verwenden 
WinExist|r| IfWinExist, Unbenannt - Editor
WinGet|r| WinGet, AktiveID, ID, A
WinGetActiveStats|r|WinGetActiveStats, Titel, Breite, H?he, X, Y 
WinGetActiveTitle|r|WinGetActiveTitle, Titel 
WinGetClass|r|WinGetClass, Klasse, A 
WinGetPos|r|WinGetPos, X, Y, Breite, H?he, Rechner 
WinGetText|r| WinGetText, Text ; Das oben gefundene Fenster wird verwendet. 
WinGetTitle|r|WinGetTitle, Titel, A 
WinHide|r| WinHide ; verwendet das oben gefundene Fenster 
WinKill|r| WinKill ; verwendet das oben gefundene Fenster
WinMaximize|r| WinMaximize ; verwendet das zuletzt gefundene Fenster 
WinMenuSelectItem|r| WinMenuSelectItem, Unbenannt - Editor, , Datei, ?ffnen 
WinMinimize|r| WinMinimize ; verwendet das zuletzt gefundene Fenster 
WinMinimizeAll|r|WinMinimizeAll 
WinMove|r| WinMove, 0, 0 ; Verschiebt das gefundene Fenster von WinWait in die obere linke Ecke des Bildschirms. 
WinRestore|r|WinRestore, Unbenannt - Editor
WinSet|r|WinSet, Transparent, 200, Unbenannt - Editor ; Macht das Fenster ein wenig transparent. 
WinSetTitle|r|WinSetTitle, Unbenannt - Editor, , Ein neuer Titel 
WinShow|r| WinShow 
WinWait|r| WinWait, Unbenannt - Editor, , 3 
WinWaitActive|r| WinWaitActive, Unbenannt - Editor, , 2 
WinWaitClose|r| WinWaitClose ; Wartet, bis das gefundene Fenster von WinWait geschlossen wird. 
_ClipboardTimeout|r|_ClipboardTimeout 
_CommentFlag|r|_CommentFlag 
_ErrorStdOut|r|_ErrorStdOut 
_EscapeChar|r|_EscapeChar 
_HotkeyModifierTimeout|r|_HotkeyModifierTimeout 
_IfTimeout|r|_IfTimeout 
_InstallKeybdHook|r|_InstallKeybdHook 
_InstallMouseHook|r|_InstallMouseHook 
_MaxHotkeysPerInterval|r|_MaxHotkeysPerInterval 
_MaxMem|r|_MaxMem 
_MaxThreads|r|_MaxThreads 
_MaxThreadsPerHotkey|r|_MaxThreadsPerHotkey 
_NoTrayIcon|r|_NoTrayIcon 
_Persistent|r|_Persistent 
_WinActivateForce|r|_WinActivateForce 
; E:\fre\private\HtmlDevelop\AutoHotKey\foundFunctionsActionList.ahk
getLineNumberFromScite() 
backup(fpathFr, fpathTo, fname, tstamp, tstamp_pre) 
minus_1(x) 
debug(debug,text:="",mSec:=800) 
debug(debug,text="",mSec=800) 
backup(fpathFr, fpathTo, fname, tstamp) 
CreateDictionary(nCompMode = 0) 
CreateObject(ByRef CLSID, ByRef IID, CLSCTX = 5) 
Add(pdic, sKey, sItm) 
VTable(ppv, idx) 
GUID4String(Byref CLSID, sString) 
Get(pdic, sKey) 
AllocBString(ByRef Key, ByRef Var, sString) 
Ansi2Unicode(ByRef sString, ByRef wString, nLen = 0) 
Unicode2Ansi(ByRef wString, ByRef sString, nLen = 0) 
ExpandVars(Var) 
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) 
WM_ACTIVATE(wParam, lParam, msg, hwnd) 
ShowOnlyAPartInGui(Control, FullContent, Limit=200) 
DrawFrameAroundControl(ControlID, WindowUniqueID, frame_t) 
iif(expr, a, b="") 
ToggleOnTopGui1(wParam, lParam, msg, hwnd) 
ToolTip(Text, TimeOut=1000) 
HEXtoDEC(HEX) 
SelectFile(Control, OldFile, Text) 
CheckAHKVersion(AHK_version) 
GetAvailableFileName(ExportFileName) 
DeleteObject( p_object ) 
DeleteDC( p_dc ) 
CreateDrawHandles(UniqueID, ScreenWidth, ScreenHeight, frame_cc, frame_cw) 
BufferAndRestoreRegion( p_x, p_y, p_w, p_h ) 
DrawFrame( p_x, p_y, p_w, p_h, p_t, h_brush ) 
VA_IAudioClient_Initialize(this, ShareMode, StreamFlags, BufferDuration, Periodicity, Format, AudioSessionGuid) 
VA_IAudioClient_GetBufferSize(this, ByRef NumBufferFrames) 
VA_IAudioClient_GetStreamLatency(this, ByRef Latency) 
VA_IAudioClient_GetCurrentPadding(this, ByRef NumPaddingFrames) 
VA_IAudioClient_IsFormatSupported(this, ShareMode, Format, ByRef ClosestMatch) 
VA_IAudioClient_GetMixFormat(this, ByRef Format) 
VA_IAudioClient_GetDevicePeriod(this, ByRef DefaultDevicePeriod, ByRef MinimumDevicePeriod) 
VA_IAudioClient_Start(this) 
VA_IAudioClient_Stop(this) 
VA_IAudioClient_Reset(this) 
VA_IAudioClient_SetEventHandle(this, eventHandle) 
VA_IAudioClient_GetService(this, iid, ByRef Service) 
rundIfExist(m_r , m_WinTitle = "",m_category="") 
SchachImgON(imgX, imgY, titel ) 
SchachImgOFF(titel) 
check_mediawiki_installed(wokingAbsDir, EverythingExe) 
check_BLUESPICE_installed(wokingAbsDir,EverythingExe="") 
checkChange_localSettingsPHP(wokingAbsDir) 
rename_files(wokingAbsDir,EverythingExe="") 
openBlueSpice_installcheckPhp_in_webbroser(wokingRelDir) 
createIfNotExist_directoryListFile( sshExe, wokingAbsDir, directoryListFile) 
clone_from_directoryListFile( gitExe) 
phpIni_update(phpIni) 
SendSlow(s,ms) 
scramble( s, replacementCount, letter2NumberFlag ) 
letter2Number( ll ) 
randomLetters(ll, letter2NumberFlag ) 
SingleDoubleClickFinder(cKey) 
togglePauseResumeF9() 
pressPause() 
pressResume() 
togglePauseResume() 
isCamtasiaRecorderExist() 
isCamtasia_recording(cRdoIsRec) 
show_rectangle_by_mouseMove_animation(rArea) 
set2Pause(cRdoIsRec, toggleKey) 
set2Rec(cRdoIsPause, toggleKey) 
setToggle(wOld, toggleKey, doMouseRestore = true) 
setTrayIcon(color) 
getMousePos() 
isMouseInsideArea(r) 
get_Benutzerdefinierte_Auswahl(id) 
watchCursor_wait_for_Benutzerdefinierte_Auswahl() 
monitorDemo() 
debugCorrectWTitleNames() 
checkSoundMaximum(peakMeter) 
checkSoundMinimum(peakMeter) 
SetDefaultKeyDelay() 
MouseMove2(x,y) 
set2Rec(w, toggleKey) 
set2Pause(wOld, toggleKey) 
set2Rec(wOld, toggleKey) 
GetMonitor(hwnd := 0) 
watchCursorFunc() 
isRecordMonitorActive(monitor_ID_record) 
setToggle(wOld,toggleKey) 
setToggle(w,toggleKey) 
trayIconSet() 
mouseClick_deleteRecording(cRdoIsRec, cRall) 
mouseClick_camtasia(w, cRall, xP ) 
readme() 
CSV_TotalRows() 
CSV_TotalCols() 
CSV_Delimiter() 
CSV_FileName() 
CSV_Path() 
CSV_FileNamePath() 
CSV_Save(FileName, OverWrite="1") 
CSV_DeleteRow(RowNumber) 
CSV_AddRow(RowData) 
CSV_DeleteColumn(ColNumber) 
CSV_AddColumn(ColData) 
CSV_ModifyCell(Value, Row, Col) 
CSV_ModifyRow(Value, RowNumber) 
CSV_ModifyColumn(Value, ColNumber) 
CSV_Search(SearchText, Instance=1) 
CSV_SearchRow(SearchText, RowNumber, Instance=1) 
CSV_SearchColumn(SearchText, ColNumber, Instance=1) 
CSV_MatchCell(SearchText, Instance=1) 
CSV_MatchRow(SearchText, Instance=1) 
CSV_MatchCol(SearchText, Instance=1) 
CSV_ReadCell(Row, Col) 
CSV_ReadRow(RowNumber) 
CSV_ReadCol(ColNumber) 
CSV_LVLoad(Gui=1, x=10, y=10, w="", h="", header="", Sort=0, AutoAdjustCol=1) 
CSV_LVSave(FileName, Delimiter=",",OverWrite=1, Gui=1) 
CSV_Load(FileName, Delimiter="`,") 
csv_loadvar(Var, Delimiter="`,") 
LVtoCSV(Var, Delimiter=",",OverWrite=1, Gui=1) 
convert123To_NumPad123(t) 
setSearchAreaToChromeWindowArea(eBayChromeTitle) 
setCoordModeAll(coord = "Screen") 
parseWebsiteText(eBayChromeTitle) 
doAddArticleIDBiEtOMaticFunc( article ) 
doPasteArticleIDBiEtOMaticFunc( article, MultiMonitorXY ) 
closeHotkeyAHKscripts() 
reOpenClosedAHKscripts() 
setEuro2emptyEuroBietOmat(euro , bom) 
erweiterteSuche(erweiterteWucheTitle, article , mm) 
findLastNumberInDir(dir) 
WM_MOUSEMOVE(wParam,lParam) 
TOOLTIP(tooltip) 
CMDret_RunReturn(CMDin, Byref CMDout) 
InsertInteger(pInteger, ByRef pDest, pOffset = 0, pSize = 4) 
ExtractInteger(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4) 
verGetStdValue(byref fi, value) 
iif(expr, a, b) 
strLeft(s, n) 
strRight(s, n) 
switch(idx,val1="",val2="",val3="",val4="",val5="",val6="",val7="",val8="" 
          ,val9="",val10="",val11="",val12="",val13="",val14="",val15="",val16="") 
          ,val9="",val10="",val11="",val12="",val13="",val14="",val15="",val16="")
EncodeInteger( p_value, p_size, p_address, p_offset ) 
ReportError( p_condition, p_title, p_extra ) 
checkFileExt(extOK,fileAdress,fileLabel="fileAdress",showMessage=true) 
pastInCodeBlocks(fileAdress,target,ClipboardBackup) 
StrgAStrgA() 
DestroyDictionary(pdic) 
Set(pdic, sKey, sItm) 
Count(pdic) 
Exists(pdic, sKey) 
Rename(pdic, sKeyFr, sKeyTo) 
Remove(pdic, sKey) 
RemoveAll(pdic) 
GetCompareMode(pdic) 
HashVal(pdic,sKey) 
NextKey(ByRef penum, pdic="") 
QueryInterface(ppv, ByRef IID) 
AddRef(ppv) 
Release(ppv) 
QueryService(ppv, ByRef SID, ByRef IID) 
FindConnectionPoint(pdp, DIID) 
GetConnectionInterface(pcp) 
Advise(pcp, psink) 
Unadvise(pcp, nCookie) 
Enumerate(penum, ByRef Result) 
Invoke(pdisp, sName, arg1="vT_NoNe",arg2="vT_NoNe",arg3="vT_NoNe",arg4="vT_NoNe",arg5="vT_NoNe",arg6="vT_NoNe",arg7="vT_NoNe",arg8="vT_NoNe",arg9="vT_NoNe") 
Invoke_(pdisp, sName, type1="",arg1="",type2="",arg2="",type3="",arg3="",type4="",arg4="",type5="",arg5="",type6="",arg6="",type7="",arg7="",type8="",arg8="",type9="",arg9="") 
DispInterface(this, prm1="", prm2="", prm3="", prm4="", prm5="", prm6="", prm7="", prm8="") 
DispGetParam(pDispParams, Position = 0, vtType = 8) 
CreateIDispatch() 
GetDefaultInterface(pdisp, LCID = 0) 
GetDefaultEvents(pdisp, LCID = 0) 
GetGuidOfName(pdisp, Name, LCID = 0) 
GetTypeInfoOfGuid(pdisp, GUID, LCID = 0) 
ConnectObject(psource, prefix = "", DIID = "{00020400-0000-0000-C000-000000000046}") 
ActiveXObject(ProgID) 
GetObject(Moniker) 
GetActiveObject(ProgID) 
CLSID4ProgID(ByRef CLSID, ProgID) 
GUID4String(ByRef CLSID, String) 
ProgID4CLSID(pCLSID) 
String4GUID(pGUID) 
IsEqualGUID(pGUID1, pGUID2) 
CoCreateGuid() 
CoTaskMemAlloc(cb) 
CoTaskMemFree(pv) 
CoInitialize() 
CoUninitialize() 
OleInitialize() 
OleUninitialize() 
SysAllocString(sString) 
SysFreeString(bstr) 
SysStringLen(bstr) 
SafeArrayDestroy(psa) 
VariantClear(pvarg) 
AtlAxWinInit(Version = "") 
AtlAxWinTerm(Version = "") 
AtlAxGetControl(hWnd, Version = "") 
AtlAxAttachControl(pdsp, hWnd, Version = "") 
AtlAxCreateControl(hWnd, Name, Version = "") 
AtlAxCreateContainer(hWnd, l, t, w, h, Name = "", Version = "") 
AtlAxGetContainer(pdsp) 
Ansi4Unicode(pString, nSize = "") 
Unicode4Ansi(ByRef wString, sString, nSize = "") 
Ansi2Unicode(ByRef sString, ByRef wString, nSize = "") 
Unicode2Ansi(ByRef wString, ByRef sString, nSize = "") 
DecodeInteger(ref, nSize = 4) 
EncodeInteger(ref, val = 0, nSize = 4) 
ScriptControl(sCode, sLang = "", bExec = False, sName = "", pdisp = 0, bGlobal = False) 
wOpen(Wopen) 
contextHelp(HardDriveLetter) 
runContextHelpFile(fNameContextHelp, HardDriveLetter, ActiveClass, ActiveTitle) 
while(!clipboard && loopCounter < 100) 
copyLineOrWord2clipBoard(doSelectLine) 
addPrev0(t) 
createDir(dir) 
fileCreateDirS(dir,addSecondDir="") 
isFile(Path) 
isDir(Path) 
SetSystemCursor() 
RestoreCursors() 
setAlwaysOnTopOnLoop() 
setAlwaysOnTopOffLoop() 
setOriginalWinTitle(ActiveTitle) 
SplashImageOff() 
changLeftClickActionMode(iconAdress,modeValue) 
AlwaysOnTopAction(ActiveTitle) 
Dictionary() 
SetCompareMode(pdic, nCompMode = 1) 
Enumerate(pdic) 
HashVal(pdic, sKey) 
downloader4k(m_c) 
init_draw(c=1) 
exit_draw() 
paint_canvas(c=1) 
draw_dot(x, y, r=1, c=16) 
draw_line(x0, y0, x1, y1, w=1, c=16) 
draw_box(x0, y0, x1, y1, c=16) 
DynaRun(TempScript, pipename="") 
bieten(eBayChromeTitle, GebenSieIhrMaximalgebotEinPng, mm , euro ) 
clickVolstaendig(VollstaendigeBeschreibungAufrufenPng, mm) 
winActivateWithFeedback(eBayChromeTitle) 
bieten(googlTitle, GebenSieIhrMaximalgebotEinPng, mm , euro ) 
winActivateWithFeedback(googlTitle) 
setSearchAreaToChromeWindowArea(googlTitle) 
parseWebsiteText(googlTitle) 
setSearchAreaToChromeWindowArea(googlTitle, mm) 
parse_EbayChromeListVerkaufteArtikel(eBayChromeTitle, article ) 
erweiterteSuche(erweiterteSucheTitle, article , mm) 
holdEclipseStarted() 
holdEclipseActive() 
mayOpenURL(titleRTHalleKletterpartnerIn, urlRTHalleKletterpartnerIn) 
listMitglieder(mm, titleRTHalleKletterpartnerIn, mehrAnzeigenPNG, pngMITGLIEDERblau, PNGdir) 
checkDirExist(PNGdir) 
clickStandardSortierung(titleRTHalleKletterpartnerIn, pngStandardSortierung) 
everyMemberOnScreen(mm, pngBeigetreten, pngNachrichtSchreiben, titleRTHalleKletterpartnerIn, pngDuChatFuer, pngVerfasseEineNachricht , pngChatCloseXblueBeiAktivemCursor) 
writeMessage2member(pngNachrichtSchreiben, mm, titleRTHalleKletterpartnerIn, pngDuChatFuer, pngVerfasseEineNachricht, pngChatCloseXblueBeiAktivemCursor) 
getFirstNameFromChatWindow(titleRTHalleKletterpartnerIn) 
selftest() 
alertIfSecretIntoClipBoard() 
switch_MicrosoftWord_Fenster() 
HasVal2(haystack, needle) 
HasVal(haystack, needle) 
indexOf(Arr, needle, fromIndex:=1) 
DokumentFokusieren() 
open_SuchenErsetzen() 
ClipboardWaitChanged(firstClipboard) 
ToggleFullScreen(ByRef hWnd) 
forceWinActivate(t) 
killAllOpenWinWithoutSave(w) 
setSearchAreaToWinTitleArea(winTitle) 
clickAllHeartSymbols(mm, finya_Firefox, magIchPNG) 
click100Fragen(mm, finya_Firefox, i100PNG) 
PERSONENSUCHE(mm, finya_Firefox, sucheFirefoxPNG) 
click72reutlingenPersonFrage(finya_Firefox, r72ReutlingenPNG, mm) 
click72ReutlingenPerson(finya_Firefox, r72ReutlingenPNG, mm) 
saveProfil(pathHTM, finya_Firefox) 
openMagIchView(finya_Firefox, mm) 
setze_alle_instanzen(_x,_y) 
isInteger(var) 
changeAllIncludeDir_and_copy2dir(used_ahk,preFix,copy2dir) 
changeAllIncludeDir(f,preFix) 
rundIfNotExist(m_r , m_WinTitle = "",m_category="") 
winGetPos() 
WinActivateTry(wintit,tries) 
runCopyQ_Ctrl_Shift_v() 
file_put_contents(f, c, doOverwrite=1) 
sendStrgC(trycount = 10) 
ternaryOperator( bool , t = true, f = false) 
get_obj_ToString(obj) 
clipboardPaste(s) 
FuzzySearch(string1, string2) 
StringDifference(string1, string2, maxOffset=1) 
stringLower(s) 
isUrlAvailable(URL) 
lll(A_LineNumber, A_LineFile, text="")|rr|lll(A_LineNumber, A_LineFile, "")|ahk|Send,{left 2}
; lll(A_LineNumber, A_LineFile, msg)
lll(ln, sn, text="") 
file_put_contents(f, c, overwrite=true) 
SendStrgC(trycount) 
preParser(AScriptDir, AScriptName, AScriptFullPath) 
bToolTip(s) 
bMsgBox(s) 
bStringProzentNotation(s) 
bStringPunktNotation(s) 
tip(text, timeout="", x="", y="") 
tipEx(text, timeout="", x="", y="") 
error(error, function="") 
log(str) 
trayMenu(items, tip="", icon="") 
donate() 
donateNow() 
milli2hms(milli, ByRef hours=0, ByRef mins=0, ByRef secs=0, secPercision=0) 
exit() 
var(var) 
isIn(var, matchlist) 
contains(var, matchlist) 
inRect(x, y, w, h, px, py) 
web() 
joyExist() 
random(min, max, newSeed="") 
isBetween(var, lower, upper) 
isType(var, type) 
swap( byRef left, byRef right ) 
fontList() 
postLeftClick(x, y, win, activate=1) 
plc(x, y, table_id, activate=1) 
insertIntegerAtAddress(pInteger, pAddress, pOffset = 0, pSize = 4) 
psql(sql, database="", debug=0, host="", username="") 
rectOverlap(x1, y1, w1, h1, x2, y2, w2, h2) 
cs_captureCursor(hDC, nL, nT) 
cs_zoomer(hDC, mDC, hBM, nW, nH, znW, znH) 
cs_convert(sFileFr, sFileTo) 
decodeInteger(ptr) 
ansi2Unicode(ByRef sString, ByRef wString, nSize=0) 
unicode2Ansi(ByRef wString, ByRef sString, nSize=0) 
urlDownload2Var(URL, ByRef Result, UserAgent = "", Proxy = "", ProxyBypass = "") 
digitSearch(startX, startY, endX, endY, win, dir, ex="bmp", shades=100, options="") 
mouseGetX() 
mouseGetY() 
mouseGetWin() 
mgw() 
mouseGetCtrl() 
mgc() 
toggleCursor() 
setParent(win, gui) 
lv_getTxt(row, column=1) 
lv_isChecked(row) 
tv_getTxt(id) 
lv_walk(row, dir, options="") 
lv_walkDown(row, options="") 
lv_walkUp(row, options="") 
tv_walk(item, up=1, c=1) 
tv_collapseAll() 
freeGui() 
forceOS(x="", y="", title="", NA=0, offsetX=0, offsetY=0, useWorkArea=0, hide=0) 
setGuiPos(owner, x="",y="", hide=0) 
setOwner(options="") 
setFont(input, bgCtrl=1) 
mouseOver() 
addCustomFrame(iPaths, title="", toolwindow=0, resize=0, pIcon="") 
animateWin(hWnd,Duration,Flag) 
getGuiCtrlRect(byRef width, byRef height, ctrl, p1="", p2="", fontStr="") 
strRep(str,char,rep_char="",all=1) 
strMid(str, str1, str2) 
strLeft(str, count) 
strRight(str, count) 
trimWhiteSpace(str) 
tws(str) 
tabs2Spaces(str, n=2) 
exNum(str, start=0) 
strEnd(o, str) 
strUpper(str) 
strLower(str) 
varize(var, autofix = true) 
hexify(x) 
lines(c) 
regExEsc(str) 
listAdd( byRef list, item, del="," ) 
listGet(list, pos=1, del=",") 
listGetPos(list, item, del=",") 
listCut( byRef list, pos=1, del="," ) 
listDel( byRef list, pos=1, del="," ) 
listDelItem( byRef list, item, del=",") 
listRep( byRef list, itm1, itm2="", del="," ) 
listSwap( byRef list, pos1, pos2, del="," ) 
listSwapItems( byRef list, item1, item2, del="," ) 
min(list, del=",") 
max(list, del=",") 
ctrlGetTxt(ctrl, win="", mm=1) 
isVisCtrl(ctrl, win="", mm=1) 
isDisabledCtrl(ctrl, win="", mm=1) 
ctrlGetHwnd(ctrl, win="", mm=1) 
ctrlGetStyle(ctrl, win="", mm=1) 
ctrlGetExStyle(ctrl, win="", mm=1) 
isCheckedCtrl(ctrl, win="", mm=1) 
toggleCheckbox(ctrl, win="", mm=1) 
focusedCtrl() 
ctrlWaitVis(ctrl, win="", timeout="") 
ctrlClick(ctrl, win="", mm=1) 
ctrlCheck(ctrl, win="", mm=1) 
ctrlUncheck(ctrl, win="", mm=1) 
fileRead(file) 
fileReadLine(file, line) 
iniRead(file, section, key, def="") 
iniR(key, default=" ", section="prefs", ini="") 
iniW(key, section="prefs", ini="") 
fileSearch(file, dir="", ex="*") 
gradient(file, rgb1, rgb2="", vertical=1) 
bgr(rgb) 
pixelGetColor(x, y, options="") 
getPixelCount(x1, y1, x2, y2, color, options="") 
getPredominateColor(x1, y1, x2, y2, options="") 
bgr2rgb(c) 
winMinMax(id) 
winWaitStatic(win, int=1000, timeout="") 
frameAroundWin(win, c="red", t=10) 
isWinInTray(title) 
removeMinimizedTables(list) 
rmt(list) 
winGetTitle(win) 
windowFromPoint(x, y) 
border(win) 
caption(win) 
getClientRect(byRef x, byRef y="", byRef w="", byRef h="", hwnd="") 
hasWinMoved(win, sizeOnly=0) 
tableNav() 
lobbyStars() 
tablesStars() 
gameTypeStars(win) 
gts(win) 
bbStars(win) 
sbStars(win) 
isTourneyStars(win) 
xmaxStars(hh) 
namesStars(hh, all=0) 
stacksStars(hh) 
currStackStars(hh, player) 
rebuyStars(win, bb, fake=0) 
takeSeatStars(win, dir) 
getActionsStars(player, hh) 
trimHHStars(hh) 
player2seatStars(player, hh) 
seat2playerStars(seat, win) 
adj4prefSeatStars(hh) 
adjNamesStars(hh, names) 
heroStars() 
hhStars(win) 
hhFileStars(win) 
hasNewHHStars(win) 
postStarsClick(x, y, win) 
psc(x, y, win) 
toggleSitOutStars(studOnly=1) 
sitOutStars(win) 
sitInStars(win) 
isSittingOutStars(win) 
isCbChckdStars(x, y, win) 
isTableWaitingStars(win) 
relXStars(x, ww) 
rxs(x, ww) 
relYStars(y, wh) 
rys(y, wh) 
relWStars(w, ww) 
rws(w, ww) 
relHStars(h, wh) 
rhs(h, wh) 
hhDirStars() 
prefSeatStars(max) 
isInHandStars(win, seat) 
isHeroInHandStars(win) 
invokeIconStars(player, note, win) 
grabShowdownStars(hh) 
switchModStars(win, modPath) 
calcRakeStars(pot, bb, #players, NL=0) 
dataStars(pathStars_) 
tableDataStars(win) 
isTableWaitingFullTilt(win) 
isTableWaitingEuroBet(win) 
lobbyPrima() 
tablesPrima() 
lobbyInterPoker() 
tablesInterPoker() 
lobbyWillHill() 
tablesWillHill() 
inputbox(prompt="", options="", title="", default="", font="") 
fontPicker(font="face:default;size:8;bg:default;fg:000000", options="") 
colorPicker(hex="FFFFFF", owner="") 
cp_hex2rgb(hex, del=",") 
cp_rgb2hex(rgb, del=",") 
cp_gradientColorBand(rgb) 
getFunctList(c) 
getFunct(c, @l) 
getSub(c, @l) 
isOpeningBrace(l) 
isClosingBrace(l) 
escape(byRef esc, l) 
getLine(c, l#) 
dfcCreate(c) 
check_mediawiki_installed(wokingAbsDir) 
AHK_Hook( PID, State ) 
AHK_NotifyIcon( wParam, lParam ) 
CreateRightClickMenu() 
CreateLeftClickMenu() 
SetTrayIcon( Gui0=0 ) 
ScriptFullPath( hWnd ) 
IniReadSection( iniFile, Section ) 
IniGet( IniFile, Section, Key, def="", t=0 ) 
IniPut( Value, IniFile, Section, Key ) 
InitGlobalVars() 
HashStr(Str, L=4, nSz=0) 
FileGetVersionInfo( peFile="", StringFileInfo="" ) 
uHex( U=0, L=8 ) 
PathRemoveArgs( sPath ) 
PathRemoveBlanks( sPath ) 
PathUnquoteSpaces( sPath ) 
PathQuoteSpaces( sPath ) 
SetDebugPrivilege() 
ProcessOpen( PID, da=0x43a, ihnd=0 ) 
ProcessClose( Byref nProc ) 
ProcessGetOwner( nProc, PID=1 ) 
ProcessGetPriority( nProc, PID=1 ) 
ProcessGetModuleFileName( nProc, PID=1 ) 
ProcessGetCommandLine( nProc, PID=1 ) 
ProcessGetCreationTime( nProc, PID=1 ) 
writeTo_familie_maPa_Geschwister_mit_Partner_Enkel() 
writeTo_Geschwister() 
writeTo_GeschwisterAngepartnerte() 
writeTo_Ladies() 
writeTo_Brothers() 
writeTo_Sisters() 
writeTo_ParentsLaufferOhmenhausen() 
writeTo_ParentsKoenig() 
writeTo_ParentsReicheneck() 
writeTo_ChildrenKoenigs() 
writeTo_ChildrenOhmenhausen() 
writeTo_NichtenNeffen() 
sendTo_familie_ma_pa_geschwister_mit_partner_enkel() 
sendListOfEmails() 
sendOpenSeriesMail() 
killAllOpenSeriesMailWithoutSave() 
addClipboard2AllVerfassen(isFastModus) 
setEmailAnd(anText, mf, duSie) 
sendActiveEmail() 
findFirstNameInThunderbirdVerfassen(mf, duSie) 
duSieModifier(fullname,duSie) 
EnumWindowsProcHideAhk(hwnd, lParam) 
codeLetter(l,az,n9) 
keyPressed(k) 
compare() 
httpQuery(byref Result, lpszUrl, POSTDATA="", HEADERS="") 
Ready() 
rectangle(x1,y1,x2,y2) 
DoChangeIP(interface,IP,SubMask,Gateway) 
getNetworkDevices(dump) 
send_convert123To_NumPad123(t) 
exitBecouseOfErrorInLine(info) 
UriEncode(Uri) 
UriDecode(Uri) 
KeyState(Key, State) 
tp41fn(ComputerName, key1, key2) 
nPPcollapseLevel(level) 
GlestMousePosBackup() 
GlestMousePosBack() 
GlestMouseClick(x,y) 
walkThrowQuote(mc, quoteName) 
SpaceSendRawLetter_in_win(l,fc) 
openUrlInOpenFirefoxBrowser(url) 
setCaret2lastEditPosition() 
getInputBoxOnTop( title, prompt, timeout, default) 
copySelection2clipBoard() 
ctrl_alt_v() 
filePaste(i) 
GetTVPath() 
GetHandles() 
FindWindowExID(dlg, className, ctrlId) 
RemoteBuf_Open(p_handle, p_size) 
RemoteBuf_Close(p_bufHandle) 
RemoteBuf_Read(p_bufHandle, byref p_localBuf, p_size, p_offset = 0) 
RemoteBuf_Write(p_bufHandle, byref p_local, p_size, p_offset=0) 
RemoteBuf_GetAdr(p_handle) 
RemoteBuf_GetSize(p_handle) 
COMPARE(color1,color2) 
WM_CTLCOLOREDIT1(wParam,lParam) 
WM_CTLCOLOREDIT(wParam,lParam) 
openTextModus_PaintNet() 
closeResiceImage_PaintNet() 
openResiceImage_PaintNet() 
openSaveAs_PaintNet() 
send2paintNet(k) 
winActiveCheck(winExpected , fromLine) 
move2Img(i , textInfo) 
clickImg(i, textInfo) 
myHalllo() 
ToolTip1sec(msg " (" A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
ToolTip3sec(msg " (" A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
ToolTipSec(t,x=123,y=321,sec=1000) 
openHelpFile(command) 
letterPressed(l,typedGlobal) 
fightFocusBack(at) 
set_AutoHotkeyHelp_AlwaysOnTop(isOnTop) 
SplashStehSitzDynamik( t, t2, text ) 
readPartFromFile(fAdress) 
vBoxGles_WinMax() 
vBoxGlesStartWithGUI() 
notausToManyProcessses() 
InputBoxKoordinaten( fromline, partsNumber, dir ) 
MagixExport(fromline, x1,y1,xN,yN,MouseSpeed,pActiveTitle, partsNumber, dir, useMovieFromStart=true ) 
magixWaitExportFinished(fromline, dir, countFilesTime1 = 0) 
magixExportSelectedArea(fromline) 
MagixSplitUndIrgendwasSpurenMarkiern(fromline, x1,y1,xN,yN,MouseSpeed,pActiveTitle, partsNumber, dir ) 
waitForReadyNewFile(fromline , dir="") 
fileWaitSizeNotChanging(fromline , newestF) 
waitForNewFile(fromline , countFilesStart, dir, slowDownSeconds=20) 
countFilesInFolder(fromline , dir="") 
MouseClickIntervalSL5( fromline , x1,y1,xN,yN, MouseSpeed=0, pActiveTitle = "", partsNumber=0, xOffset=0, yOffset=0, doclick = "" ) 
MouseMoveIntervalSL5( fromline , x1,y1,xN,yN, MouseSpeed=0, pActiveTitle = "", partsNumber=0, xOffset=0, yOffset=0, doclick = "" ) 
MouseIntervalSL5( fromline , x1,y1,xN,yN, MouseSpeed=0, pActiveTitle = "", partsNumber=0, xOffset=0, yOffset=0, doclick = "" ) 
MouseMoveLineSL5( fromline,x1,y1,xN,yN,MouseSpeed=0,w1 = "",c1 = "" ,wN = "",cN = "") 
MouseMoveSL5( fromline,x1,y1,MouseSpeed=0,w1 = "",c1 = "" ) 
MouseMoveNoSL5( fromline, x=1, y=1 ) 
MouseClickSL5(fromline , x, y, pActiveTitle, lrButton="left", clickcount=1, speed=3) 
MyWinActivate( fromline , winText) 
move2ImgORImg(i, i2 , textInfo, mm, variation := 85) 
move2Img(i , textInfo, mm, variation := 85) 
clickImg(i, textInfo, mm, offset = 20, variation := 85) 
setChromeDefaultZoom(kundencenter_Googl, errorLogMetho="") 
deselectAllSelectedHtmlFiles(mm) 
downloadAllHtmlFiles_OLD(htmlPNG, tmplPNG,downloadPNG, AktuellesVerzeichnisPNG, symLinksPNGbottom, dirLocal, xM1) 
getAktuellesVerzeichnis(AktuellesVerzeichnisPNG) 
isDirEmpty(Dir) 
downloadSelected( downloadPNG, AktuellesVerzeichnisPNG, dirLocal ) 
clickDownload(downloadPNG,mm,AktuellesVerzeichnisPNG) 
scrollToTop(AktuellesVerzeichnisPNG) 
getNextNotSelectedDirName(openFoderPNG, mm, variation := 85) 
getNextNotSelectedAbsDir_localNotExist( openFoderPNG, mm, dirLocal ) 
clickOpenFolder(xM1, yM1) 
winWaitCorrectWindow() 
downloadAllHtmlFiles( htmlPNG, tmplPNG,  downloadPNG,  symLinksPNGbottom, AktuellesVerzeichnisPNG, dirLocal, xM0, yM0 ) 
downloadEachVisibleHtmlFile( htmlPNG, tmplPNG,  downloadPNG, AktuellesVerzeichnisPNG,  dirLocal, xM0, yM0 ) 
pageDown() 
getHtmlFileNameFromScreen(htmlPNG, tmplPNG, xM0, yOffset) 
getMultiMonitor() 
mouseMove( p, speed = 0 ) 
MouseMoveRectrangle(mm) 
MsgBoxMM(mm) 
MyWinActivate(winText) 
insertLink(t) 
convertToFileName(t) 
getCorrectMMFileName(t) 
IsClipboardPngPath() 
exportToClipbord() 
exportToFile() 
versionBackup(m_dir, m_subFolderNameForBackUps, m_fileExtension, m_backUpFilePostfixModus, m_show_tooltip=0) 
fileCopy_NAME_INJECTION(m_source, m_destination, m_dest_injectString_type, m_dest_ext) 
fileCreateDirS(dir,addSecondDir) 
MinMaxBothWin(domax,fTitleLeft,fTitleRight) 
readFramset2firefox(htmlframeset,fTitleLeft,fTitleRight) 
splitWindows(w1,w2) 
SingleKeyInput(m) 
CaptureScreen(aRect = 0, bCursor = False, sFile = "", nQuality = "") 
Zoomer(hBM, nW, nH, znW, znH) 
Convert(sFileFr = "", sFileTo = "", nQuality = "") 
CreateDIBSection(hDC, nW, nH, bpp = 32, ByRef pBits = "") 
SaveHBITMAPToFile(hBitmap, sFile) 
SetClipboardData(hBitmap) 
Unicode4Ansi(ByRef wString, sString) 
Ansi4Unicode(pString) 
RefreshList() 
GetScriptPathFromHwnd(hwnd) 
GetProcessMemoryInfo(pid, info=-1) 
Anchor(i, a = "", r = false) 
sendTextToDebataGraphAndSave(doSave) 
openPlayEntireTestSuiteSelenium() 
useDebategraphWithSuiteSelenium(TestCaseName) 
openOpenFileDialogSelenium() 
openTestSelenium(fileName) 
HideTrayIcon(idn, bHide = True) 
GetTrayBar() 
TrayIcons(sExeName = "") 
TrayIcon_CleanUp() 
exampleHideAllAutohotkey() 
exampleReloadAllAutohotkey() 
TrayIcons(sExeName = "", sClassName = "", sOnlyOneClass = "", OnOFF = true) 
RemoveTrayIcon(hWnd, uID, nMsg = 0, hIcon = 0, nRemove = 2) 
DeleteTrayIcon(idx) 
MoveTrayIcon(idxOld, idxNew) 
GGV(var) 
SGV(var,value="") 
GGVparse(m_pf2,m_delimiter) 
GetSciTEInstance() 
While(i <= iTransparency) 
LaunchFile(sFilePath, iLine) 
CheckLabelMatch(sHaystack, iPos) 
GUIInteract(wParam, lParam, msg, hwnd) 
WrapSel(bUp) 
FindLibFile(sLib) 
ScanScriptFile(sPath, bRecurse = False, bFuncsOnly = False, bIsInclude = False) 
AbsolutePath(sPath) 
IsCached(sPath, ByRef iCacheType) 
CacheFile(sType, iStart, iStop, iCacheIndex) 
GetScriptLabels(ByRef s, bExternal = False) 
GetCachedScriptLabels(iCacheIndex) 
GetScriptHotkeys(ByRef s, bExternal = False) 
GetCachedScriptHotkeys(iCacheIndex) 
IsValidHotkey(ByRef s) 
GetScriptFunctions(ByRef s, bExternal = False) 
GetCachedScriptFunctions(iCacheIndex) 
GetScriptDirectives(ByRef s) 
ApplyCommentFilterSetting(ByRef sFile) 
GetScriptCommentOverride(ByRef s) 
FilterComments(ByRef s, bRespectLines = False) 
GetScriptCommentFlag(ByRef s) 
GetScriptEscapeChar(ByRef s) 
AppendFilename() 
GenSpaces(n) 
AppendSymbol(i) 
CreateList(filter = "") 
GetFile(i, bWholePath = False) 
ListBoxAdjustHSB(hLB) 
AddListBoxItem(hLB, ByRef sItem, iItemData = 0) 
GetListBoxItem(hLB, i) 
GetListBoxItemData(hLB, i) 
GetLongestItem(hLB) 
GetMaxCharacters(hLB, iWidth) 
Sci_GetText(hSci) 
Sci_GetSelText(hSci) 
Sci_GetLineText(hSci, iLine) 
Sci_VScrollVisible(hSci) 
LineFromPos(pos) 
LineFromPosEx(ByRef s, pos) 
CheckTextClick(x, y) 
StringReverse(s) 
ShowLine(line) 
LineHistory(bForward, iRecordMode = 0) 
LH_GetCurLine(ByRef uLine) 
LH_SetCurLine(ByRef uLine) 
HID_Register(UsagePage = False, Usage = False, Handle = False, Flags = 0) 
HID_GetInputInfo(InputHandle, Flag) 
HID_NumIsShort(ByRef Flag) 
HID_NumIsSigned(ByRef Flag) 
EmptyMem(PID="AHK Rocks") 
GetFileCRC32(path = False) 
doAndSave(HardDriveLetter) 
chooseOneDayYesterday() 
choosePreviousWeek() 
createAbsSaveAdress(HardDriveLetter,NewStr) 
saveToPDF(SaveAdress) 
parseTitleText() 
clickTypMenue() 
Applications() 
DailyUsage() 
HourlyUsage() 
TimeDistributionReport() 
TimeUsageVisualizationByDay() 
TimeUsageVisualizationByHour() 
ToDoList() 
createBuiltReport() 
Indent(ol) 
LastChar(str) 
AhkWindowSpy() 
ShowTable(Table, LVName) 
doIt(mode) 
getContinueFlag(tc , tcOld) 
sendSlow(m,t) 
getAnredeTimeGenerated( fullAdress:="" , firstname:="",lastname:="", duSie:="Du", mf:="m") 
doSuspendAll() 
updateTrayIcon() 
ConvertToWAV(linrOffset) 
IfoverwriteNo(linrOffset) 
labelme() 
FIX_includes_of_each_subDir() 
writeTo_Wav_Stuttgart() 
subscribeToADbNewsSender(email) 
setEmailAnd(anText, mf, duSie, OpenEmailCounter) 
findFirstNameInThunderbirdVerfassen() 
ToolTip2sec(msg " (" A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
ToolTip4sec(msg " (" A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
ToolTip5sec(msg " (" A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
RemoveToolTip() 
exampleHideAllAutohotkey_1601191314() 
TrayIcon_GetInfo(sExeName:="") 
TrayIcon_Hide(idCmd, sTrayP:="Shell_TrayWnd", bHide:=True) 
TrayIcon_Remove(hWnd, uID) 
TrayIcon_Delete(idx, sTrayP:="Shell_TrayWnd") 
TrayIcon_Move(idxOld, idxNew, sTrayP:="Shell_TrayWnd") 
TrayIcon_GetTrayBar() 
TrayIcon_GetHotItem() 
TrayIcon_GetInfo(sExeName := "") 
TrayIcon_Hide(cmdID, sTray := "Shell_TrayWnd", bHide:=True) 
TrayIcon_Delete(idx, sTray := "Shell_TrayWnd") 
TrayIcon_Move(idxOld, idxNew, sTray := "Shell_TrayWnd") 
TrayIcon_Button(sExeName, sButton := "L", bDouble := false, index := 1) 
while(true) 
ActionListOLDbackup( ActionListDir , ActionListOLD) 
ActionListNEWactivate( ActionListDir , ActionListNEW, ActionListActive, typingAidSourcePath) 
ActionListOLDdisable( typingAidSourcePath, ActionListActive) 
checkFilePathExistens(ActionListDir, destinDir, sourceDir, typingAidAHK ) 
getActionListNEWfromPluginIfExist(ActionListDir, ActionListNEW, ActiveClass, activeTitle   ) 
simplifyNameOfActionListNEWstep1( ActionListNEW ) 
encodeAHKchars( s ) 
encodeAHKcharsOLD( s ) 
DynaRunGetClipboard(ahkCode) 
FileWrite(sayHelloCode, sayHelloFunctionInc) 
mvarInjects(ActionListDir, ActionListNEW, ActiveClass, activeTitle) 
getWelcomeMsg() 
while(i++ < iMax ) 
selfPerformanceTest() 
while(i++ < 99) 
DynaRunGetClipboard2(ahkCode) 
selfPerformanceTest2() 
FileWriteAndRun(sayHelloCode, sayHelloFunctionInc) 
getAhkCodeInsideFile(ActionListDir, ActionListFilterPath ) 
DynaRunGetClipboard(value) 
while( k++ < 1000) 
selfTestLoop1000(loopMax) 
while( i++ < loopMax) 
createGLOBALActionListNameFilterIfNotExist(ActionListDirBase ) 
createEmptyFilterInNewDir(ActionListDir, ActionListFilterPath,ahkCode, isInternMsgTransportIsClipboard) 
checkIdle() 
wavetanzenEu() 
get4(m,w,pos1,pos2,str, str2) 
get2Pair(m,w,pos1,pos2) 
get1Pair(m,w,pos1) 
getGleichString(w) 
walk(m,w) 
walk2qeb(w) 
get3(az) 
generateNextePasUL(wrongPasList, pasUL, isDemoMode := false ) 
pastInForm(loginTitle, pasUL) 
getULstring( s ) 
getNextLetterNameUL(start,stop) 
test_getNextLetterName(start,stop) 
getNextLetterName(lastPletter, isDemoMode := false  ) 
getRandPLetterName() 
StringJoin(array, d = "###}") 
searchNotOKmsg(loginTitle) 
range(from, to) 
folderUpDoubleClick(folderUpIcon) 
setChromeDefaultZoom(kundencenter_Googl) 
cickDownload(downloadPNG) 
clickAllHtmlFiles(htmlPNG, symLinksPNGbottom) 
downloadSelected( downloadPNG ) 
scrollToTop() 
getNextNotSelectedDirName(openFoderPNG) 
getNextNotSelectedAbsDir_localNotExist( openFoderPNG, dirLocal ) 
move2Img(i , textInfo, yOffset = 0) 
clickImg(i, textInfo, yOffset = 0) 
deselectAllSelectedHtmlFiles() 
downloadAllHtmlFiles(htmlPNG,downloadPNG, symLinksPNGbottom, dirLocal, xM1) 
downloadSelected( downloadPNG , countDownload ) 
clickDownload(downloadPNG) 
downloadEachVisibleHtmlFile( htmlPNG,  downloadPNG,  dirLocal, yM0 ) 
getHtmlFileNameFromScreen(htmlPNG) 
move2ImgORImg(i, i2 , textInfo, yOffset = 0) 
clickDownload(downloadPNG,AktuellesVerzeichnisPNG) 
AddSort(Name, Value) 
WFT_CheckOccupied(Xcor, Ycor) 
WinSet_Click_Through(I, T="254") 
scramble( s ) 
randomLetters(ll) 
ToolTipShortCuts(miliSec=4000) 
showXY(randName) 
addNode(type) 
mouseMoveMiddle() 
get_yRandOben(xWinMitte,Ywin1,h) 
get_xRandLinks(Xwin1, yWinMitte,w) 
get_yRandUnten(xWinMitte, Ywin2,h) 
get_xRandRechts(Xwin2, yWinMitte,w) 
KnotenWieBeschriftung() 
RefreshAll(layoutTyp) 
Layout_Organisch_Smart() 
Layout_Orthogonal_UmlStil() 
Layout_Orthogonal_Kompakt() 
Layout_Kantenleger_Organisch() 
Layout_Hierarisch_Interaktiv() 
Ansicht_Modus_Navigation() 
Ansicht_Modus_Bearbeitung() 
EnvAdd_PATH(pNew) 
EnvSet_PATH(pNew) 
scanFolder(path) 
getIconFile(al_IconFile) 
qc_func_GetDrive( Path, RealPath = "" ) 
func_StrTranslate(String,TransFrom,TransTo) 
func_Deref(Var) 
func_ReplaceWithCommonPathVariables(Var,AdditionalVariables="") 
isFunct() 
isFile() 
isDir() 
currFunct() 
currFile() 
currDir() 
currCode() 
load(file, parent=0, expand="", select="") 
LoadDir(d) 
hasAutoExe(c, l) 
handleMessage(p_w, p_l, p_m, p_hw) 
DragSplitter(_controlName, _companionName1, _companionName2) 
SetUInt(ByRef @struct, _value, _offset=0) 
GetUInt(ByRef @struct, _offset=0) 
captureScreen(aRect, bCursor=false, sFile="") 
msgbox(msg="", options="", title="", font="", iPaths="") 
DBGp(session, command, args="", ByRef response="") 
DBGp_StartListening(localAddress="127.0.0.1", localPort=9000) 
DBGp_OnBegin(function_name) 
DBGp_OnBreak(function_name) 
DBGp_OnStream(function_name) 
DBGp_OnEnd(function_name) 
DBGp_StopListening(socket) 
DBGp_Receive(session, ByRef packet) 
While(received < length) 
DBGp_Send(session, command, args="") 
DBGp_Base64UTF8Decode(ByRef base64) 
DBGp_Base64UTF8Encode(ByRef textdata) 
DBGp_Base64Decode(ByRef base64) 
DBGp_Base64Encode(ByRef textdata) 
DBGp_BinaryToString(ByRef bin, sz=0, fmt=12) 
DBGp_StringToBinary(ByRef bin, hex, fmt=12) 
DBGp_GetSessionSocket(session) 
DBGp_GetSessionIDEKey(session) 
DBGp_GetSessionCookie(session) 
DBGp_GetSessionThread(session) 
DBGp_GetSessionFile(session) 
DBGp_WindowMessageHandler(hwnd, uMsg, wParam, lParam) 
DBGp_AddSession(session) 
DBGp_RemoveSession(session) 
DBGp_FindSessionBySocket(socket) 
DBGp_SetSessionAsync(session, async) 
DBGp_EncodeFileURI(s) 
DBGp_StrUpper(q) 
DBGp_DecodeFileURI(s) 
DBGp_DecodeXmlEntities(s) 
DBGp_StrDup(str) 
DBGp_hwnd() 
DBGp_WSAE(n="") 
DBGp_E(n) 
DBGp_CloseSession(session) 
Hibernate(obj, file, binary=0) 
Dehibernate(file) 
SciTEMsgHandler(wParam, lParam, msg, hwnd) 
DBGp_CloseDebugger(force=0) 
SciTE_Connect() 
SciTE_Disconnect() 
OnDebuggerConnection(session, init) 
OnDebuggerBreak(session, ByRef response) 
OnDebuggerStream(session, ByRef stream) 
OnDebuggerDisconnection(session) 
DBGp_CmdRun(a) 
DBGp_CmdStepInto(a) 
DBGp_CmdStepOver(a) 
DBGp_CmdStepOut(a) 
ST_Create() 
ST_Clear() 
ST_Update() 
ST_ShortName(a) 
ST_Destroy() 
Dbg_GetStack() 
VE_Create(name, ByRef cont, readonly=0) 
VE_BestChoice(ByRef lf, ByRef crlf, ByRef a) 
VE_Close() 
VL_Create() 
VL_Update() 
VL_ShortCont(a) 
VL_Destroy() 
Dbg_GetContexts() 
SP_Output(stream, data) 
OE_Create(ByRef objdom) 
OE_Update(ByRef cont) 
OE_Add(nodes, tnode) 
OE_Preview(node) 
OE_Close() 
SciTE_UpdateCurLineOfCode() 
SciTE_RedrawLine(hwnd, line) 
SciTE_EnsureFileIsOpen(fname) 
SciTE_GetFile() 
Util_Is64bitOS() 
Util_UnpackNodes(nodes) 
Util_UnpackContNodes(nodes) 
Util_EscapeRegEx(str) 
Util_ProcessExist(a) 
Util_AddBkToList(uri, line, cond="") 
Util_RemoveBk(uri, line) 
loadXML(ByRef data) 
FTP_Init() 
FTP_CreateDirectory(hConnect,DirName) 
FTP_RemoveDirectory(hConnect,DirName) 
FTP_SetCurrentDirectory(hConnect,DirName) 
FTP_PutFile(hConnect,LocalFile, NewRemoteFile="", Flags=0) 
FTP_GetFile(hConnect,RemoteFile, NewFile="", Flags=0) 
FTP_GetFileSize(hConnect,FileName, Flags=0) 
FTP_DeleteFile(hConnect,FileName) 
FTP_RenameFile(hConnect,Existing, New) 
FTP_Open(Server, Port=21, Username=0, Password=0 ,Proxy="", ProxyBypass="") 
FTP_CloseSocket(hConnect) 
FTP_Close() 
FTP_GetFileInfo(ByRef @FindData, InfoName) 
FileTimeToStr(FileTime) 
FTP_FindFirstFile(hConnect, SearchFile, ByRef @FindData) 
FTP_FindNextFile(hEnum, ByRef @FindData) 
RemoteBuf_Open(ByRef H, hwnd, size) 
RemoteBuf_Close(ByRef H) 
RemoteBuf_Read(ByRef H, ByRef pLocal, pSize, pOffset = 0) 
RemoteBuf_Write(Byref H, byref pLocal, pSize, pOffset=0) 
RemoteBuf_Get(ByRef H, pQ="adr") 
Escape_Characters(byref Var) 
FindPropOrDie(regex, name) 
ReplaceProp(regex, repl) 
CountStylesAndChoose(ByRef choosenum) 
CountLocalesAndChoose(ByRef choosenum) 
Util_Is64bitWindows() 
Util_Is64bitProcess(pid) 
ValidateFilename(fn) 
GetIndex(sSearch, bIsFunc) 
IsValidHotkey(s) 
NotWord(ByRef word) 
AddListBoxItem(hLB, sItem, iItemData = 0) 
CheckTextClick(x, y, ByRef iPos) 
GetProcessPath(hwnd) 
LittleSplashOn(t) 
LittleSplashText(t) 
LittleSplashOff() 
ScintillaGetLength(hwnd) 
ScintillaGetText(hwnd) 
ScintillaGetText(hSci) 
ParseParams(outVar, nParams) 
ExecCmd(cmd, param1="", param2="", param3="", param4="") 
FTP_GetCurrentDirectory(hConnect,ByRef DirName) 
InitCrypt() 
CryptData(data) 
DecryptData(data) 
MCode(ByRef code, hex) 
Bin2Hex(addr,len) 
PrepareScript(script) 
AdaptHTML(script) 
GetSource(script) 
HighlightComments(script) 
Unescape(str) 
CheckIndentation(script) 
Anchor(cl, a = "", r = 0) 
BBCode2HTML(code) 
GetTag(tag) 
IsBBCodeTag(tag) 
IsChmCompilerPresent() 
CreateProj(name, title, filelist, topics, ignore=0) 
CompileProj(projhandle, output) 
FreeProj(projhandle) 
Lower(string) 
echo(txt, icon) 
fanfare() 
fanfare2() 
error_fanfare() 
FormatStr(str, bbcode = 0) 
Prepare(string) 
FileWriteEncoding(file, contents, encoding="UTF-8") 
FileContents(file) 
ContainsUnicode(name) 
GetClientSize(ByRef w, ByRef h, Title="", Text="", ExcludeTitle="", ExcludeText="") 
isFunct2() 
isFile2() 
isDir2() 
Container_DefaultPreferences(name) 
Container_COM(c,comobj,field="") 
Container_COMn(c,comobj,field="",n=1) 
Container_list(c, list, delimiters="__deFault__", omit="__deFault__") 
Container_listn(c,list,n,delimiters="__deFault__", omit="__deFault__") 
Container_array(c, array) 
Container_arrayn(c,array,n) 
Container_file(c, fpath, delimiters="__deFault__", omit="__deFault__") 
Container_filen(c,fpath,n,delimiters="__deFault__", omit="__deFault__") 
Container_toList(c,delim="__deFault__") 
Container_toArray(c) 
Container_toFile(c,fpath="", options="") 
Container_toClipboard(c,delim="__deFault__") 
Container_x(c,indexOrValue) 
Container_clear(c) 
Container_makeTemplate(c) 
Container_makeCopy(c) 
Container_sort(c,type="__deFault__", method="__deFault__", c2="",reverse=0) 
Container_rsort(c, type="__deFault__", method="__deFault__") 
Container_sortLinked(c,c2, type="__deFault__", method="__deFault__") 
Container_rsortLinked(c,c2, type="__deFault__", method="__deFault__") 
Container_makeOrder(c) 
Container_updateLinked(c,c2,order) 
Container_refresh(c,param="__deFault__") 
Container_absorb(c,targets*) 
Container_extend(c, method, source="", params*) 
Container_become(c, params*) 
Container_bud(c, params*) 
Container_manipulate(c,func, params*) 
Container_editAsText(c,editor="__deFault__") 
Container_filter(c,func,keep_if_func_returns=false, params*) 
Container_filterTF(c,func,keep_if_return_is=false, params*) 
xor(a,b) 
Container_xBlanks(c) 
Container_xDuplicates(c) 
Container_xShared(c,c2) 
Container_xIn(c,c2) 
Container_iIn(c,c2) 
finder(item,c) 
remove_unchanged(c1,c2) 
Container_iAt(c,indices) 
Container_xAt(c,indices) 
Container_iRange(c,start=1,end="") 
Container_xRange(c,start=1,end="") 
Container_makeSplit(c,func,params*) 
Container_makeIndicesSlice(o,indices,ret="",overwrite=false) 
Container_makeRangeSlice(o,start=1,end="",ret="",off0=-1,off1=-1,remove=true) 
Container_makeSlice(o,a=1,b="",c=0, off0=-1,off1=-1,remove=true) 
Container_isEmpty(c) 
Container_IsEqual(c,c2,strict=true) 
Container_IsEquivalent(c,c2) 
Container_find(c,item,x_index=0) 
Container_makeTemp(c,type="file", create=false, base="") 
Container__runWait(f, line, working_dir="", options="") 
Container__run(f, line, working_dir="", options="", wait=false) 
Container_saveParams(c,method,source,params*) 
Container_makeNew(c,params*) 
Container_get(c,method,params*) 
Container_onEach(c,type,method,params*) 
Container(method="",source="__deFault__", params*) 
FC_DefaultPreferences(name,value="") 
FC_file(f, fpath, delimiters="__deFault__", omit="__deFault__", fix="__deFault__") 
dir_fixer(item) 
depthsort(item) 
FC_refresh(f,param="__deFault__") 
FC_makeTemplate(f,take="") 
FC_makeCopy(f,leave_catch=0) 
FC_absorb(f,params*) 
FC_MakePathSuggestion(path) 
FC_enableCatch(f) 
FC_disableCatch(f) 
FC_takeCatch(f,disable="__deFault__") 
FC_pattern(f, pattern, folders="__deFault__", recurse="__deFault__", regexp="") 
FC_regex(f,base,regexp, folders="__deFault__", recurse="__deFault__") 
FC_explorer(f,hwnd="",mode="__deFault__",fix="__deFault__") 
FC_simplify(f) 
FC_reduce(f) 
FC_makeContaining(f) 
FC_makeExpansion(f,includeFolders="__deFault__",recursive="__deFault__",pattern="__deFault__",f2="__deFault__") 
FC_expand(f,includeFolders="__deFault__",recursive="__deFault__",pattern="__deFault__") 
FC_iAttr(f,attr) 
FC_xAttr(f,attr) 
hasAttributes(item,list) 
FC_files(f) 
FC_folders(f) 
IsFolder(item) 
IsFile(item) 
FC_iExists(f) 
FC_xExists(f) 
PathExist(item) 
FC_create(f,extra_flags="") 
FC_recycle(f,extra_flags="") 
FC_delete(f,extra_flags="") 
FC_moveInto(f,p1,extra_flags="") 
FC_moveOnto(f,p1,extra_flags="") 
FC_move(f,p1, extra_flags="", dest_mode="onto") 
FC_copyInto(f,p1, extra_flags="") 
FC_copyOnto(f,p1, extra_flags="") 
FC_copy(f,p1, extra_flags="", dest_mode="onto") 
FC_rename(f,p1,extra_flags="") 
FC_moveContents(f,p1, extra_flags="") 
FC_enfolder(f,dest="",prompt="__deFault__",return_mode="__deFault__") 
FC_enfolderEach(f,return_mode="__deFault__") 
FC_spiller(f,folders,recurse,delete) 
FC_leak(f,delete=0) 
FC_spill(f,delete=0) 
FC_dump(f,delete=0) 
FC_flatten(f,delete=0) 
move_helper(item,dir) 
FC_zip(f,destination="", options="") 
FC_zipEach(f,options="") 
FC_unzip(f,options="",man="__default__",params*) 
FC_run7z(f, line, working_dir, hide) 
remove_dir_ext(item) 
FC_shorten(f, delete="__deFault__", recursive=false) 
FC_ShortenAll(f,delete="__deFault__") 
shorten_helper(folder) 
canShorten(item) 
FC_removeEmptyFolders(f,recursive="__deFault__") 
FC_up(f) 
up_helper(item) 
FC_doManip(f,func, params*) 
FC_setAttr(f,attributes,recursive="__deFault__",catch="__deFault__") 
FC_renameAsText(f,editor="__deFault__") 
FC_run(f,line) 
FC_exploreAll(f,warn="__deFault__") 
FC_exploreBase(f,warn="__deFault__") 
FC_explore(f, base_only=false, warn="__deFault__") 
FC_makeStats(f, desired_units="__deFault__") 
fc_structureToClipboard(f) 
remove_trailing_slash(item) 
isEmpty(folder) 
kill_bad_spaces(path) 
FC_promptForPath(f, path="", msg="", prompt=true, use_standard_dialog="__deFault__") 
MsgBox(p1,p2="",p3="",p4="") 
FC_operation(f,operation,destination_in="",extra_flags="",dest_mode="onto") 
FC_pickFlags(f,op,extra_flags) 
ShFO(op, source, dest="", extra_flags="") 
tricky(item) 
FC_(parts*) 
FC_Path(parts*) 
FC_Path_caller(self,method,params*) 
FC_onArray(array,action,params*) 
caller(c,func,params*) 
FC_Die(f) 
Prefs_init(b,default_func) 
while(bc := bc.base) 
Prefs_setter(prefs,name,value) 
Prefs_getter(prefs,name) 
Prefs_caller(prefs, func, n1, ByRef r1="__deFault__",n2="",ByRef r2="__deFault__",n3="",ByRef r3="__deFault__",n4="",ByRef r4="__deFault__",n5="",ByRef r5="__deFault__",n6="",ByRef r6="__deFault__") 
While(name := n%A_Index%) 
Prefs_remove(prefs,name) 
Prefs_override(prefs,n1,v1="",n2="",v2="",n3="",v3="",n4="",v4="",n5="",v5="",n6="",v6="") 
ShellFileOperation( fileO=0x0, fSource="", fTarget="", flags=0x0, ghwnd=0x0 ) 
sayHello() 
get2x(x) 
sayHello(hi1, hi2, hi3 ) 
while(!StopXMPFlag && RepeatTime>=0) 
ControlDisableEnable(DisableList="",EnableList="") 
ControlHideShow(HideList="",ShowList="") 
DisplayInfo(Info1,Info2,Position=0) 
InsertInfo(Info,Line) 
DelInfo(Line) 
XMR(ByRef StopXMRFlag,CoordModeType="Screen") 
KeyboardRecord(KeyList,State = "On") 
IsMouseMove(CoordModeType="Screen") 
MouseClickRecord(State = "On") 
WindowInfoRecord(Reset=0) 
TimeIntervalRecord() 
XMF(ByRef XMR,WT=0,WC=0,WP=0,WS=0,M=0,C=0,K=0,D=0,DefaultDelay=0) 
XMP(ByRef StopXMPFlag,XMR_Data="",CoordModeType="Screen",BlockInputType="MouseMove") 
XMR2AHK(XMR,CoordType="Screen",BlockInputType="Off") 
WindowInfo2AHK(Data) 
MouseMove2AHK(Data) 
Click2AHK(Data) 
MsgMonitor(wParam, lParam, msg) 
Tab_Swap(ByRef Tab_List, ByRef Text1, ByRef Text2) 
Tab_Button_Get_Text(Tab_Index) 
Get__Selected_Row_and_RowText() 
Gui_Read_Hotkey(Gui, var_name) 
Gui_Add_Hotkey(Gui, Text, Comment, var_name) 
WinXCenter(WinID) 
WinYCenter(WinID) 
ScrnXCenter() 
ScrnYCenter() 
RegisterRawInputDevice(UsagePage, Usage, hwnd) 
WM_INPUT(wParam, lParam) 
get_mouse_name(h) 
checkNumber(Wert) 
drawButtons(str="" , fontSize=150) 
drawButtons(str , fontSize) 
assign() 
funZ(v1) 
showUsageInfoBox() 
tp41fn(isNumPadAvailable,ComputerName, key1, key2) 
getRunPHP_link(phpFile , argv) 
saveWait(fileAdress) 
isFileOpendInSciteUnsaved(filename) 
mcatch( date) 
myMethod(somePara) 
GuiGetPos(ctrl, guiId := "") 
strg_alt_l() 
testtest() 
testtest3() 
move2ImgORImg(i, i2 , textInfo, mm) 
move2Img(i , textInfo, mm) 
clickImg(i, textInfo, mm, offset = 20) 
rectangle() 
rectangleProof() 
schacharenaVoiceNavi() 
SchacharenaMouseClick() 
emptyDragonPadText() 
doSecureProof() 
setStatus() 
pastIt() 
WinActivateRealy(w) 
startDragonPad() 
getDragonPadText() 
getNewDragonPadText() 
setProgramPauseCondition() 
endOfChessMovement() 
WinActivateRealyDragonPad() 
chessClickByVoice(wrongNumber,schacharenaAlwaysClick,t,SchacharenaWindowName) 
moveToChessCoordinate(h8,SchacharenaWindowName,x1,y1,x2,y2) 
StringReplaceSchacharenaVoiceNavi(t) 
SchacharenaMouseClick(SchacharenaWindowName) 
bewegMouse( voice, Needle, x, y  ) 
emptyZugriffstaste(Zugriffstastezuordnen) 
IsTrustedLocation(path) 
EXE_uiAccess_set(file, value) 
Fail(msg) 
Warn(msg) 
OpenStore(pStoreProvider, dwMsgAndCertEncodingType, dwFlags, ParamType="Ptr", Param=0) 
GetStoreNames(dwFlags) 
FindCertificates(dwFindFlags, dwFindType, FindParamType="ptr", FindParam=0) 
AddCertificate(Certificate, dwAddDisposition) 
GetNameString(dwType, dwFlags=0, pvTypePara=0) 
Duplicate() 
Cert_GetStoreNames_Callback(pvSystemStore, dwFlags, pStoreInfo, pvReserved, pvArg) 
AcquireContext(Container, Provider, dwProvType, dwFlags) 
IsSigned(FilePath) 
GenerateKey(KeyType, KeyBitLength, dwFlags) 
CreateSelfSignCertificate(NameObject, StartTime, EndTime) 
Dispose() 
FromString(str) 
FromPointer(pointer) 
ToString(st = 0) 
SetTimeouts(Resolve=0, Connect=60000, Send=30000, Receive=30000) 
uriDecode(str) 
uriEncode(str) 
COM_Init() 
COM_Term() 
COM_VTable(ppv, idx) 
COM_QueryInterface(ppv, IID = "") 
COM_AddRef(ppv) 
COM_Release(ppv) 
COM_QueryService(ppv, SID, IID = "") 
COM_FindConnectionPoint(pdp, DIID) 
COM_GetConnectionInterface(pcp) 
COM_Advise(pcp, psink) 
COM_Unadvise(pcp, nCookie) 
COM_Enumerate(penum, ByRef Result, ByRef vt = "") 
COM_Invoke(pdsp,name="",prm0="vT_NoNe",prm1="vT_NoNe",prm2="vT_NoNe",prm3="vT_NoNe",prm4="vT_NoNe",prm5="vT_NoNe",prm6="vT_NoNe",prm7="vT_NoNe",prm8="vT_NoNe",prm9="vT_NoNe") 
COM_Invoke_(pdsp,name,typ0="",prm0="",typ1="",prm1="",typ2="",prm2="",typ3="",prm3="",typ4="",prm4="",typ5="",prm5="",typ6="",prm6="",typ7="",prm7="",typ8="",prm8="",typ9="",prm9="") 
COM_DispInterface(this, prm1="", prm2="", prm3="", prm4="", prm5="", prm6="", prm7="", prm8="") 
COM_DispGetParam(pDispParams, Position = 0, vt = 8) 
COM_DispSetParam(val, pDispParams, Position = 0, vt = 8) 
COM_Error(hr = "", lr = "", pei = "", name = "") 
COM_CreateIDispatch() 
COM_GetDefaultInterface(pdisp) 
COM_GetDefaultEvents(pdisp) 
COM_GetGuidOfName(pdisp, Name) 
COM_GetTypeInfoOfGuid(pdisp, GUID) 
COM_ConnectObject(psource, prefix = "", DIID = "") 
COM_DisconnectObject(psink) 
COM_CreateObject(CLSID, IID = "", CLSCTX = 5) 
COM_ActiveXObject(ProgID) 
COM_GetObject(Moniker) 
COM_GetActiveObject(ProgID) 
COM_CLSID4ProgID(ByRef CLSID, ProgID) 
COM_GUID4String(ByRef CLSID, String) 
COM_ProgID4CLSID(pCLSID) 
COM_String4GUID(pGUID) 
COM_IsEqualGUID(pGUID1, pGUID2) 
COM_CoCreateGuid() 
COM_CoTaskMemAlloc(cb) 
COM_CoTaskMemFree(pv) 
COM_CoInitialize() 
COM_CoUninitialize() 
COM_SysAllocString(astr) 
COM_SysFreeString(bstr) 
COM_SysStringLen(bstr) 
COM_SafeArrayDestroy(psar) 
COM_VariantClear(pvar) 
COM_VariantChangeType(pvarDst, pvarSrc, vt = 8) 
COM_SysString(ByRef wString, sString) 
COM_AccInit() 
COM_AccTerm() 
COM_AccessibleChildren(pacc, cChildren, ByRef varChildren) 
COM_AccessibleObjectFromEvent(hWnd, idObject, idChild, ByRef _idChild_="") 
COM_AccessibleObjectFromPoint(x, y, ByRef _idChild_="") 
COM_AccessibleObjectFromWindow(hWnd, idObject=-4, IID = "") 
COM_WindowFromAccessibleObject(pacc) 
COM_GetRoleText(nRole) 
COM_GetStateText(nState) 
COM_AtlAxWinInit(Version = "") 
COM_AtlAxWinTerm(Version = "") 
COM_AtlAxAttachControl(pdsp, hWnd, Version = "") 
COM_AtlAxCreateControl(hWnd, Name, Version = "") 
COM_AtlAxGetControl(hWnd, Version = "") 
COM_AtlAxGetHost(hWnd, Version = "") 
COM_AtlAxCreateContainer(hWnd, l, t, w, h, Name = "", Version = "") 
COM_AtlAxGetContainer(pdsp, bCtrl = "") 
COM_Ansi4Unicode(pString, nSize = "") 
COM_Unicode4Ansi(ByRef wString, sString, nSize = "") 
COM_Ansi2Unicode(ByRef sString, ByRef wString, nSize = "") 
COM_Unicode2Ansi(ByRef wString, ByRef sString, nSize = "") 
COM_ScriptControl(sCode, sLang = "", bEval = False, sFunc = "", sName = "", pdisp = 0, bGlobal = False) 
AddSubFoldersToTree(Folder, ParentItemID = 0) 
maksjdhkjh( aksjdhkjh) 
findFirstName() 
ActiveGoTo_Init() 
RoutineInfoGui_Create() 
RoutineInfoGui_Show() 
GenerateBM( FileName ) 
AddToBMArray(Pos, Text, Type ="") 
GotoPos(Row="") 
SendGoTo(Position) 
ReadIni(Key, Default="") 
Anchor(ctrl, a, draw = false) 
ActiveGoTo_MenuHandler( ThisMenuItem ) 
ActiveGoTo_MenuToggle(State,Menu) 
ActiveGoTo_HotkeyHandler( ThisHotkey ) 
ActiveGoTo_EditorTitleCheck( ) 
ActiveGoTo_EditorTypeCheck() 
While(CurrentStep < Items) 
While(%CurrentStep%_c%A_Index% <> "") 
While(GuiCommand = "~LButton") 
about() 
Add_Bookmark(line="") 
Add_Function_Call() 
Add_Selected_To_Personal_Variables() 
Add_Space_After_Commas() 
add_space_before_and_after_commas() 
Add_Space_Before_Commas() 
Add_Button(this="") 
arrows() 
Auto_Insert() 
Auto_Update() 
automenu() 
Backspace() 
brace() 
bracesetup(win=1) 
Custom_case_settings() 
center(win) 
cgp(Control) 
changehotkey() 
Check_For_Update() 
check_id(id) 
scan(node) 
remove(filename) 
populate() 
Add(value,parent=0,options="") 
Refresh_Code_Explorer() 
cej() 
createfile(name) 
put(file,dir,compile,existing:="") 
cleanup(error*) 
setdir(dir) 
GetDir() 
GetLastError(error) 
delete(repo,filenames) 
find(search,text) 
sha(text) 
getref(repo) 
blob(repo,text) 
send(verb,url,data="") 
tree(repo,parent,blobs) 
commit(repo,tree,parent,message="Updated the file",name="placeholder",email="placeholder@gmail.com") 
ref(repo,sha) 
Limit() 
CreateRepo(name,description="Created with AHK Studio",homepage="http://www.maestrith.com",private="false",issues="true",wiki="true",downloads="true") 
CreateFile(repo,filefullpath,text,commit="First Commit",realname="Testing",email="Testing") 
utf8(info) 
select(num:="") 
load() 
next() 
menus() 
SetTimer(timer,period:=-1) 
AutoClose(script) 
update(filename,text) 
Style() 
TrayTip(info) 
Publish(info:=0) 
Hotkey(win:=1,key:="",label:="",on:=1) 
hwnd(win:=1) 
get(name) 
call(info*) 
activate() 
open(info) 
GuiControl(info*) 
ssn(node,path) 
hide(id) 
show(id) 
add(gui,style="",mask=132) 
getpos(hwnd) 
notify() 
delete(x*) 
class_search() 
bookmark_search() 
setstate(button,state) 
SetImageList() 
add(info) 
addbutton(id) 
SetMaxTextRows(MaxRows=0) 
Customize() 
barinfo() 
ideal() 
delete(button) 
node() 
default() 
labels() 
remver() 
settext(cv,text) 
Add(vers) 
Edit(win) 
getver(ver) 
updown(win,control,direction) 
root() 
Theme(Background,forground,font="Fixedsys",size=12) 
Show(title:="",position="") 
track(control,pos) 
Add(control) 
vars(control="",var="") 
Exit(win) 
CreateElement(doc,root) 
search(node,find,return="") 
lang(info) 
unique(info) 
add2(path,att:="",text:="",dup:=0,list:="") 
find(info) 
under(under,node:="",att:="",text:="",list:="") 
ssn(node) 
Get(path,Default) 
transform() 
save(x*) 
remove(rem) 
clean(clean,tab="") 
Clear_Line_Status() 
Code_Vault() 
color(con) 
commit(commitmsg,version) 
compile_main_gist(filename) 
compile(main="") 
compilebox(win) 
context(return="") 
convert_hotkey(key) 
copy() 
create_launcher() 
Create_Segment_From_Selection() 
csc(set=0) 
current(parent="") 
Custom_Commands() 
cut() 
deadend() 
Debug_Current_Script() 
debug_settings() 
addrinfo() 
Run(filename) 
encode(text) 
decode(string) 
register() 
accept() 
Send(message) 
Sock(info*) 
debug(text) 
Default_Project_Folder() 
defaultfont() 
Delete_Bookmark(line:="") 
delete_matching_brace() 
delete() 
detach() 
display(store) 
Dlg_Color(Color,hwnd) 
Dlg_Font(ByRef Style,Effects=1,window="") 
Duplicate_Line() 
duplicates() 
addsel() 
DynaRun(Script,debug=0) 
Edit_Comment_Insert() 
Edit_Replacements() 
EditStyle(stylenumber) 
eol() 
exit(x="",reload=0) 
Export() 
extract(list,top) 
FEAdd(value,parent,options) 
file_search() 
filecheck() 
Find_Nearest_Brace() 
find() 
Find_Replace() 
fix_after(line) 
fix_indent(sc="") 
NewIndent(indentwidth:="") 
Focus(a*) 
fold_all() 
fold_current_level() 
fold_level_x(level="") 
unfold_all() 
unfold_current_level() 
unfold_level_x(level="") 
Forward() 
ftp_servers() 
Full_Backup() 
function_search() 
get_access() 
GetInclude() 
GetWebBrowser() 
Github_Repository() 
global() 
Go_To_Line() 
google_search_selected() 
Goto() 
GRUpdate(url) 
help() 
command_help() 
Highlight_to_Matching_Brace() 
History(file="") 
hltline() 
Hotkey_Search() 
hotkeys(win,item="") 
hwnd(win,hwnd="") 
Index_Current_File() 
InputBox(parent,title,prompt,default="") 
Insert_Code_Vault_Text() 
json(info,filename,newver) 
Jump_To_Next_Bookmark() 
Jump_To_Previous_Bookmark() 
jump_to_project() 
Jump_to_Segment() 
Jump_To_Specific(find:="") 
Jump_To_First_Available() 
Jump_To_Function() 
Jump_To_Label() 
Jump_To_Class() 
Jump_To_Method() 
Jump_To_Include() 
keywords() 
lastfiles() 
listvars() 
local() 
LV_Select(win,add) 
Manage_Bookmarks() 
marginwidth(sc="") 
menu_editor(x:=0) 
menu_search() 
menu(menuname) 
Menu_Editor_Icon(info) 
MenuWipe() 
Method_Search() 
move_selected_lines_down() 
move_selected_lines_up() 
MsgBox_Creator() 
multisel() 
New_File_Template() 
New_Scintilla_Window(file="") 
new_segment(new:="",text:="",adjusted:="") 
new(filename:="",text:="") 
NewFile(mainfile,newfile) 
Next_Found() 
next_prev_file() 
notify(csc="") 
omni_search(start="") 
open_folder() 
open(filelist="",show="") 
options() 
paste() 
PERefresh() 
Personal_Variable_List() 
test_plugin() 
plugins(refresh:=0) 
popftp() 
posinfo() 
post_all_in_one_gist(info="") 
Post_Multiple_Segment_Gist() 
Previous_Found() 
Previous_Scripts(filename="") 
ProjectFolder() 
Proxy_Settings() 
publish(return="") 
Quick_Scintilla_Code_Lookup() 
redo() 
Refresh_Plugins() 
Refresh_Variable_List() 
refreshthemes() 
RegisterIDs(CLSID,APPID) 
ObjRegisterActive(Object,CLSID:="{DBD5A90A-A85C-11E4-B0C7-43449580656B}",Flags:=0) 
RelativePath(main,new) 
remove_current_selection() 
Remove_Scintilla_Window() 
Remove_Segment() 
Remove_Spaces_From_Selected() 
RemoveSpacesFromAroundCommas() 
RemoveCandP(cc) 
replace_selected() 
Reset_Zoom() 
Resize(info*) 
restore_current_file() 
run_as_ansii() 
run_as_u64() 
run_as_u32() 
run_as(ahk) 
run_as_V2() 
Run_Comment_Block() 
run_program() 
run_selected_text() 
Run() 
runfile(file) 
runit() 
Save_As() 
save(option="") 
savegui() 
scintilla(return:="") 
Scratch_Pad() 
ScrollWheel() 
Search_Label() 
Select_Next_Duplicate() 
selectall() 
set_as_default_editor() 
setpos(tv) 
setup(window,nodisable="") 
Show_Class_Methods(object) 
Show_Classes() 
show_scintilla_code_in_line() 
Show_Functions() 
social() 
receive() 
Sort_Selected() 
split_code() 
Step_Over() 
Step_Into() 
Step_Out() 
step() 
stop() 
striperror(text,fn) 
Tab_To_Next_Comma() 
Tab_To_Previous_Comma() 
tab_width() 
testing() 
Theme(info="") 
themetext(theme=1) 
toggle_comment_line() 
Toggle_Multiple_Line_Comment() 
togglemenu(Label) 
traymenu() 
ubp(sc,file) 
undo() 
update_github_info() 
update(info) 
upload(winname="Upload") 
Upper(info) 
uppos() 
URLDownloadToVar(url) 
varbrowser() 
Widths() 
Label(label) 
window(info) 
Words_In_Document() 
d_logger(textToLog,debugMode=0) 
e_newTriggerContainer() 
e_NewTrigger() 
e_NewAction() 
e_NewCondition() 
e_newConnection(from,to,ConnectionType="normal") 
e_UpdateTriggerName() 
e_removeTrigger(id) 
e_removeElement(id) 
e_ElementIDtoNumber(id) 
e_TriggerIDtoNumber(id) 
e_ElementNumbertoID(num) 
e_TriggerNumbertoID(num) 
e_getParameter(elementName,parName) 
e_setParameter(elementName,parName,value) 
i_loadGeneralParameters() 
r_startRun() 
r_run() 
ui_disableElementSettingsWindow() 
ui_EnableElementSettingsWindow() 
ui_selectElementType(type,setElementID) 
ui_selectConnectionType(tempNewID) 
ui_selectContainerType(tempNewID="") 
ui_SettingsOwFLow() 
ui_Draw() 
ui_DrawEverything(ByRef Variable,bildw,bildh) 
ui_FitgridX(pos) 
ui_FitgridY(pos) 
ui_SeekForNewElementPosition() 
ui_DrawShapeOnScreen(WindowPosx,WindowPosy,WindowWidth,WindowHeight,ControlPosx,ControlPosy,ControlWidth,ControlHeight) 
ui_DeleteShapeOnScreen() 
ui_DisableMainGUI() 
ui_EnableMainGUI() 
ui_showgui() 
ui_UpdateStatusbartext(whitch="") 
moveSelectedElements(option="") 
detectMovement(threshold=2) 
detectMovementWithoutBlocking(threshold=0) 
markElement(toMark="",additional="false") 
SortMarkedInForeground() 
ToolTip(text="",duration=1000) 
v_EvaluateExpression(InstanceID,ExpressionString) 
v_EvaluateExpressionRecurse(InstanceID,ExpressionString) 
v_SearchForFirstOperand(String,ByRef ResFoundoperand,Byref ResLeftString, Byref ResRightString) 
getvariabletest(name) 
v_replaceVariables(InstanceID,String) 
v_eval(InstanceID,String) 
v_InsertLocalVariable(InstanceID,name,value) 
v_GetLocalVariable(InstanceID,name) 
v_deleteLocalVariable(InstanceID,name) 
v_getVariable(InstanceID,name,VariableType="Normal") 
v_setVariable(InstanceID,name,value,VariableType="Normal") 
v_deleteVariable(InstanceID,name) 
v_WriteLocalVariablesToString(InstanceID) 
MarkThatElementHasFinishedRunningOneVar(InstanceIDWithElementID,value) 
getNameActionActivateWindow() 
getCategoryActionActivateWindow() 
getParametersActionActivateWindow() 
GenerateNameActionActivateWindow(ID) 
getNameActioncloseWindow() 
getCategoryActioncloseWindow() 
getParametersActioncloseWindow() 
GenerateNameActioncloseWindow(ID) 
getNameActionExecute_Flow() 
getCategoryActionExecute_Flow() 
getParametersActionExecute_Flow() 
GenerateNameActionExecute_Flow(ID) 
CheckSettingsActionExecute_Flow(ID) 
getNameActionGet_Clipboard() 
getCategoryActionGet_Clipboard() 
getParametersActionGet_Clipboard() 
GenerateNameActionGet_Clipboard(ID) 
getNameActionHibernate_Computer() 
getCategoryActionHibernate_Computer() 
getParametersActionHibernate_Computer() 
GenerateNameActionHibernate_Computer(ID) 
getNameActionLock_Computer() 
getCategoryActionLock_Computer() 
getParametersActionLock_Computer() 
GenerateNameActionLock_Computer(ID) 
getNameActionLog_Off() 
getCategoryActionLog_Off() 
getParametersActionLog_Off() 
GenerateNameActionLog_Off(ID) 
getNameActionNewVariable() 
getCategoryActionNewVariable() 
getParametersActionNewVariable() 
GenerateNameActionNewVariable(ID) 
getNameActionReboot_Computer() 
getCategoryActionReboot_Computer() 
getParametersActionReboot_Computer() 
GenerateNameActionReboot_Computer(ID) 
getNameActionRun() 
getCategoryActionRun() 
getParametersActionRun() 
GenerateNameActionRun(ID) 
getNameActionScript() 
getCategoryActionScript() 
getParametersActionScript() 
GenerateNameActionScript(ElementID) 
getNameActionSend_Keystrokes() 
getCategoryActionSend_Keystrokes() 
getParametersActionSend_Keystrokes() 
GenerateNameActionSend_Keystrokes(ID) 
getNameActionSend_Keystrokes_To_Control() 
getCategoryActionSend_Keystrokes_To_Control() 
getParametersActionSend_Keystrokes_To_Control() 
GenerateNameActionSend_Keystrokes_To_Control(ID) 
CheckSettingsActionSend_Keystrokes_To_Control(ID) 
GetNameActionSet_Clipboard() 
GetCategoryActionSet_Clipboard() 
GetParametersActionSet_Clipboard() 
GenerateNameActionSet_Clipboard(ID) 
getNameActionSet_Flow_Status() 
getCategoryActionSet_Flow_Status() 
getParametersActionSet_Flow_Status() 
GenerateNameActionSet_Flow_Status(ID) 
CheckSettingsActionSet_Flow_Status(ID) 
getNameActionShutdown() 
getCategoryActionShutdown() 
getParametersActionShutdown() 
GenerateNameActionShutdown(ID) 
getNameActionSleep() 
getCategoryActionSleep() 
getParametersActionSleep() 
GenerateNameActionSleep(ID) 
getNameActionStop_Flow() 
getCategoryActionStop_Flow() 
getParametersActionStop_Flow() 
GenerateNameActionStop_Flow(ID) 
CheckSettingsActionStop_Flow(ID) 
getNameActionSuspend_Computer() 
getCategoryActionSuspend_Computer() 
getParametersActionSuspend_Computer() 
GenerateNameActionSuspend_Computer(ID) 
getNameActionTooltip() 
getCategoryActionTooltip() 
getParametersActionTooltip() 
GenerateNameActionTooltip(ID) 
runConditionConfirmation_Dialog(InstanceID,ElementID,ElementIDInInstance) 
stopConditionConfirmation_Dialog(ID) 
getParametersConditionConfirmation_Dialog() 
getNameConditionConfirmation_Dialog() 
getCategoryConditionConfirmation_Dialog() 
GenerateNameConditionConfirmation_Dialog(ID) 
runConditionExpression(InstanceID,ElementID,ElementIDInInstance) 
stopConditionExpression(ID) 
getParametersConditionExpression() 
getNameConditionExpression() 
getCategoryConditionExpression() 
GenerateNameConditionExpression(ID) 
getNameConditionFlow_Enabled() 
getCategoryConditionFlow_Enabled() 
getParametersConditionFlow_Enabled() 
GenerateNameConditionFlow_Enabled(ID) 
CheckSettingsConditionFlow_Enabled(ID) 
getNameConditionFlow_Running() 
getCategoryConditionFlow_Running() 
getParametersConditionFlow_Running() 
GenerateNameConditionFlow_Running(ID) 
CheckSettingsConditionFlow_Running(ID) 
stopConditionKey_is_down(ID) 
getParametersConditionkey_is_down() 
getNameConditionKey_is_down() 
getCategoryConditionKey_is_down() 
GenerateNameConditionKey_is_down(ID) 
getNameConditionWindow_Active() 
getCategoryConditionWindow_Active() 
getParametersConditionWindow_Active() 
GenerateNameConditionWindow_Active(ID) 
getNameConditionWindow_Exists() 
getCategoryConditionWindow_Exists() 
getParametersConditionWindow_Exists() 
GenerateNameConditionWindow_Exists(ID) 
getParametersTriggerClipboard_Changes() 
getNameTriggerClipboard_Changes() 
getCategoryTriggerClipboard_Changes() 
DisableTriggerClipboard_Changes(ID) 
GenerateNameTriggerClipboard_Changes(ID) 
EnableTriggerHotkey(ElementID) 
getParametersTriggerHotkey() 
getNameTriggerHotkey() 
getCategoryTriggerHotkey() 
DisableTriggerHotkey(ID) 
GenerateNameTriggerHotkey(ID) 
CheckSettingsTriggerHotkey(ID) 
getParametersTriggerPeriodic_timer() 
getNameTriggerPeriodic_timer() 
getCategoryTriggerPeriodic_timer() 
DisableTriggerPeriodic_timer(ID) 
GenerateNameTriggerPeriodic_timer(ID) 
getParametersTriggerShortcut() 
getNameTriggerShortcut() 
getCategoryTriggerShortcut() 
EnableTriggerShortcut(ID) 
DisableTriggerShortcut(ID) 
GenerateNameTriggerShortcut(ID) 
getParametersTriggerWindow_Closes() 
getNameTriggerWindow_Closes() 
getCategoryTriggerWindow_Closes() 
DisableTriggerWindow_Closes(ID) 
GenerateNameTriggerWindow_Closes(ID) 
getParametersTriggerWindow_Gets_Active() 
getNameTriggerWindow_Gets_Active() 
getCategoryTriggerWindow_Gets_Active() 
DisableTriggerWindow_Gets_Active(ID) 
GenerateNameTriggerWindow_Gets_Active(ID) 
getParametersTriggerWindow_Gets_Inactive() 
getNameTriggerWindow_Gets_Inactive() 
getCategoryTriggerWindow_Gets_Inactive() 
DisableTriggerWindow_Gets_Inactive(ID) 
GenerateNameTriggerWindow_Gets_Inactive(ID) 
getParametersTriggerWindow_Opens() 
getNameTriggerWindow_Opens() 
getCategoryTriggerWindow_Opens() 
DisableTriggerWindow_Opens(ID) 
GenerateNameTriggerWindow_Opens(ID) 
WM_MOUSEMOVE() 
eval(expr) 
eval_ParseExpr(expr, stopAt="", ByRef i=1) 
eval_ConvertTokens(toks) 
eval_FreeTokens(x, nTok = -1) 
eval_TokenizeInfixExpr(ByRef expr, stopAt="", ByRef i=1) 
eval_InfixToPostfix(infix, ByRef expr) 
eval_Error(txt, v="") 
eval_SafeInStr(ByRef a, ByRef b, p*) 
IsNumeric(a) 
IsOperand(a) 
IsOParenLike(a) 
IsCParenLike(a) 
IsOParenMatchingCParen(a,b) 
CParenForOParen(a) 
OParenForCParen(a) 
YieldsAnOperand(a) 
IsAssgnExcptPostAndPre(a) 
IsAssgnOrPostOp(a) 
IsRelOp(a) 
eval_Unescape(ByRef t, escchar="``") 
eval_FindFunc(name) 
eval_FindGlobalVar(name) 
UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255) 
BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster="") 
StretchBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, sw, sh, Raster="") 
SetStretchBltMode(hdc, iStretchMode=4) 
SetImage(hwnd, hBitmap) 
SetSysColorToControl(hwnd, SysColor=15) 
Gdip_BitmapFromScreen(Screen=0, Raster="") 
Gdip_BitmapFromHWND(hwnd) 
CreateRectF(ByRef RectF, x, y, w, h) 
CreateRect(ByRef Rect, x, y, w, h) 
CreateSizeF(ByRef SizeF, w, h) 
CreatePointF(ByRef PointF, x, y) 
CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0) 
PrintWindow(hwnd, hdc, Flags=0) 
DestroyIcon(hIcon) 
PaintDesktop(hdc) 
CreateCompatibleBitmap(hdc, w, h) 
CreateCompatibleDC(hdc=0) 
SelectObject(hdc, hgdiobj) 
DeleteObject(hObject) 
GetDC(hwnd=0) 
GetDCEx(hwnd, flags=0, hrgnClip=0) 
ReleaseDC(hdc, hwnd=0) 
DeleteDC(hdc) 
Gdip_LibraryVersion() 
Gdip_BitmapFromBRA(ByRef BRAFromMemIn, File, Alternate=0) 
Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h) 
Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r) 
Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h) 
Gdip_DrawBezier(pGraphics, pPen, x1, y1, x2, y2, x3, y3, x4, y4) 
Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle) 
Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle) 
Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2) 
Gdip_DrawLines(pGraphics, pPen, Points) 
Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h) 
Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r) 
Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode=0) 
Gdip_FillPie(pGraphics, pBrush, x, y, w, h, StartAngle, SweepAngle) 
Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h) 
Gdip_FillRegion(pGraphics, pBrush, Region) 
Gdip_FillPath(pGraphics, pBrush, Path) 
Gdip_DrawImagePointsRect(pGraphics, pBitmap, Points, sx="", sy="", sw="", sh="", Matrix=1) 
Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1) 
Gdip_SetImageAttributesColorMatrix(Matrix) 
Gdip_GraphicsFromImage(pBitmap) 
Gdip_GraphicsFromHDC(hdc) 
Gdip_GetDC(pGraphics) 
Gdip_ReleaseDC(pGraphics, hdc) 
Gdip_GraphicsClear(pGraphics, ARGB=0x00ffffff) 
Gdip_BlurBitmap(pBitmap, Blur) 
Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality=75) 
Gdip_GetPixel(pBitmap, x, y) 
Gdip_SetPixel(pBitmap, x, y, ARGB) 
Gdip_GetImageWidth(pBitmap) 
Gdip_GetImageHeight(pBitmap) 
Gdip_GetImageDimensions(pBitmap, ByRef Width, ByRef Height) 
Gdip_GetDimensions(pBitmap, ByRef Width, ByRef Height) 
Gdip_GetImagePixelFormat(pBitmap) 
Gdip_GetDpiX(pGraphics) 
Gdip_GetDpiY(pGraphics) 
Gdip_GetImageHorizontalResolution(pBitmap) 
Gdip_GetImageVerticalResolution(pBitmap) 
Gdip_BitmapSetResolution(pBitmap, dpix, dpiy) 
Gdip_CreateBitmapFromFile(sFile, IconNumber=1, IconSize="") 
Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette=0) 
Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff) 
Gdip_CreateBitmapFromHICON(hIcon) 
Gdip_CreateHICONFromBitmap(pBitmap) 
Gdip_CreateBitmap(Width, Height, Format=0x26200A) 
Gdip_CreateBitmapFromClipboard() 
Gdip_SetBitmapToClipboard(pBitmap) 
Gdip_CloneBitmapArea(pBitmap, x, y, w, h, Format=0x26200A) 
Gdip_CreatePen(ARGB, w) 
Gdip_CreatePenFromBrush(pBrush, w) 
Gdip_BrushCreateSolid(ARGB=0xff000000) 
Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle=0) 
Gdip_CreateTextureBrush(pBitmap, WrapMode=1, x=0, y=0, w="", h="") 
Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode=1) 
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode=1, WrapMode=1) 
Gdip_CloneBrush(pBrush) 
Gdip_DeletePen(pPen) 
Gdip_DeleteBrush(pBrush) 
Gdip_DisposeImage(pBitmap) 
Gdip_DeleteGraphics(pGraphics) 
Gdip_DisposeImageAttributes(ImageAttr) 
Gdip_DeleteFont(hFont) 
Gdip_DeleteStringFormat(hFormat) 
Gdip_DeleteFontFamily(hFamily) 
Gdip_DeleteMatrix(Matrix) 
Gdip_TextToGraphics(pGraphics, Text, Options, Font="Arial", Width="", Height="", Measure=0) 
Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF) 
Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF) 
Gdip_SetStringFormatAlign(hFormat, Align) 
Gdip_StringFormatCreate(Format=0, Lang=0) 
Gdip_FontCreate(hFamily, Size, Style=0) 
Gdip_FontFamilyCreate(Font) 
Gdip_CreateAffineMatrix(m11, m12, m21, m22, x, y) 
Gdip_CreateMatrix() 
Gdip_CreatePath(BrushMode=0) 
Gdip_AddPathEllipse(Path, x, y, w, h) 
Gdip_AddPathPolygon(Path, Points) 
Gdip_DeletePath(Path) 
Gdip_SetTextRenderingHint(pGraphics, RenderingHint) 
Gdip_SetInterpolationMode(pGraphics, InterpolationMode) 
Gdip_SetSmoothingMode(pGraphics, SmoothingMode) 
Gdip_SetCompositingMode(pGraphics, CompositingMode=0) 
Gdip_Startup() 
Gdip_Shutdown(pToken) 
Gdip_RotateWorldTransform(pGraphics, Angle, MatrixOrder=0) 
Gdip_ScaleWorldTransform(pGraphics, x, y, MatrixOrder=0) 
Gdip_TranslateWorldTransform(pGraphics, x, y, MatrixOrder=0) 
Gdip_ResetWorldTransform(pGraphics) 
Gdip_GetRotatedTranslation(Width, Height, Angle, ByRef xTranslation, ByRef yTranslation) 
Gdip_GetRotatedDimensions(Width, Height, Angle, ByRef RWidth, ByRef RHeight) 
Gdip_ImageRotateFlip(pBitmap, RotateFlipType=1) 
Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode=0) 
Gdip_SetClipPath(pGraphics, Path, CombineMode=0) 
Gdip_ResetClip(pGraphics) 
Gdip_GetClipRegion(pGraphics) 
Gdip_SetClipRegion(pGraphics, Region, CombineMode=0) 
Gdip_CreateRegion() 
Gdip_DeleteRegion(Region) 
Gdip_LockBits(pBitmap, x, y, w, h, ByRef Stride, ByRef Scan0, ByRef BitmapData, LockMode = 3, PixelFormat = 0x26200a) 
Gdip_UnlockBits(pBitmap, ByRef BitmapData) 
Gdip_SetLockBitPixel(ARGB, Scan0, x, y, Stride) 
Gdip_GetLockBitPixel(Scan0, x, y, Stride) 
Gdip_PixelateBitmap(pBitmap, ByRef pBitmapOut, BlockSize) 
Gdip_ToARGB(A, R, G, B) 
Gdip_FromARGB(ARGB, ByRef A, ByRef R, ByRef G, ByRef B) 
Gdip_AFromARGB(ARGB) 
Gdip_RFromARGB(ARGB) 
Gdip_GFromARGB(ARGB) 
Gdip_BFromARGB(ARGB) 
WM_LBUTTONDOWN() 
Gdip_SetProgress(ByRef Variable, Percentage, Foreground, Background=0x00000000, Text="", TextOptions="x0p y15p s60p Center cff000000 r4 Bold", Font="Arial") 
ToolTip(Text = "",X = "",Y = "",WhichToolTip = 1) 
Sleep(Delay) 
ExprInit() 
ExprCompile(e) 
ExprEval(e) 
Exprap(o,ByRef s,ac) 
Exprt(e) 
Exprols(o1,o2) 
Exprpr(o) 
Expras(o) 
Exprac(o) 
Exprp1(ByRef dl,d) 
Exprp2(ByRef dl) 
Exprp3(ByRef dl) 
lang(langvar,$1="",$2="",$3="",$4="",$5="",$6="",$7="",$8="",$9="") 
LangImport() 
NewFlow(NewName,Categoryname="",enabled="false",CreateNewFile=false) 
MoveFlow(ID,TO) 
enableFlow(ID) 
disableFlow(ID) 
TVOf(tempItem) 
IDOf(tempItem) 
TypeOf(tempItem) 
NameOf(tempItem) 
updateIcon(tempItem) 
setGlobalVariable(var,value,noSave="") 
getGlobalVariable(var) 
deleteGlobalVariable(var) 
removeUncategorizedCategoryIfPossible() 
ToolTip(text,duration=1000) 
debug() 
loadSavedFlows() 
SaveFlow(ID) 
MainLoop() 
ProcessKey(InputChar,EndKey) 
RecomputeMatches() 
CheckForCaretMove(MouseButtonClick, UpdatePosition = false) 
InitializeHotKeys() 
EnableKeyboardHotKeys() 
DisableKeyboardHotKeys() 
CheckWord(Key) 
EvaluateUpDown(Key) 
ReturnLineWrong() 
AddSelectedWordToList() 
DeleteSelectedWordFromList() 
EvaluateScriptPathAndTitle() 
InactivateAll() 
SuspendOn() 
SuspendOff() 
BuildTrayMenu() 
ClearAllVars(ClearWord) 
FileAppendDispatch(Text,FileName,ForceEncoding=0) 
MaybeFixFileEncoding(File,Encoding) 
GetOSVersion() 
MaybeCoInitializeEx() 
MaybeCoUninitialize() 
InitializeListBox() 
ListBoxClickItem(wParam, lParam, msg, ClickedHwnd) 
SetSwitchOffListBoxTimer() 
ListBoxScroll(Hook, Event, EventHwnd) 
GetScrollInfo(ctrlhwnd) 
ListBoxChooseItem(Row) 
CloseListBox() 
DestroyListBox() 
ListBoxEnd() 
SavePriorMatchPosition() 
SetupMatchPosition() 
RebuildMatchList() 
AddToMatchList(position, MaxLength, HalfLength, LongestBaseLength, ComputeBaseLengthOnly) 
ComputeListBoxMaxLength() 
ShowListBox() 
ForceWithinMonitorBounds(ByRef ListBoxPosX, ByRef ListBoxPosY, ListBoxActualSizeW, ListBoxActualSizeH) 
GetRows() 
HCaretX() 
HCaretY() 
CheckIfCaretNotDetectable() 
SendKey(Key) 
SendWord(WordIndex) 
SendFull(SendValue,ForceBackspace=false) 
While(WordIndex <= BackSpaceLen) 
SendCompatible(SendValue,ForceSendForInput) 
EnableWinHook() 
DisableWinHook() 
WinChanged(hWinEventHook, event, wchwnd, idObject, idChild, dwEventThread, dwmsEventTime) 
SwitchOffListBoxIfActive() 
GetIncludedActiveWindow() 
GetIncludedActiveWindowGuts() 
CheckForActive(ActiveProcess,ActiveTitle) 
ReturnWinActive() 
getActionListNEW173129( activeTitle, ActiveClass, ActionListNEW, ActionListDir ) 
getActionListNEW173129addFileExtension(ActionListNEW ) 
getActionListNEW173129simplify( ActionListNEW ) 
ToolTipSlowMotion(ActionListNEW, LineNumber) 
ReadActionList() 
ReverseWordNums(LearnedWordsCount) 
AddWordToList(AddWord,ForceCountNewOnly,ForceLearn=false, ByRef LearnedWordsCount = false) 
CheckValid(Word,ForceLearn=false) 
TransformWord(AddWord, AddWordReplacement, AddWordDescription, ByRef AddWordTransformed, ByRef AddWordIndexTransformed, ByRef AddWordReplacementTransformed, ByRef AddWordDescriptionTransformed) 
DeleteWordFromList(DeleteWord) 
UpdateWordCount(word,SortOnly) 
CleanupActionList(LearnedWordsOnly := false) 
MaybeUpdateActionList() 
StrUnmark(string) 
