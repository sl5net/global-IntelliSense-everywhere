; Indentation_style: https://de.wikipedia.org/wiki/Einrueckungsstil#SL5small-Stil
; # ErrorStdOut

SetWorkingDir %A_ScriptDir%

if(0){
; global actionListDirBase
; actionListDirBase := A_ScriptDir "\..\actionLists"
; actionListDirBase := "..\actionLists"
; actionListDirBase := ""

if(!FileExist( actionListDirBase ))
    msgbox,!actionListDirBase `n(%A_LineFile%~%A_LineNumber%)
if(substr(actionListDirBase,1,1)=="\")
    msgbox,substr(actionListDirBase,1,1)=="\" `n(%A_LineFile%~%A_LineNumber%)
}

; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), "test  6", 1, 1, 6 )
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, aScriptDir, %A_ScriptDir% ; RegWrite , RegSave
;/¯¯¯¯ CreatedDir ¯¯ 190131114631 ¯¯ 31.01.2019 11:46:31 ¯¯\
; DONT DO THE following line now (19-01-31_11-46)
; its for communication beetween the two scripts !!!
; if you do so, new lists will never created !!!
; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, CreatedDir, % "" ; RegWrite , RegSave
; RegRead, aScriptDir, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, aScriptDir
;\____ CreatedDir __ 190131114634 __ 31.01.2019 11:46:34 __/

#NoEnv

;/¯¯¯¯ Performance ¯¯ 190217075111 ¯¯ 17.02.2019 07:51:11 ¯¯\
SetBatchLines, -1 ; I can not do recognice any improvement with that right now
; SetBatchLines, -1 ; used till 03.11.2018 18:51. thats okay. Use SetBatchLines -1 to never sleep (i.e. have the script run at maximum speed). The default setting is 10m
ListLines Off ; history of lines most recently executed is shown
; see: https://www.autohotkey.com/docs/misc/Performance.htm
; https://www.thesycon.de/eng/latency_check.shtml
; https://www.autohotkey.com/boards/viewtopic.php?p=263928&sid=897c0e6c67e541a9dcbe3cbf0f661825#p263928
;\____ Performance __ 190217075115 __ 17.02.2019 07:51:15 __/


; Check if this script is already running (from a different location) and, if so, close the older process
CheckProcess(){ ; https://www.autohotkey.com/boards/viewtopic.php?p=270490&sid=c32390254b53fb40d729b4d989b6769c#p270490
  PID := DllCall("GetCurrentProcessId")
  Process, Exist, %A_ScriptName%
  If (ErrorLevel != PID)
    Process, Close, %ErrorLevel%
}
FileEncoding,UTF-8
#Include %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

#Include %A_ScriptDir%\inc_ahk\soundBeep.inc.ahk
#Include %A_ScriptDir%\inc_ahk\sql_temp.class.inc.ahk

#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
; Process, Priority,, Normal
; SetBatchLines, 20ms ; addet 03.11.2018 18:51
; SetBatchLines, 10
SetKeyDelay, -1, -1
SetWinDelay, -1 ; Sets the delay that will occur after each windowing command, such as WinActivate.
; SetWinDelay, 10
SetControlDelay, -1 ; A short delay (sleep) is done automatically after every Control command that changes a control, namely Control, ControlMove, ControlClick, ControlFocus, and ControlSetText (ControlSend uses SetKeyDelay).
; SetControlDelay, 10

lineFileName := RegExReplace(A_LineFile, ".*\\([\w\s\.]+)$", "$1")
; G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\Source\inc_ahk\soundBeep.inc.ahk

;Change the Running performance speed (Priority changed to High in GetIncludedActiveWindow)

; https://autohotkey.com/docs/commands/Process.htm#Priority
; L (or Low), B (or BelowNormal), N (or Normal), A (or AboveNormal), H (or High), R (or Realtime)
Process, Priority,, H ; <=== only use this if its not in a critical development 05.11.2018 13:20
; Process, Priority,, R ; <=== it acts on me as if the script was working more UNstable

; ;19-02-12_20-00;;;Critical, On  ; I can not do recognice any improvement with that right now
; Thread, NoTimers ; https://autohotkey.com/docs/commands/Thread.htm



; tooltip tooltip tooltip  tooltip too tool toolt tool tool tool msgbxo ms msgbox m m  m msgb msgbo msgbox tooltip
; tooltip tooltip t t t t t tooltip msgbox tooltip msgbxo toolt

CoordMode, ToolTip, Screen

