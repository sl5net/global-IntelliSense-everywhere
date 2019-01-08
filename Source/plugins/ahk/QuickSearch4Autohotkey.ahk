toEncode :=	[" ","%", """", "#", "&"
 , "/", ":", ";", "<"
 , "=", ">", "?", "@"
 , "[", "\", "]", "^"
 , "``", "{", "|", "}", "~"]

e :=	["+","%25", "%22", "%23", "%26"
 , "%2F", "%3A", "%3B", "%3C"
 , "%3D", "%3E", "%3F", "%40"
 , "%5B", "%5C", "%5D", "%5E"
 , "%60", "%7B", "%7C", "%7D", "%7E"]



Gui, Add, Text, x10 y10 h20, Search Autohotkey's site documentation, or search from Google:
Gui, Add, Edit, yp+20 wp vSearch,%Clipboard%
Gui, Add, Button, yp+30 w77 h26 gStrgV, &v paste it
Gui, Add, Button, xp+85 wp hp gfSearch, &Forum Search
Gui, Add, Button, xp+85 wp hp ggSearch, &Google It!
Gui, Show, AutoSize Center, Quick Search for Autohotkey
Send,{tab} ; focus first button
return

StrgV:
Gui, Destroy
Send,^v
ExitApp
return

fSearch:
gSearch:
Gui, Submit
Gui, Destroy
For i, u in toEncode		; check/replace loop for unsafe chars
	StringReplace, Search, Search, %	u, %	e[i], All
if	(A_ThisLabel="fSearch")		; if the forum search was selected
	Run, https://www.autohotkey.com/boards/search.php?keywords=%Search%		; use the forum search
else	Run, http://www.google.com/search?q=%Search%+site:autohotkey.com		; else use Google search
	ExitApp

GuiClose:
Gui, Destroy
ExitApp


esc::
     exitapp
return
; enter:: ; deprecated
     ; Send,!f
; return
