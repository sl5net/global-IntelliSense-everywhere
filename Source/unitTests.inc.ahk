; #Include %A_ScriptDir%\unitTests.inc.ahk
FileEncoding, UTF-8
global errStr_first := ""

global in

prepareGi()
countErrors := 0
if(false){
}
if(1){
 if(errStr:=err_is_without_keywords())
	countErrors++
else if(errStr:=err_multi_r_content())
	countErrors++
else if(errStr:=err_tests_easy_0())
	countErrors++
else if(errStr:=err_problemNow())
	countErrors++
else if(errStr:=err_unitTest1())
	countErrors++
else if(errStr:=err_tests_preparser())
	countErrors++
}
if(1){
}
else if(errStr:=test_synonym())
	countErrors++
else if(errStr:=err_multi_rr())
	countErrors++
else if(errStr:=test_getAutoKeywords())
	countErrors++
else if(errStr:=err_difficult_do_it_later())
	countErrors++
else if(errStr:=err_open_issues())
	countErrors++
else if(errStr:=test_dontDeleteComments())
	countErrors++

global errStr_first
; clipboard := clipboard "`n`nFIRST=" errStr_first "`nLAST=" errStr
errStr_first := regExReplace(errStr_first,"(``|`%)","``$1")
     ; s := regExReplace(s,"`%","``%")
errStr_first := regExReplace(errStr_first,"([\n\r][ ]*)\)","$1``)")

msg =
	(
%countErrors% errors counted.
( clipboard := errStr_first )
%errStr_first%

reload??
	)
msgbox,% countErrors " errors counted. reload?? errStr= `n`n" errStr
run,% "..\start.ahk"


;/¯¯¯¯ test_synonym
test_synonym(){
    in := "test_synonym|rr||ahk|q"
    expected := "test_synonym|rr||ahk|q"
    expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
    result := getAutoKeywords(oldKeywords:="", in)
    if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
        Return errStr " °" A_ThisFunc "° "

    in := "A bit of a longer text"
    expected := "longer text"
    result := getAutoKeywords(oldKeywords:="", in)
    if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
        Return errStr " °" A_ThisFunc "° "
}
;\____ test_synonym


test_dontDeleteComments(){
in =
(
dontDeleteComments|r|
; a comment
)
expected =
(
dontDeleteComments|r|
; a comment
)
    expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
    result := getAutoKeywords(oldKeywords:="", in)
    if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
        Return errStr " °" A_ThisFunc "° "

    in := "A bit of a longer text"
    expected := "longer text"
    result := getAutoKeywords(oldKeywords:="", in)
    if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
        Return errStr " °" A_ThisFunc "° "
}



;/¯¯¯¯ test_getAutoKeywords ¯¯ 181116202412 ¯¯ 16.11.2018 20:24:12 ¯¯\
test_getAutoKeywords(){
    in := "nothingSpecial textlang"
    expected := "nothing Special textlang"
    expectedInFutureRelaise := "nothingSpecial nothing Special textlang"
    result := getAutoKeywords(oldKeywords:="", in)
    if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
        Return errStr " °" A_ThisFunc "° "

    in := "A bit of a longer text"
    expected := "longer text"
    result := getAutoKeywords(oldKeywords:="", in)
    if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
        Return errStr " °" A_ThisFunc "° "
}
;\____ test_getAutoKeywords __ 181116202416 __ 16.11.2018 20:24:16 __/



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
phpScripte
)
		result := Loop_Parse_ParseWords(in)
		if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
			Return errStr " °" A_ThisFunc "° "


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
thanks for the message|rr||ahk|
msg =
(
superduper
`)
send,`% msg

Skills|r|Skills.pdf
)
		result := Loop_Parse_ParseWords(in)
		if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
			Return errStr " °" A_ThisFunc "° "


}



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
		result := Loop_Parse_ParseWords(in)
		if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
			Return errStr " °" A_ThisFunc "° "


	lines := ""
	loop,3
	{
line := "nothing special " A_Index "|r|weeks and forest " A_Index "`n"
in .= lines
expected := in
		result := Loop_Parse_ParseWords(in)
		if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber)){




in =
(
special|r|weeks
)
expected =
(
special|r|weeks
)
		result := Loop_Parse_ParseWords(in)
		if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
			Return errStr " °" A_ThisFunc "° "

in =
(
nothing special 1|r|weeks and forest 1
)
expected =
(
nothing special 1|r|weeks and forest 1
)
		result := Loop_Parse_ParseWords(in)
		if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	; MsgBox, % result
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	; MsgBox, % result
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
a color
|r|
weeks and years
)
	expected =