fnReceive_actionListAddress := Func("Receive_actionListAddress").Bind(1)
; OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA  ; deprecated 15.02.2018 10:26
; ObjRegisterActive(Stuff, "{93C04B39-0465-4460-8CA0-7BFFF481FF98}")
ObjRegisterActive(fnReceive_actionListAddress, "{93C04B39-0465-4460-8CA0-7BFFF481FF98}")  ; Receive_actionListAddress(CopyOfData){
class Stuff{
    static abc := 1
    callFunction( name, p* ) { ;allows you to call any function in this script
        abc := func( name )
       %abc%( p* )
    }
}

; tool tool 

; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change, % ""
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change, % ""

RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_permanentSELECT, % ""

configMinifyIncAhkAddress := A_ScriptDir "\inc_ahk\minify\config.minify.inc.ahk" ; update_configMinify_incAhkFile()
simulateAfirstUserContact := 0
itsProbablyNewInstallation := (simulateAfirstUserContact || !FileExist(configMinifyIncAhkAddress))
;/¯¯¯¯ itsProbablyNewInstallation ¯¯ 190119180241 ¯¯ 19.01.2019 18:02:41 ¯¯\
;itsProbablyNewInstallation := !(FileExist(g_actionListDBfileAdress))
configIncAhkAddress := A_ScriptDir "\config\config.inc.ahk"
if(itsProbablyNewInstallation){
    msg := "add some defaults to config"
    ToolTip2sec( msg "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )

    FileRead, configContent , % configIncAhkAddress
    configContentNew := RegExReplace( configContent , "m)^([ \t]*g_min_searchWord_length[ ]*\:=[ ]*)\d+", "$1" "0" )
    configContentNew := RegExReplace( configContentNew , "m)^([ \t]*durationMilliseconds[ ]*\:[ ]*)\d+", "$1" "3500" )
    if( StrLen(configContent) <> StrLen(configContentNew) ){
        tempFileAddress := A_ScriptDir "\" A_TickCount ".temp.txt"
        FileAppend, % configContentNew, % tempFileAddress
        FileCopy,% tempFileAddress, % configIncAhkAddress, 1
        Sleep,200
        ; FileDelete,% tempFileAddress
        Sleep,150
    msgBox,tatOO
    }
    FileExist1 := FileExist(configMinifyIncAhkAddress)
    FileExist2 := FileExist(configIncAhkAddress)
    msg =
     (
     existMinify = %FileExist1%
     existConfig = %FileExist2%
     )
    if(0 && InStr(A_ComputerName,"SL5"))
        msgBox,% msg "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
}
;\____ itsProbablyNewInstallation __ 190119180246 __ 19.01.2019 18:02:46 __/

;
;/¯¯¯¯ global ¯¯ 190113082459 ¯¯ 13.01.2019 08:24:59 ¯¯\
;/¯¯¯¯ global ¯¯ 190113082459 ¯¯ 13.01.2019 08:24:59 ¯¯\
;/¯¯¯¯ global ¯¯ 190113082459 ¯¯ 13.01.2019 08:24:59 ¯¯\
;/¯¯¯¯ global ¯¯ 190113082459 ¯¯ 13.01.2019 08:24:59 ¯¯\
#Include %A_ScriptDir%\inc_ahk\global_variables_declaration_without_initialization.inc.ahk

if(0 && InStr(A_ComputerName,"SL5"))
    g_minBytesNeedetToAskBevoreChangingActionList := 812345 ; <== Minimum bytes. then will be asked before the change 20.03.2018 18:22

global g_TimeMilli_SincePriorMouseClick := A_TickCount

global g_actionList_UsedByUser_since_midnight := {} ; [g_actionListID]

g_config := {}
#Include *i %A_ScriptDir%\inc_ahk\minify\config.minify.inc.ahk ; update_configMinify_incAhkFile()



if(g_config.debug.active || g_config.infoBox[1]["showName"]){
    ; use a virtal line and then all your toolTipGui are moveble by mousedrag and drop
    toolTipGui("^_^", x:=0, y:=10, "v)_" ,A_LineNumber,"Purple")
}


SetTimer,check_configFile_Changed,2500

;/¯¯¯¯ check_configFile_values ¯¯ 190124152939 ¯¯ 24.01.2019 15:29:39 ¯¯\
if(!g_config["FuzzySearch"]["MAXlines"] || !g_config["FuzzySearch"]["keysMAXperEntry"]){
msg =
(
fast No/Cancel-Button or ===>
auto >>reload<< in seconds for selfconfig

reasons maybe:
your first install
or Problem with g_config["FuzzySearch"]["enable"]
or g_config["FuzzySearch"]["MAXlines"]
)
msg .= "or " configIncAhkAddress "`n"
msg .= "or " configMinifyIncAhkAddress "`n"
msg .= "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
MsgBox, 4,reload in seconds, % msg,3
IfMsgBox Yes
    reload
IfMsgBox Timeout
    reload
}

g_config.codeRunner_fileExist := {}
for lang,runnerAddress in g_config.codeRunner
{
    exe := g_config["codeRunner"][lang]
    is_codeRunner_exist := FileExist(exe)
    ; g_config.codeRunner_fileExist := { (lang): is_codeRunner_exist }
    g_config.codeRunner_fileExist[lang] := is_codeRunner_exist
    msg := lang ": >" is_codeRunner_exist "<"
    ; if(is_codeRunner_exist)
    ;    MsgBox,% msg
}
infoText := ""
for lang,is_codeRunner_exist in g_config.codeRunner_fileExist
    if(!is_codeRunner_exist){
        infoText .= "not exist:    " lang "`n"
    }
if(!InStr(A_ComputerName,"SL5"))
if(infoText){
    ToolTip3sec( "Information (not a Error): `n`nNot all of your CodeRunner exist: `n`n`n" infoText "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",1,100,14 )
}
; MsgBox,262208,% A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% s "`n`n`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
; MsgBox,% "code_AutoHotkey_Community= " g_config.codeRunner_fileExist["code_AutoHotkey_Community"]
; exitapp
;\____ check_configFile_values __ 190124152941 __ 24.01.2019 15:29:41 __/






g_ListBoxX := 0 ; if g_ListBoxX (not false > 0) it never usses CaretXorMouseXfallback . if you want go back to default, reload the
g_ListBoxY := 0 ; if g_ListBoxX (not false > 0) it never usses CaretXorMouseXfallback . if you want go back to default, reload the

global g_show_ListBox_Id_EMTY_COUNT := 0

global g_sending_is_buggy := false ; Solved: SendPlay. 29.07.2017 11:21
global g_doSaveLogFiles := false
global g_doRunLogFiles := false


; msgbox, % g_config.sql.template.dir "`n ==??== `n" g_config.sql.template["dir"] "`n ==??== `n" g_config["sql"]["template"]["dir"]
; ^- interesting all above is the same value 19-02-23_18-39

#Include %A_ScriptDir%\Lib\SQLite_DLLPath.inc.ahk

; DB := new SQLiteDB
#Include %A_ScriptDir%\Lib\Class_SQLiteDB.ahk
if(0){
DB := new SQLiteDB
If (!g_actionListDBfileAdress)
   MsgBox, 16, 19-03-22_12-24
If !DB.OpenDB(g_actionListDBfileAdress) {
   MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode "`n`n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
   ExitApp
}
sql_template_dir := g_config.sql.template.dir
fileNamePrefix := "select0"
fileName := fileNamePrefix (1-1) ".sql"
fileAdress := sql_template_dir "\" fileName
FileRead, SELECT , % fileAdress
If !DB.GetTable(SELECT, Table)
   MsgBox, 16, SQLite Error: GetTable, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
sumStr := ""
If (Table.HasNames) {
  ; Loop, % Table.ColumnCount
  If (Table.HasRows) {
     Loop, % Table.RowCount {
        ; RowCount := LV_Add("", "")
        RowID := A_Index
        Table.Next(Row)
        sumStr .= A_Index - 1 ": "
        Loop, % Table.ColumnCount
        {
            sumStr .= Row[A_Index] "< = " RowID "," Table.ColumnNames[A_Index]
        }
          ; LV_Modify(RowCount, "Col" . A_Index, Row[A_Index])
        sumStr .= "`r`n"
     }
  }
}
Table.Free()
RecordSet.Free()
; DB.CloseDB()
tooltip,% sumStr
msgbox,% fileName ": `n" sumStr
}else{






}

; Tooltip
; Tool


;/¯¯¯¯ doUseNewMethodStartOfImplementing22march2019 ¯¯ 190324044131 ¯¯ 24.03.2019 04:41:31 ¯¯\
    global doUseNewMethodStartOfImplementing22march2019
    ; global doUseNewMethodStartOfImplementing22march2019 := true
    ; global doUseNewMethodStartOfImplementing22march2019 := false
    global DB
    if(doUseNewMethodStartOfImplementing22march2019){
        global DB := new SQLiteDB

        ;msgbox,% ObjToStrTrim(DB) "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"

; clipboard  := "DB.HasKey(""SQL"")=" DB.HasKey("SQL") "`n" get_obj_ToString(DB)
; MsgBox,262208,% ":)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% clipboard


;MsgBox,262208,% ":)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% DB

If (!g_actionListDBfileAdress)
   MsgBox, 16, 19-03-22_12-24
If !DB.OpenDB(g_actionListDBfileAdress) {
   MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode "`n`n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
   ExitApp
}

actionList := "..\actionLists\ChromeWidgetWin1\GitHub_Desktop.ahk"
g_actionListID := getActionListID(g_config["sql"]["template"]["dir"], actionList)

SQL = DELETE FROM performance
If !DB.Exec(SQL)
   MsgBox, 16, SQLite Error: GetTable, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode "`n`n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"


        SELECT = select * from Words limit 5
        If !DB.GetTable(SELECT, Table){
            clipboard := SELECT
           MsgBox, 16, SQLite Error: GetTable, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode "`n`n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
        }



        sumStr := ""
        If (Table.HasNames) {
          ; Loop, % Table.ColumnCount
          If (Table.HasRows) {
             Loop, % Table.RowCount {
                ; RowCount := LV_Add("", "")
                RowID := A_Index
                Table.Next(Row)
                sumStr .= RowID - 1 ": "
                Loop, % Table.ColumnCount
                {
                    sumStr .= Row[A_Index] ; "" Table.ColumnNames[A_Index] " "
                    ; Matches[RowID][A_Index] := Row[A_Index]
                }
              ; LV_Modify(RowCount, "Col" . A_Index, Row[A_Index])
                sumStr .= "`r`n"
             }
          }
        }
        Table.Free()
        ; tooltip,% sumStr
        ; msgbox,% sumStr
}
;\____ doUseNewMethodStartOfImplementing22march2019 __ 190324044151 __ 24.03.2019 04:41:51 __/


if(g_config.debug.DB.table.performance.onLoad == "empty")
    Rebuild_performance_table()


;\____ global __ 190113082444 __ 13.01.2019 08:24:44 __/
;\____ global __ 190113082444 __ 13.01.2019 08:24:44 __/
;\____ global __ 190113082444 __ 13.01.2019 08:24:44 __/
;\____ global __ 190113082444 __ 13.01.2019 08:24:44 __/

if(1 && InStr(A_ComputerName,"SL5"))
	Speak("sound check sucessful. you could config it with: g_doSound ","PROD")




debug(g_config,["debug","actionList","onChange"], actionList)
; msgbox,% g_config["debug"]["window"]["onChange"].color



; SoundbeepString2Sound("zzz")
; SoundbeepString2Sound("aaa")
; exitApp
; SoundbeepString2Sound("abc") ; 3 beep
; SoundbeepString2Sound("abcd")
; SoundbeepString2Sound("zx")
; SoundbeepGameOver()

; doValueCopy. todo: issue . doValueCopy : false  is not fully implemented

countNotchangingActiveTitleOLD := 0


listBoxFontSizeOLD := g_ListBoxFontSize


feedbackMsgBoxCloseAllWindows()

;/¯¯¯¯ helloWelcomeMessage ¯¯ 190113113557 ¯¯ 13.01.2019 11:35:57 ¯¯\

if(itsProbablyNewInstallation){
helloWelcomeMessage =
(
Hello, welcome to gi. I tried my best with gi and I hope you have a great with it, if you have any trouble and anything, please reach out to me, message me, I will try my best to solve your issues. thanks again, enjoy.

it would be great if you provide some review, it will give me a chance to create a better GI for you and everyone.
thank you. :)

now you should see a little GI icon into your taskBar.


BTW: gi thinks you are a new user because
'%configMinifyIncAhkAddress%'
has not been generated before.
for the configuration please use:
'%configIncAhkAddress%'
its also accessible via the TrayMenu.
There gi have just made a few small changes.
)
; TrayMenu ??? 09.01.2019 19:40
feedbackMsgBox(substr(helloWelcomeMessage,1,100) "...", helloWelcomeMessage, 1, 1, 66 * 5 )
}
;\____ helloWelcomeMessage __ 190113113600 __ 13.01.2019 11:36:00 __/



;/¯¯¯¯ showFilePrefix ¯¯ 190113113547 ¯¯ 13.01.2019 11:35:47 ¯¯\
if(g_config["sql"]["select"]["showFilePrefix"]){
msg =
(
showFilePrefix is set TRUE
showFilePrefix useful if you want find out which select data supplies
it is recommended set it off by normal using.

If the selects do not work as expected, it may be helpful to backup the database, then delete the database once.
so it should be recreated automatically by next start.
see: \Source\config\config.inc.ahk
(13.01.2019 11:34)
)
title := substr(msg,1,100) "..."
if(!WinExist(title)){
    ; feedbackMsgBox(title, msg, 1, 1, 66 * 5 )
    MsgBox, , % title, % msg
}
}
;\____ showFilePrefix __ 190113113551 __ 13.01.2019 11:35:51 __/





temp := "___________________________________`n"



    lll("`n" . A_LineNumber, A_ScriptName, temp . " STARTING first lines :) ")



if(!fileExist(actionList_isNotAProject)){
    msg := ":( ERROR: !fileExist(" actionList_isNotAProject " =actionList_isNotAProject) `n`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    lll("`n" . A_LineNumber, A_ScriptName, msg)
    Msgbox,% msg
    clilpboard := msg
    sleep,5000
}
RegRead, actionList, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList ; todo: 02.03.2018 12:55 18-03-02_12-55
if(!fileExist(actionList)){
    ; addet 26.4.2018 12:58 becouse of mistourios things
    ; deactivated 10.06.2018 08:36 becouse messeage disturbing every new installed is first time started.
    ; and becouse dont know the use of this lines?
    msg = :( !fileExist(%actionList%) `n token80 `n (%A_LineFile%~%A_LineNumber%)
    lll("`n" . A_LineNumber, A_ScriptName, msg)
    if(false){
        Msgbox,% msg
        clilpboard := msg
        sleep,5000
    }
}



maxLinesOfCode4length1 := 900 ;




;/¯¯¯¯ config_readonly ¯¯ 190224171802 ¯¯ 24.02.2019 17:18:02 ¯¯\
if(false){
; Gui -DPIScale
; testobj := {one: [1,2,3], two: {foo: 1, bar: 2, baz: 3}}
; tlv := new TreeListViewTest(TestNode(g_config), "w600 h400", "Name|Value")
; tlv.MinEditColumn := 1
; tlv.MaxEditColumn := 3
; Gui Show, , config readonly
; winwaitactive, config readonly
}
;\____ config_readonly __ 190224171805 __ 24.02.2019 17:18:05 __/




; SetTimer, saveIamAllive, 8000 ; setinterval
; SetTimer,checkInRegistryChangedActionListAddress,600 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; SetTimer,checkInRegistryChangedActionListAddress,2000 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; SetTimer,checkInRegistryChangedActionListAddress,100 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; SetTimer,checkInRegistryChangedActionListAddress,200 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; SetTimer,checkInRegistryChangedActionListAddress,150 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; SetTimer,checkInRegistryChangedActionListAddress,1000 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList

SetTimer,checkInRegistryChangedActionListAddress,80 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
/*
30.01.2019 09:48 : changed from 2000 to 200 ==> 0,27 CPU maybe
30.01.2019 09:48 : changed from 2000 to 150 ==> 0,54 CPU maybe
30.01.2019 09:48 : changed from 2000 to 100 ==> 1,15 CPU maybe
30.01.2019 09:48 : changed from 2000 to 50 ==> 1,69 CPU maybe
a disadvantage is that when you accidentally make a window change then the maybe a new big list is loaded long time.
; problem actually 19-01-30_11-05 if you reload to fast maybe open the action list by right click gives wrong result
; reproduce: everything, type, open list by right click produces error:
---------------------------
gi-everywhere.ahk
---------------------------
ops. Cant open a folder?
you try opening:
'G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\Source\'
file not folder ecpected.

somme additional info:
 = aScriptDir

 (openInEditorFromIntern:138 openInEditor_actionList.inc.ahk)
---------------------------
OK
---------------------------

*/
SetTimer,checkInRegistryChangedActionListAddress,off ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList


SetTimer,lbl_check_permanentSELECT_changedInRegistry,100 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList

;/¯¯¯¯ config_checkActionListAHKfile_sizeAndModiTime ¯¯ 190119095143 ¯¯ 19.01.2019 09:51:43 ¯¯\
;config_checkActionListAHKfile_sizeAndModiTime
lbl_default_checkActionListAHKfile_sizeAndModiTime := 8123456789
lbl_default_checkActionListAHKfile_sizeAndModiTime := 500
lbl_default_checkActionListAHKfile_sizeAndModiTime := 8000 ; used: 19-01-19_09-50
; SetTimer,checkActionListAHKfile_sizeAndModiTime, % lbl_default_checkActionListAHKfile_sizeAndModiTime
; ^--- It is much more enjoyable, smother without this timer 19-01-19_09-56
;\____ config_checkActionListAHKfile_sizeAndModiTime __ 190119095149 __ 19.01.2019 09:51:49 __/

; tooltip Tooltip Tooltip Msgbox Tooltip
; To msgbox

SetTimer,check_some_keys_hanging_or_freezed,1800 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
SetTimer,check_actionList_GUI_is_hanging_or_freezed,1800 ; ; 26.09.2018 16:38 it sometimes happesn.
SetTimer,checkWinChangedTitle,1000 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList



; tool tool tooltip too tooltip
; tooltip



SetTimer,doListBoxFollowMouse,off
;SetTimer,doListBoxFollowMouse,off



; SetTimer,lbl_repeat_ShowListBox,1000 ; may helps using reactOS 19-01-05_13-00
; no effect 05.01.2019 13:08



RegRead, g_ListBoxX, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_ListBoxX
RegRead, g_ListBoxY, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_ListBoxY
; a li s too test halo



; SetTitleMatchMode,regEx
; #IfWinActive,(Autohotkey|\.ahk)
; Hotkey, ^+esc, off ; l



#IfWinActive,
Hotkey, WheelUp, off
Hotkey, WheelDown, off
Hotkey, #s, off ; toggle_RealisticDelayDynamic()
if(1 && InStr(A_ComputerName,"SL5"))
    Hotkey, #s, on ; toggle_RealisticDelayDynamic()
; #IfWinActive,AHK Studio ahk_class #32770
; Hotkey, ^s, on



; tool t tool  too too
; Tooltip
if(g_config.infoBox[2]["crosshair"]){
tipLast := a_hour ":" a_min ":" a_sec
toolTipGui(tipLast " (" RegExReplace(A_LineFile,".*\\") ">" A_LineNumber ")", x:=0, y:=0, "¯" ,A_LineNumber,"Yellow")
}
if(0){
feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, " oldKeywords=" oldKeywords "`n`n" ObjSToStrTrim(DBstr:="", DB) DBstr )
run,tools\DebugVars\DebugVars.ahk
        pause
}

; Tooltip


#IfWinActive,




#SingleInstance,Force ; thats sometimes not working : https://autohotkey.com/boards/viewtopic.php?f=5&t=1261&p=144860#p144860



DetectHiddenWindows,Off
SetTitleMatchMode,1
scriptName := SubStr( A_ScriptName , 1 , Strlen(A_ScriptName)-4)
#NoTrayIcon ; make it unvisible #NoTrayIcon ; make it unvisible Wozu???????????? dar?ber kanne es erkennen ob nicht schon eine andere instanz l?uft... es w?rde sonst denken eine andere l?uft schon???? 16.11.2017 09:06 17-11-16_09-06



