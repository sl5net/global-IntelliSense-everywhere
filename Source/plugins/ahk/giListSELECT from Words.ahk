bodyText =
(
Search Table Words saved in DB. SQL command is simply taken from the WindowTitle (needet token: giListSELECT )
ESC closes the window
)
Gui, Add, Text, x10 y1 h40, % bodyText
Gui, Add, Edit, yp+40 wp vSearch, 
; Gui, Add, Button, yp+30 w77 h26 gAdd2Reg, &set this list permanent
; Gui, Add, Button, xp+85 wp hp gfSearch, &Forum Search
; Gui, Add, Button, xp+85 wp hp ggSearch, &Google It!
; Gui, Show, AutoSize Center, % substr(A_ScriptName , 1, -4)
newTitle := "giListSELECT distinct ltrim(word), ltrim(worddescription), ltrim(wordreplacement) from Words WHERE word LIKE 'g_Word'  ESCAPE '~' LIMIT 10"
Gui, Show, w900 Center, % newTitle
WinSetTitle,% A_ScriptName ,% newTitle
; Send,{tab} ; focus first button
return

Add2Reg:
Gui, Submit
actionListNewTemp_withoutExt := SubStr( Search ,1 , -4 )
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, actionList, % actionListNewTemp_withoutExt 
MsgBox,% Search
return


GuiClose:
Gui, Destroy
return

SetTitleMatchMode,2
#IfWinActive, giListSELECT
esc::
Gui, Destroy
exitapp
return
; enter:: ; deprecated
     ; Send,!f
; return
