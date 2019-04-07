;/¯¯¯¯ SQLite_DLLPath ¯¯ 190404213413 ¯¯ 04.04.2019 21:34:13 ¯¯\
SQLite_DLLPath(forcedPath = "") {
   static DLLPath := ""
   static dllname := "SQLite3.dll"

   if(DLLPath == ""){
      ; search the dll
      prefix := (A_PtrSize == 8) ? "x64\" : ""
      dllpath := prefix . dllname

      if (FileExist(A_ScriptDir . "\" . dllpath))
         DLLPath := A_ScriptDir . "\"  . dllpath
      else
         DLLPath := A_ScriptDir . "\Lib\" . dllpath
   }

   if (forcedPath != "")
      DLLPath := forcedPath

   return DLLPath
}
;\____ SQLite_DLLPath __ 190404213416 __ 04.04.2019 21:34:16 __/