;|r|list is from here: https://autohotkey.com/docs/commands/index.htm
Object()|r|Creates a scriptable associative array.
Array()|r|Creates a scriptable associative array with integer keys.
Abs()|r|Returns|r|the absolute value of Number.
AutoTrim|r|Determines|r|whether traditional assignments like Var1 = %Var2% omit spaces and tabs from the beginning and end of Var2.
Asc()|r|Returns the numeric value of the first byte or UTF-16 code unit in the specified string.
ASin()|r|Returns the arcsine (the number whose sine is Number) in radians.
ACos()|r|Returns the arccosine (the number whose cosine is Number) in radians.
ATan()|r|Returns the arctangent (the number whose tangent is Number) in radians.
BlockInput|r|Disables or enables the user's ability to interact with the computer via keyboard and mouse.
Break|r|Exits (terminates) a loop. Valid inside any kind of loop.
Catch|r|Specifies the code to execute if an exception is raised during execution of a try statement.
Ceil()|r|Returns Number rounded up to the nearest integer (without any .00 suffix).
Chr()|r|Returns the string (usually a single character) corresponding to the character code indicated by the specified number.
Click|r|Clicks a mouse button at the specified coordinates. It can also hold down a mouse button, turn the mouse wheel, or move the mouse.
ClipWait|r|Waits until the clipboard contains data.
ComObjActive()|r|Retrieves a registered COM object.
ComObjArray()|r|Creates a SAFEARRAY for use with COM.
ComObjConnect()|r|Connects a COM object's event sources to functions with a given prefix.
ComObjCreate()|r|Creates a COM object.
ComObject()|r|Creates an object representing a typed value to be passed as a parameter or return value.
ComObjEnwrap()|r|/ ComObjUnwrap()	Wraps/unwraps a COM object.
ComObjError()|r|Enables or disables notification of COM errors.
ComObjFlags()|r|Retrieves or changes flags which control a COM wrapper object's behaviour.
ComObjGet()|r|Returns a reference to an object provided by a COM component.
ComObjMissing()|r|Creates a "missing parameter" object to pass to a COM method.
ComObjParameter()|r|Wraps a value and type to pass as a parameter to a COM method.
ComObjQuery()|r|Queries a COM object for an interface or service.
ComObjType()|r|Retrieves type information from a COM object.
ComObjValue()|r|Retrieves the value or pointer stored in a COM wrapper object.
Continue|r|Skips the rest of the current loop iteration and begins a new one. Valid inside any kind of loop.
Control|r|Makes a variety of changes to a control.
ControlClick|r|Sends a mouse button or mouse wheel event to a control.
ControlFocus|r|Sets input focus to a given control on a window.
ControlGet|r|Retrieves various types of information about a control.
ControlGetFocus|r|Retrieves which control of the target window has input focus, if any.
ControlGetPos|r|Retrieves the position and size of a control.
ControlGetText|r|Retrieves text from a control.
ControlMove|r|Moves or resizes a control.
ControlSend|r|/ ControlSendRaw	Sends simulated keystrokes to a window or control.
ControlSetText|r|Changes the text of a control.
CoordMode|r|Sets coordinate mode for various commands to be relative to either the active window or the screen.
Cos()|r|Returns the trigonometric cosine of Number.
Critical|r|Prevents the current thread from being interrupted by other threads, or enables it to be interrupted.
DetectHiddenText|r|Determines whether invisible text in a window is "seen" for the purpose of finding the window. This affects commands such as IfWinExist and WinActivate.
DetectHiddenWindows|r|Determines whether invisible windows are "seen" by the script.
DllCall()|r|Calls a function inside a DLL, such as a standard Windows API function.
Drive|r|Ejects/retracts the tray in a CD or DVD drive, or sets a drive's volume label.
DriveGet|r|Retrieves various types of information about the computer's drive(s).
DriveSpaceFree|r|Retrieves the free disk space of a drive, in Megabytes.
Edit|r|Opens the current script for editing in the associated editor.
Else|r|Specifies the command(s) to perform if an IF-statement evaluates to FALSE. When more than one command is present, enclose them in a block (braces).
EnvAdd|r|Sets a variable to the sum of itself plus the given value (can also add or subtract time from a date-time value). Synonymous with: Var += Value.
EnvDiv|r|Sets a variable to itself divided by the given value. Synonymous with: Var /= Value.
EnvGet|r|Retrieves an environment variable.
EnvMult|r|Sets a variable to itself times the given value. Synonymous with: Var *= Value.
EnvSet|r|Writes a value to a variable contained in the environment.
EnvSub|r|Sets a variable to itself minus the given value (can also compare date-time values). Synonymous with: Var -= Value.
EnvUpdate|r|Notifies the OS and all running applications that environment variable(s) have changed.
Exception()|r|Creates an object which can be used to throw a custom exception.
Exit|r|Exits the current thread or (if the script is not persistent and contains no hotkeys) the entire script.
ExitApp|r|Terminates the script unconditionally.
Exp()|r|Returns e (which is approximately 2.71828182845905) raised to the Nth power.
FileAppend|r|Writes text to the end of a file (first creating the file, if necessary).
FileCopy|r|Copies one or more files.
FileCopyDir|r|Copies a folder along with all its sub-folders and files (similar to xcopy).
FileCreateDir|r|Creates a folder.
FileCreateShortcut|r|Creates a shortcut (.lnk) file.
FileDelete|r|Deletes one or more files.
FileEncoding|r|Sets the default encoding for FileRead, FileReadLine, Loop Read, FileAppend, and FileOpen.
See|r|also: Text Encodings
FileExist()|r|Checks for the existence of a file or folder and returns its attributes.
FileInstall|r|Includes the specified file inside the compiled version of the script.
FileGetAttrib|r|Reports whether a file or folder is read-only, hidden, etc.
FileGetShortcut|r|Retrieves information about a shortcut (.lnk) file, such as its target file.
FileGetSize|r|Retrieves the size of a file.
FileGetTime|r|Retrieves the datetime stamp of a file or folder.
FileGetVersion|r|Retrieves the version of a file.
FileMove|r|Moves or renames one or more files.
FileMoveDir|r|Moves a folder along with all its sub-folders and files. It can also rename a folder.
FileOpen|r|Provides object-oriented file I/O.
FileRead|r|Reads a file's contents into a variable.
FileReadLine|r|Reads the specified line from a file and stores the text in a variable.
FileRecycle|r|Sends a file or directory to the recycle bin, if possible.
FileRecycleEmpty|r|Empties the recycle bin.
FileRemoveDir|r|Deletes a folder.
FileSelectFile|r|Displays a standard dialog that allows the user to open or save file(s).
FileSelectFolder|r|Displays a standard dialog that allows the user to select a folder.
FileSetAttrib|r|Changes the attributes of one or more files or folders. Wildcards are supported.
FileSetTime|r|Changes the datetime stamp of one or more files or folders. Wildcards are supported.
Finally|r|Ensures that a block of code is always executed after a Try statement finishes.
Floor()|r|Returns Number rounded down to the nearest integer (without any .00 suffix).
For|r|Repeats a series of commands once for each key-value pair in an object.
Format|r|Formats a variable number of input values according to a format string.
FormatTime|r|Transforms a YYYYMMDDHH24MISS timestamp into the specified date/time format.
Func()|r|Retrieves a reference to a function.
GetKeyName()|r|Retrieves the name or text of a key.
GetKeyVK()|r|Retrieves the virtual key code of a key.
GetKeySC()|r|Retrieves the scan code of a key.
GetKeyState|r|Checks if a keyboard key or mouse/joystick button is down or up. Also retrieves joystick status.
Gosub|r|Jumps to the specified label and continues execution until Return is encountered.
Goto|r|Jumps to the specified label and continues execution.
GroupActivate|r|Activates the next window in a window group that was defined with GroupAdd.
GroupAdd|r|Adds a window specification to a window group, creating the group if necessary.
GroupClose|r|Closes the active window if it was just activated by GroupActivate or GroupDeactivate. It then activates the next window in the series. It can also close all windows in a group.
GroupDeactivate|r|Similar to GroupActivate except activates the next window not in the group.
Gui|r|Creates and manages windows and controls. Such windows can be used as data entry forms or custom user interfaces.
GuiControl|r|Makes a variety of changes to a control in a GUI window.
GuiControlGet|r|Retrieves various types of information about a control in a GUI window.
Hotkey|r|Creates, modifies, enables, or disables a hotkey while the script is running.
Hotstring()|r|Creates, modifies, enables, or disables a hotstring while the script is running.
if|r|Specifies the command(s) to perform if the comparison of a variable to a value evaluates to TRUE. When more than one command is present, enclose them in a block (braces).
if|r|(expression)	Specifies the command(s) to perform if an expression evaluates to TRUE.
If|r|var [not] between	Checks whether a variable's contents are numerically or alphabetically between two values (inclusive).
If|r|var [not] in/contains MatchList	Checks whether a variable's contents match one of the items in a list.
If|r|var is [not] type	Checks whether a variable's contents are numeric, uppercase, etc.
IfEqual|r|/ IfNotEqual	Compares a variable to a value for equality. Synonymous with: if Var = Value | if Var <> Value.
IfExist|r|/ IfNotExist	Checks for the existence of a file or folder.
IfGreater|r|/ IfGreaterOrEqual	Compares a variable to a value. Synonymous with: if Var > Value | if Var >= Value.
IfInString|r|/ IfNotInString / InStr()	Checks if a variable contains the specified string.
IfLess|r|/ IfLessOrEqual	Compares a variable to a value. Synonymous with: if Var < Value | if Var <= Value.
IfMsgBox|r|Checks which button was pushed by the user during the most recent MsgBox command.
IfWinActive|r|/ IfWinNotActive
Checks|r|if the specified window exists and is currently active (foremost).
IfWinExist|r|/ IfWinNotExist
Checks|r|if the specified window exists.
IL_Create()|r|IL_Add()
IL_Destroy()|r|The means by which icons are added to a ListView or TreeView control.
ImageSearch|r|Searches a region of the screen for an image.
IniDelete|r|Deletes a value from a standard format .ini file.
IniRead|r|Reads a value from a standard format .ini file.
IniWrite|r|Writes a value to a standard format .ini file.
Input|r|Waits for the user to type a string.
InputBox|r|Displays an input box to ask the user to enter a string.
InStr()|r|Searches for a given occurrence of a string, from the left or the right.
IsByRef()|r|Returns a non-zero number if a ByRef parameter of a function was supplied with the specified variable.
IsFunc()|r|Returns a non-zero number if the specified function exists in the script.
IsLabel()|r|Returns a non-zero number if the specified label exists in the script.
IsObject()|r|Returns a non-zero number if the specified value is an object.
KeyHistory|r|Displays script info and a history of the most recent keystrokes and mouse clicks.
KeyWait|r|Waits for a key or mouse/joystick button to be released or pressed down.
ListHotkeys|r|Displays the hotkeys in use by the current script, whether their subroutines are currently running, and whether or not they use the keyboard or mouse hook.
ListLines|r|Displays the script lines most recently executed.
ListVars|r|Displays the script's variables: their names and current contents.
LoadPicture()|r|Loads a picture from file and returns a bitmap or icon handle.
Log()|r|Returns the logarithm (base 10) of Number.
Ln()|r|Returns the natural logarithm (base e) of Number.
Loop|r|(normal)	Performs a series of commands repeatedly: either the specified number of times or until break is encountered.
Loop|r|(files & folders)	Retrieves the specified files or folders, one at a time.
Loop|r|(parse a string)	Retrieves substrings (fields) from a string, one at a time.
Loop|r|(read file contents)	Retrieves the lines in a text file, one at a time (performs better than FileReadLine).
Loop|r|(registry)	Retrieves the contents of the specified registry subkey, one item at a time.
LV_Add()|r|LV_Delete()
LV_DeleteCol()|r|LV_GetCount()
LV_GetNext()|r|LV_GetText()
LV_Insert()|r|LV_InsertCol()
LV_Modify()|r|LV_ModifyCol()
LV_SetImageList()|r|The means by which the rows and columns of a ListView control are added, modified or retrieved.
Max()|r|Returns the highest value of one or more numbers.
Menu|r|Creates, deletes, modifies and displays menus and menu items. Changes the tray icon and its tooltip. Controls whether the main window of a compiled script can be opened.
MenuGetHandle|r|Retrieves the Win32 menu handle of a menu.
MenuGetName|r|Retrieves the name of a menu given a handle to its underlying Win32 menu.
Min()|r|Returns the lowest value of one or more numbers.
Mod()|r|Modulo. Returns the remainder when Dividend is divided by Divisor.
MouseClick|r|Clicks or holds down a mouse button, or turns the mouse wheel. NOTE: The Click command is generally more flexible and easier to use.
MouseClickDrag|r|Clicks and holds the specified mouse button, moves the mouse to the destination coordinates, then releases the button.
MouseGetPos|r|Retrieves the current position of the mouse cursor, and optionally which window and control it is hovering over.
MouseMove|r|Moves the mouse cursor.
MsgBox|r|Displays the specified text in a small window containing one or more buttons (such as Yes and No).
NumGet()|r|Returns the binary number stored at the specified address+offset.
NumPut()|r|Stores a number in binary format at the specified address+offset.
ObjAddRef()|r|/ ObjRelease()	Increments or decrements an object's reference count.
ObjBindMethod()|r|Creates a BoundFunc object which calls a method of a given object.
ObjClone()|r|ObjCount()
ObjDelete()|r|ObjGetAddress()
ObjGetCapacity()|r|ObjHasKey()
ObjInsert()|r|ObjInsertAt()
ObjLength()|r|ObjMaxIndex()
ObjMinIndex()|r|ObjNewEnum()
ObjPop()|r|ObjPush()
ObjRemove()|r|ObjRemoveAt()
ObjSetCapacity()|r|These functions are equivalent to built-in methods of the Object type. It is usually recommended to use the corresponding method instead.
ObjGetBase()|r|Retrieves an object's base object.
ObjRawGet()|r|Retrieves a key-value pair from an object, bypassing the object's meta-functions.
ObjRawSet()|r|Stores or overwrites a key-value pair in an object, bypassing the object's meta-functions.
ObjSetBase()|r|Sets an object's base object.
OnClipboardChange()|r|Registers a function or function object to run whenever the clipboard's content changes.
OnError|r|Specifies a function to run automatically when an unhandled error occurs.
OnExit|r|Specifies a subroutine to run automatically when the script exits.
OnMessage()|r|Specifies a function to call automatically when the script receives the specified message.
Ord()|r|Returns the ordinal value (numeric character code) of the first character in the specified string.
OutputDebug|r|Sends a string to the debugger (if any) for display.
Pause|r|Pauses the script's current thread.
PixelGetColor|r|Retrieves the color of the pixel at the specified x,y coordinates.
PixelSearch|r|Searches a region of the screen for a pixel of the specified color.
PostMessage|r|Places a message in the message queue of a window or control.
Process|r|Performs one of the following operations on a process: checks if it exists; changes its priority; closes it; waits for it to close.
Progress|r|Creates or updates a window containing a progress bar.
Random|r|Generates a pseudo-random number.
RegExMatch()|r|Determines whether a string contains a pattern (regular expression).
RegExReplace()|r|Replaces occurrences of a pattern (regular expression) inside a string.
RegDelete|r|Deletes a subkey or value from the registry.
RegRead|r|Reads a value from the registry.
RegWrite|r|Writes a value to the registry.
RegisterCallback()|r|Creates a machine-code address that when called, redirects the call to a function in the script.
Reload|r|Replaces the currently running instance of the script with a new one.
Return|r|Returns from a subroutine to which execution had previously jumped via function-call, Gosub, Hotkey activation, GroupActivate, or other means.
Round()|r|If N is omitted or 0, Number is rounded to the nearest integer. If N is positive number, Number is rounded to N decimal places. If N is negative, Number is rounded by N digits to the left of the decimal point.
Run|r|Runs an external program.
RunAs|r|Specifies a set of user credentials to use for all subsequent uses of Run and RunWait.
RunWait|r|Runs an external program and waits until it finishes.
SB_SetIcon()|r|SB_SetParts()
SB_SetText()|r|The means by which the bar of a StatusBar control is modified.
Send|r|/ SendRaw / SendInput / SendPlay / SendEvent	Sends simulated keystrokes and mouse clicks to the active window.
SendLevel|r|Controls which artificial keyboard and mouse events are ignored by hotkeys and hotstrings.
SendMessage|r|Sends a message to a window or control and waits for acknowledgement.
SendMode|r|Makes Send synonymous with SendInput or SendPlay rather than the default (SendEvent). Also makes Click and MouseMove/Click/Drag use the specified method.
SetBatchLines|r|Determines how fast a script will run (affects CPU utilization).
SetCapsLockState|r|Sets the state of the CapsLock key. Can also force the key to stay on or off.
SetControlDelay|r|Sets the delay that will occur after each control-modifying command.
SetDefaultMouseSpeed|r|Sets the mouse speed that will be used if unspecified in Click and MouseMove/Click/Drag.
SetEnv|r|(Var = Value)	Assigns the specified value to a variable.
SetFormat|r|Sets the format of integers and floating point numbers generated by math operations.
SetKeyDelay|r|Sets the delay that will occur after each keystroke sent by Send or ControlSend.
SetMouseDelay|r|Sets the delay that will occur after each mouse movement or click.
SetNumLockState|r|Sets the state of the NumLock key. Can also force the key to stay on or off.
SetScrollLockState|r|Sets the state of the ScrollLock key. Can also force the key to stay on or off.
SetRegView|r|Allows registry commands in a 32-bit script to access the 64-bit registry view and vice versa.
SetStoreCapsLockMode|r|Whether to restore the state of CapsLock after a Send.
SetTimer|r|Causes a subroutine to be launched automatically and repeatedly at a specified time interval.
SetTitleMatchMode|r|Sets the matching behavior of the WinTitle parameter in commands such as WinWait.
SetWinDelay|r|Sets the delay that will occur after each windowing command, such as WinActivate.
SetWorkingDir|r|Changes the script's current working directory.
Shutdown|r|Shuts down, restarts, or logs off the system.
Sin()|r|Returns the trigonometric sine of Number.
Sleep|r|Waits the specified amount of time before continuing.
Sort|r|Arranges a variable's contents in alphabetical, numerical, or random order (optionally removing duplicates).
SoundBeep|r|Emits a tone from the PC speaker.
SoundGet|r|Retrieves various settings from a sound device (master mute, master volume, etc.)
SoundGetWaveVolume|r|Retrieves the wave output volume from a sound device.
SoundPlay|r|Plays a sound, video, or other supported file type.
SoundSet|r|Changes various settings of a sound device (master mute, master volume, etc.)
SoundSetWaveVolume|r|Changes the wave output volume for a sound device.
SplashImage|r|Creates or updates a window containing a JPG, GIF, or BMP image.
SplashTextOn|r|Creates a customizable text popup window.
SplashTextOff|r|Closes the above window.
SplitPath|r|Separates a file name or URL into its name, directory, extension, and drive.
Sqrt()|r|Returns the square root of Number.
StatusBarGetText|r|Retrieves the text from a standard status bar control.
StatusBarWait|r|Waits until a window's status bar contains the specified string.
StrPut()|r|/ StrGet()	Copies a string to or from a memory address, optional converting it between code pages.
StringCaseSense|r|Determines whether string comparisons are case sensitive (default is "not case sensitive").
StringGetPos|r|/ InStr()	Retrieves the position of the specified substring within a string.
StringLeft|r|Retrieves a number of characters from the left-hand side of a string.
StringLen|r|/ StrLen()	Retrieves the count of how many characters are in a string.
StringLower|r|Converts a string to lowercase.
StringMid|r|/ SubStr()	Retrieves one or more characters from the specified position in a string.
StringReplace|r|/ StrReplace()	Replaces the specified substring with a new string.
StringRight|r|Retrieves a number of characters from the right-hand side of a string.
StringSplit|r|/ StrSplit()	Separates a string into an array of substrings using the specified delimiters.
StringTrimLeft|r|Removes a number of characters from the left-hand side of a string.
StringTrimRight|r|Removes a number of characters from the right-hand side of a string.
StringUpper|r|Converts a string to uppercase.
Suspend|r|Disables or enables all or selected hotkeys and hotstrings.
SysGet|r|Retrieves screen resolution, multi-monitor info, dimensions of system objects, and other system properties.
Tan()|r|Returns the trigonometric tangent of Number.
Thread|r|Sets the priority or interruptibility of threads. It can also temporarily disable all timers.
Throw|r|Signals the occurrence of an error. This signal can be caught by a try-catch statement.
ToolTip|r|Creates an always-on-top window anywhere on the screen.
Transform|r|Performs miscellaneous math functions, bitwise operations, and tasks such as ASCII/Unicode conversion.
TrayTip|r|Creates a balloon message window or toast notification near the tray icon.
Trim()|r|/ LTrim() / RTrim()	Trims certain characters from the beginning and/or end of a string.
Try|r|Guards one or more statements (commands or expressions) against runtime errors and exceptions thrown by the throw command.
TV_Add()|r|TV_Delete()
TV_Get()|r|TV_GetChild()
TV_GetCount()|r|TV_GetNext()
TV_GetParent()|r|TV_GetPrev()
TV_GetSelection()|r|TV_GetText()
TV_Modify()|r|TV_SetImageList()	The means by which the items of a TreeView control are added, modified or retrieved.
Until|r|Applies a condition to the continuation of a Loop or For-loop.
UrlDownloadToFile|r|Downloads a file from the Internet.
Var|r|= value	Assigns the specified value to a variable.
Var|r|:= expression	Evaluates an expression and stores the result in a variable.
VarSetCapacity()|r|Enlarges a variable's holding capacity or frees its memory. Normally, this is necessary only for unusual circumstances such as DllCall.
While-loop|r|Performs a series of commands repeatedly until the specified expression evaluates to false.
WinActivate|r|Activates the specified window.
WinActivateBottom|r|Same as WinActivate except that it activates the bottommost matching window rather than the topmost.
WinActive()|r|Returns the Unique ID (HWND) of the active window if it matches the specified criteria.
WinClose|r|Closes the specified window.
WinExist()|r|Returns the Unique ID (HWND) of the first matching window.
WinGetActiveStats|r|Combines the functions of WinGetActiveTitle and WinGetPos into one command.
WinGetActiveTitle|r|Retrieves the title of the active window.
WinGetClass|r|Retrieves the specified window's class name.
WinGet|r|Retrieves the specified window's unique ID, process ID, process name, or a list of its controls. It can also retrieve a list of all windows matching the specified criteria.
WinGetPos|r|Retrieves the position and size of the specified window.
WinGetText|r|Retrieves the text from the specified window.
WinGetTitle|r|Retrieves the title of the specified window.
WinHide|r|Hides the specified window.
WinKill|r|Forces the specified window to close.
WinMaximize|r|Enlarges the specified window to its maximum size.
WinMenuSelectItem|r|Invokes a menu item from the menu bar of the specified window.
WinMinimize|r|Collapses the specified window into a button on the task bar.
WinMinimizeAll|r|Minimizes all windows.
WinMinimizeAllUndo|r|Reverses the effect of a previous WinMinimizeAll.
WinMove|r|Changes the position and/or size of the specified window.
WinRestore|r|Unminimizes or unmaximizes the specified window if it is minimized or maximized.
WinSet|r|Makes a variety of changes to the specified window, such as "always on top" and transparency.
WinSetTitle|r|Changes the title of the specified window.
WinShow|r|Unhides the specified window.
WinWait|r|Waits until the specified window exists.
WinWaitActive|r|Waits until the specified window is active.
WinWaitClose|r|Waits until the specified window does not exist.
WinWaitNotActive|r|Waits until the specified window is not active.
ClipboardTimeout|r|Changes how long the script keeps trying to access the clipboard when the first attempt fails.
CommentFlag|r|Changes the script's comment symbol from semicolon to some other string.
Delimiter|r|Changes the script's command parameter delimiter from comma to some other character.
DerefChar|r|Changes the script's dereference symbol from percent to some other character.
ErrorStdOut|r|Sends any syntax error that prevents a script from launching to stdout rather than displaying a dialog.
EscapeChar|r|Changes the script's escape character (for example: backslash vs. accent).
HotkeyInterval|r|Along with #MaxHotkeysPerInterval, specifies the rate of hotkey activations beyond which a warning dialog will be displayed.
HotkeyModifierTimeout|r|Affects the behavior of hotkey modifiers: Ctrl, Alt, Win, and Shift.
Hotstring|r|Changes hotstring options or ending characters.
If|r|Similar to #IfWinActive, but for arbitrary expressions.
IfTimeout|r|Sets the maximum time that may be spent evaluating a single #If expression.
IfWinActive|r|/ #IfWinNotActive / #IfWinExist / #IfWinNotExist	Creates context-sensitive hotkeys and hotstrings. Such hotkeys perform a different action (or none at all) depending on the type of window that is active or exists.
Include|r|/ #IncludeAgain	Causes the script to behave as though the specified file's contents are present at this exact position.
InputLevel|r|Controls which artificial keyboard and mouse events are ignored by hotkeys and hotstrings.
InstallKeybdHook|r|Forces the unconditional installation of the keyboard hook.
InstallMouseHook|r|Forces the unconditional installation of the mouse hook.
KeyHistory|r|Sets the maximum number of keyboard and mouse events displayed by the KeyHistory window. You can set it to 0 to disable key history.
LTrim|r|Enables or disables trimming of indentation in continuation sections.
MaxHotkeysPerInterval|r|Along with #HotkeyInterval, specifies the rate of hotkey activations beyond which a warning dialog will be displayed.
MaxMem|r|Sets the maximum capacity of each variable to the specified number of megabytes.
MaxThreads|r|Sets the maximum number of simultaneous threads.
MaxThreadsBuffer|r|Causes some or all hotkeys to buffer rather than ignore keypresses when their #MaxThreadsPerHotkey limit has been reached.
MaxThreadsPerHotkey|r|Sets the maximum number of simultaneous threads per hotkey or hotstring.
MenuMaskKey|r|Changes which key is used to mask Win or Alt keyup events.
NoEnv|r|Avoids checking empty variables to see if they are environment variables (recommended for all new scripts).
NoTrayIcon|r|Disables the showing of a tray icon.
Persistent|r|Keeps a script permanently running (that is, until the user closes it or ExitApp is encountered).
SingleInstance|r|Determines whether a script is allowed to run again when it is already running.
UseHook|r|Forces the use of the hook to implement all or some keyboard hotkeys.
Warn|r|Enables or disables warnings for selected conditions that may be indicative of developer errors.
WinActivateForce|r|Skips the gentle method of activating a window and goes straight to the forceful method.
Copyright|r|© 2003-2018 autohotkey.com - LIC: GNU GPLv2