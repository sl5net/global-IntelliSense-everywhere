; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
; __
g_ignReg["saveLogFiles"]["scriptName"] := "." ; ps no log in this script 28.02.2018 16:41

Loop,log\*.txt ; ;FileRemoveDir,log,1
    FileDelete,% A_LoopFileLongPath

; too too too

lll( A_ThisFunc ":" A_LineNumber , A_LineFile ," hi :) just started. ")
;MsgBox,% RegExReplace(A_LineFile,".*\\") . "`n hi :) just started. "
;feedbackMsgBox("hi :) just started. ", A_LineNumber . " , " . A_ScriptName,1,1)
; MsgBox,% RegExReplace(A_LineFile,".*\\") . "`n hi :) ??? feedbackMsgBox visible ???? "


actionList := "..\actionLists\_globalActionLists\_global.ahk"
actionList := "..\actionLists\_globalActionListsGenerated\_ahk_global.ahk"
actionList := "E:\fre\private\HtmlDevelop\AutoHotKey\tools\gi-everywhere-master\Source\..\actionLists\_globalActionListsGenerated\_ahk_global.ahk"

pLength := 0
while(pLength <> StrLen(actionList )){
; tooltip,`% A_index . "# Line:" . A_LineNumber . " Name:" . A_ScriptName . " "
pLength := StrLen(actionList )
actionList := RegExReplace(actionList ,"(\\[^\\]+\\\.\.)+") ; works. removes all symbolic links 24.02.2018  cleanPath
}
actionList := RegExReplace(actionList,"\\\.\\")  ; works. removes all symbolic link 24.02.2018 cleanPath
actionList := RegExReplace(actionList,"^\.\\")  ; works. removes all symbolic link 24.02.2018  cleanPath

setRegistry_actionList(actionList)
#Include,RegWrite181031.ahk
ExitApp 

stringToSend := actionList

try{
    ; feedbackMsgBox("%A_LineFile%>%A_LineNumber%", "ComObjActive" . " " . A_ScriptName . "~" . A_LineNumber)
    y := ComObjActive("{93C04B39-0465-4460-8CA0-7BFFF481FF98}")
    feedbackMsgBox(A_ScriptName . ">" . A_LineNumber, "START y.callFunction( Receive_actionListAddress, " . stringToSend )
    y.callFunction( "Receive_actionListAddress", stringToSend ) ;will call the function of the other script , ObjRegisterActive , shuttle
    feedbackMsgBox(A_ScriptName . ">" . A_LineNumber, "END y.callFunction( Receive_actionListAddress, " . stringToSend )

} catch e{
    tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
    lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
    tooltip, % tip
    feedbackMsgBox(A_ScriptName . ">" . A_LineNumber, tip )
    Clipboard := tip
}

feedbackMsgBox("hi :) ExitApp now. ", A_LineNumber . " , " . A_ScriptName,1,1)
ExitApp

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


#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk 