IfWinExist, %scriptName% - Active ; maybe  work 26.04.2017 15:28
{
 ; Msgbox,%scriptName% ?= %g_ScriptTitle% `n (%A_LineFile%~%A_LineNumber%)



lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"exit ")
   ExitApp ; this protect hopefully the scipt from building 100drets of instances.
   ; this was happend during looking videos. tv- mediathek oder sometimes youtube.
}
; Menu, Tray, Tip, %g_ScriptTitle% - Inactive ; make it visible again
WinShow,%g_ScriptTitle%
DetectHiddenWindows,On ; if this is off it does not find the tool in tray bar 27.04.2017 12:04
SetTitleMatchMode,2  ; if this is 1 it does not find the tool in tray bar 27.04.2017 12:04



; DetectHiddenWindows,On
; IfWinNotExist,Could not close the previous instance of this script_autoCloser.ahk
;    run,%A_ScriptDir%\Could not close the previous instance of this script_autoCloser.ahk



;WinWait,Typing_Aid_everywhere_multi_clone.ahk ahk_class AutoHotkey



g_nextCriticalCommandString := "104:Suspend, On"
; Disables all hotkeys



;msgbox,% A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") "`n SuspendOn()`n"
Suspend, On ; wieder (10.07.2017 11:47) auskommentiert weils mir zu oft auf suspand on war. wehr oft wenn ich auf skype gewecheelt habe. hoffe die anderen bugFix haben den Seiteneffekt das ich dieses nicht mehr brauche.



g_nextCriticalCommandString := ""
Gosub, saveIamAllive






g_OSVersion := GetOSVersion()



;Set the Coordinate Modes before any threads can be executed
CoordMode, Caret, Screen
CoordMode, Mouse, Screen



EvaluateScriptPathAndTitle()



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; next line is useless sice 16.07.2017 11:51 . i have daktivated it.
; SetTimer, checkActiveTitleChanged, 50 ; 31.07.2017 20:57
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



;disable hotkeys until setup is complete
g_nextCriticalCommandString := "120:SuspendOn()"
g_nextCriticalCommandTimeIdle := A_TimeIdle
SuspendOn()  ; wieder (10.07.2017 11:51) auskommentiert weils mir zu oft auf suspand on war. wehr oft wenn ich auf skype gewecheelt habe. hoffe die anderen bugFix haben den Seiteneffekt das ich dieses nicht mehr brauche.
g_nextCriticalCommandString := ""



; Gosub, setActionListFileUpdatedTime ; 29.04.2017 14:03



;Change the setup performance speed
SetBatchLines, 20ms
;read in the preferences file
ReadPreferences()



SetTitleMatchMode, 2



;set windows constants
g_EVENT_SYSTEM_FOREGROUND := 0x0003
g_EVENT_SYSTEM_SCROLLINGSTART := 0x0012
g_EVENT_SYSTEM_SCROLLINGEND := 0x0013
g_GCLP_HCURSOR := -12
g_IDC_HAND := 32649
g_IDC_HELP := 32651
g_IMAGE_CURSOR := 2
g_LR_SHARED := 0x8000
g_NormalizationKD := 0x6
g_NULL := 0
g_Process_DPI_Unaware := 0
g_Process_System_DPI_Aware  := 1
g_Process_Per_Monitor_DPI_Aware := 2
g_PROCESS_QUERY_INFORMATION := 0x0400
g_PROCESS_QUERY_LIMITED_INFORMATION := 0x1000
g_SB_VERT := 0x1
g_SIF_POS := 0x4
g_SM_CMONITORS := 80
g_SM_CXVSCROLL := 2
g_SM_CXFOCUSBORDER := 83
g_WINEVENT_SKIPOWNPROCESS := 0x0002
g_WM_LBUTTONUP := 0x202
g_WM_LBUTTONDBLCLK := 0x203
g_WM_MOUSEMOVE := 0x200
g_WM_SETCURSOR := 0x20



;setup code
g_DpiScalingFactor := A_ScreenDPI/96
g_Helper_Id = 
g_HelperManual = 
g_DelimiterChar := Chr(2)
g_cursor_hand := DllCall( "LoadImage", "Ptr", g_NULL, "Uint", g_IDC_HAND , "Uint", g_IMAGE_CURSOR, "int", g_NULL, "int", g_NULL, "Uint", g_LR_SHARED ) 
if (A_PtrSize == 8) {
   g_SetClassLongFunction := "SetClassLongPtr"
} else {
   g_SetClassLongFunction := "SetClassLong"
}
g_PID := DllCall("GetCurrentProcessId")
AutoTrim, Off 



; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), "test  6", 1, 1, 6 )



; RebuildDatabase(g_config["sql"]["template"]["dir"])
if(g_config.debug.DB.table.performance.onLoad == "empty")
    Rebuild_performance_table()



; while(RegExMatch(Build,"O)(\w+)",Found,Pos),Pos:=Found.Pos(1)+Found.Len(1)){
;    LastWord:=Found.1
; to tooltiip too



; RegRead, g_config["listBoxGui"]["tipps"]["show"] , HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, listBoxGui_tipps_show
; RegRead, g_config[" ... , HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_doSound



; RegRead, g_isListBoxDisabled    , HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_isListBoxDisabled
;/¯¯¯¯ g_min_searchWord_length ¯¯ 181202112524 ¯¯ 02.12.2018 11:25:24 ¯¯\
; RegRead, g_min_searchWord_length, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_min_searchWord_length
; regwrite/regread: data normalization of true and false ??? https://autohotkey.com/boards/viewtopic.php?f=76&t=59740
 ; RegWrite , RegSave
if(0 && !g_min_searchWord_length && InStr(A_ComputerName,"SL5")){
    todo =
    (
    if g_min_searchWord_length == 0
    moving wordlist is not working at the moment
    if you typing not matching things you need to change a window for using it again
    or try to use it twice (use shortcut twice)
    )
    feedbackMsgBox("g_min_searchWord_length:" g_min_searchWord_length, g_min_searchWord_length "`n`n`n" A_LineNumber . " " .  A_LineFile,1,1)
}


; too too#ClipboardTimeout
; #HotkeyInterval#CommentFlag

if(g_min_searchWord_length <= 2) ; becouse of performance reasons. thats optional. dont need 02.12.2018 09:25
    g_min_searchWord_length_2 := g_min_searchWord_length + 2
;\____ g_min_searchWord_length __ 181202112528 __ 02.12.2018 11:25:28 __/



; test test test test
; test tool tooltip  tool tool
; ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )

; MsgBox,262208,%  A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" g_config["editor"]["tryThisEditorFirst"] "=tryThisEditorFirst :)`n"


BuildTrayMenu()
setTrayIcon("loading. from: " A_LineFile)



if(g_isListBoxDisabled){
    DestroyListBox()
    setTrayIcon("g_isListBoxDisabled")
}
else
    InitializeListBox()



if(g_min_searchWord_length==0){
    InitializeListBox()
    RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
    ShowListBox()
}
;



BlockInput, Send

lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"InitializeHotKeys()")
InitializeHotKeys()

lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"DisableKeyboardHotKeys()")
DisableKeyboardHotKeys()

g_actionListID := getActionListID(g_config["sql"]["template"]["dir"], actionList) ; 24.03.2018 23:02
ReadInTheActionList(g_config["sql"]["template"]["dir"], A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))

g_WinChangedCallback := RegisterCallback("WinChanged")
g_ListBoxScrollCallback := RegisterCallback("ListBoxScroll")
if !(g_WinChangedCallback){
   MsgBox, Failed to register callback function  `n (%A_LineFile%~%A_LineNumber%)
   ExitApp
}
if !(g_ListBoxScrollCallback){
   MsgBox, Failed to register ListBox Scroll callback function  `n (%A_LineFile%~%A_LineNumber%)
   ExitApp
}



GetIncludedActiveWindow() ;Find the ID of the window we are using



if(true){
    ; is updated each time relods the script. currently independent of the timestamp of the file.
    ; This allows someone to change the files and does not have to delete the table first ; 28.11.2018 12:15
    ; Sql_Temp.sqLite2obj()
    ; if(!Sql_Temp.valueObj)
    Sql_Temp.file2sqLite(g_config["sql"]["template"]["dir"])
    Sql_Temp.sqLite2obj()
    if(!Sql_Temp.valueObj)
        msgbox,% " ERROR !Sql_Temp.valueObj `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
}

gosub, checkInRegistryChangedActionListAddress ; At the moment I have the problem that when restarting the wrong list was loaded. it was not ahk list. was repared by window switch alt-tab . may this helps 11.01.2019 23:08

;/¯¯¯¯ test open config
; gosub lbl_open_config_file
;\____ test open config


; run,tools\DebugVars\DebugVars.ahk



setTrayIcon()

return_from_LineNumber := create_al_Address(actionList
,activeTitle,activeClass,controlName
,stop_list_change
,actionListDirBase )







