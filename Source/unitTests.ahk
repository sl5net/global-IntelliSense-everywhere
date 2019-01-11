;/¯¯¯¯ readme ¯¯ 181204164622 ¯¯ 04.12.2018 16:46:22 ¯¯\
readme =
(
Database testing needs exclusive access.
!!!!!! all scripts are temporarily closed and then restarted !!!!!
You can disable this if you do not want to eat the database. changing a few lines of code is not difficult.
Good luck  :-) 04.12.2018 16:48
)
;\____ readme __ 181204164624 __ 04.12.2018 16:46:24 __/


;/¯¯¯¯ todo
; intersting may useful for debugging: https://hotkeyit.github.io/v2/docs/commands/ahkExecuteLine.htm
;\____ todo __ 181119235301 __ 19.11.2018 23:53:01 __/


#SingleInstance,Force
#Include %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#Include %A_ScriptDir%\inc_ahk\soundBeep.inc.ahk
SetTimer,checkInRegistryChangedActionListAddress,off
SetTimer,checkActionListAHKfile_sizeAndModiTime, off
SetTimer,checkWinChangedTitle,off
Thread, NoTimers , False ; Prevents interruptions from any timers.
lineFileName := RegExReplace(A_LineFile, ".*\\([\w\s\.]+)$", "$1")
#SingleInstance,Force

;/¯¯¯¯ g_ignRegm ¯¯ 181124100933 ¯¯ 24.11.2018 10:09:33 ¯¯\
;/¯¯¯¯ g_ignRegm ¯¯ 181124100933 ¯¯ 24.11.2018 10:09:33 ¯¯\
;/¯¯¯¯ g_ignRegm ¯¯ 181124100933 ¯¯ 24.11.2018 10:09:33 ¯¯\
;/¯¯¯¯ g_ignRegm ¯¯ 181124100933 ¯¯ 24.11.2018 10:09:33 ¯¯\
if(InStr(A_ComputerName,"xxxxxxxxx SL5")) ; do ignore nothing. development computer
	global g_ignReg := { feedbackMsgBox:{tit:".^", text:".^"} ,          saveLogFiles: {ln:".^", scriptName:"\b(Window|ListBox)\.ahk", text:"(WordIndex|CloseListBox|HotKeys|g_ListBox_Id)\b"},                    sqlQuery: {ln:".^", scriptName:".^", text:".^"},                    hotKeyStuff: {ln:".^", scriptName:".^", text:".^"},                    runLogFile: {ln:".^", scriptName:".^", text:".^"} } ;;;; regEx ignoreConfigList ;;;;
