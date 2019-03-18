;/¯¯¯¯ UrlEncode ¯¯ 190121070409 ¯¯ 21.01.2019 07:04:09 ¯¯\
UrlEncode(Uri){
	; Uniform Resource Identifier
	; https://www.rosettacode.org/wiki/URL_decoding#AutoHotkey
	VarSetCapacity(Var, StrPut(Uri, "UTF-8"), 0)
	StrPut(Uri, &Var, "UTF-8")
	f := A_FormatInteger
	SetFormat, IntegerFast, H
	While Code := NumGet(Var, A_Index - 1, "UChar")
		If (Code >= 0x30 && Code <= 0x39 ; 0-9
			|| Code >= 0x41 && Code <= 0x5A ; A-Z
			|| Code >= 0x61 && Code <= 0x7A) ; a-z
			Res .= Chr(Code)
	Else
		Res .= "%" . SubStr(Code + 0x100, -1)
	SetFormat, IntegerFast, %f%
	Return, Res
}
;\____ UrlEncode __ 190121070415 __ 21.01.2019 07:04:15 __/


;/¯¯¯¯ UrlDecode ¯¯ 190121070309 ¯¯ 21.01.2019 07:03:09 ¯¯\
UrlDecode(encURL){
; from: https://www.rosettacode.org/wiki/URL_decoding#AutoHotkey
; encURL := "http%3A%2F%2Ffoo%20bar%2F"
	SetFormat, Integer, hex
	Loop Parse, encURL
		If A_LoopField = `%
			reading := 2, read := ""
	else if reading
	{
		read .= A_LoopField, --reading
		if not reading
			out .= Chr("0x" . read)
	}
	else out .= A_LoopField
		;tooltip % out ; http://foo bar/
	Return, out
}
;\____ UrlDecode __ 190121070314 __ 21.01.2019 07:03:14 __/


