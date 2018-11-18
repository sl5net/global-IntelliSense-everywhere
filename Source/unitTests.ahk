#SingleInstance,Force
#Include %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#Include %A_ScriptDir%\inc_ahk\soundBeep.inc.ahk
SetTimer,checkInRegistryChangedActionListAddress,off
SetTimer,checkActionListAHKfile_sizeAndModiTime, off
SetTimer,checkWinChangedTitle,off
Thread, NoTimers , False ; Prevents interruptions from any timers.
lineFileName := RegExReplace(A_LineFile, ".*\\([\w\s\.]+)$", "$1")
#SingleInstance,Force
;<<<<<<<< g_ignRegm <<<< 180224082501 <<<< 24.02.2018 08:25:01 <<<<
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
;>>>>>>>> g_ignReg >>>> 180224082506 >>>> 24.02.2018 08:25:06 >>>>


global errStr_first := ""

prepareGi()

;/¯¯¯¯ g_do_only_this_testCase ¯¯ 181118111647 ¯¯ 18.11.2018 11:16:47 ¯¯\
;/¯¯¯¯ g_do_only_this_testCase ¯¯ 181118111647 ¯¯ 18.11.2018 11:16:47 ¯¯\
;/¯¯¯¯ g_do_only_this_testCase ¯¯ 181118111647 ¯¯ 18.11.2018 11:16:47 ¯¯\
global g_do_only_this_testCase 
g_do_only_this_testCase  := "test_short_keywords"
g_do_only_this_testCase  := ""
;\____ g_do_only_this_testCase __ 181118111650 __ 18.11.2018 11:16:50 __/
;\____ g_do_only_this_testCase __ 181118111650 __ 18.11.2018 11:16:50 __/
;\____ g_do_only_this_testCase __ 181118111650 __ 18.11.2018 11:16:50 __/

countErrors := 0

SetTitleMatchMode,1
WinWaitNotActive,WinMerge
WinGetActiveTitle,activeTitle


if(1 && err_multi_rr_stop_by_is_r())
	countErrors++
else if(1 && errStr:=err_problemNow())
	countErrors++
else if(1 && errStr:=test_short_keywords())
	countErrors++
else if(1){
if(1 && test_do_indexFollowingLines4search())
	countErrors++
if(1 && errStr:=test_synonym())
	countErrors++
else if(false && errStr:=test_dontDeleteComments())
	countErrors++
if(1 && errStr:=err_multi_r_content())
	countErrors++


else if(false){
}
else if(1 && errStr:=test_synonym())
	countErrors++

if(1 && errStr:=err_is_without_keywords())
	countErrors++
if(1){
	if(errStr:=err_multi_r_content())
		countErrors++
	else if(errStr:=err_tests_easy_0())
		countErrors++
	else if(errStr:=err_unitTest1())
		countErrors++
	else if(errStr:=err_tests_preparser())
		countErrors++
}
else if(false){
}
else if(1 && errStr:=err_multi_rr())
	countErrors++
else if(1 && errStr:=test_getAutoKeywords())
	countErrors++
else if(1 && errStr:=err_difficult_do_it_later())
	countErrors++
else if(1 && errStr:=err_open_issues())
	countErrors++
}


ifWinNotActive, WinMerge
    WinGetActiveTitle,activeTitle


; clipboard := clipboard "`n`nFIRST=" errStr_first "`nLAST=" errStr
errStr_first := regExReplace(errStr_first,"(``|`%)","``$1")
     ; s := regExReplace(s,"`%","``%")
errStr_first := regExReplace(errStr_first,"([\n\r][ ]*)\)","$1``)")

msg =
(
%countErrors% errors counted.
( clipboard := errStr_first )
%errStr_first%
)
tooltip,% msg, 1,1

if(!countErrors)
    Speak("Its Okey. No Error found. " ALineNumber, "PROD" )


Critical,On
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

weitUserDoSometingMilli(200)
weitUserDoNothingMilli(2000)
Critical,Off

reload
sleep,9000
exitapp





msgbox,% countErrors " errors counted. reload?? errStr= `n`n" errStr
exitapp
return
; run,% "..\start.ahk"


;/¯¯¯¯ test_synonym
test_synonym(){
	in =
(
test1 baum testsynonym1|rr||ahk|q
testsynonym2|rr||ahk|q
)
	expected =
(
test1 baum testsynonym1|rr||ahk|q
testsynonym2|rr||ahk|q
)
; expectedInFutureRelaise := "nothingSpecial nothing Special textlang"

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in := "A bit of a longer text"
	expected := "longer text"
	result := getAutoKeywords(in)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
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
		Return errStr " °" A_ThisFunc "° "

    if(0){
        in := "A bit of a longer text"
        expected := "longer text"
        result := getAutoKeywords(in)
        if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
            Return errStr " °" A_ThisFunc "° "
    }
}
;\____ test_short_keywords __ 181118073226 __ 18.11.2018 07:32:26 __/





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
	result := getAutoKeywords(in)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in := "A bit of a longer text"
	expected := "longer text"
	result := getAutoKeywords(in)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
}
;\____ test_dontDeleteComments __ 181118073110 __ 18.11.2018 07:31:10 __/