(
___open pfade E|rr||ahk|openInEditor,D:\pfade.ahk
string
color |r|
a color
weeks years |r|
weeks and years
)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	; MsgBox, % result
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	in = 
(
a |r|
a
b |r|
b
)
	result := Loop_Parse_ParseWords(in)
	expected =
(
a |r|
a
b |r|
b
)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
}

err_problemNow(){
	in = 
(
A[a|rr||ahk|[
With a bit of content
)
	expected = 
(
A[a|rr||ahk|[
it =
(
With a bit of content
`)
Send,`% it
	)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(rTrim(expected," `t`r`n"),rTrim(result," `t`r`n"),A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
}


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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	in = 
	(
indexed programming text|rr||ahk|
`; Gi: do_indexFollowingLines4search := true
ToolTip, is green
MsgBox, is yellow
)
	expected = 
(
ToolTip green|r|ToolTip, is green
MsgBox yellow|r|MsgBox, is yellow
indexed programming text|rr||ahk|
ToolTip, is green 
MsgBox, is yellow
)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	in = 
(
|r|
almMountain
)
	expected =
(
almMountain |r|
almMountain
)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	
} ; endOf test

err_tests_easy_0(){
	in = `; Comments are not stored in the database
	result := Loop_Parse_ParseWords(in)
	expected := ""
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in = simple string
	result := Loop_Parse_ParseWords(in)
	expected := in
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	
	in = a|r|A
	result := Loop_Parse_ParseWords(in)
	expected := in
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in = searchWord|rr||ahk|do something
	result := Loop_Parse_ParseWords(in)
	expected := in
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
	
	in = 
	(
searchWord 1|rr||ahk|do something 1
searchWord 2|rr||ahk|do something 2
	)
	expected := in
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber))
		Return errStr " °" A_ThisFunc "° "
}


err_unitTest1(){
	in =
(
aaa|r|AAA
)
	result := Loop_Parse_ParseWords(in)
	expected =
    (
    aaa|r|AAA
    )
	return getAssertEqual_ErrorStr(expected,result,A_ThisFunc ":" A_LineNumber)
}




getAssertEqual_ErrorStr(expected,result,ALineNumber){
	global strDebugByRef

	fileNameResult := "result18-11-13_18-03.txt"
	fileNameExpected := "expected18-11-13_18-03.txt"
	
	expected := Trim(expected," `t`r`n")
	result := Trim(result," `t`r`n")
	if(result <> expected){
		Speak("Not Okey in " ALineNumber, "PROD" )
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
		if(!result && strCompareBoth){


			; clipboard .= "`n####`n" strDebugByRef
			}
		; msg := "Not Okey in " ALineNumber ":`n`n" strCompareBoth "#####################`n" strDebugByRef "`n`n ("
		msg := strCompareBoth
		; msgbox,  , % "Not Okey in " ALineNumber , % strCompareBoth "#####################`n" strDebugByRef "`n`n ("

		feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), msg )
		, ALineNumber ">" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		
		global errStr_first
		if(!global errStr_first)
			errStr_first := strCompareBoth
		Return ALineNumber ":`n" strCompareBoth
	}
	return false
	msgbox, % ":)" strDebugByRef "`n`n`n`n"  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
}


prepareGi(){

fileDelete,G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\Source\log\ActionList.ahk.log.txt

    feedbackMsgBoxCloseAllWindows()
	; clipboard := ""
	Speak("gestartet","PROD")
	
	Hotkey, WheelUp, off
	Hotkey, WheelDown, off
	BuildTrayMenu()
}