; please use it like this:     if( 1<RegExMatch(0 . A_ScriptName, g_ignReg["saveLogFiles"]["scriptName"])	|| ......
		; OR: the regEx .^ never match anything. if you use .^ i recomand using: if( RegExMatch(ln, g_ignReg["saveLogFiles"]["ln"])	|| ......
else ; ignore all ==> means for e.g. no log then
	global g_ignReg := { feedbackMsgBox:{tit:".^", text:".^"} ,          saveLogFiles: {ln:".^", scriptName:".^", text:".^"},                    sqlQuery: {ln:".^", scriptName:".^", text:".^"},                    hotKeyStuff: {ln:".^", scriptName:".^", text:".^"},                    runLogFile: {ln:".^", scriptName:".^", text:".^"} } ;;;; regEx ignoreConfigList ;;;;

; https://autohotkey.com/boards/viewtopic.php?f=6&t=44696&p=202322#p202322
g_ignReg_exampleUsing =
(
if(RegExMatch(A_ScriptName, g_ignReg["saveLogFiles"]["scriptName"]))
	MsgBox,ignore matched
else
	MsgBox,ignore NOT matched
)
lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"hey from ini ")
;\____ g_ignRegm __ 181124100939 __ 24.11.2018 10:09:39 __/
;\____ g_ignRegm __ 181124100939 __ 24.11.2018 10:09:39 __/
;\____ g_ignRegm __ 181124100939 __ 24.11.2018 10:09:39 __/
;\____ g_ignRegm __ 181124100939 __ 24.11.2018 10:09:39 __/
;\____ g_ignRegm __ 181124100939 __ 24.11.2018 10:09:39 __/

setTitleMatchMode,2
if(!winExist("actionList.ahk.log.txt") && FileExist("log\actionList.ahk.log.txt") )
    run,log\actionList.ahk.log.txt

; to ms ms Spe to Ms mes mes too t mu 

global g_closedAHKlist := []

global errStr_first := ""

global g_LegacyLearnedWords
global g_ScriptTitle
global g_actionListDone
global g_actionListDB
global actionList
global g_actionListID
global g_actionListDBfileAdress
global g_config


prepareGi()
ToolTip4sec( "close GI, get DataBase, rund UnitTest`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
closeAllOtherAHK()

SetTitleMatchMode,3
name=gi ahk_class AutoHotkey
while(WinExist(name) && A_Index < 9){
	WinClose,
	sleep,20
}
while(WinExist(name) && A_Index < 9){
	WinKill,
	sleep,20
}

name=gi.ahk ahk_class AutoHotkey
if(1){
    while(WinExist(name) && A_Index < 9){
        WinClose,% name
        sleep,20
    }
    while(WinExist(name) && A_Index < 9){
        WinKill,% name
        sleep,20
    }
}
ToolTip,% "winWaitClose `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
winwaitclose,% name
ifwinexist,gi
    msgbox,Oops `n(%A_LineFile%~%A_LineNumber%)





g_actionListDB.BeginTransaction()

fromLine := "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
g_actionListDB.Query("delete from Words where actionListID = " g_actionListID ";")
if(sqlLastError := trim(SQLite_LastError()))
    msgbox,:( g_actionListID = %g_actionListID%,sqlLastError = %sqlLastError% %fromLine%
CreateWordsTable()
if(sqlLastError := trim(SQLite_LastError()))
    msgbox,:( g_actionListID = %g_actionListID%,sqlLastError = %sqlLastError% %fromLine%



;/¯¯¯¯ g_do_only_this_testCase ¯¯ 181118111647 ¯¯ 18.11.2018 11:16:47 ¯¯\
;/¯¯¯¯ g_do_only_this_testCase ¯¯ 181118111647 ¯¯ 18.11.2018 11:16:47 ¯¯\
;/¯¯¯¯ g_do_only_this_testCase ¯¯ 181118111647 ¯¯ 18.11.2018 11:16:47 ¯¯\
; how do you use these lines?
; if you want all tests to run then put an empty string. 04.12.2018 14:10
; the test in this list must also exist below in the if else statements
global g_do_only_this_testCase 
g_do_only_this_testCase  := "test_short_keywords"
g_do_only_this_testCase  := "err_problemNow"
g_do_only_this_testCase  := "err_doAsimpleCopyOfLine"
g_do_only_this_testCase  := "err_indexFollowingLines4search"
g_do_only_this_testCase  := "err_problemNow"
g_do_only_this_testCase  := "err_multi_rr_stop_by_is_r"
g_do_only_this_testCase  := "err_string_ahk_line"
g_do_only_this_testCase  := "err_is_r_without_keywords"
g_do_only_this_testCase  := "test_getAutoKeywords"
g_do_only_this_testCase  := "err_is_without_keywords"
g_do_only_this_testCase  := "test_synonym"
g_do_only_this_testCase  := "err_without_includes_update"
g_do_only_this_testCase  := "" ; then all test will be run 24.11.2018 20:33
;\____ g_do_only_this_testCase __ 181118111650 __ 18.11.2018 11:16:50 __/
;\____ g_do_only_this_testCase __ 181118111650 __ 18.11.2018 11:16:50 __/
;\____ g_do_only_this_testCase __ 181118111650 __ 18.11.2018 11:16:50 __/

countErrors := 0

SetTitleMatchMode,1
WinWaitNotActive,WinMerge
WinGetActiveTitle,activeTitle


;             SELECT := "SELECT wordreplacement FROM Words Where wordreplacement like '"
;              SELECT .= timeStampMini "' LIMIT 1 " ";"
;              Matches := g_actionListDB.Query(SELECT)
;              isFound  := false
;              for each, row in Matches.Rows
;                  if( row[1] )
;                      isFound  := true


;/¯¯¯¯ err_without_includes_update ¯¯ 181224102746 ¯¯ 24.12.2018 10:27:46 ¯¯\
err_without_includes_update(){
    ToolTip5sec( "thats only a stup :) ====> return `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    return
    actionList := "..\actionLists\ChromeWidgetWin1\playground_Piratenpad_Google_Chrome.ahk"
    if(!FileExist(actionList)){
        msgbox,% "ERROR `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    }
content =
(
; #Include ..\_globalActionLists\_global.ahk
; #Include ..\ChromeWidgetWin1\_global.ahk
; #Include ..\_globalActionLists\examplesForBeginners.ahk
___open window library |rr||ahk|openInEditor,playground_Piratenpad_Google_Chrome.ahk
heyho12345
)

FileAppend, % content, % actionList "_temp"
sleep,20
fileCopy, % actionList "_temp", % actionList,1
filedelete, % actionList "_temp"

}
;\____ err_without_includes_update __ 181224102748 __ 24.12.2018 10:27:48 __/




;/¯¯¯¯ err_string_ahk_line ¯¯ 181204152914 ¯¯ 04.12.2018 15:29:14 ¯¯\
err_string_ahk_line(){
    f=log\actionList.ahk.log.txt
    fileDelete,% f
    while(0 && fileExist(f))
        sleep,150
    in := "searchkeys|rr|stringReplacement|ahk|ahkSource"
	expected := in
	if(errStr := getAssertEqual_ErrorStr( in, expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

    in := "url|rr|[url=]title[/url]|ahk|send,{left 12}{text}%clipboard% ``n send,{CtrlDown}{ShiftDown}{Left}{ShiftUp}{CtrlUp}"
	expected := in
	if(errStr := getAssertEqual_ErrorStr( in, expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

    SELECT := "SELECT word FROM Words Where word like '" in "' "
    SELECT .= " LIMIT 1 " ";"
    Matches := g_actionListDB.Query(SELECT)
    isFound  := false
    for each, row in Matches.Rows
        if( row[1] )
            isFound  := true
    if(!isFound)
        Return in " NOT in DB °" A_LineNumber ":" A_ThisFunc "°"

}
;\____ err_string_ahk_line __ 181204152918 __ 04.12.2018 15:29:18 __/




; err_read_actionList_from_file_and_preParse()
;/¯¯¯¯ err_bewe ¯¯ 181119210955 ¯¯ 19.11.2018 21:09:55 ¯¯\
err_read_actionList_from_file_and_preParse(){
    ; maybe you need to set 	g_actionListDone  to 0 19.11.2018 21:45
    ; if( g_actionListDone == "0"){ ;if this is read from the actionList ; 1 ||



    fileAddress := "..\actionLists\_globalActionLists\.....................ahk"
    FileRead, in , % fileAddress
    result := Loop_Parse_ParseWords( in )
    clipboard  := result
    msgbox , clipboard  := result
}
;\____ err_bewe __ 181119210958 __ 19.11.2018 21:09:58 __/








err_ReadActionList()

;/¯¯¯¯ AutoKeywords ¯¯ 181118181811 ¯¯ 18.11.2018 18:18:11 ¯¯\
if(1 && errStr:=test_getAutoKeywords())
	countErrors++ ; Msgbox,% A_LineNumber  ;
;\____ AutoKeywords __ 181118181814 __ 18.11.2018 18:18:14 __/
if(false){
noop=1
}
else if(1 && errStr:=err_without_includes_update())
 		countErrors++ ; Msgbox,% A_LineNumber  ;
else if(1 && errStr:=err_is_r())
 		countErrors++ ; Msgbox,% A_LineNumber  ;
else if(1 && errStr:=err_is_r_without_keywords())
 		countErrors++ ; Msgbox,% A_LineNumber  ;
else if(0 && errStr:=err_indexFollowingLines4search())
 		countErrors++ ; Msgbox,% A_LineNumber  ;
else if(1 && errStr:=err_doAsimpleCopyOfLine())
		countErrors++ ; Msgbox,% A_LineNumber  ;
;ToolTip4sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
else if(1 && errStr:=err_CheckValid())
		countErrors++ ; Msgbox,% A_LineNumber  ;


else if(1 && InStr(A_ComputerName,"SL5") && errStr:=err_string_ahk_line())
 		countErrors++ ; Msgbox,% A_LineNumber  ;


else if(1 && errStr:=err_is_without_keywords())
		countErrors++ ; Msgbox,% A_LineNumber  ;
else if(1 && errStr:=err_problemNow())
	countErrors++ ; Msgbox,% A_LineNumber  ;

else if(1 && errStr:=err_multi_r_content())
    countErrors++ ; Msgbox,% A_LineNumber  ;
else if(1 && err_multi_rr_stop_by_is_r())
	countErrors++ ; Msgbox,% A_LineNumber  ;

else if(1 && InStr(A_ComputerName,"SL5") && errStr:=err_multi_r_content())
    countErrors++ ; Msgbox,% A_LineNumber  ;
;^---- its using selecs without inserts before. so its only works if inserts are finsished before 18-12-25_15-14

else if(1 && errStr:=test_short_keywords())
	countErrors++ ; Msgbox,% A_LineNumber  ;
else if(1 && test_do_indexFollowingLines4search())
    countErrors++ ; Msgbox,% A_LineNumber  ;
else if(false && errStr:=test_dontDeleteComments())
    countErrors++ ; Msgbox,% A_LineNumber  ;

else if(1 && InStr(A_ComputerName,"SL5") && errStr:=test_synonym())
		countErrors++ ; Msgbox,% A_LineNumber  ;
;^---- its using selecs without inserts before. so its only works if inserts are finsished before 18-12-25_15-14

else if(errStr:=err_tests_easy_0())
    countErrors++ ; Msgbox,% A_LineNumber  ;
else if(errStr:=err_unitTest1())
    countErrors++ ; Msgbox,% A_LineNumber  ;
else if(errStr:=err_tests_preparser())
    countErrors++ ; Msgbox,% A_LineNumber  ;
else if(1 && errStr:=err_multi_rr())
		countErrors++ ; Msgbox,% A_LineNumber  ;
else if(1 && errStr:=err_difficult_do_it_later())
    countErrors++ ; Msgbox,% A_LineNumber  ;
else if(1 && errStr:=err_open_issues())
    countErrors++ ; Msgbox,% A_LineNumber  ;



ifWinNotActive, WinMerge
	WinGetActiveTitle,activeTitle


if(countErrors<1)
	Speak("Its Okey. No Error found. " ALineNumber, "PROD" )
if(countErrors>0){
	Speak( countErrors " Error found. " ALineNumber, "PROD" )
	tooltip,% errStr,1,1
	Msgbox,,% errStr ,,2
    feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), errStr )
    clipboard := errStr
	sleep,2000
}

g_actionListDB.EndTransaction()
restoreClosedAHK()


Critical, Off
SetTitleMatchMode,1
WinWaitActive,WinMerge,,6 ; [result,,5
;tooltip,activate %activeTitle%
loop,% 9999
{
	WinActivate,% activeTitle
	sleep,15
	ifWinNotActive, WinMerge
		WinGetActiveTitle,activeTitle
	if((10 * A_Index) > 1000)
		break
}
WinWaitActive,WinMerge [result,,1

; waitUserDoSometingMilli(needetMilli,200)
; waitUserDoNothingMilli(needetMilli,2000)
needetMilli := 111
loop,4
{
waitUserDoSometingMilli(needetMilli,100)
waitUserDoNothingMilli(needetMilli,200)
}
needetMilli := 111
waitUserDoNothingMilli(needetMilli,500)
Critical, Off

KeyWait, s, D
If GetKeyState("Ctrl", "P"){
    sleep,111
	reload
}
return
reload
sleep,12000
exitapp


; mu mu cl


msgbox,% countErrors " errors counted. reload?? errStr= `n`n" errStr
exitapp
return
; run,% "..\start.ahk"





;/¯¯¯¯ ReadActionList ¯¯ 181028133202 ¯¯ 28.10.2018 13:32:02 ¯¯\
err_ReadActionList(){

info =
(
	global g_LegacyLearnedWords
	global g_ScriptTitle
	global g_actionListDone
	global g_actionListDB
	global actionList
	global g_actionListID
	global g_actionListDBfileAdress
	global g_config
)


global g_actionListDB
g_actionListDBfileAdress := "G:\fre\private\sql\sqlite\actionList.db"
g_actionListDBfileAdress  =  G:\fre\private\sql\sqlite\actionList.db
if(!fileexist(g_actionListDBfileAdress))
    g_actionListDBfileAdress := A_ScriptDir "\actionListLearned.db"
g_actionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_actionListDBfileAdress ) ;

global g_LegacyLearnedWords =
global g_ScriptTitle = gi-everywhere
global actionList
actionList = ..\actionLists\ChromeWidgetWin1\lubuntu18-11-19_16-05_Piratenpad_Google_Chrome.ahk._Generated.ahk
global g_actionListID
global g_actionListDBfileAdress
global g_config


if(!g_actionListDB)
    g_actionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_actionListDBfileAdress ) ;

if(!g_actionListID := getActionListID(actionList)){ ; 24.03.2018 23:02
	sql := "INSERT INTO actionLists "
	sql .= " (id, actionList, actionListmodified, actionListsize) VALUES "
	sql .= " (null, '" actionList "', '" actionListModified "', '" actionListSize "' );"
    g_actionListDB.Query(sql)
    fromLine := "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
    if(!g_actionListID := getActionListID(actionList))
        if(sqlLastError := trim(SQLite_LastError()))
            msgbox,:( g_actionListID = %g_actionListID%,sqlLastError = %sqlLastError% %fromLine%
}
fromLine := "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
if(sqlLastError := trim(SQLite_LastError()))
    msgbox,:( g_actionListID = %g_actionListID%,sqlLastError = %sqlLastError% %fromLine%

fromLine := "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")

; VALUES ('" AddWordIndexTransformed "', '" AddWordTransformed "', " LearnedWordsCount++ ", " g_actionListID ", " lineNr ");"

VALUES = VALUES ('%fromLine% %A_TickCount%' , '%fromLine%', 0, '%fromLine% %A_TickCount%', %g_actionListID% , 555);
INSERT_INTO_words := "INSERT INTO words (wordindexed, word, count, wordreplacement, actionListID, lineNr) "
INSERT_INTO_words .= VALUES
g_actionListDB.Query(INSERT_INTO_words)

fromLine := "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
if(sqlLastError := trim(SQLite_LastError()))
    msgbox,g_actionListID = %g_actionListID%,:(  sqlLastError = `n`n>%sqlLastError%< `n`n%fromLine%
    ; msgbox,, :-) g_actionListID = %g_actionListID%,%sqlLastError% %fromLine%,2

}
    ; ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
;\____ err_ReadActionList __ 181119181923 __ 19.11.2018 18:19:23 __/







;/¯¯¯¯ err_CheckValid() ¯¯ 181119174125 ¯¯ 19.11.2018 17:41:25 ¯¯\
err_CheckValid(){
    if(!CheckValid("Word",ForceLearn:= false, is_IndexedAhkBlock := false))
        return " °" A_ThisFunc "° <" A_LineNumber
    if(CheckValid("",ForceLearn:= false, is_IndexedAhkBlock := false))
        return " °" A_ThisFunc "° <" A_LineNumber
    if(CheckValid("; käsewurst ",ForceLearn:= false, is_IndexedAhkBlock := false))
        return " °" A_ThisFunc "° <" A_LineNumber
}
;\____ err_CheckValid() __ 181119174128 __ 19.11.2018 17:41:28 __/







;/¯¯¯¯ test_getAutoKeywords ¯¯ 181116202412 ¯¯ 16.11.2018 20:24:12 ¯¯\
; IMPORTEND becouse used by other functions !!!
test_getAutoKeywords(){


	in =
(
al color
no colors
)
	expected := "al color colors"
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


	in =
(
weeks   and
years   and   ears
)
	expected := "weeks years ears"
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

	in := "weeks weeks years"
	expected := "weeks years"
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


if(1){ ;
	in := "setTitleMatchMode"
    e := getAutoKeywords(in)
	expected := "setTitleMatchMode setTitleMatch Mode setTitle MatchMode TitleMatchMode"
	expected := "setTitleMatchMode Mode setTitleMatch Match setTitle Title"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}

if(1){ ;
	in := "SetTitleMatchMode"
    e := getAutoKeywords(in)
	expected := "SetTitleMatchMode SetTitleMatch Mode SetTitle MatchMode TitleMatchMode"
	expected := "SetTitleMatchMode Mode SetTitleMatch Match SetTitle Title"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}


if(false){ ; playground
    in =
    (
     oma opa
     klaus mark
     neandertaler
    )
    in := "  weeks   and  years   and   ears"
	in := " weeks weeks years "

    loop,
    {
    e := getAutoKeywords(in)
    tooltip,% e  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1 ,1
    sleep,1000
    if(winExist(A_ScriptName " ahk_class #32770")) ; be careful with loop
        pause
    reload
    }
}

	in := "abc"
	expected := "abc"
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 



	in := "abcdef"
	expected := "abcdef"
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


	in := "al color"
	expected := "al color"
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


	in := "A bit of a longer text"
	expected := "A longer text"
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

if(1){ ; playground
    line := "|rr|"
    newKeyWords := "thanks message"
    expected := "thanks message|rr|"
    loop,
    {
    result :=  setInNewKeywordsIntoLine( newKeyWords , line )
    if(result == expected)
        break
    tooltip,% ">" result "<`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
    sleep,1000
    if(winExist(A_ScriptName " ahk_class #32770")) ; be careful with loop
        pause
    reload
    }
}


}
;\____ test_getAutoKeywords __ 181116202416 __ 16.11.2018 20:24:16 __/



;/¯¯¯¯ test_synonym
test_synonym(){
    f=log\actionList.ahk.log.txt
    fileDelete,% f
    while(a_index < 5 && fileExist(f))
        sleep,150

	in :=       "test1 baum testsynonym1|rr||ahk|q"
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber, "Loop_Parse_ParseWords")) ; line 727 = Loop_Parse_ParseWords
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

	    SELECT := "SELECT word FROM Words Where word like '" in "' "
        SELECT .= " LIMIT 1 " ";"
        Matches := g_actionListDB.Query(SELECT)
        isFound  := false
        for each, row in Matches.Rows
            if( row[1] )
                isFound  := true
        if(!isFound)
            Return in " NOT in DB °" A_LineNumber ":" A_ThisFunc "°"




	in := "A bit of a longer text"
	expected := "A longer text"
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}
;\____ test_synonym




;/¯¯¯¯ test_short_keywords ¯¯ 181118073220 ¯¯ 18.11.2018 07:32:20 ¯¯\
test_short_keywords(){
	in =
(
PHP|r|
Hey PHP
JS|r|
Hey JavaScript
)
	expected =
(
PHP|r|
Hey PHP
JS|r|
Hey JavaScript
)
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	if(0){
		in := "A bit of a longer text"
		expected := "longer text"
		result := getAutoKeywords(in)
		if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
			Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	}
}
;\____ test_short_keywords __ 181118073226 __ 18.11.2018 07:32:26 __/




;/¯¯¯¯ err_indexFollowingLines4search ¯¯ 181124195020 ¯¯ 24.11.2018 19:50:20 ¯¯\
err_indexFollowingLines4search(){
	in =
(
indexFollowingLines|rr||ahk|
Gi: do_indexFollowingLines4search := true
something
a nother thing
)
	expected =
(
PHP|r|
Hey PHP
JS|r|
Hey JavaScript
)
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}
;\____ err_indexFollowingLines4search __ 181124195036 __ 24.11.2018 19:50:36 __/





;/¯¯¯¯ test_dontDeleteComments ¯¯ 181118073106 ¯¯ 18.11.2018 07:31:06 ¯¯\
test_dontDeleteComments(){
	in =
(
dontDeleteComments|r|
; a comment
)
	expected =
(
dont Delete Comments comment|r|
; a comment
)
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in := "A bit of a longer text"
	expected := "longer text"
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber),"getAutoKeywords")
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}
;\____ test_dontDeleteComments __ 181118073110 __ 18.11.2018 07:31:10 __/



;/¯¯¯¯ test_multi_rr_stop_by_is_r ¯¯ 181117224250 ¯¯ 17.11.2018 22:42:50 ¯¯\
err_multi_rr_stop_by_is_r(){
in =
(
Skills|r|Skills.pdf
Skills2|r|Skills2.pdf
Skills3|r|Skills3.pdf
)
	expected =
(
Skills|r|Skills.pdf
Skills2|r|Skills2.pdf
Skills3|r|Skills3.pdf
)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

in =
(
thanks for the message|r|
hiHo
Skills|r|Skills.pdf
Skills2|r|Skills2.pdf
)
	expected =
(
thanks for the message|r|
hiHo
Skills|r|Skills.pdf
Skills2|r|Skills2.pdf
)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

in =
(
thanks for the message|rr||ahk|
send,hiHo
Skills|r|Skills.pdf
Skills2|r|Skills2.pdf
)
	expected =
(
thanks for the message|rr||ahk|
send,hiHo
Skills|r|Skills.pdf
Skills2|r|Skills2.pdf
)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

	in =
(
thanks for the message|rr||ahk|
; Gi: do_indexFollowingLines4search = true
msg =
(
superduper
`)
send,`% msg
Skills|r|Skills.pdf
Skills2|r|Skills2.pdf
)
	expected =
(
msg|r|msg =
without keywords|r|(
superduper|r|superduper
without keywords|r|)
send|r|send,`% msg
thanks for the message|rr||ahk|
msg =
(
superduper
`)
send,`% msg
Skills|r|Skills.pdf
Skills2|r|Skills2.pdf
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}
;\____ test_multi_rr_stop_by_is_r __ 181117224255 __ 17.11.2018 22:42:55 __/



;/¯¯¯¯ err_multi_rr ¯¯ 181117223638 ¯¯ 17.11.2018 22:36:38 ¯¯\
err_multi_rr() {
	
	in =
(
thanks for the message|rr||ahk|
msg =
(
superduper
`)
send,`% msg
|r|
ahkScripte
PhpScripte
)
	expected =
(
thanks for the message|rr||ahk|
msg =
(
superduper
`)
send,`% msg
ahkScripte Scripte PhpScripte|r|
ahkScripte
PhpScripte
)
	
f=log\actionList.ahk.log.txt
fileDelete,log\actionList.ahk.log.txt
while(fileExist(f))
    sleep,150

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
}
;\____ err_multi_rr __ 181117223655 __ 17.11.2018 22:36:55 __/




;/¯¯¯¯ err_multi_r_content ¯¯ 181117223618 ¯¯ 17.11.2018 22:36:18 ¯¯\
err_multi_r_content() {
	
	in =
(
nothing special|r|
textlang
)
	expected =
(
nothing special|r|
textlang
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	lines := ""
	loop,3
	{
		line := "nothing special " A_Index "|r|weeks and forest " A_Index "`n"
		in .= lines
		expected := in
		if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
            Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
    }

			in =
(
special|r|weeks
)
			expected =
(
special|r|weeks
)
			if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
				Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
			
			in =
(
nothing special 1|r|weeks and forest 1
)
			expected =
(
nothing special 1|r|weeks and forest 1
)
			if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
				Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}
