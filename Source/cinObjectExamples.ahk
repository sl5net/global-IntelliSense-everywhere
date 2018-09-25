; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#SingleInstance,force


obj := Object()

; The following two lines are equivalent:
ptr1 := Object(obj)
ptr2 := ObjectToPointer(obj)

ObjectToPointer(obj) {
    if !IsObject(obj)
        return ""
    ptr := &obj
    ObjAddRef(ptr)
    return ptr
}

; Each pointer retrieved via Object() or ObjectToPointer() must be manually released
; to allow the object to be eventually freed and any memory used by it reclaimed.
ObjRelease(ptr2)
ObjRelease(ptr1)
; Func to allow RPC from remote scripts
ObjRegisterActive(Object, CLSID, Flags:=0) { ; stores a reference to the object as a key in its cookieJar.
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



#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk

#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
