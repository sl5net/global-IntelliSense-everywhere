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
    Reload      ; Script wird neu geladen,neu ausgefÃ¶hrt
  }
Return