;/¯¯¯¯ test_getAutoKeywords ¯¯ 181116202412 ¯¯ 16.11.2018 20:24:12 ¯¯\
test_getAutoKeywords(){
	in := "weeks and years"
	expected := "weeks years"
	expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
	result := getAutoKeywords(in)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in := "A bit of a longer text"
	expected := "longer text"
	result := getAutoKeywords(in)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
}
;\____ test_getAutoKeywords __ 181116202416 __ 16.11.2018 20:24:16 __/


;/¯¯¯¯ test_multi_rr_stop_by_is_r ¯¯ 181117224250 ¯¯ 17.11.2018 22:42:50 ¯¯\
err_multi_rr_stop_by_is_r(){
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
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
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
Scripte |r|
ahkScripte
PhpScripte
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	

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
		Return errStr " °" A_ThisFunc "° "
	
	
	lines := ""
	loop,3
	{
		line := "nothing special " A_Index "|r|weeks and forest " A_Index "`n"
		in .= lines
		expected := in

		if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber)){
			
			
			
			
			in =
(
special|r|weeks
)
			expected =
(
special|r|weeks
)

			if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
				Return errStr " °" A_ThisFunc "° "
			
			in =
(
nothing special 1|r|weeks and forest 1
)
			expected =
(
nothing special 1|r|weeks and forest 1
)

			if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
				Return errStr " °" A_ThisFunc "° "
			
			msgbox,% in "`n" result
			Return errStr " °" A_ThisFunc "° "
		}
	}
}


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
something another |r|
something

another
)
	feedbackMsgBoxCloseAllWindows()

	; MsgBox, % result
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	in =
(
|r|
Keyboard is better1
|r|
Computer is better2
)
	expected =
(
Keyboard better |r|
Keyboard is better1
Computer better |r|
Computer is better2
)
	feedbackMsgBoxCloseAllWindows()

	; MsgBox, % result
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
}
;\____ err_open_issues __ 181114094059 __ 14.11.2018 09:40:59 __/
;\____ err_open_issues __ 181114094059 __ 14.11.2018 09:40:59 __/









