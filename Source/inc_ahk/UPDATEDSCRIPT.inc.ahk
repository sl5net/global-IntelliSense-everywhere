; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
;STARTOFSCRIPT
;~ 



UPDATEDSCRIPT:
  FileGetAttrib,attribs,%A_ScriptFullPath%
  IfInString,attribs,A
  {
    FileSetAttrib,-A,%A_ScriptFullPath%
    SplashTextOn,,,Updated script,
    Sleep,500
    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, Reload , % A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
    Reload      ; Script wird neu geladen,neu ausgefÃ¶hrt
  }
Return