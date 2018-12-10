#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

o := "ABC SetTitle MatchMode"
o := "setTitleMatchMode" ; <== works not
o := " setTitleMatchMode " ; <== works
n := getAutoKeywords181209( o )
; ToolTip5sec( n "   =n `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",190,1 )
ToolTip, % ">" n "<   =n `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",190,1 
Sleep,3000
Reload



;/¯¯¯¯ getAutoKeywords181209 ¯¯ 181209222042 ¯¯ 09.12.2018 22:20:42 ¯¯\
getAutoKeywords181209(ByRef oldKeywords){
    ; AddWord rootDoObj.createKeys https://g-intellisense.myjetbrains.com/youtrack/issues?q=project:%20g-IntelliSense#issueId=GIS-65
	; https://github.com/sl5net/global-IntelliSense-everywhere/blob/master/Source/Includes/ActionList.ahk#L1438
    ; https://stackoverflow.com/questions/53345266/generate-search-words-from-text-with-camelcase-by-using-regex
	newKeyWords := " " oldKeywords " " 
	resultStr  := ""
	
	firstWord := RegExMatch(newKeyWords,"(\w+)",m) ? m1 : ""
	resultStr := firstWord " "
	
	addKeysMAX := 44
	minLength := 3
	regEx := "\b((\w+?(?=[A-Z]|\b))([A-Z][a-z]*)?)([A-Z][a-z]*)?"
	StartingPosition  := 2
	addedKeysCounter := 0
	Array := [] ; or Array := Array()
	while(foundPos := RegexMatch( newKeyWords, "(" regEx ")", Match, StartingPosition )){
		; StartingPosition := Match.Pos(1) + Match.Len(1)
		
		if(addedKeysCounter >= addKeysMAX)
			break
		loop,3
		{
			word := Match%A_Index%
			; strlenWord := MatchLen%A_Index% ; works not 
			; strlenWord := Match.Len(1) ; works not 
			; MsgBox, % len " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
			
			strlenWord := strlen(word)
			StartingPosition += strlenWord
			if(0){
				strlenWord := strlen(word)
				wordPast := SubStr(newKeyWords, Match.Pos(1) + strlenWord ) ; + Match.Len(1) ) ; strlenWord +  
				MsgBox,% ">" wordPast "<  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
				; MsgBox,% ">" word "<  (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
			}
			if(!HasVal(Array,word)){
				if(!firstWord){
					firstWord := word
					resultStr .= firstWord " "
				}
				if(minLength <= strlen(word)){
					Array.Push(word) ; Append this line to the array.
					ArrayCount++
				}
				;rest :=  strlenWord
				rest := SubStr( oldKeywords , strlenWord + 2 ) ; strlenWord 
				if(minLength <= strlen(rest)){
					Array.Push(rest) ; Append this line to the array.
					ArrayCount++
				}
				resultStr .= "  " ArrayCount ":" word " " rest
				; resultStr .= "  " ArrayCount ":" word " (" rest ") "
			}
		}
	}
	; MsgBox,% ">" resultStr "<  `n`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	return RTrim( resultStr )
	newKeyWords := ""
	Loop % ArrayCount
	{
        ; element := Array%A_Index%
		element := Array[A_Index]
        ; MsgBox % "Element number " . A_Index . " is " . Array%A_Index%
		newKeyWords .= element " "
	}
	if(!newKeyWords := rTrim(newKeyWords))
		if(!newKeyWords := firstWord)
			newKeyWords := "without keywords"
        ; MsgBox % "Element number " . A_Index . " is " . Array%A_Index%
	return newKeyWords
}
;\____ getAutoKeywords181209 __ 181209222049 __ 09.12.2018 22:20:49 __/



;/¯¯¯¯ HasVal ¯¯ 181116205402 ¯¯ 16.11.2018 20:54:02 ¯¯\
HasVal(haystack, needle) { ; return index
	if !(IsObject(haystack)) || (haystack.Length() = 0)
		return 0
	for index, value in haystack
	{
		if (value = needle)
			return index
	}
	return 0
}
;\____ HasVal __ 181116205406 __ 16.11.2018 20:54:06 __/