;/¯¯¯¯ playGround ¯¯ 190322063403 ¯¯ 22.03.2019 06:34:03 ¯¯\
if(false){ ; sqLite playGround
; the following returns nothing from the database (no errors) if i use ahk, gives results if i using sqlitebrowser:
select =
(
SELECT rowid FROM ( SELECT rowid FROM Words LIMIT 1 ) t1
UNION ALL
SELECT rowid FROM ( SELECT rowid FROM Words ORDER by rowid DESC LIMIT 1 ) t2
)
; the following returns a number from the database:
select =
(
SELECT rowid FROM Words LIMIT 1
)

	try{
		results := g_actionListDB.Query(select)
		for each, row in results.Rows
		{
			msgbox,% row[1] = "`n>" row[1] "<`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		}
        msgbox,% select "`n" row[1] "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	} catch e{
		tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line

		if oFunc := Func("SQLite_LastError") ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=63186&p=270178#p270178
            sqlLastError := %oFunc%()
        else
            toolTip2sec( SQLite_LastError " :( not found`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
		; sqlLastError := SQLite_LastError()

		tip .= "`n sqlLastError=" sqlLastError "`n sql=" select " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
		tooltip, `% tip
		feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
		Clipboard := tip
		msgbox, % tip
	}
reload
}
;\____ playGround __ 190322063417 __ 22.03.2019 06:34:17 __/


SoundbeepString2Sound( "test" A_LineFile, "DEBUG" ) ;   ;  (DEV, TEST, STAGING, PROD)
;   Msgbox,% g_config.debug.actionList.onChange.infoBox " 19-04-09_17-16"

; color := g_config.debug.actionList.onChange.color
; Msgbox,%color% `n(%A_LineFile%~%A_LineNumber%)


    if(g_config.debug.DB.onLoad.delete){
        FileDelete,%g_actionListDBfileAdress%
        sleep,500
    }




debug(g_config,["debug","actionList","onChange"], actionList)

if(g_config.debug.DB.table.performance.onLoad == "empty")
    Rebuild_performance_table()


MainLoop()

; too too too tool

; dirty bugfix, https://github.com/sl5net/global-IntelliSense-everywhere/issues/4
; __ __
; tooltip tooltip
;<<<<<<<<<<<<<<<<< workaround <<<<<<<<<<<<<<<<<
; https://stackoverflow.com/questions/52493547/autohotkey-read-of-two-underscore-keys
; https://github.com/sl5net/global-IntelliSense-everywhere/issues/4



; #IfWinActive,asdjkfhaldjskahdskfjh
; ~^s:: ; funktioniert nur einmal oder so ... komishc
;     editor_open_folder() {
;         Speak(A_LineNumber ": gespeichert" )
;         sleep,250
;         ; Gosub,checkActionListAHKfile_sizeAndModiTime
;         ; SetTimer,checkActionListAHKfile_sizeAndModiTime,Off
;         SetTimer,checkActionListAHKfile_sizeAndModiTime,On
;     }
;
;Gosub,checkActionListAHKfile_sizeAndModiTime
  ;  speak(A_LineNumber ": Ctrl s Shortcut found" )
    ; sleep,555
    ; Gosub,checkActionListAHKfile_sizeAndModiTime
    ; SetTimer,checkActionListAHKfile_sizeAndModiTime,Off
    ; SetTimer,checkActionListAHKfile_sizeAndModiTime,1200
; return

setTitleMatchMode,1
#IfWinActive,doubleCtrl detected: Hide ListBox
Esc::
; winclose,doubleCtrl detected
; winkill,doubleCtrl detected
ControlSend, , n, doubleCtrl detected
ToolTip5sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
return


;/¯¯¯¯ doubleCtrl double Ctrl ListBoxDisabled¯¯ 181201095644 ¯¯ 01.12.2018 09:56:44 ¯¯\
#IfWinActive,
~ctrl::
    ; not exist: A_TimeSinceKey ... if exist its helpful 19-01-13_10-05
   ;If (A_TimeSincePriorHotkey < 280 && A_TimeSincePriorHotkey > 120){ ; 50 was to short. i tested it with holding the ctrl key
If (A_TimeSincePriorHotkey < 500 && A_TimeSincePriorHotkey > 80 ){ ; 50 was to short. i tested it with holding the ctrl key
    ; DoubleClickTime := DllCall("GetDoubleClickTime")   ; Get the doubleclicktime in milliseconds
    ; asking about good doubleCtrl quality 05.01.2019 12:33: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=60699


    ;if(A_PriorKey <> A_ThisHotkey && A_PriorKey <> A_ThisHotkey) ; works not 06.01.2019 15:05
    if(A_PriorKey <> "LControl" && A_PriorKey <> "RControl")
        return
     toolTip2sec( "Ctrl+Ctrl = toggle listbox`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
     ; toolTip2sec( A_PriorKey "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
     ; toolTip2sec( ":) `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )

    ; msgbox,% A_PriorKey "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    ;

; may helpful: https://autohotkey.com/board/topic/56493-easiest-way-to-detect-double-clicks/


    if(0 && InStr(A_ComputerName,"SL5"))
        msgbox,% "toggle Listbox `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"

;

    ; g_fontColor := (g_isListBoxDisabled) ? "cRed" : "cGreen"
    if(1 && !g_isListBoxDisabled){ ; doent need this anymore
        ; MsgBox , Options, Title, Text, Timeout / countdown
        MsgBox, 4,doubleCtrl detected: Hide ListBox ? (%A_TimeSincePriorHotkey%ms = TimeSincePriorHotkey),  `nYES? or ESC/NO?   (timeout 2sec), 2
		IfMsgBox yes
		{
            g_isListBoxDisabled := !g_isListBoxDisabled

            g_doListBoxFollowMouse := false
            SetTimer,doListBoxFollowMouse,off
        }
    }else
        g_isListBoxDisabled := !g_isListBoxDisabled

    if(g_isListBoxDisabled){
        DestroyListBox()
        setTrayIcon("g_isListBoxDisabled")
    }else{
        g_doListBoxFollowMouse := false
        SetTimer,doListBoxFollowMouse,off
        InitializeListBox()



        ; g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
        backup_g_min_searchWord_length := g_min_searchWord_length
        g_min_searchWord_length := 0  ; temporarily. list pops up short time user could see something was happend 05.12.2018 12:37
        ShowListBox() ; maybe sometimes neeedet 01.12.2018 11:32
        RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        setTrayIcon()



        if(g_min_searchWord_length <> backup_g_min_searchWord_length){
            ; sleep,100 ; short time user could see something was happend 05.12.2018 12:37
            g_min_searchWord_length := backup_g_min_searchWord_length
        }
        RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_min_searchWord_length, %g_min_searchWord_length% ; RegWrite , RegSave
    }
     if(InStr(A_ComputerName,"SL5")){
         setTitleMatchMode,2
     if(WinActive( "ahk_class SunAwtFrame" )){ ; idea use this shortcut also
     Sleep,30
     Send,{esc}
     Sleep,150 ; 50 works 100 works 150 works  200 works 300 works
     ; works NOT always: 5 10 100
     Send,{esc}
    }}



;
; global-IntelliSense-everywhere-Nightly-Build [G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build] - ...\Source\gi-everywhere.ahk [global-IntelliSense-everywhere-Nightly-Build] - IntelliJ IDEA (Administrator) ahk_class SunAwtFrame ; mouseWindowTitle=0x7f12b2  ;
;
;       Gui, ListBoxGui:Font, s%g_ListBoxFontSize% %g_fontColor% Bold, %ListBoxFont% ; https://autohotkey.com/docs/commands/GuiControl.htm#Font
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_isListBoxDisabled, %g_isListBoxDisabled% ; RegWrite , RegSave , Registry
    return
}
return
;\____ doubleCtrl __ 181201095649 __ 01.12.2018 09:56:49 __/



; 54625 toool        too___hallo Welt von global too msgbox lkjl451212
;




;/¯¯¯¯ doubleCtrlC Ctrl+C double CtrlC ¯¯ 181108142340 ¯¯ 08.11.2018 14:23:40 ¯¯\
; doubleCtrlC for add entry to actionsList
#IfWinNotActive,ahk_class #32770 ; let messageboxes out because i won't copy the message completely 22.11.2018 22:11
~^c::
   KeyWait, c, L
   ; KeyWait, Ctrl, L
   diffMilli := A_tickCount - copyCTriggeredTimeMilli
   ; diffMilli > 750 ... was not ok 20.11.2018 20:58
   if( diffMilli > 750 || diffMilli < 18 ){ ; diffMilli < 10 probably not human triggerd
      copyCTriggeredTimeMilli := A_tickCount
      return
   }



  if(instr(actionList,"\isNotAProject") || !actionList ){
       toolTip4sec( actionList "`n`nFirst, create a list`n before entry can be added. `n(" A_ThisLabel " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",1,1 )
   return
  }



    ; MsgBox,262208,% diffMilli "=diffMilli :)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    RegExReplace(A_LineFile,".*\\")



    ; msgbox,% "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    actionListWithoutGenerated_withExt := StrReplace(actionList_withExt, "._Generated.ahk", "")



    while(!clipboard && A_index < 100)
        Sleep, 10
     if(!clipboard){
        ToolTip8sec( "ups. clipboard is empty.`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
        return
     }
     s := clipboard
     s := regExReplace(s,"(``|`%)","``$1")
     ; s := regExReplace(s,"`%","``%")
     s := regExReplace(s,"^([ ]*)\)","$1`)")
     ; msgbox,% s "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    isMultiline := (regExMatch(trim(s), "m)\n"))



if(isMultiline){
s =
(
|r|
%s%
)
}



    ;if(isMultiline)
     ;   msgbox,% clipboard "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    ;msgbox,% clipboard "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
;


    ; extension := SubStr( actionListWithoutGenerated_withExt , -3 )
    ; actionListWithoutGenerated_withExt := StrReplace(actionList_withExt, "._Generated.ahk", "")
    sActionListWithoutGenerated_withExt := RegExReplace(actionList,"\.[^\\]*$") ".ahk"
    extension := SubStr( sActionListWithoutGenerated_withExt , -3 )
    if(extension <> ".ahk"){
        m =
        (
%actionListWithoutGenerated_withExt% = actionListWithoutGenerated_withExt
%sActionListWithoutGenerated_withExt% = sActionListWithoutGenerated_withExt
%extension% = extension
%actionList% = actionList `n`n
        )
        MsgBox,262160,is wrong extension, % m "is wrong extension :(`n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

    }

    sActionListFileName := actionListFileName ; needs to saved becouse it changing if input box inside
    ; ; needs to saved becouse it changing if input box inside
    ;msgbox,%  actionListWithoutGenerated_withExt "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    ;return
    timeoutSec := 9
    AHKcode := "#" "NoTrayIcon `n"
    AHKcode2 =
    (
SetWorkingDir,%A_ScriptDir%
sActionListWithoutGenerated_withExt = %sActionListWithoutGenerated_withExt%
; actionList_withExt = %actionList_withExt%
; actionListWithoutGenerated_withExt = %actionListWithoutGenerated_withExt%
; actionList = %actionList%
s =
(



%s%
`)
if(true){
    inputBox, s, add to actionLists?, add to ``n%sActionListFileName%  ? ``n``n timeoutSec = %timeoutSec% , , 350, 180,,,,%timeoutSec%,`% s
     if ErrorLevel
        return
    s =
(

`%s`%
`)
}
if(!sActionListWithoutGenerated_withExt)
    MsgBox,262160,sActionListWithoutGenerated_withExt is empty, `% ":( (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
FileAppend, `% s , %sActionListWithoutGenerated_withExt%
; clipboard := sActionListWithoutGenerated_withExt
exitApp
    )
    ; clipboard := AHKcode AHKcode2 " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"


; if("%isMultiline%"){
result := Loop_Parse_ParseWords( s )
; rootLineObj := { value:s, Aindex: 1 }
; isCommandType := setCommandTypeS(rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj )
; AddWordToList(rootCmdTypeObj,strDebug4insert:="",strDebugByRef:="",1,1, s , 0,"ForceLearn",LearnedWordsCount, rootCmdTypeObj.is_IndexedAhkBlock)

    DynaRun(AHKcode AHKcode2)
    if(0 && InStr(A_ComputerName,"SL5"))
        msgbox,% AHKcode2 "`n saved to " sActionListWithoutGenerated_withExt "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    ; tooltip,% AHKcode2 "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"



   ; InactivateAll_Suspend_ListBox_WinHook()
return
;\____ doubleCtrlC __ 181108142352 __ 08.11.2018 14:23:52 __/



;/¯¯¯¯ underscores__ ¯¯ 181201095127 ¯¯ 01.12.2018 09:51:27 ¯¯\
#IfWinActive,alsdkfjasödklfjasdöklfasödf
:b0*?:__:: ;does not delete the underscores
    ; ToolTip4sec(" (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
    ; return
    SetTimer, show_ListBox_Id, 600 ; setinterval
    Sleep,100
    g_reloadIf_ListBox_Id_notExist := true
    ; reload_IfNotExist_ListBoxGui()
    ; ~_:: countUnderscore++ if(countUnderscore == 2){ countUnderscore := 0 reload_IfNotExist_ListBoxGui()
return
;\____ underscores__ __ 181201095132 __ 01.12.2018 09:51:32 __/



;/¯¯¯¯ reload_IfNotExist_ListBoxGui ¯¯ 181201095157 ¯¯ 01.12.2018 09:51:57 ¯¯\
reload_IfNotExist_ListBoxGui(){
   global g_ListBox_Id



if(true){
    winTitle := "Action List Appears Here"
    class := "ahk_class AutoHotkeyGUI"



    ; DetectHiddenText, on
    DetectHiddenWindows, on
    WinWait,%winTitle% %class%, , 5
    WinGet, listBox_Id, ID, Action List Appears Here
    msg := listBox_Id " - g_ListBox_Id : " g_ListBox_Id
    ;ToolTip4sec(msg " = msg (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
    tooltip,% msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    ;MsgBox,% msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    IfWinExist, %winTitle% %class%, , 5
        MsgBox,% msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    ;__ __ __ __ __ __ ______ __



}



    AHKcode := "#" . "NoTrayIcon `n "
    AHKcode =
(
    ; class := "ahk_class AutoHotkeyGUI"
    SetTitleMatchMode, 2
    ; DetectHiddenText, on
    DetectHiddenWindows, on
    winTitle := "Action List Appears Here"
    WinWait,`%winTitle`% `%class`%, , 1
    WinGet, listBox_Id, ID, Action List Appears Here.
    IfWinNotExist, `%winTitle`% ; `%class`% __
    {
    ; if(!listBox_Id){
       MsgBox, `%winTitle`% NOT Exist `%class`%  : %A_LineFile%~%A_LineNumber%
       run,`% "..\start.ahk"
    } else {
        tooltip, winTitle=`%winTitle`% found: winText=`%winText`% :%countUnderscore% = countUnderscore : %A_LineFile%~%A_LineNumber%,1,1
        MsgBox, `%winTitle`% Exist `%class`%  : %A_LineFile%~%A_LineNumber%
        sleep,2200
    }
    exitapp
)
    DynaRun(AHKcode)

    return
}
;\____ reload_IfNotExist_ListBoxGui __ 181201095204 __ 01.12.2018 09:52:04 __/



;<<<<<<<<<<<<<<<<< workaround <<<<<<<<<<<<<<<<<
; https://github.com/sl5net/global-IntelliSense-everywhere/issues/4
; :*:___:: ; workaround if it comes sleeping
;   ;run,% "E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere\start.ahk"
;   tooltip, reload every idle time? 31.07.2018 11:44 18-07-31_11-44
;   pause
;    run,% "..\start.ahk"
  ;InitializeListBox() ; don work. produce error... new test 18-06-11_20-00
;   Last_A_This:=A_ThisFunc . A_ThisLabel
;   ToolTip4sec("InitializeListBox `n " A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
return 
;>>>>>>>>>>>>>>>>> workaround >>>>>>>>>>>>>>>
#IfWinActive,
; Ctrl+Shift+Pause
; ^+p:: ; pause
;    tooltip,pause `n (from: %A_LineFile%~%A_LineNumber%)
;    pause
; return



;/¯¯¯¯ Ctrl+Shift+F5 ¯¯ 181201095247 ¯¯ 01.12.2018 09:52:47 ¯¯\
; Ctrl+Shift+F5
^+f5:: ; exit-all-scripts and restart
reload
return
; test
;if(1 && InStr(A_ComputerName,"SL5")){
if(1){
    setRegistry_toDefault()
    msg := "" "`n"
    msg .= "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    MsgBox, 4,^+f5 > reload in seconds, % msg,2
    doReload := false
    IfMsgBox Yes
        doReload := true
    IfMsgBox Timeout
        doReload := true
    if(doReload){
        ToolTip,% "FileDelete, " g_actionListDBfileAdress "`n`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
    /* its not working:
        DetectHiddenWindows,On
        settitlematchmode,2
        ToolTip,`% "winwaitclose %A_LineNumber% %A_ScriptName%"
        winwaitclose,%A_ScriptName%
        winwaitclose,%A_ScriptName%
    */
    settitlematchmode,2
    needle=DB Browser for SQLite ; ahk_class Qt5QWindowIcon
    ifwinExist, % needle
        winclose, % needle

    ; FileRemoveDir, % A_ScriptDir "\log" , 1
    FileDelete, % A_ScriptDir "\log\*.*"

    AHKcode =
(
    soundbeep,3532,400
    ToolTip,`% "FileDelete, %g_actionListDBfileAdress% " (%A_LineNumber%+A_LineNumber+1) " %A_ScriptName%"
    while(A_Index < 100 && FileExist( "%g_actionListDBfileAdress%" )){
    sleep,180
    FileDelete,%g_actionListDBfileAdress%
    }
    if(FileExist( "%g_actionListDBfileAdress%" )){
        ToolTip,`% "FAILED !!! FileDelete, %g_actionListDBfileAdress% " (%A_LineNumber%+A_LineNumber+1) " %A_ScriptName%"
        soundbeep,4000,100
        soundbeep,1500,100
        soundbeep,4000,100
        soundbeep,1500,100
    }
    ToolTip,
    ToolTip,`% "run " (%A_LineNumber%+A_LineNumber+1) " %A_ScriptName%"
    run,%A_ScriptFullPath%
settitlematchmode,2
    ToolTip,`% "activate " (%A_LineNumber%+A_LineNumber+1) " %A_ScriptName%"
    loop,20
    {
    winactivate,ahk_class SunAwtFrame ; mouseWindowTitle=0x180c64  ;
    soundbeep,`% (4555+A_Index*20),700
    sleep,100
    }
    ToolTip,`% "goodbye sound " (%A_LineNumber%+A_LineNumber+1) " %A_ScriptName%"
    while(A_Index < 100){
        soundbeep,`% (3555-A_Index),50
        sleep,50
    }
)
    clipboard := AHKcode
    DynaRun(AHKcode)
    exitApp
    ToolTip,% "FileDelete, " g_actionListDBfileAdress "`n`n" A_ThisFunc ":" A_LineNumber " " A_ScriptName
    if(FileExist( g_actionListDBfileAdress ))
        pause
    exitApp
    ; reload
}
}
return
;\____ Ctrl+Shift+F5 __ 181201095253 __ 01.12.2018 09:52:53 __/



; #IfWinActive,Action List Appears Here. ahk_class AutoHotkeyGUI
; #IfWinActive,ahk_class AutoHotkeyGUI
;#IfWinActive,"ListBoxTitle (sec="
#IfWinActive,
WheelUp::
 ; global g_ListBoxFontSize
 g_ListBoxFontSize := g_ListBoxFontSize + 1
 Tooltip,WheelDown:: Size=%g_ListBoxFontSize% `n (from: %A_LineFile%~%A_LineNumber%) ; to to
return
#IfWinActive,
WheelDown::
 ; global g_ListBoxFontSize
 g_ListBoxFontSize := g_ListBoxFontSize - 1
 Tooltip,WheelDown:: Size=%g_ListBoxFontSize% `n (from: %A_LineFile%~%A_LineNumber%) ; to to
return



;/¯¯¯¯ toggle_RealisticDelayDynamic ¯¯ 181201095447 ¯¯ 01.12.2018 09:54:47 ¯¯\
#IfWinActive,
#s::
 toggle_RealisticDelayDynamic(){
     global g_config
     global test
     g_config["Send"]["RealisticDelayDynamic"] := (g_config["Send"]["RealisticDelayDynamic"]) ? false : true ;
     ; Msgbox,% "RealisticDelayDynamic=`n" g_config["Send"]["RealisticDelayDynamic"] "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
     ToolTip4sec("RealisticDelayDynamic = `n`n`n >" g_config["Send"]["RealisticDelayDynamic"] "< `n`n`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This,1,1)
 }
;\____ toggle_RealisticDelayDynamic __ 181201095452 __ 01.12.2018 09:54:52 __/



; SetTitleMatchMode,2
; #IfWinActive,ahk_class Notepad++  ; ahk - Notepad
; ~^s::
 ; someFunctionNotepad(){
;           sleep,150
;           if(false){
;            Gosub,checkActionListAHKfile_sizeAndModiTime ; seems working only two times if i dont change window. working always inside same window. 01.11.2018 18:24
;            }else{
;             Speak(A_LineNumber ": gespeichert" )
;             global checkActionListAHKfile_sizeAndModiTime
;             SetTimer,checkActionListAHKfile_sizeAndModiTime,Off
;             SetTimer,checkActionListAHKfile_sizeAndModiTime,200
            ; ^- I'm surprised that somehow has no effect 01.11.2018 18:47
            ; https://autohotkey.com/boards/viewtopic.php?f=76&t=58824&p=247295#top
;             SetTimer,checkActionListAHKfile_sizeAndModiTime,On
;           }
; }
; return



; #IfWinActive,AHK Studio ahk_class #32770
; ~^s::
 ; someFunction(){
;           Speak(A_LineNumber ": gespeichert" )
;           Speak(A_LineNumber ": gespeichert" )
;           sleep,250
          ; Gosub,checkActionListAHKfile_sizeAndModiTime
;           SetTimer,checkActionListAHKfile_sizeAndModiTime,Off
;           SetTimer,checkActionListAHKfile_sizeAndModiTime,On



;     WinWaitActive,AHK Studio ahk_class #32770,Please close any error messages and try again,1
;      winclose,
;      msgBox,% ":( ERROR: " msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
;  }
; return



;



;return



; ToolTip3sec("^+esc:: exit-all-scripts",1,1)
SetTitleMatchMode,regEx
#IfWinActive,i).*(Autohotkey|\.ahk|IntelliSense)
; #IfWinActive,
^+esc:: ; exit-all-scripts. usefull in developer mode
    if(1 && InStr(A_ComputerName,"SL5") ){
     setRegistry_toDefault()
     exit_all_scripts()
     ; MsgBox, `n (%A_LineFile%~%A_LineNumber%)
     exitapp
    }
 return



;test too tool tool



#IfWinActive, ; thats probably needet. 27.09.2018 10:29 was problem that hitting 1 , 2 , 3 ... not triggered any. triggers notihng.. with this line it works again.

RecomputeMatchesTimer:
    ; was triggerd by strg+shift+backspace and in search jetbraisns windwo ... may always? 19-01-10_07-19
   ; MsgBox,262208,% "used ?? :)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
   Thread, NoTimers
   RegRead, RegReadActionList_DebugInfo, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
   short_RegReadActionList_DebugInfo := RegExReplace(RegReadActionList_DebugInfo,".*\\")
   short_actionList := RegExReplace(actionList,".*\\")
   isInIn := (instr(actionList,short_RegReadActionList_DebugInfo) || instr(RegReadActionList_DebugInfo,short_actionList) )
   ;  1 is the first character; this is because 0 is synonymous with "false",
    if(!actionList || !isInIn){
        ; actionList := RegReadActionList_DebugInfo ; todo: not pretty 18-12-28_08-27 quck and dirty
        gosub,checkInRegistryChangedActionListAddress
    }
   if(0 && InStr(A_ComputerName,"SL5")){
       isInIn := (instr(actionList,short_RegReadActionList_DebugInfo) || instr(RegReadActionList_DebugInfo,short_actionList) )
        tooltip,% "RecomputeMatchesTimer: " g_Word "(" StrLen(g_Word) ") (" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\") ")" ((!isInIn) ? "Oops: al=" RegExReplace(actionList,".*\\") "<> reg=" RegExReplace(RegReadActionList_DebugInfo,".*\\") : RegExReplace(actionList,".*\\") ) ,1,-20
        ; tes
        ; plausibilty-check (18-12-28_08-03):
        ; WinGetActiveTitle,at
        if( 0 && instr(at, ".ahk") && instr(actionList, "isNotAProject" ))
            tooltip,% "ERROR: wrong list: " actionList "(" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\"),1,20,9
}
    ;/¯¯¯¯ Temporary ¯¯ 181107201243 ¯¯ 07.11.2018 20:12:43 ¯¯\
    ; Temporary switched off
    ; g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
    ; if(1 && !g_reloadIf_ListBox_Id_notExist && StrLen(g_Word) == g_min_searchWord_length ){
    if(!g_reloadIf_ListBox_Id_notExist && RegExMatch(g_Word,"^_{2,}$")  ){ ; tried open edit-mode
        toolTip, % g_Word "(" StrLen(g_Word) ")," g_min_searchWord_length "=g_min_searchWord_length:" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
        ; reload_IfNotExist_ListBoxGui()
        SetTimer, show_ListBox_Id, 600 ; setinterval ; 28.10.2018 02:39: fallback bugfix workaround help todo:
        ;Sleep,100
        g_reloadIf_ListBox_Id_notExist := true
        ; msgbox,% "g_reloadIf_ListBox_Id_notExist:= true(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
    }
   RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; RecomputeMatchesTimer:
Return



; Msgbox,(`%A_LineFile`%~`%A_LineNumber`%)



#MaxThreadsPerHotkey 1



; some users dont have numpad ; 25.03.2018 15:35
; keyState_Numpad := GetKeyState("NumpadAdd","P")
; MsgBox,%keyState_Numpad% = keyState_Numpad (line:%A_LineNumber%) `



; #include,%A_ScriptDir%\shortcuts\listbox_shortcutStyle_numpad09.inc.ahk ; <=== works 28.12.2018 00:31
; #include,%A_ScriptDir%\shortcuts\listbox_shortcutStyle_shiftNumpad09.inc.ahk ; <=== ;( seems not working 18-12-28_00-29
#include,%A_ScriptDir%\shortcuts\listbox_shortcutStyle_ctrlNumpad09.inc.ahk ; <=== default 18-12-28_00-24
#include,%A_ScriptDir%\shortcuts\listbox_shortcutStyle_numpad09_ifMouseInListBox.inc.ahk ; <=== default 19-01-07_21-27
; https://g-intellisense.myjetbrains.com/youtrack/newIssue?draftId=2-472


; tooltip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
; too depreca 1 deprecated



; $^Enter::
; $^Space::
; $Tab::
; $Up::
; $Down::
; $PgUp::
; $PgDn::
; $Right::
; $Enter::
;$NumpadEnter::
;EvaluateUpDown(A_ThisHotKey)
; Return



; $^+h::
; MaybeOpenOrCloseHelperWindowManual()
; Return



; $^+c::
; AddSelectedWordToList()
; Return



; $^+Delete::
; DeleteSelectedWordFromList()
; Return



; Configuration:
; GoSub, LaunchSettings
; Return
; toolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
; 4 44 4 4 4  test too
; tootool too tools tip tool too



lbl_g_ListBoxGui_tippsTOGGLE:
    Last_A_This:=A_ThisFunc . A_ThisLabel
    ToolTip2sec( Last_A_This "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    g_config["listBoxGui"]["tipps"]["show"] := (!g_config["listBoxGui"]["tipps"]["show"])
    ToolTip4sec( ((g_config["listBoxGui"]["tipps"]["show"])?"ON":"OFF") "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, listBoxGui_tipps_show, % g_config["listBoxGui"]["tipps"]["show"] ; RegWrite , RegSave
return

lbl_set_permanent_ActionList:
    Last_A_This:=A_ThisFunc . A_ThisLabel
    ToolTip2sec( Last_A_This "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    run,plugins\ahk\giListSELECT.ahk
return

lbl_g_doSoundTRUE:
    Last_A_This:=A_ThisFunc . A_ThisLabel
    ToolTip2sec( Last_A_This "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    g_doSound := TRUE
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_doSound, %g_doSound% ; RegWrite , RegSave
return

lbl_open_config_file:
    Last_A_This:=A_ThisFunc . A_ThisLabel
    ToolTip2sec( Last_A_This "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    ; edit,%A_ScriptDir%\config\config.inc.ahk
    openInEditorFromIntern(A_ScriptDir "\config\config.inc.ahk")
return



lbl_g_doSoundFALSE:
    Last_A_This:=A_ThisFunc . A_ThisLabel
    ToolTip2sec( Last_A_This "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    g_doSound := FALSE
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_doSound, %g_doSound% ; RegWrite , RegSave
return



lbl_g_min_searchWord_length_0:
    Last_A_This:=A_ThisFunc . A_ThisLabel
    ToolTip2sec( Last_A_This "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    g_min_searchWord_length := 0
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_min_searchWord_length, %g_min_searchWord_length%
     ; RegWrite , RegSave
return
; 18-12-01_10-50 too
lbl_g_min_searchWord_length_1:
    Last_A_This:=A_ThisFunc . A_ThisLabel
    ToolTip2sec( Last_A_This "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    g_min_searchWord_length := 1
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, g_min_searchWord_length, %g_min_searchWord_length%
    ; RegWrite , RegSave
return



lbl_Help_AutoHotkey_online:
    t := "open `n`n autohotkey help online`n`n ?"
    if(!InStr(A_ComputerName,"SL5"))
        msgbox, ,% t,% t "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    IfMsgBox, Cancel
       return
    run,https://autohotkey.com/docs/Tutorial.htm
return
lbl_HelpOnline_EditCreate_actionList:
    t := "open `n`n g-IntelliSense Edit/Create actionList`n`n in myjetbrains.com ?"
    if(!InStr(A_ComputerName,"SL5"))
        msgbox, ,% t,% t "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    IfMsgBox, Cancel
       return
    run,https://g-intellisense.myjetbrains.com/youtrack/print/GIS?q=project`%3A+g-IntelliSense+`%23`%7Bedit+list`%7D
return
lbl_HelpOnline_Search_Keywords:
    t := "open `n`n g-IntelliSense Search Keywords`n`n in myjetbrains.com ?"
    if(!InStr(A_ComputerName,"SL5"))
        msgbox, ,% t,% t "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    IfMsgBox, Cancel
       return
    run,https://g-intellisense.myjetbrains.com/youtrack/print/GIS?q=project`%3A+g-IntelliSense+`%23`%7Bsearch+keywords`%7D
return
lbl_HelpOnline_features:
    t := "open `n`n g-IntelliSense Features`n`n in myjetbrains.com ?"
    if(!InStr(A_ComputerName,"SL5"))
        msgbox, ,% t,% t "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    IfMsgBox, Cancel
       return
    ; run,https://g-intellisense.myjetbrains.com/youtrack/issues/GIS?q=project:`%20g-IntelliSense`%20`%23Feature`%20order`%20by:`%20updated`%20asc`%20
    run,https://g-intellisense.myjetbrains.com/youtrack/print/GIS?q=project:`%20g-IntelliSense`%20`%23Feature`%20order`%20by:`%20updated`%20asc`%20
return
lbl_HelpOnline_shortcut:
    t := "open `n`n g-IntelliSense about Shortcuts`n`n in myjetbrains.com ?"
    if(!InStr(A_ComputerName,"SL5"))
        msgbox, ,% t,% t "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    IfMsgBox, Cancel
       return
    ;run,https://g-intellisense.myjetbrains.com/youtrack/issues/GIS?q=project:`%20g-IntelliSense`%20`%23shortcut`%20order`%20by:`%20updated`%20asc`%20
    run,https://g-intellisense.myjetbrains.com/youtrack/print/GIS?q=project:`%20g-IntelliSense`%20`%23shortcut`%20order`%20by:`%20updated`%20asc`%20
return
lbl_HelpOnline_issues_open:
    t := "open `n`n g-IntelliSense open issues `n`n in myjetbrains.com ?"
    if(!InStr(A_ComputerName,"SL5"))
        msgbox, ,% t,% t "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    IfMsgBox, Cancel
       return
    ; run,https://g-intellisense.myjetbrains.com/youtrack/issues/GIS?q=project:`%20g-IntelliSense`%20`%23Unresolved`%20order`%20by:`%20Priority
    run,https://g-intellisense.myjetbrains.com/youtrack/print/GIS?q=project:`%20g-IntelliSense`%20`%23Unresolved`%20order`%20by:`%20Priority
return

lbl_noOp:
return


PauseResumeScript:
if (g_PauseState == "Paused"){
    if(1 && !InStr(A_ComputerName,"SL5"))
        Msgbox,g_PauseState == "Paused"`n (%A_LineFile%~%A_LineNumber%)
   g_PauseState =
   Pause, Off
   EnableWinHook()
   Menu, tray, Uncheck, Pause
} else {
   g_PauseState = Paused
   DisableWinHook()
   SuspendOn()
   Menu, tray, Check, Pause
   Pause, On, 1
}
Return



ExitScript:
    ExitApp
Return
lblEditThisScript:
    edit,% A_ScriptFullPath
return



#Include %A_ScriptDir%\Includes\gi-everywhere.inc.ahk






;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
doReload:
return ; reload is deaktivated today :D 29.07.2017 14:51 17-07-29_14-51 . i using it from the Administrator user
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



ifActionListFileWasUpdatedChanged:
msgbox,18-03-02_12-51 return
return



    FileGetTime, actionListModiTime, %actionList%, M
    if(actionListModiTime_OLD <> actionListModiTime){
        SetTimer, ifActionListFileWasUpdatedChanged, Off
        SetTimer, ifActionListFileWasUpdatedChanged, 1500 ; one second is really slow. this line is a little obsulete. but better let it be. 31.07.2017 22:45
        actionListOLD := actionList
        ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
        ;GoSub, reloadActionList
        WinGetActiveTitle, activeTitle
        if(activeTitleOLD <> activeTitle )
            activeTitleOLD := activeTitle
    }else{
        ; sometimes it stacks at line 105 105: Suspend,On (573.41)
        ;~ it needs then reloaded 29.04.2017 13:35
        WinGetActiveTitle, activeTitle
        if(activeTitleOLD && activeTitleOLD <> activeTitle && actionListOLD == actionList ){



            actionListModiTime_OLD:=actionListModiTime
            i := 0
            isActuallyWrittenToLog := false
            while(actionListModiTime_OLD == actionListModiTime && i++ < 25){
               ; lets wait a little for new given/copied actionList 16.07.2017 02:01
               Sleep,100
               if(!isActuallyWrittenToLog){
global g_doSaveLogFiles



lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"Title changed, actionList(modiTime) NOT changed so fast ... ups `n actionList=>" . actionList . "< `n Sleep,100")
                  isActuallyWrittenToLog := true
               }
               FileGetTime, actionListModiTime, %actionList%, M
            }



            msg = %activeTitleOLD%  <> `n%activeTitle%
global g_doSaveLogFiles



lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"`n Sleep,100 `n" . msg . "`n ==> Goto, doReload")
           ;feedbackMsgBox("ReadInTheActionList",A_LineNumber . " , " . A_ScriptName,1,1)
            ReadInTheActionList(g_config["sql"]["template"]["dir"], A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; 07.02.2018 17:28
         }
    }
    ;Msgbox, actionList was changed (%A_LineFile%~%A_LineNumber%)
    actionListModiTime_OLD:=actionListModiTime



   ; lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"doReloadIfScriptDontMoveThisLine()")



    doReloadIfScriptDontMoveThisLine()
;
Return



saveIamAllive:
    return
   FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
   FormatTime, timestampyyMMddHHmmssPretty, %A_now%,yy:MM:dd HH:mm:ss
   FileDelete, gi-everywhere_programmCounter_LineAndTime.txt
tooltip,% "FileAppend (" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\") ")"
   FileAppend,117_%timestampyyMMddHHmmssPretty%_line_%timestampyyMMddHHmmss% , gi-everywhere_programmCounter_LineAndTime.txt
return





;/¯¯¯¯ checkActionListAHKfile_sizeAndModiTime ¯¯ 181023101000 ¯¯ 23.10.2018 10:10:00 ¯¯\
;/¯¯¯¯ checkActionListAHKfile_sizeAndModiTime ¯¯ 181023101000 ¯¯ 23.10.2018 10:10:00 ¯¯\
;/¯¯¯¯ checkActionListAHKfile_sizeAndModiTime ¯¯ 181023101000 ¯¯ 23.10.2018 10:10:00 ¯¯\
checkActionListAHKfile_sizeAndModiTime:
    if(0 && !actionList && InStr(A_ComputerName,"SL5")){
        Speak(A_ThisLabel, "PROD" )  ;  (DEV, TEST, STAGING, PROD),
        tooltip,% actionList,1,1,9
    }
    if(!actionList || g_doListBoxFollowMouse)
        return



    ;SetTimer,checkInRegistryChangedActionListAddress,Off



;        Speak(A_LineNumber ":" A_thisFunc A_ThisLabel)
    if(0 && InStr(A_ComputerName,"SL5"))
        SoundbeepString2Sound("a")



    if(instr(actionList,".ahk._Generated.ahk._Generated.ahk")){
        actionList := StrReplace(actionList, ".ahk._Generated.ahk._Generated.ahk", ".ahk._Generated.ahk") ; todo: dirty Bugfix 18-12-24_22-32
    }
    if(instr(actionList,"isNotAProject._Generated.ahk")){
        actionList := RegExReplace(actionList, "isNotAProject\._Generated\.ahk", "isNotAProject.ahk._Generated.ahk" ) ; todo: dirty Bugfix 18-12-24_22-16
    }
    if(!FileExist(actionList)){
        if(FileExist(actionList ".ahk")){
            actionList .= ".ahk" ; what a mess. sometime must be cleaned up here ;) 19-03-18_16-01
            return
        }else{
        if(1 && InStr(A_ComputerName,"SL5")){ ; 23.10.2018 10:08 was used
            msg := ">" actionList "<  `n `n is this deadlink? never used? (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
            ;feedbackMsgBox(msg,msg,1,1)
            tooltip,% msg,1,1
            ; clipboard := actionList  "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
            ; ..\actionLists\_globalActionListsGenerated\isNotAProject._Generated.ahk
            ; pause
            sleep,3000
       }
        ; actionList := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\actionLists\_globalActionListsGenerated\_global.ahk" )
        actionList := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\actionLists\_globalActionListsGenerated\isNotAProject.ahk" )
        }
    }
    if(!FileExist(actionList)){
        msg =
        (
        !FileExist(actionList)
        >>%actionList%<<

        %A_ThisLabel% = A_ThisLabel
        )
        if(1 && InStr(A_ComputerName,"SL5")){
            tooltip,% "ups" msg "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
            ; todo: thats proably not so a big problem.
        }
        Sleep, 100
        return
    }



        if(1 && InStr(actionList,"._Generated.ahk._Generated.ahk")){
             ToolTip9sec(" found ._Generated.ahk._Generated.ahk and not suported `n" actionList "`n" A_LineNumber ) ; in checkActionListAHKfile_sizeAndModiTime



    actionList := StrReplace(actionList, ".ahk._Generated.ahk._Generated.ahk", ".ahk._Generated.ahk") ; clean strange wordlists 25.10.2018 20:03
        }



;



    FileGetSize, actionListSize, %actionList%
    FileGetTime, actionListModified, %actionList%, M
    FormatTime, actionListModified, %actionListModified%, yyyy-MM-dd HH:mm:ss



    SELECTactionListmodified := "SELECT id, actionListmodified, actionListsize FROM actionLists WHERE actionList = '" . actionList . "';"
    ;clipboard := SELECTactionListmodified ; SELECT actionListmodified, actionListsize FROM actionLists WHERE actionList = '..\actionLists\_globalActionListsGenerated\_global.ahk';
    ; [2018-03-20 11:56:58] [1] [SQLITE_ERROR] SQL error or missing database (no such table: actionLists)
    WordsTbl := g_actionListDB.Query(SELECTactionListmodified)
    For each, row in WordsTbl.Rows
    {
        g_actionListID := row[1]
        actionListLastModified := row[2]
        actionListLastSize := row[3]
        break
    }
    ; doReadActionListTXTfile := (actionListSize && actionListModified && (actionListSize <> actionListLastSize || actionListModified > actionListLastModified))



; tooltTip2sec(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)



    isSizeChanged := (actionListSize <> actionListLastSize)
    isTimeChanged := (actionListModified <> actionListLastModified)
    isSizeNull := (!actionListLastSize || !actionListLastSize)



; compu compu https://autohotkey.com/boards/viewtopic.php?f=5&t=59
; com Hallo Rübennase Comp1 compu
; 01.11.2018 14:19



    doReadActionListTXTfile := (isSizeChanged || isTimeChanged || isSizeNull )
    doReadActionListTXTfileSTR = %isSizeChanged%||%isTimeChanged%||%isSizeNull%



    ; ToolTip9sec(doReadActionListTXTfileSTR "`n" actionList "`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
    ; clipboard := actionList



; Hallo compu compu rüben hallo



    if(doReadActionListTXTfile){
        ;msgbox, doReadActionListTXTfile 654654654



        if(0 && isTimeChanged){
            msg =
             (
             %isTimeChanged% = isTimeChanged ('%actionListModified%' <> '%actionListLastModified%')
             %g_actionListID% = g_actionListID
             %actionList% = actionList
             )
            msgbox,% msg "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
        }
        if(0 && isSizeNull){
            msg =
             (
             the old list and the new list is 0 size
             %isSizeChanged% = isSizeChanged
             %g_actionListID% = g_actionListID
             %actionList% = actionList
              (actionListSize='%actionListSize%' <> '%actionListLastSize%'=actionListLastSize)
             )
            msgbox,% msg "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
        }
        ; compu hall Rüb
        if(1 && InStr(A_ComputerName,"SL5"))
            Speak(A_LineNumber ": ReadInTheActionList")
        ReadInTheActionList(g_config["sql"]["template"]["dir"], "checkActionListAHKfile_sizeAndModiTime:" doReadActionListTXTfileSTR " " A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        ;ParseWordsCount := ReadActionList(calledFromStr) ; there is also update and select of time of the actionList
        ;g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
        ; RebuildDatabase(g_config["sql"]["template"]["dir"])
        ; msgbox, have fun with :) `n %actionList% 18-03-02_18-37  (%A_LineFile%~%A_LineNumber%)



        RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; doReload:
        tip := "doReadActionListTXTfile=" doReadActionListTXTfile " ReadInTheActionList  actionList=" actionList " 4567984654888888 "

					; sqlLastError := SQLite_LastError()
        			if oFunc := Func("SQLite_LastError") ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=63186&p=270178#p270178
                        sqlLastError := %oFunc%()
                    else
                        toolTip2sec( SQLite_LastError " :( not found`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )



        tip .= "`n sqlLastError=" sqlLastError " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
        if( instr(sqlLastError, "no such table") ){



            tooltip, % tip
            SuspendOn()
            ;msgbox,% tip
                        if(doUseNewMethodStartOfImplementing22march2019){

        if(!DB.HasKey("SQL")){
            toolTip2sec( "ups !DB.HasKey(""SQL"") `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
            MsgBox, 16, % "ups !DB.HasKey(""SQL"") `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
            ;MsgBox, 16, % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% tip "`n" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
        }
}
            RebuildDatabase(g_config["sql"]["template"]["dir"])
            SuspendOff()
            sleep,3000
            ; msgbox,% tip
            ; reload ; hardcore. anyway. thats a way it works
        }
        ;pause ; RebuildDatabase(g_config["sql"]["template"]["dir"])
        sleep,100
        ;reload ; hardcore. anyway. thats a way it works
    }
    ; SetTimer,checkInRegistryChangedActionListAddress,On
    SetTimer,checkActionListAHKfile_sizeAndModiTime, % lbl_default_checkActionListAHKfile_sizeAndModiTime
return
;\____ checkActionListAHKfile_sizeAndModiTime __ 181023101012 __ 23.10.2018 10:10:12 __/



; msgb



; tool tooltip


;/¯¯¯¯ lbl_check_permanentSELECT_changedInRegistry ¯¯ 190119092044 ¯¯ 19.01.2019 09:20:44 ¯¯\
lbl_check_permanentSELECT_changedInRegistry:
check_permanentSELECT_changedInRegistry(g_permanentSELECT
                                      , g_permanentSELECT_OLD
                                      , ParseWordsCount)
return
;\____ lbl_check_permanentSELECT_changedInRegistry __ 190119092050 __ 19.01.2019 09:20:50 __/


; ActiveTitleOLD2 := activeTitleOLD
;/¯¯¯¯ checkInRegistryChangedActionListAddress ¯¯ 181025104242 ¯¯ 25.10.2018 10:42:42 ¯¯\
; it reads: RegRead, actionListNewTemp_RAW, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; SetTimer,checkInRegistryChangedActionListAddress,2000 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; called from \Window.ahk > WinChanged( :
; SetTimer,checkInRegistryChangedActionListAddress,on
#Include %A_ScriptDir%\inc_ahk\gi\checkInRegistryChangedActionListAddress.inc.ahk
;\____ checkInRegistryChangedActionListAddress __ 181025104318 __ 25.10.2018 10:43:18 __/


        ;/¯¯¯¯ actionListNewTemp_withoutExt ¯¯ 181031091909 ¯¯ 31.10.2018 09:19:09 ¯¯\
get_Action_Lists_without_Extension_and_send_warning(actionListNewTemp,log := ""){
        if(1 && InStr(A_ComputerName,"SL5"))
            feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), actionListNewTemp "`n" log )
            ;msgBox,% log " ==> RETURN `n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"



                    msg = pease use Action Lists without Extension `n thats not an error, a warning`n
                    msg .= actionListNewTemp "`n" ; inside checkInRegistryChangedActionListAddress
                    if( SubStr( actionListNewTemp , -3 ) == ".ahk" )
                        actionListNewTemp_withoutExt := SubStr( actionListNewTemp, 1, -4 )
                    msg .= actionListNewTemp_withoutExt " <== repaired`n" ; inside checkInRegistryChangedActionListAddress
                    msg .= " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
                    if(1 && InStr(A_ComputerName,"SL5"))
                        ToolTip2sec( msg, 30, - 140 )
                        ; feedbackMsgBox(msg,msg,1,1)
                    if(!fileExist(actionListNewTemp_withoutExt ".ahk")){
                        clilpboard := actionListNewTemp_withoutExt
                        msg = :( list read by RegRead NOT exist: `n`n actionListNewTemp_withoutExt = `n >>%actionListNewTemp_withoutExt%<< `n = clilpboard = `n
                        msg .= " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

                        isNotYet_actionList := actionListNewTemp_withoutExt
                        RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, isNotYet_actionList1795,% isNotYet_actionList
                        actionList := actionList_isNotAProject
                        if(0 && InStr(A_ComputerName,"SL5")) {
                            Speak(A_LineNumber ":  isNotAProject","PROD")
                            sleep,1000
                        }
                        if(1 && InStr(A_ComputerName,"SL5")){
                            ; msgBox,% ":( ERROR: " msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
                            ; feedbackMsgBox(msg,msg,1,1)
                            ToolTip3sec( msg, 30, - 140 )
                            ; clilpboard := msg
                            ; sleep,5000
                        }
                        sleep,2000
                        ; 111123456789
                    }
                    Speak("Action List New Temp without Extension in line " A_LineNumber)
                     ; (DEV, TEST, STAGING, PROD),
                    return actionListNewTemp_withoutExt
        }
        ;\____ actionListNewTemp_withoutExt __ 181031091858 __ 31.10.2018 09:18:58 __/



; ToolTip1sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This) )



;<<<<<<<< onLink2actionListChangedInRegistry <<<< 180319214441 <<<< 19.03.2018 21:44:41 <<<<
onLink2actionListChangedInRegistry:



if(g_doListBoxFollowMouse)
  Return



    ;Msgbox,RETURN OFF`n (%A_LineFile%~%A_LineNumber%)
    ;return
    global g_SingleMatch
    global g_FLAGmsgbox
    SetTitleMatchMode,2



    ;SetTimer,checkInRegistryChangedActionListAddress,off



    FileGetTime, actionListModified, %actionList%, M
    FormatTime, actionListModified, %actionListModified%, yyyy-MM-dd HH:mm:ss
    ;ToolTip4sec(actionList " = actionList `n"  actionListModified  " `n" . A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This,1,1)
    if(actionListModiTime_OLD <> actionListModiTime && actionListModiTime_OLD ){
        ;Msgbox,actionListModiTime_OLD <> actionListModiTime `n (%A_LineFile%~%A_LineNumber%)
        ; ParseWordsCount := ReadActionList(calledFromStr)
        ; g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)



        g_actionListID := getActionListID(sql_template_dir, actionList) ; 24.03.2018 23:02
        ReadInTheActionList(g_config["sql"]["template"]["dir"], A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        g_min_searchWord_length := getMinLength_Needetthat_ListBecomesVisible(ParseWordsCount, maxLinesOfCode4length1)
        ; RebuildDatabase(g_config["sql"]["template"]["dir"])



        ;If(WinExist("actionListChangedInRegistry"))
        winclose,actionListChangedInRegistry



        ;SetTimer,checkInRegistryChangedActionListAddress,on
        ;ToolTip4sec("RecomputeMatches(calledFromStr) `n " actionList " = actionList `n"  actionListModified  " `n" . A_LineNumber . " " . A_ScriptName . " " . Last_A_This,1,1)
        ;RecomputeMatches(calledFromStr) ; 27.03.2018 23:51
        return ; no update jet
    }
    actionListModiTime_OLD := actionListModiTime



    if(0 && firstLine := g_SingleMatch[1])
        tooltip,%firstLine% `n (%A_LineFile%~%A_LineNumber%)



    ; WinWaitNotActive,actionListChangedInRegistry ahk_class AutoHotkeyGUI



    ; DetectHiddenWindows,On ; it set the window to no tray icon. i surprized to use now DetectHiddenWindows,On 18-03-03_17-16 Really necasary ??? TODO:need it ?



    ; may there was a change anyway



return



;
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
couldIfindMyself:
global g_doSaveLogFiles



lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"couldIfindMyself cant find scripts running in tray. so its useless :( deprevated. return from function :( now.")



; but BTW it works with oter windows (probably the proble is a changed window name???) . for e.x. this works: IfWinNotExist,Could not close the previous instance of this script_autoCloser.ahk
; 12.07.2017 17:49
return



; IfWinNotActive,gi-everywhere.ahk - SciTE4AutoHotkey



DetectHiddenWindows,On
if(!FOUNDmyselfCounter)
   FOUNDmyselfCounter := 1
SetTitleMatchMode,1 
scriptNameWithoutAHK := RegExReplace( A_ScriptName, "\.ahk") . " - "



WinMaximize,% scriptNameWithoutAHK 
; WinShow,% scriptNameWithoutAHK ; is without effect 12.07.2017 17:01



pId := DllCall("GetCurrentProcessId") ; thats possible, thats works to get a process id 12.07.2017 17:05
ScriptHwnd := WinExist("ahk_class AutoHotkey ahk_pid " DllCall("GetCurrentProcessId"))



if(false){
IfWinNotExist,% scriptNameWithoutAHK 
{
   ; this time tray icon apps could not be found from autohotkey scripts. you may need a shuffle app for parse information inside the titele bar or so. 16.07.2017 02:16
   ToolTip,LineNumber = %A_LineNumber% : `n `n i cant find myself `n (`nScriptHwnd = %ScriptHwnd% `npId = %pId%`n '%scriptNameWithoutAHK%' ) `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n (programmed at 11.07.2017 15:12)
   ; thats a totally stupid situation, but it happen often.
   ; not always but often.
   ; then i think no autohotkey scrpt should start oter scripts. 
   ; its to dangerous that a stack overflow happens.
   ; may one good workaround could be, wait a lang time and then try it again or pause the script for ever..... and ever ...
   suspend,On
      msgbox,% A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") "`n SuspendOn()`n"



   min := 60 * 1000
   ; sleep, % 9 * min 
   ; reload 
global g_doSaveLogFiles



lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"ExitApp")
   Sleep, 3000
   ExitApp
   Pause
}
}
FOUNDmyselfCounter += 1
if(false){
ToolTip, i FOUND :-) myself yeaah `n not a totally idiot :) `n ( %scriptNameWithoutAHK% )  `n FOUNDmyselfCounter = %FOUNDmyselfCounter% `n `n  (programmed at 11.07.2017 20:26)
}
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



;
/*
    ObjRegisterActive(Object, CLSID, Flags:=0)



        Registers an object as the active object for a given class ID.
        Requires AutoHotkey v1.1.17+; may crash earlier versions.



    Object:
            Any AutoHotkey object.
    CLSID:
            A GUID or ProgID of your own making.
            Pass an empty string to revoke (unregister) the object.
    Flags:
            One of the following values:
              0 (ACTIVEOBJECT_STRONG)
              1 (ACTIVEOBJECT_WEAK)
            Defaults to 0.



    Related:
        http://goo.gl/KJS4Dp - RegisterActiveObject
        http://goo.gl/no6XAS - ProgID
        http://goo.gl/obfmDc - CreateGUID()
*/
ObjRegisterActive(Object, CLSID, Flags:=0) {
    static cookieJar := {}
    if (!CLSID) {
        if (cookie := cookieJar.Remove(Object)) != ""
            DllCall("oleaut32\RevokeActiveObject", "uint", cookie, "ptr", 0)
        return
    }
    if cookieJar[Object]
        throw Exception("Object is already registered", -1)
    VarSetCapacity(_clsid, 16, 0)
    if (hr := DllCall("ole32\CLSIDFromString", "wstr", CLSID, "ptr", &_clsid)) < 0
        throw Exception("Invalid CLSID", -1, CLSID)
    hr := DllCall("oleaut32\RegisterActiveObject"
        , "ptr", &Object, "ptr", &_clsid, "uint", Flags, "uint*", cookie
        , "uint")
    if hr < 0
        throw Exception(format("Error 0x{:x}", hr), -1)
    cookieJar[Object] := cookie
}
;



actionListTooltip:
    tip=%actionList% `n%actionListOLD% = old `n ( %A_LineFile%~%A_LineNumber% )
    ToolTip,% tip
return



;/¯¯¯¯ recreateListBox_IfFontSizeChangedAndTimeIdle ¯¯ 181107232259 ¯¯ 07.11.2018 23:22:59 ¯¯\
recreateListBox_IfFontSizeChangedAndTimeIdle(g_ListBoxFontSize, newListBoxFontSize){
  if ( A_TimeIdlePhysical < 1000 * 0.5 )
    return false
    if(1 && InStr(A_ComputerName,"SL5"))
        Sound("recreateListBox_IfFontSizeChangedAndTimeIdle. " RegExReplace(A_LineFile,".*\\") )
    if(g_ListBoxFontSize <> newListBoxFontSize ){
        g_ListBoxFontSize := newListBoxFontSize ; ; to to
        ; ListBoxEnd()
        DestroyListBox()
        InitializeListBox()
        return g_ListBoxFontSize
    }
    return false
}
;\____ recreateListBox_IfFontSizeChangedAndTimeIdle __ 181107232303 __ 07.11.2018 23:23:03 __/

; drag drop ? not importand
if(false){
      if(GetKeyState("LButton")
        && g_ListBoxX && g_ListBoxY
        && (abs(g_ListBoxX - mouseX)>200 || abs(g_ListBoxY - mouseY) > 200 )){
            tooltip, % "probably drag drop detected `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")", %g_ListBoxX%, 1, 5
      }
}

;/¯¯¯¯ doListBoxFollowMouse ¯¯ 181107183540 ¯¯ 07.11.2018 18:35:40 ¯¯\
doListBoxFollowMouse:
      MouseGetPos, mouseX, mouseY
      ; g_ListBoxX := mouseX - ( g_min_MonitorBound_right / 2 )
      g_ListBoxX := mouseX - ( g_min_MonitorBound_right )
      ; g_ListBoxY := round(mouseY / 100) * 100  - 80
      ; g_ListBoxY := mouseY - 68 ; 19-01-19_18-30: 80
      ; ==> Problem mouse was out of the box... so it was not possible to stop 19-02-14_09-01
      g_ListBoxY := mouseY - 73 ; 19-01-19_18-30: 80



;    class := "ahk_class AutoHotkeyGUI"
;    winTitle := "Action List Appears Here."
;    WinGetPos, X, Y, W, H, %winTitle% %class%
; too to too too tooo tool tool tool



      newFontSize := recreateListBox_IfFontSizeChangedAndTimeIdle(listBoxFontSizeOLD , g_ListBoxFontSize )
      if(newFontSize){
        g_ListBoxFontSize := newFontSize
        listBoxFontSizeOLD := g_ListBoxFontSize

        g_ListBoxCharacterWidthComputed := getListBoxCharacterWidth( g_ListBoxFontSize, g_ListBoxCharacterWidthComputed )

       }else
          ShowListBox(g_ListBoxX,g_ListBoxY)

            tip := ""
            tip .= "use SINGLE click for stop moving`n"
            tip .= "use double Ctrl to toggle Listbox (OFF/ON)`n"
            tooltipPosY := (g_ListBoxY)
    tooltipPosY += (g_ListBoxActualSizeH_maxFound) ? g_ListBoxActualSizeH_maxFound : 164 ; found: 164. is maybe a good value. nearly correct 04.01.2019 11:16
    tooltipPosY += 29 ; of some reasons seems to be necasary Oops ??? 04.01.2019 11:29

            ToolTip9sec(tip,g_ListBoxX, tooltipPosY ) ; 13px pe line
            winmove,% tip, ,% g_ListBoxX, % tooltipPosY ; needet if tootop is beetween monitio or out of moinitor bouds 04.01.2019 13:07

; toool tool tool too too

return
;\____ doListBoxFollowMouse __ 181107183544 __ 07.11.2018 18:35:44 __/



check_some_keys_hanging_or_freezed:
  if( A_TimeIdlePhysical <= 1000 * 3 )
    return
  fixBug_Alt_Shift_Ctrl_hanging_down()
return



;/¯¯¯¯ exit_all_scripts ¯¯ 181101135520 ¯¯ 01.11.2018 13:55:20 ¯¯\
exit_all_scripts(){
        DetectHiddenWindows, On
        WinGet, List, List, ahk_class AutoHotkey
        Loop %List%
          {
            WinGet, PID, PID, % "ahk_id " List%A_Index%
            If ( PID <> DllCall("GetCurrentProcessId") )
                 PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index%
          }
}
;\____ exit_all_scripts __ 181101135538 __ 01.11.2018 13:55:38 __/



;/¯¯¯¯ fixBug_Alt_Shift_Ctrl_hanging_down ¯¯ 181107183135 ¯¯ 07.11.2018 18:31:35 ¯¯\
fixBug_Alt_Shift_Ctrl_hanging_down(){
  ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
    Suspend,On
 if( GetKeyState("Alt","P") ){ 
    tip := "Alt is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{AltUp}
  }
 if( GetKeyState("RAlt","P") ){
    tip := "Alt is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{RAltUp}
  }
 if( GetKeyState("Ctrl","P") ){
    tip := "Ctrl is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{CtrlUp}
  }
 if( GetKeyState("Shift","P") ){ 
    tip := "Shift is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{ShiftUp}
  }
 if( GetKeyState("AltGr","P") ){
    tip := "AltGr is down"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{ALTGR}
  }
 if( !GetKeyState("NumLock","T") ){
    tip := "NumLock was not on. we need numpad"
    ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip)
    send,{NumLock}
  }
    Suspend, Off
  return
} ; endOf: fixBug_Alt_Shift_Ctrl_hanging_down
;\____ fixBug_Alt_Shift_Ctrl_hanging_down __ 181107183142 __ 07.11.2018 18:31:42 __/

;/¯¯¯¯ check_configFile_Changed ¯¯ 190112114734 ¯¯ 12.01.2019 11:47:34 ¯¯\
check_configFile_Changed:
configMinifyObj := update_configMinify_incAhkFile()
if(configMinifyObj){
    ; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), "test  6", 1, 1, 6 )
    configMinifyIncAhkContent := configMinifyObj["content"]
    configMinifyIncAhkAddress := configMinifyObj["Address"]
    configMinifyIncAhkContentSTATIC := RegExReplace(configMinifyIncAhkContent, "A" "_ScriptDir", """" A_ScriptDir """" )
    configMinifyIncAhkAddressSTATIC := configMinifyIncAhkAddress "STATIC.ahk"
    ; A_ScriptDir

	tempFileAddress := A_ScriptDir "\" A_TickCount ".temp.txt"
	FileAppend, % configMinifyIncAhkContentSTATIC, % tempFileAddress
	FileCopy,% tempFileAddress, % configMinifyIncAhkAddressSTATIC, 1
	Sleep,20
	FileDelete,% tempFileAddress
    ; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), configMinifyIncAhkAddressSTATIC, 1, 1, 6 )
    sleep,500
	; msgbox, % configMinifyIncAhkAddressSTATIC

	; reload could produced hundrets of windows up !! 19-01-14_14-27
    run,% "..\start.ahk"
    exitapp
}
return
;\____ check_configFile_Changed __ 190112114737 __ 12.01.2019 11:47:37 __/






;/¯¯¯¯ check_actionList_GUI_is_hanging_or_freezed ¯¯ 181024140430 ¯¯ 24.10.2018 14:04:30 ¯¯\
check_actionList_GUI_is_hanging_or_freezed:
  ; g_ListBox_Id
  ;if( A_TimeIdlePhysical < 1000 * 9 )
  ;      return
  ;  ToolTip,%g_ListBox_Id% = g_ListBox_Id `n %g_ListBoxTitle% = g_ListBoxTitle `n %g_ListBoxTitle_firstTimeInMilli% = g_ListBoxTitle_firstTimeInMilli `n (%A_LineFile%~%A_LineNumber%),,1



    ; msgbox,%g_ListBoxTitle% = g_ListBoxTitle `n (%A_LineFile%~%A_LineNumber%)
    ; if(!g_ListBoxTitle)
      ;  return ; probably no problem
    SetTitleMatchMode,1
    DetectHiddenWindows,Off
    IfWinNotExist, % g_ListBoxTitle
        return ; probably no problem
    if(!g_ListBoxTitle_firstTimeInMilli){
         MsgBox, % ":( milli is empty  `n should never happens `n g_ListBoxTitle=" g_ListBoxTitle " `n g_ListBoxTitle_firstTimeInMilli = " g_ListBoxTitle_firstTimeInMilli "`n(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
        return
    }
    ;tooltip too too too__too



    elapsedMilli := A_TickCount - g_ListBoxTitle_firstTimeInMilli
    elapsedSec := ceil(elapsedMilli/1000)
    ; tip = %g_ListBoxTitle% = g_ListBoxTitle `n %elapsedSec% = elapsedSec `n (%A_LineFile%~%A_LineNumber%)
    ; ToolTip,%g_ListBoxTitle% = g_ListBoxTitle `n %elapsedSec% = elapsedSec `n (%A_LineFile%~%A_LineNumber%)
    ;MsgBox, % tip "`n`n" elapsedMilli  "millisec = " elapsedSec "sec have elapsed. (" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"

    if( (   elapsedSec == 25 && InStr(A_ComputerName,"SL5")
         || elapsedSec == 25 && !InStr(A_ComputerName,"SL5") )
        && itsProbablyNewInstallation
        && A_TimeIdleKeyboard > 1500 ){ ; if BoxGui is long time opend and noct used. maybe user dont know what todo with it?
     ;winclose, % g_ListBoxTitle
     ; t
     ;/¯¯¯¯ return ¯¯ 181107181830 ¯¯ 07.11.2018 18:18:30 ¯¯\
     m =
     (
ListBox is open for long.
some tips from assistent:
 Reload => Ctrl+Shift+F5,
 Move => Click it,
 Resize Font by MouseWheel,
 Choose item by CTRL + Nr.
     )
     if(1 && InStr(A_ComputerName,"SL5")){

        RegRead, stop_list_change, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change ; todo: 02.03.2018 12:55 18-03-02_12-55
    	RegRead, ALinfoOnley, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
	    RegRead, ALinfoOnleyNEW, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionListNEW
	    actionListSHORT := RegExReplace(actionList, ".*\\")
	    fileExist := FileExist(actionList)
	    ALinfoOnley := RegExReplace(ALinfoOnley, ".*\\")
	    ALinfoOnleyNEW := RegExReplace(ALinfoOnleyNEW, ".*\\")

        ; word := "to" ; to
        ; wordIndex := getWordIndex(word)

; SingleMatch1 := g_SingleMatch[1] ; <== works but not needet
global ParseWordsCount
; ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
SingleMatchAllStr := ""
SingleMatchCount := g_SingleMatch.Count()
is_create_found := false
for each, match in g_SingleMatch
{
    if(inStr(actionList, "isNotAProject" ) 
        && inStr(match, "___create" ))
            is_create_found := true ;    m .= "`n" " ERROR 19-01-19_13-31!! ___create NOT EXIST !"
    SingleMatchAllStr .= A_index " " SubStr(match, 1 , 50) "..`n"
}

        ; wordIndex = %wordIndex% from '%word%'
        ; ParseWordsCount = %ParseWordsCount%
        ; global ParseWordsCount
        mNew =
        (
    additional info for gi develper:
SingleMatchCount = %SingleMatchCount%

stop_list_change = %stop_list_change%
actionList = %actionListSHORT% (%fileExist%)
ALinfoOnley = %ALinfoOnley%
ALinfoOnleyNEW= %ALinfoOnleyNEW%
actionListNEW = %actionListNEW% <= deprecated ?? 
        )
        m .= "`n`n" ; mNew
        if(inStr(actionList, "isNotAProject" ) && !is_create_found){
            m .= "`n`n" " ERROR ___create NOT EXIST !!!"
            mNew .= "`n`n" " ERROR ___create NOT EXIST !!!"
            ; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), "ERROR ___create NOT EXIST !!!", 1, 1 )
        }
        m .= "`n`n" SingleMatchAllStr
        mNew .= "`n`n" SingleMatchAllStr
     }
    ToolTip9sec(m mNew "`n`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ") ",1, 1) ; -5
    ; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), m, 1, 1, 99 )     return
     ;\____ return __ 181107181826 __ 07.11.2018 18:18:26 __/

    ;/¯¯¯¯ g_min_searchWord_length_NOT_0 ¯¯ 190123010348 ¯¯ 23.01.2019 01:03:48 ¯¯\
     if(g_min_searchWord_length>0){
         ToolTip4sec("check_actionList_GUI_is_hanging_or_freezed: elapsedSec > 11: DestroyListBox()`n`n" A_LineNumber " " A_ScriptName )
         DestroyListBox()




    ; ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\"; ) ":"  A_LineNumber ")" )



     ; script hangs at this position
     ;winclose, % g_ListBoxTitle
     ;winkill, % g_ListBoxTitle
     ; reload ; script hangs if gui was not used. here we could check if its hanging. 27.09.2018 19:21 if ListBox was not used and not closed. reload helps to get script running again.
    RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; <=== dont know if this helps 19.10.2018 11:24 in check_actionList_GUI_is_hanging_or_freezed
     ;MsgBox, % tip "`n`n" elapsedMilli  "millisec = " elapsedSec "sec have elapsed. (" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
    AHKcode := "#" . "NoTrayIcon `n "
    AHKcode =
    (
    SetTitleMatchMode, 2
    WinWaitActive,menu closed? #32770, ,1
    winclose,
    exitapp,
     )
     DynaRun(AHKcode)
     ; menu closed? ahk_class #32770 ; mouseWindowTitle=0x23d0f68  ;
     MsgBox , ,menu closed? , is it closed??? `n (%A_LineFile%~%A_LineNumber%) , 1 ; <== helps closing the listbox probalby 19.10.2018 11:28
    }
    return
      ; clipboard := tip
     }

     ;\____ g_min_searchWord_length_NOT_0 __ 190123010400 __ 23.01.2019 01:04:00 __/

return
;\____ check_actionList_GUI_is_hanging_or_freezed __ 181024140439 __ 24.10.2018 14:04:39 __/



;/¯¯¯¯ show_ListBox_Id
show_ListBox_Id:
    SetTimer, show_ListBox_Id, Off ; setinterval
    return



    global g_ListBox_Id
    global g_reloadIf_ListBox_Id_notExist
    ;ToolTip1sec(g_ListBox_Id " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This,1,1)
    if(g_ListBox_Id){
        g_show_ListBox_Id_EMTY_COUNT := 0
        return
    }
    while(A_index < 100 && !g_ListBox_Id && g_reloadIf_ListBox_Id_notExist){
        sleep,10 ; Gives listbox time to arise 28.10.2018 15:18
    }
    if(!g_ListBox_Id && g_reloadIf_ListBox_Id_notExist){
        g_show_ListBox_Id_EMTY_COUNT++



    ;/¯¯¯¯ happens ¯¯ 181024150019 ¯¯ 24.10.2018 15:00:19 ¯¯\
    ; it happend 24.10.2018 15:00 will i triggered around so muhc. my foul.
    ; msgbox, should neerv happens  24.10.2018 14:28
    ToolTip5sec( g_show_ListBox_Id_EMTY_COUNT ": DisEn `n`n Very rare error which will definitely not happen again. or? (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " al= " RegExReplace(actionList,".*\\") "  2:" actionListNEW ,1,1)
    ; MsgBox, % ":( milli is empty  `n should never happens `n g_ListBoxTitle=" g_ListBoxTitle " `n g_ListBoxTitle_firstTimeInMilli = " g_ListBoxTitle_firstTimeInMilli "`n(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
    ;\____ happens __ 181024150022 __ 24.10.2018 15:00:22 __/



        if(1 && g_show_ListBox_Id_EMTY_COUNT >= 1){
            InactivateAll_Suspend_ListBox_WinHook() ; addet 24.10.2018 14:16
            ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),True) ; 24.10.2018 14:16 may help listBoxGUI NEVER HANGS TODO:check it
        }
        if(1 && g_show_ListBox_Id_EMTY_COUNT >= 2){ ; the only think that helps today 24.10.2018 15:11
            RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, Reload , % A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " A_now
            ; if(1 && InStr(A_ComputerName,"SL5"))
            ;    sleep,2000
            Msgbox,reload`n(%A_LineFile%~%A_LineNumber%)
            ; reload ;  [^;\n]*[ ]*\breload\b\n <= cactive reloads 18-10-28_11-47
            ; run,% "..\start.ahk" ; deactivated. test 22.10.2018 05:54
        }
        if(1 && g_show_ListBox_Id_EMTY_COUNT >= 2){
            ; DisableWinHook() ; stoped. todo: test 23.10.2018 11:17
            try{
                EnableWinHook()
            }
            ;/¯¯¯¯ ReturnWinActive ¯¯ 181022213048 ¯¯ 22.10.2018 21:30:48 ¯¯\
            ReturnWinActive() ; <=========== addet today as an test. its not disturbing. dont know if its halp
            ;\____ ReturnWinActive __ 181022213051 __ 22.10.2018 21:30:51 __/
        }
        if(1 && g_show_ListBox_Id_EMTY_COUNT >= 3)
            RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; <=== hope it helps. not sure 22.10.2018 07:59



; n n  n
        ;/¯¯¯¯ ;ToolTip1sec(g_ListBox_Id ¯¯ 181022055812 ¯¯ 22.10.2018 05:58:12 ¯¯\
        ; tested . it works. dont need to reload or so
        ToolTip5sec( g_show_ListBox_Id_EMTY_COUNT ": DisEn (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " al= " RegExReplace(actionList,".*\\") "  2:" actionListNEW ,1,1)



    if(0 && g_show_ListBox_Id_EMTY_COUNT >= 1)
        EnableKeyboardHotKeys() ; seems needet 01.11.2018 19:04



    ; if(1 && g_show_ListBox_Id_EMTY_COUNT >= 1)
        ; InitializeListBox() ; ERROR same vaiabele cannot used twice



        if(0 && g_show_ListBox_Id_EMTY_COUNT >= 2){



            try{
             RebuildMatchList() ; line addet 19.03.2018 20:57
             InitializeListBox() ; line addet 19.03.2018 20:57^
             }
         ; RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; line addet 19.03.2018 21
        }



        ;\____ ;ToolTip1sec(g_ListBox_Id __ 181022055815 __ 22.10.2018 05:58:15 __/



        ; RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; <=== hope it helps. not sure 19.10.2018 11:34 ... not helped 19.10.2018 11:37
        ; goto, lblTopOfScriptLine111 ; <=== hope it helps. ...  not helped 19.10.2018 11:37
    }
        ;reload
        ;MsgBox, , repair Manue, repair Manue, 1
    g_reloadIf_ListBox_Id_notExist := false
        ;MsgBox, [ Options, Title, Text, Timeout]
        ;
return
;\____ show_ListBox_Id



; toool ool tool



lbl_repeat_ShowListBox:
; seems hast no effect 05.01.2019 13:06
ShowListBox()
return



lblCheckTrayIconStatus:
showTempTrayIf_isNearTrayMenue(iconAdress) ; Source\inc_ahk\ScriptNameLetterIcon.inc.ahk
DetectHiddenWindows,Off
IfWinExist,%A_ScriptName%_icon,ExitApp %A_ScriptName% ; message from child DynaRun() script
{
	WinClose,%A_ScriptName%_icon
	ExitApp
}
return



#Include,RegWrite181031.ahk

#Include %A_ScriptDir%\inc_ahk\gi\ReadActionList.inc.ahk


; #Include *i tools\DebugVars\VarTreeGui.ahk
; #Include *i tools\DebugVars\dbgp.ahk
; #Include *i tools\DebugVars\TreeListView_test.ahk
