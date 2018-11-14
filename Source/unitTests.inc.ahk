; #Include %A_ScriptDir%\unitTests.inc.ahk
FileEncoding, UTF-8
global errStr_first := ""

toDoList =
(
open issues:
|r|
Keyboard is better
|r|
Computer is better
)

if(1 && InStr(A_ComputerName,"SL5")){
	prepareGi()
	countErrors := 0
	if(0){
	if(errStr:=err_is_without_keywords())
		countErrors++
	if(errStr:=err_tests_easy_0())
		countErrors++
	if(errStr:=err_problemNow())
		countErrors++
	if(errStr:=err_unitTest1())
		countErrors++
	if(errStr:=err_tests_preparser())
		countErrors++
	if(errStr:=err_difficult_do_it_later())
		countErrors++
    }
	if(errStr:=err_open_issues())
		countErrors++


	global errStr_first
	clipboard := clipboard "`n`nFIRST=" errStr_first "`nLAST=" errStr
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
	msgbox,%countErrors% errors counted. reload??
	run,% "..\start.ahk"
}	


;/¯¯¯¯ err_open_issues ¯¯ 181114094056 ¯¯ 14.11.2018 09:40:56 ¯¯\
err_open_issues(){

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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr

}
;\____ err_open_issues __ 181114094059 __ 14.11.2018 09:40:59 __/









;/¯¯¯¯ err_is_without_keywords ¯¯ 181114072044 ¯¯ 14.11.2018 07:20:44 ¯¯\
err_is_without_keywords(){

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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr

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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr


	in =
(
___open pfade E|rr||ahk|openInEditor,D:\pfade.ahk
string
|r|
weeks and years
)
	expected =
(
___open pfade E|rr||ahk|openInEditor,D:\pfade.ahk
string
weeks years |r|
weeks and years
)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr


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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr


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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr




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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr




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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr





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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr




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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr






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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr

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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr





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
years weeks |r|
years weeks
)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr





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
years weeks |r|
years weeks
)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr



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
years weeks |r|
years weeks
)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr



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
years weeks |r|
years weeks
)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr


}
;\____ err_is_without_keywords __ 181114072047 __ 14.11.2018 07:20:47 __/

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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	
	in = 
(
|r|
a
)
	expected =
(
without keywords |r|
a
)
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	
	in = 
(
|r|
a
|r|
b
)
	result := Loop_Parse_ParseWords(in)
	expected =
(
without keywords |r|
a
without keywords |r|
b
)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	
	
}

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
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	
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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	
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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	
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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	
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
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	
	
} ; endOf test

err_tests_easy_0(){
	in = `; Comments are not stored in the database
	result := Loop_Parse_ParseWords(in)
	expected := ""
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	in = simple string
	result := Loop_Parse_ParseWords(in)
	expected := in
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	
	in = a|r|A
	result := Loop_Parse_ParseWords(in)
	expected := in
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	in = searchWord|rr||ahk|do something
	result := Loop_Parse_ParseWords(in)
	expected := in
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
	
	in = 
	(
searchWord 1|rr||ahk|do something 1
searchWord 2|rr||ahk|do something 2
	)
	expected := in
	result := Loop_Parse_ParseWords(in)
	if(errStr := getAssertEqual_ErrorStr(expected,result,A_LineNumber))
		Return errStr
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
	return getAssertEqual_ErrorStr(expected,result,A_LineNumber)
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
		
		strCompareBoth :=  ":( result<>expected" r1 result r2 "<>" e1 expected e2 
		
		result := regExReplace(result,"(``|`%)","``$1")
     ; s := regExReplace(s,"`%","``%")
		result := regExReplace(result,"([\n\r][ ]*)\)","$1``)")
		
		If(!WinExist(fileNameResult) && result)
			run,E:\____\_Portable\HTTP_gif_html_php_sql\WinMerge\WinMerge.exe "%fileNameResult%" "%fileNameExpected%"
		
		strCompareBoth4clipboard :=  ":( result<>expected" r1 result r2 "<>" e1 expected e2 
		clipboard .= "`n`n" strCompareBoth4clipboard
		if(!result && strCompareBoth)
			clipboard .= "`n####`n" strDebugByRef
		; msg := "Not Okey in " ALineNumber ":`n`n" strCompareBoth "#####################`n" strDebugByRef "`n`n ("
		msg := strCompareBoth
		; msgbox,  , % "Not Okey in " ALineNumber , % strCompareBoth "#####################`n" strDebugByRef "`n`n ("
		feedbackMsgBox(RegExReplace(A_LineFile,".*\\") ">" A_LineNumber, msg )
		, ALineNumber ">" A_LineNumber " " RegExReplace(A_LineFile,".*\\")
		
		global errStr_first
		if(!global errStr_first)
			errStr_first := strCompareBoth
		Return ALineNumber ":`n" strCompareBoth
	}
	return false
	msgbox, % ":)" strDebugByRef "`n`n`n`n"  "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\")
}


prepareGi(){
	clipboard := ""
	Speak("gestartet","PROD")
	
	Hotkey, WheelUp, off
	Hotkey, WheelDown, off
	BuildTrayMenu()
}