;\____ err_multi_r_content __ 181119113151 __ 19.11.2018 11:31:51 __/


;/¯¯¯¯ err_open_issues ¯¯ 181114094056 ¯¯ 14.11.2018 09:40:56 ¯¯\
;/¯¯¯¯ err_open_issues ¯¯ 181114094056 ¯¯ 14.11.2018 09:40:56 ¯¯\
err_open_issues(){
	
	in =
(
|r|
something

another
)
	expected =
(
something another|r|
something

another
)
	feedbackMsgBoxCloseAllWindows()
	
	; MsgBox, % result
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	in =
(
|r|
Keyboard is better1
|r|
Computer is better2
)
	expected =
(
Keyboard better1|r|
Keyboard is better1
Computer better2|r|
Computer is better2
)
	feedbackMsgBoxCloseAllWindows()
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
}
;\____ err_open_issues __ 181114094059 __ 14.11.2018 09:40:59 __/
;\____ err_open_issues __ 181114094059 __ 14.11.2018 09:40:59 __/


;/¯¯¯¯ err_doAsimpleCopyOfLine ¯¯ 181124201212 ¯¯ 24.11.2018 20:12:12 ¯¯\
err_doAsimpleCopyOfLine(){
in := "a|r|A"
expected := true
rootLineObj := { value:in, Aindex: 1 }
isCommandType := setCommandTypeS(rootLineObj, rootCmdTypeObj, rootCollectObj, rootDoObj )
result := doAsimpleCopyOfLine(ByRef rootCmdTypeObj,infoBox := "")
if(result <> expected){
    feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), A_This )
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}
}
;\____ err_doAsimpleCopyOfLine __ 181124201215 __ 24.11.2018 20:12:15 __/



