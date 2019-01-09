#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#SingleInstance,force



#Persistent
DllCall("AllocConsole")
conout := FileOpen("CONOUT$", 1|4)



GUID := "{9359E8E4-3E3C-427F-81D8-5E1314B39E73}"
obj := {Test:Func("Test"), Status:1}



; REFCOUNT == 1
ObjAddRef(&obj)
conout.WriteLine("RefCount: " . ObjRelease(&obj)), conout.Read(0)



ObjRegisterActive(obj, GUID) ; register the object



; REFCOUNT == 3 ??
ObjAddRef(&obj)
conout.WriteLine("RefCount: " . ObjRelease(&obj)), conout.Read(0)



code := Format("
(
obj := ComObjActive({1}{2}{1})
obj.Status := 0
obj.Test()
return
)", Chr(34), GUID)



cmd := Format("{1}{2}{1} *", Chr(34), A_AhkPath)
exec := ComObjCreate("WScript.Shell").Exec(cmd)
exec.StdIn.Write(code), exec.StdIn.Close()
while obj.Status && (exec.Status == 0)
	Sleep 10



; REFCOUNT == 6 ??
ObjAddRef(&obj)
conout.WriteLine("RefCount: " . ObjRelease(&obj)), conout.Read(0)



ObjRegisterActive(obj, "") ; revoke



conout.Write("`nPress 'Enter' to quit.`n>>> "), conout.Read(0)
KeyWait Enter, D
DllCall("FreeConsole")
ExitApp



Test(this){
lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"lin1 at Test")
	ObjAddRef(&this)
	FileOpen("CONOUT$", 1|4).WriteLine(A_ThisFunc . "->RefCount: " . ObjRelease(&this))
}



; Func to allow RPC from remote scripts
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



#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk



#Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
