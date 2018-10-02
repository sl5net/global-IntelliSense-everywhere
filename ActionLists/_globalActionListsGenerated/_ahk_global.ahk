
chat:|r|https://autohotkey.com/boards/viewtopic.php?f=5&t=59
Server IRQ: chat.freenode.net
Port IRQ: 6667 (6697 for SSL)
Channel IRQ: #ahk



Msgbox lineFileName|rr|Msgbox,(%A_LineFile%~%A_LineNumber%)|ahk|Send,{shift down}{left 33}{shift up}
ToolTip2sec lineFileName|rr|ToolTip2sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip2sec lineFileName|rr|ToolTip2sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip4sec lineFileName|rr|ToolTip4sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip5sec lineFileName|rr|ToolTip5sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}

Msgbox|rr|Msgbox,(%A_LineFile%~%A_LineNumber%)|ahk|Send,{shift down}{left 33}{shift up}
ToolTip2sec|rr|ToolTip2sec(A_LineNumber " " A_LineFile " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip2sec|rr|ToolTip2sec(A_LineNumber " " A_LineFile " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip4sec|rr|ToolTip4sec(A_LineNumber " " A_LineFile " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTip5sec|rr|ToolTip5sec(A_LineNumber " " A_LineFile " " Last_A_This)|ahk|Send,{CtrlDown}{left 8}{CtrlUp}
ToolTipSec(t,x=123,y=321,sec=1000)
Tooltip, `n (from: %A_LineFile%~%A_LineNumber%)

lineFileName := RegExReplace(A_LineFile,".*\\")


ToolTipSec(t,x=123,y=321,sec=1000)
Tooltip, `n (from: %A_LineFile%~%A_LineNumber%)

tool

runIfNotExist|rr||ahk|s=runIfNotExist(m_r , m_WinTitle = "",m_category="", doFeedbackMsgBox:=258)`nSend,%s%

regEx remove some lines in ActionList|r|^((?!(ToolTipSec|init_global|functions_global_dateiende|move2Img_functions|functions_global|copy2clipBoard.functions)).)*$

regEx find AHK functios definitions|r|^[ ]*?\w[\w\d_]{5,}\s*\([^()+<>]+\)[\s\S]{0,5}?\{

    EnvAdd, lcs, 1 
FileGetTime, sourceModifiedTime, %f%  ; Retrieves the modification time by default. 
FileReadLine, line, %f%, %A_Index% 
SoundBeep,n ,200 ; high beep 
while(!clipboard && loopCounter < 100) 
copyLineOrWord2clipBoard(doSelectLine) 
isInteger(var) 
changeAllIncludeDir_and_copy2dir(used_ahk,preFix,copy2dir) 
changeAllIncludeDir(f,preFix) 
rundIfNotExist(m_r , m_WinTitle = "",m_category="") 
winGetPos() 
WinActivateTry(wintit,tries) 
runCopyQ_Ctrl_Shift_v() 
file_put_contents(f, c, doOverwrite=1) 
sendStrgC(trycount = 10) 
ternaryOperator( bool , t = true, f = false) 
get_obj_ToString(obj) 
clipboardPaste(s) 
FuzzySearch(string1, string2) 
StringDifference(string1, string2, maxOffset=1) 
stringLower(s) 
isUrlAvailable(URL) 
lll(ln, sn, text="") 
file_put_contents(f, c, overwrite=true) 
SendStrgC(trycount) 
preParser(AScriptDir, AScriptName, AScriptFullPath) 
bToolTip(s) 
bMsgBox(s) 
bStringProzentNotation(s) 
bStringPunktNotation(s) 
move2ImgORImg(i, i2 , textInfo, mm, variation := 85)
move2Img(i , textInfo, mm, variation := 85) 
clickImg(i, textInfo, mm, offset = 20, variation := 85) 
setChromeDefaultZoom(kundencenter_Googl, errorLogMetho="") 
deselectAllSelectedHtmlFiles(mm) 
downloadAllHtmlFiles_OLD(htmlPNG, tmplPNG,downloadPNG, AktuellesVerzeichnisPNG, symLinksPNGbottom, dirLocal, xM1) 
getAktuellesVerzeichnis(AktuellesVerzeichnisPNG) 
isDirEmpty(Dir) 
downloadSelected( downloadPNG, AktuellesVerzeichnisPNG, dirLocal ) 
clickDownload(downloadPNG,mm,AktuellesVerzeichnisPNG) 
scrollToTop(AktuellesVerzeichnisPNG) 
getNextNotSelectedDirName(openFoderPNG, mm, variation := 85) 
getNextNotSelectedAbsDir_localNotExist( openFoderPNG, mm, dirLocal ) 
clickOpenFolder(xM1, yM1) 
winWaitCorrectWindow() 
downloadAllHtmlFiles( htmlPNG, tmplPNG,  downloadPNG,  symLinksPNGbottom, AktuellesVerzeichnisPNG, dirLocal, xM0, yM0 ) 
downloadEachVisibleHtmlFile( htmlPNG, tmplPNG,  downloadPNG, AktuellesVerzeichnisPNG,  dirLocal, xM0, yM0 ) 
pageDown() 
getHtmlFileNameFromScreen(htmlPNG, tmplPNG, xM0, yOffset) 
getMultiMonitor() 
mouseMove( p, speed = 0 ) 
MouseMoveRectrangle(mm) 
MsgBoxMM(mm) 
RemoveToolTip()
move2ImgORImg(i, i2 , textInfo, mm) 
move2Img(i , textInfo, mm) 
clickImg(i, textInfo, mm, offset = 20) 