;/¯¯¯¯ err_is_r ¯¯ 181128135906 ¯¯ 28.11.2018 13:59:06 ¯¯\
err_is_r(){
; automatically create keywords. by using: |r|value value value ...
    f=log\actionList.ahk.log.txt
    fileDelete,log\actionList.ahk.log.txt
    while(fileExist(f))
        sleep,100

	in =
(
five|r|5
baum|r|huhu all
)
	expected := in
if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

    in =
    (
    baum|r|huhu all
    )
	expected := in
	Critical, Off
	if(errStr := getAssertEqual_ErrorStr( in, expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


}
;\____ err_is __ 181128135910 __ 28.11.2018 13:59:10 __/


;/¯¯¯¯ err_is_r_without_keywords ¯¯ 181128135906 ¯¯ 28.11.2018 13:59:06 ¯¯\
err_is_r_without_keywords(){
; automatically create keywords. by using: |r|value value value ...
    f=log\actionList.ahk.log.txt
    fileDelete, % f
    while(fileExist(f))
        sleep,100
	in =
(
|r|setTitleMatchMode
)
	expected =
(
setTitleMatchMode setTitleMatch Mode setTitle MatchMode TitleMatchMode|r|setTitleMatchMode
)
	expected =
(
setTitleMatchMode Mode setTitleMatch Match setTitle Title|r|setTitleMatchMode
)
if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

    f=log\actionList.ahk.log.txt
    fileDelete, % f
    while(fileExist(f))
        sleep,100
	in =
(
|r|om is a color
)
	expected =
(
om color|r|om is a color
)
if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

}
;\____ err_is_r_without_keywords __ 181128135910 __ 28.11.2018 13:59:10 __/



;/¯¯¯¯ err_is_without_keywords ¯¯ 181114072044 ¯¯ 14.11.2018 07:20:44 ¯¯\
err_is_without_keywords(){


f=log\actionList.ahk.log.txt
fileDelete,log\actionList.ahk.log.txt
while(fileExist(f))
    sleep,100

	in =
(
java and javascript
)
	expected := "java javascript"
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	in =
(
al color
no colors
)
	expected := "al color colors"
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	if(errStr := getAssertEqual_ErrorStr(      in,      expected,A_ThisFunc ":" A_LineNumber,"getAutoKeywords"))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	in =
(
|r|
al color
no colors
|r|
weeks and years
|r|
girls and boys
|r|
trees and animals
|r|
java and javascript
)
	expected =
(
al color colors|r|
al color
no colors
weeks years|r|
weeks and years
girls boys|r|
girls and boys
trees animals|r|
trees and animals
java javascript|r|
java and javascript
)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 



	in =
(
|r|
A bit of a longer50 text
|r|
weeks and forest52
)
	expected =
(
A longer50 text|r|
A bit of a longer50 text
weeks forest52|r|
weeks and forest52
)
	feedbackMsgBoxCloseAllWindows()
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

	
	
	in =
(
|r|
weeks and years
)
	expected =
(
weeks years|r|
weeks and years
)
	feedbackMsgBoxCloseAllWindows()
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	in =
(
; ___open pfade E|rr||ahk|openInEditor,D:\pfade.ahk
string
|r|
weeks and years
)
	expected =
(
string
weeks years|r|
weeks and years
)
	feedbackMsgBoxCloseAllWindows()
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	in =
(
___open pfade E|rr||ahk|openInEditor,D:\pfade.ahk

string

|r|
a color

|r|
weeks
)
	expected =
(
___open pfade E|rr||ahk|openInEditor,D:\pfade.ahk
string
a color|r|
a color
weeks|r|
weeks
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	in =
(
___open|rr||ahk|openInEditor,D:\pfade.ahk

string

|r|
a weeks
years

)
	expected =
(
___open|rr||ahk|openInEditor,D:\pfade.ahk
string
a weeks years|r|
a weeks
years
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	
	in =
(
|r|
a color kindergarten
|r|
a weeks years

)
	expected =
(
a color kindergarten|r|
a color kindergarten
a weeks years|r|
a weeks years
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	
	in =
(
|r|
a color kindergarten
|r|
a weeks years
)
	expected =
(
a color kindergarten|r|
a color kindergarten
a weeks years|r|
a weeks years

)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	
	
	in =
(
|r|
a color kindergarten
|r|
a weeks years

)
	expected =
(
a color kindergarten|r|
a color kindergarten
a weeks years|r|
a weeks years

)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	
	in =
(
|r|
a weeks
years
)
	expected =
(
a weeks years|r|
a weeks
years
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	
	
	
	in =
(
|r|
a weeks
years
)
	expected =
(
a weeks years|r|
a weeks
years
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in =
(
|r|
a color
|r|
a weeks
years
)
	expected =
(
a color|r|
a color
a weeks years|r|
a weeks
years
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	
	
	in =
(
|r|
a color
|r|
a weeks
years

)
	expected =
(
a color|r|
a color
a weeks years|r|
a weeks
years
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	
	
	in =
(
|r|
a color

|r|
a weeks
years

)
	expected =
(
a color|r|
a color
a weeks years|r|
a weeks
years

)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	in =
(
string

|r|
a color

|r|
a weeks
years

)
	expected =
(
string
a color|r|
a color
a weeks years|r|
a weeks
years

)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
	in =
(
string

|r|
a color

|r|
a weeks
years

)
	expected =
(
string
a color|r|
a color
a weeks years|r|
a weeks
years

)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
}
;\____ err_is_without_keywords __ 181114072047 __ 14.11.2018 07:20:47 __/




;/¯¯¯¯ err_difficult_do_it_later ¯¯ 181115185319 ¯¯ 15.11.2018 18:53:19 ¯¯\
err_difficult_do_it_later(){
	in =
(
|r|
A bit of a longer text
)
	expected =
(
A longer text|r|
A bit of a longer text
)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	in =
(
|r|
a
)
	expected =
(
a|r|
a
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in =
(
|r|
Keyboard is better
|r|
Computer is better
)
	expected =
(
Keyboard better|r|
Keyboard is better
Computer better|r|
Computer is better
)
	feedbackMsgBoxCloseAllWindows()
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	in =
(
a|r|
a
b|r|
b
)
	
	expected =
(
a|r|
a
b|r|
b
)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	
}
;/¯¯¯¯ err_problemNow ¯¯ 181118093655 ¯¯ 18.11.2018 09:36:55 ¯¯\
err_problemNow(){
	in =
(
abca
)
	expected =
(
abca
)
if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in =
(
abc|r|With a bit of content
)
	expected =
(
abc|r|With a bit of content
)
if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


	in =
(
abc def|r|With a bit of content
)
	expected =
(
abc def|r|With a bit of content
)
if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 

	in =
(
Abca|r|With a bit of content
)
	expected =
(
Abca|r|With a bit of content
)
if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 




	in =
(
abcdef|r|
With a bit of content
)
	expected =
(
abcdef|r|
With a bit of content
)
if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


	in =
(
abcd|r|
With a bit of content
)
	expected =
(
abcd|r|
With a bit of content
)
if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


	in =
(
Abc def[a|r|
With a bit of content
)
	expected =
(
Abc def[a|r|
With a bit of content
)
if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


	in =
(
Abc def[a|rr||ahk|
With a bit of content
)
	expected =
(
Abc def[a|rr||ahk|
With a bit of content
)
if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
    Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


	in =
(
Abc def[a|rr||ahk|[
With a bit of content
)
	expected =
(
With content|r|With a bit of content
Abc def[a|rr||ahk|[
it =
(
With a bit of content
`)
Send,`% it
	)
	if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 


	in =
(
A[a|rr||ahk|[
busstops is bugieee
)
	expected =
(
busstops bugieee|r|busstops is bugieee
A[a|rr||ahk|[
it =
(
busstops is bugieee
`)
Send,`% it
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
}



;/¯¯¯¯ indexed_programming ¯¯ 181117200823 ¯¯ 17.11.2018 20:08:23 ¯¯\
test_do_indexFollowingLines4search(){
	in =
	(
indexed programming text|rr||ahk|
`; Gi: do_indexFollowingLines4search := true
Tooltip, is green
Msgbox, is yellow
)
	expected =
(
Tooltip green|r|Tooltip, is green
Msgbox yellow|r|Msgbox, is yellow
indexed programming text|rr||ahk|
Tooltip, is green
Msgbox, is yellow
)
	
	expected := Trim(expected," `t`r`n")
	result := Trim(result," `t`r`n")
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	return false
}
;\____ indexed_programming __ 181117200827 __ 17.11.2018 20:08:27 __/




err_tests_preparser(){
	in =
	(
multiline text|r|
line 1
iine 2
)
	expected =
(
multiline text|r|
line 1
iine 2
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in = test0"["|rr||ahk|[
	in =
	(
test0"["|rr||ahk|
WinMove,,,-50
WinMove,,,50
)
	expected =
(
test0"["|rr||ahk|
WinMove,,,-50
WinMove,,,50
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	if(1){
		in =
	(
A|rr||ahk|(
B
)
		expected =
(
A|rr||ahk|(
it =
(
B
`)
Send,`% it
)
		
		if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
			Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	}
	
	if(1){
		in =
(
|r|
almMountain
)
		expected =
(
almMountain Mountain|r|
almMountain
)

		if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
			Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	}
	
	in =
(
|r|
beutiful Brain
)
	expected =
(
beutiful Brain|r|
beutiful Brain
)
	
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	

	
} ; endOf test



err_tests_easy_0(){
    ; a short keyword
	in := "Speak(,""PROD"")"
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in := "PHP|r|PHP-Frameworks"
	expected := "PHP|r|PHP-Frameworks"
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in = `; Comments are not stored in the database
	expected := ""
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in = simple string
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	
	in = a|r|A
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in = searchWord|rr||ahk|do something
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
	
	in =
	(
searchWord 1|rr||ahk|do something 1
searchWord 2|rr||ahk|do something 2
	)
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}


err_unitTest1(){
	in =
(
aaa|r|AAA
)
	expected =
    (
    aaa|r|AAA
    )
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_LineNumber ":" A_ThisFunc "°" 
}


;

;getAssertEqual_ErrorStr(in,expected,result,ALineNumber){
getAssertEqual_ErrorStr(ByRef in,ByRef expected,ALineNumber,myFuncName := "Loop_Parse_ParseWords" ){
	global strDebugByRef
	
	if(!ALineNumber)
		MsgBox,error: ALineNumber must not be empty
	if(!ALineNumber)
		MsgBox,error: myFuncName must not be empty
	if(g_do_only_this_testCase && !InStr(ALineNumber,g_do_only_this_testCase)){
		return false
		MsgBox,% "`n`n`n`n"  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
    }


	fileNameResult := "result18-11-13_18-03.txt"
	fileNameExpected := "expected18-11-13_18-03.txt"
	if(myFuncName == "getAutoKeywords"){
		result := getAutoKeywords(in)
		;MsgBox,% ALineNumber " wants func:" myFuncName "`n`n`n`n"  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
	}else{
		result := Loop_Parse_ParseWords( in )
		; ^==== ca line Loop_Parse_ParseWords:1064 > Loop_Parse_ParseWords_LoopField:726 > AddWordToList:1703
		;MsgBox,% ALineNumber " wants func:" myFuncName "`n`n`n`n"  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")



    }

        timeStampMini = %A_DD%%A_Min%%A_Sec%

		fromLine := ALineNumber ">`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
        sqlLastError := SQLite_LastError()
        if(trim(sqlLastError)){
            tooltip,% ":( g_actionListID = " g_actionListID ",sqlLastError = " sqlLastError ", fromLine= " fromLine
            sleep,3000
        }
        if(1){
            VALUES = VALUES ('%A_ScriptName%_%A_ThisFunc%' , '%fromLine%', 0, '%timeStampMini%', %g_actionListID% , 555);
            INSERT_INTO_words := "INSERT INTO words (wordindexed, word, count,     wordreplacement   , actionListID, lineNr) "
            INSERT_INTO_words .= VALUES
            g_actionListDB.Query(INSERT_INTO_words)

            ; check if its really in db:
            SELECT := "SELECT wordreplacement FROM Words Where wordreplacement like '"
            SELECT .= timeStampMini "' LIMIT 1 " ";"
            Matches := g_actionListDB.Query(SELECT)
            isFound  := false
            for each, row in Matches.Rows
                if( row[1] )
                    isFound  := true

    		fromLine := ALineNumber ">`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
            sqlLastError := SQLite_LastError()
            if(!isFound)
                msgbox,:( g_actionListID = %g_actionListID%,sqlLastError = %sqlLastError% %fromLine% `n`n %SELECT%


        }


	expected := Trim(expected," `t`r`n")
	result := Trim(result," `t`r`n")
	if(result == expected){
		tooltip, :-)
		return false
	}else{
		
		tooltip, :-(
		; Speak("Not Okey in " ALineNumber, "PROD" )
		FileDelete, % fileNameResult
		FileDelete, % fileNameExpected
		
		SetTitleMatchMode,2
		IfWinExist,% fileNameResult
			WinClose,% fileNameResult
		
		Sleep,150
		
		headerStr  :=  ALineNumber " , " myFuncName  ":`n"
		FileAppend,% headerStr result, % fileNameResult, UTF-8
		FileAppend,% headerStr expected,% fileNameExpected, UTF-8
		
		; ToolTip,% result , 1,1
		r1 := "`n/¯¯¯¯ result ¯¯`n"
		r2 := "`n\____ result __`n"
		e1 := "`n/¯¯¯¯ expected ¯¯ `n"
		e2 := "`n\____ expected __ `n"
		i1 := "`n/¯¯¯¯ in ¯¯ `n"
		i2 := "`n\____ in __ `n"
		
		strCompareBoth :=  ":( result<>expected" r1 result r2 "<>" e1 expected e2 "" i1 in i2
		tooltip,% strCompareBoth "`n`n"  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		result := regExReplace(result,"(``|`%)","``$1")
     ; s := regExReplace(s,"`%","``%")
		result := regExReplace(result,"([\n\r][ ]*)\)","$1``)")
		
		; If(!WinExist(fileNameResult) && result)
			run,E:\____\_Portable\HTTP_gif_html_php_sql\WinMerge\WinMerge.exe "%fileNameResult%" "%fileNameExpected%"
		
		strCompareBoth4clipboard :=  ":( result<>expected" r1 result r2 "<>" e1 expected e2
		; clipboard .= "`n`n" strCompareBoth4clipboard
		; msg := "Not Okey in " ALineNumber ":`n`n" strCompareBoth "#####################`n" strDebugByRef "`n`n ("
		msg := strCompareBoth
		; msgbox,  , % "Not Okey in " ALineNumber , % strCompareBoth "#####################`n" strDebugByRef "`n`n ("
		
		; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), msg )
		; , ALineNumber ">" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		
		global errStr_first
		if(!errStr_first)
			errStr_first := strCompareBoth
		g_do_only_this_testCase := ALineNumber
    	; msgbox, % ALineNumber ":`n" strCompareBoth "`n`n`n`n"  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		Return ALineNumber ":`n" strCompareBoth
	}
	; msgbox, % ":)" strDebugByRef "`n`n`n`n"  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
	return false
}


prepareGi(){
	
; fileDelete,log\actionList.ahk.log.txt
	
	CoordMode, ToolTip,Screen
	
	
	feedbackMsgBoxCloseAllWindows()
	; clipboard := ""
	; ; Speak("gestartet","PROD")
	
	Hotkey, WheelUp, off
	Hotkey, WheelDown, off
	;BuildTrayMenu()

    Menu, Tray, Standard
}
waitUserDoSometingMilli(needetMilli,sleepi:=111){
	tooltip, % "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
	while(A_TimeIdleKeyboard > needetMilli){
		Sleep,% sleepi
	}
	tooltip,
}
waitUserDoNothingMilli(needetMilli := 4111,sleepi:=111){
	tooltip, % "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1,1
	while(A_TimeIdleKeyboard < needetMilli){
		Sleep,% sleepi
	}
	tooltip,
}

#IfWinActive,
~^s::
;tooltip,saved ??
sleep,876
reload
; do sth
return
settitlematchmode,2
#IfWinNotActive,ahk_class SunAwtFrame
esc::
     exitapp
return
#IfWinActive,asdjkfhaldjskhfsfhakdsjfasdkaösdjkfh
	WheelUp::
return
#IfWinActive,asdjkfhaldjskhfsfhakdsjfasdkaösdjkfh
	WheelDown::
return


RecomputeMatchesTimer:
PauseResumeScript:
ExitScript:
doListBoxFollowMouse:
show_ListBox_Id:
checkInRegistryChangedActionListAddress:
checkActionListAHKfile_sizeAndModiTime:
lbl_Help_AutoHotkey_online:
lbl_HelpOnline_features:
lbl_HelpOnline_shortcut:
lbl_HelpOnline_issues_open:
return
RenoveToolTip:
tooltip,
return



#Include %A_ScriptDir%\Includes\gi-everywhere.inc.ahk
#Include,RegWrite181031.ahk
#Include %A_ScriptDir%\inc_ahk\closeAllAHK_restoreClosedAHK.inc.ahk