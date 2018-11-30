; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
DynaRun(TempScript, pipename=""){ ; dynAhk, dynaAhk, AhkDyn, DynRun 01.03.2018 16:54
   TempScript := "#" . "ErrorStdOut`n" . TempScript
static _:="uint",@:="Ptr"
   If pipename =
      name := "AHK" A_TickCount
   Else
      name := pipename
try{
   __PIPE_GA_ := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
   __PIPE_    := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
} catch e{
;throw Exception("Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line, -1)
tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
tooltip, % tip
}
   if (__PIPE_=-1 or __PIPE_GA_=-1)
      Return 0
   ;gosub,couldIfindMyself
;IfNotExist, %A_AhkPath% "\\.\pipe\%name%"
;   Return 0
    try{
          fileAdress = %A_AhkPath% "\\.\pipe\%name%"
            if(0)
            while(!FileExist(fileAdress)){
                Sleep,100
                if(A_Index > 10)
                    return 0
            }
            Run, %fileAdress%,,UseErrorLevel HIDE, PID
   } catch e{
      ;throw Exception("Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line, -1)
      tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
      tooltip, % tip
     TempScript .= "`n#" "Include " A_ScriptDir "\inc_ahk\functions_global.inc.ahk"
     FileAppend, `% TempScript, `% name
   }

   If ErrorLevel
   {
      tooltip, % "Could not open file:`n" __AHK_EXE_ """\\.\pipe\" name """"
      return false
   }
; to to too1 1 too to too to to ttt t
   try{
      DllCall("ConnectNamedPipe",@,__PIPE_GA_,@,0)
      DllCall("CloseHandle",@,__PIPE_GA_)
      DllCall("ConnectNamedPipe",@,__PIPE_,@,0)
      script := (A_IsUnicode ? chr(0xfeff) : (chr(239) . chr(187) . chr(191))) TempScript
      if !DllCall("WriteFile",@,__PIPE_,"str",script,_,(StrLen(script)+1)*(A_IsUnicode ? 2 : 1),_ "*",0,@,0)
           Return A_LastError,DllCall("CloseHandle",@,__PIPE_)
      DllCall("CloseHandle",@,__PIPE_)
   } catch e{
      ;throw Exception("Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line, -1)
      tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
      tooltip, % tip
   }
if(1 && WinExist(substr(name,1,-5))) ; helps debugging
   FileAppend, `% TempScript, `% name

while(1 && name && WinExist(substr(name,1,-5)) && A_Index < 9)
   WinClose,

Return PID
}


