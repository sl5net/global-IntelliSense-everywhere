New
Add
Show
Submit
Cancel / Hide
Destroy
Font
Color
Margin
Menu
Minimize
Maximize
Restore
Flash
Default
Gui, New [, Options, Title]
Gui, Add, ControlType [, Options, Text]
Text [Static]
Edit [Edit]
UpDown [msctls_updown32]
Picture [Static] [also: Pic]
Button [Button]
Checkbox [Button]
Radio [Button]
DropDownList [ComboBox] [also: DDL]
ComboBox [ComboBox]
ListBox [ListBox]
ListView [SysListView32]
TreeView [SysTreeView32]
Link [SysLink]
Hotkey [msctls_hotkey32]
DateTime [SysDateTimePick32]
MonthCal [SysMonthCal32]
Slider [msctls_trackbar32]
Progress [msctls_progress32]
GroupBox [Button]
Tab3 [SysTabControl32] [also: Tab, Tab2]
StatusBar [msctls_statusbar32]
Gui, Show [, Options, Title]
Center
AutoSize
Minimize
Maximize
Restore
NoActivate
NA
Hide
Gui, Submit [, NoHide]
Gui, Cancel
Gui, Hide [equivalent to 'Gui, Cancel']
Gui, Destroy
Gui, Font [, Options, FontName]
bold
italic
strike
underLine
norm
Gui, Color [, WindowColor, ControlColor]
Gui, Margin [, X, Y]
Gui, +/-Option1 +/-Option2 ...
AlwaysOnTop
Border
Caption [present by default]
Delimiter
Disabled
DPIScale
Hwnd [HwndOutputVar]
Label
LastFound
LastFoundExist
MaximizeBox
MinimizeBox [present by default]
MinSize
MaxSize
OwnDialogs
Owner
Parent
Resize
SysMenu [present by default]
Theme
ToolWindow
Gui, Menu [, MenuName]
Gui, Minimize
Gui, Maximize
Gui, Restore
Gui, Flash [, Off]
Gui, GuiName:Default

CtrlEvent(CtrlHwnd, GuiEvent, EventInfo, ErrLevel:="")


AltSubmit
Disabled
Hidden
Left
Right
Center
Section
Tabstop
Wrap
VScroll
HScroll

BackgroundTrans
Background [-Background]
Border
Hwnd [HwndOutputVar]
Theme
GuiClose
GuiEscape
GuiSize
GuiContextMenu
GuiDropFiles
GuiClose(GuiHwnd)
GuiEscape(GuiHwnd)
GuiSize(GuiHwnd, EventInfo, Width, Height)
GuiContextMenu(GuiHwnd, CtrlHwnd, EventInfo, IsRightClick, X, Y)
GuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y) {
Gui, MyGui:Add, Text,, Text for about-box.
Gui, MyGui:Show
Gui MyGui:Default can be used to avoid the need for the "MyGui:" prefix above. In addition, the prefix is not necessary inside a GUI thread that operates upon the same window that launched the thread.
Text
Move
MoveDraw
Focus
Enable / Disable
Hide / Show
Delete [not yet implemented]
Choose
ChooseString
Font
Pos
Focus
FocusV
Enabled
Visible
Hwnd
NoTab
Top
Limit
Lowercase
Multi
Number
Password
ReadOnly
Uppercase
WantCtrlA
WantReturn
WantTab
Wrap [-Wrap]
Horz
Left
Range
Wrap
Default
Wrap [-Wrap]
Check3
Checked
CheckedGray
Wrap [-Wrap]


Group
Checked


Choose
Uppercase
Lowercase
Sort
Delimiter


Choose
Uppercase
Lowercase
Sort
Delimiter
Limit
Simple


Choose
Multi
ReadOnly
Sort

AltSubmit
Background
Checked
Count
Grid
Multi
NoSortHdr
NoSort
ReadOnly
Sort
SortDesc
WantF2

Icon
Tile
IconSmall
List
Report


AltSubmit
Background
Buttons
Checked
HScroll
ImageList
Lines
ReadOnly
WantF2


MyFunction(CtrlHwnd, GuiEvent, LinkIndex, HrefOrID)


Limit


Choose
ChooseNone
Range
Right


Multi
Range


Buddy1
Buddy2
Center
Invert
Left
Line
NoTicks
Page
Range
Thick
TickInterval
ToolTip
Vertical


BackgroundN
Range
Smooth [-Smooth]
Vertical


Wrap


Choose
Background [-Background]
Buttons
Left/Right/Bottom
Wrap [-Wrap]
Icons in Tabs