;/¯¯¯¯ err_is_without_keywords ¯¯ 181114072044 ¯¯ 14.11.2018 07:20:44 ¯¯\
err_is_without_keywords(){
	in =
(
___open pfade E|rr||ahk|openInEditor,D:\pfade.ahk
string
|r|
al color
|r|
weeks and years
)
	expected =
(
___open pfade E|rr||ahk|openInEditor,D:\pfade.ahk
string
color |r|
al color
weeks years |r|
weeks and years
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
	in =
(
|r|
A bit of a longer50 text
|r|
weeks and forest52
)
	expected =
(
longer text |r|
A bit of a longer50 text
weeks forest |r|
weeks and forest52
)
	feedbackMsgBoxCloseAllWindows()

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
	in =
(
|r|
weeks and years
)
	expected =
(
weeks years |r|
weeks and years
)
	feedbackMsgBoxCloseAllWindows()

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
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
weeks years |r|
weeks and years
)
	feedbackMsgBoxCloseAllWindows()

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
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
color |r|
a color
weeks |r|
weeks
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
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
weeks years |r|
a weeks
years
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
	
	in =
(
|r|
a color kindergarten
|r|
a weeks years

)
	expected =
(
color kindergarten |r|
a color kindergarten
weeks years |r|
a weeks years
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
	
	in =
(
|r|
a color kindergarten
|r|
a weeks years
)
	expected =
(
color kindergarten |r|
a color kindergarten
weeks years |r|
a weeks years

)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
	
	
	in =
(
|r|
a color kindergarten
|r|
a weeks years

)
	expected =
(
color kindergarten |r|
a color kindergarten
weeks years |r|
a weeks years

)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
	
	in =
(
|r|
a weeks
years
)
	expected =
(
weeks years |r|
a weeks
years
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
	
	
	
	in =
(
|r|
a weeks
years
)
	expected =
(
weeks years |r|
a weeks
years
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
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
color |r|
a color
weeks years |r|
a weeks
years
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
	
	
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
color |r|
a color
weeks years |r|
a weeks
years
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
	
	
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
color |r|
a color
weeks years |r|
a weeks
years

)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
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
color |r|
a color
weeks years |r|
a weeks
years

)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
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
color |r|
a color
weeks years |r|
a weeks
years

)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
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
longer text |r|
A bit of a longer text
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	in =
(
|r|
a
)
	expected =
(
a |r|
a
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in =
(
|r|
Keyboard is better
|r|
Computer is better
)
	expected =
(
Keyboard better |r|
Keyboard is better
Computer better |r|
Computer is better
)
	feedbackMsgBoxCloseAllWindows()

	; MsgBox, % result
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	in =
(
a |r|
a
b |r|
b
)

	expected =
(
a |r|
a
b |r|
b
)
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
}
;/¯¯¯¯ err_problemNow ¯¯ 181118093655 ¯¯ 18.11.2018 09:36:55 ¯¯\
err_problemNow(){
	in =
(
A[a|rr||ahk|[
With a bit of content
)
	expected =
(
With content|r|With a bit of content
A[a|rr||ahk|[
it =
(
With a bit of content
`)
Send,`% it
	)

	if(errStr := getAssertEqual_ErrorStr(in,Trim(expected," `t`r`n"),A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
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
		Return errStr " °" A_ThisFunc "° "
	
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
		Return errStr " °" A_ThisFunc "° "
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
		Return errStr " °" A_ThisFunc "° "
	
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
		Return errStr " °" A_ThisFunc "° "
	
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
			Return errStr " °" A_ThisFunc "° "
	}
	
	if(1){
		in =
(
|r|
almMountain
)
		expected =
(
Mountain |r|
almMountain
)
; future relaise: almMountain

		if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
			Return errStr " °" A_ThisFunc "° "
	}
	
	in =
(
|r|
beutiful Brain
)
	expected =
(
beutiful Brain |r|
beutiful Brain
)

	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
} ; endOf test

err_tests_easy_0(){
    ; a short keyword
	in := "PHP|r|PHP-Frameworks"

	expected := "PHP|r|PHP-Frameworks"
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in = `; Comments are not stored in the database

	expected := ""
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in = simple string
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	in = a|r|A
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in = searchWord|rr||ahk|do something
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in =
	(
searchWord 1|rr||ahk|do something 1
searchWord 2|rr||ahk|do something 2
	)
	expected := in
	if(errStr := getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
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
	return getAssertEqual_ErrorStr(in,expected,A_ThisFunc ":" A_LineNumber)
}




;getAssertEqual_ErrorStr(in,expected,result,ALineNumber){
getAssertEqual_ErrorStr(ByRef in,ByRef expected,ALineNumber){
	global strDebugByRef
	
	if(!ALineNumber)
		MsgBox,error: %ALineNumber% must not be empty
	if(g_do_only_this_testCase && !InStr(ALineNumber,g_do_only_this_testCase))
		return
	
	
	tooltip,% ALineNumber
	sleep,5000
	
	fileNameResult := "result18-11-13_18-03.txt"
	fileNameExpected := "expected18-11-13_18-03.txt"
	
	result := Loop_Parse_ParseWords( in )
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
		
		FileAppend,% ALineNumber ":`n" result, % fileNameResult, UTF-8
		FileAppend,% ALineNumber ":`n" expected,% fileNameExpected, UTF-8
		
		; ToolTip,% result , 1,1
		r1 := "`n/¯¯¯¯ result ¯¯`n"
		r2 := "`n\____ result __`n"
		e1 := "`n/¯¯¯¯ expected ¯¯ `n"
		e2 := "`n\____ expected __ `n"
		i1 := "`n/¯¯¯¯ in ¯¯ `n"
		i2 := "`n\____ in __ `n"
		
		strCompareBoth :=  ":( result<>expected" r1 result r2 "<>" e1 expected e2 "" i1 in i2
		
		result := regExReplace(result,"(``|`%)","``$1")
     ; s := regExReplace(s,"`%","``%")
		result := regExReplace(result,"([\n\r][ ]*)\)","$1``)")
		
		If(!WinExist(fileNameResult) && result)
			run,E:\____\_Portable\HTTP_gif_html_php_sql\WinMerge\WinMerge.exe "%fileNameResult%" "%fileNameExpected%"
		
		strCompareBoth4clipboard :=  ":( result<>expected" r1 result r2 "<>" e1 expected e2
		; clipboard .= "`n`n" strCompareBoth4clipboard
		; msg := "Not Okey in " ALineNumber ":`n`n" strCompareBoth "#####################`n" strDebugByRef "`n`n ("
		msg := strCompareBoth
		; msgbox,  , % "Not Okey in " ALineNumber , % strCompareBoth "#####################`n" strDebugByRef "`n`n ("
		
		; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), msg )
		, ALineNumber ">" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		
		global errStr_first
		if(!errStr_first)
			errStr_first := strCompareBoth
		g_do_only_this_testCase := ALineNumber
		Return ALineNumber ":`n" strCompareBoth
	}
	return false
	msgbox, % ":)" strDebugByRef "`n`n`n`n"  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
}


prepareGi(){
	
; fileDelete,G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\Source\log\ActionList.ahk.log.txt
	
	CoordMode, ToolTip,Screen
	
	
	feedbackMsgBoxCloseAllWindows()
	; clipboard := ""
	; ; Speak("gestartet","PROD")
	
	Hotkey, WheelUp, off
	Hotkey, WheelDown, off
	BuildTrayMenu()
}
weitUserDoSometingMilli(milli){
	while(A_TimeIdleKeyboard > milli){
		Sleep,% Ceil(milli / 2)
	}
}
weitUserDoNothingMilli(milli){
	while(A_TimeIdleKeyboard < 4000){
		Sleep,% ceil(milli / 2)
	}
}

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
return



#Include %A_ScriptDir%\Includes\gi-everywhere.inc.ahk
#Include,RegWrite181031.ahk