; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
;~ subroutinen mï¿½ssen ans ende sonst blocken die
;~ #Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


msg:=""
ToolTip,%msg%
ToolTip1sec%blank%(msg)


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
CHEC10minutes:

vTimeHour := Substr(A_Now,9,2) ; Start at 9th character, and get the next 2 depicting the hour
vTimeMinutes := Substr(A_Now,11,2) ; Start at 11th character and get the next 2 depicting the minutes
vYearVal := SubStr(A_Now, 1,4) ; Start at first character and get teh next 4 for the year
vMonthVal := SubStr(A_Now,5,2) ; Start at the 5th character and get the next 2 characters for the month
vDayVal := SubStr(A_Now,7,2) ; Start at the 7th character and get the next 2 for the day
;vClipout := vMonthVal . "/" . vDayVal . "/" . vYearVal . " " . vTimeHour . ":" . vTimeMinutes . "`n`n============================`n`n" ; Add end newline here.
;vClipout := "Clipboard Contents @ " . vClipout . clipboard

;MsgBox, %vClipout%

;~ A_Now The current local time in YYYYMMDDHH24MISS format. Note: Date and time math can be performed with EnvAdd and EnvSub. Also, FormatTime can format the date and/or time according to your locale or preferences. 

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ php overwriting
;~ if(vTimeHour = 7 AND vTimeMinutes = 10)
{
  ; A_WDay Current 1-digit day of the week (1-7). 1 is Sunday in all locales. 
  ; mod(5.0, 3) is 2.0
  ;~ if(mod(A_WDay, 2) > 1 )
    ;~ run, https://www.youtube.com/watch?v=5tcIUn6nbVE

  ;~ run, http://www.youtube.com/watch?v=JxyhAxN9bnk
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;~ A_Now The current local time in YYYYMMDDHH24MISS format. Note: Date and time math can be performed with EnvAdd and EnvSub. Also, FormatTime can format the date and/or time according to your locale or preferences. 
if(vTimeHour = 10 AND vTimeMinutes = 10){
lll(A_LineNumber, A_LineFile, "lin1 at if")
  ; A_WDay Current 1-digit day of the week (1-7). 1 is Sunday in all locales. 
  ; mod(5.0, 3) is 2.0
  if(false and mod(A_WDay, 2) = 1 )
  {}
  
}

return




;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;~ subroutinen mï¿½ssen ans ende sonst blocken die
;~ #Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
ModiTime_pilawa_OLD:=0
UPDATEDSCRIPTpilawa:
  ScriptName :="pilawa-sl5-de.inc.ahk"
  ScriptFullPath:= A_ScriptDir . "/" . ScriptName
  ;FileGetAttrib,attribs,%ScriptFullPath%
  FileGetTime, ModiTime_pilawa, %ScriptFullPath%, M
  if(ModiTime_pilawa_OLD > 0 AND ModiTime_pilawa > ModiTime_pilawa_OLD)
  ;IfInString,attribs,A
  {
    preParser(A_ScriptDir, ScriptName, ScriptFullPath)
    Sleep,500            

    FileSetAttrib,-A,%ScriptFullPath%
    SplashTextOn,,,Updated pilawa-sl5-de,
    Sleep,500
    SplashTextOff,Updated pilawa-sl5-de
    Reload      ; Script wird neu geladen,neu ausgefï¿½hrt
  }
  ModiTime_pilawa_OLD:=ModiTime_pilawa
  ;Last_A_This:=A_ThisFunc . A_ThisLabel 
  ;ToolTip1sec(A_LineNumber . " " .  A_LineFile . " " . Last_A_This)
  ; sicherheitshallber mach ich das noch in den update script timer
Return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;~ testsdlfd n15-05-09_13-12

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
ModiTime_functions_global_OLD:=0
UPDATEDSCRIPTfunctions_global:
  ScriptName :="functions_global.inc.ahk" 
  ScriptFullPath:= A_ScriptDir . "/" . ScriptName
  FileGetAttrib,attribs,%ScriptFullPath%
  FileGetTime, ModiTime_functions_global, %ScriptFullPath%, M
  if(ModiTime_functions_global_OLD > 0 AND ModiTime_functions_global > ModiTime_functions_global_OLD)
  {    
    preParser(A_ScriptDir, ScriptName, ScriptFullPath)
    Sleep,500           
    FileSetAttrib,-A,%ScriptFullPath%
    SplashTextOn,,,Updated functions_global,
    Sleep,500
    SplashTextOff,Updated functions_global
    Reload      ; Script wird neu geladen,neu ausgefï¿½hrt
  }
  ModiTime_functions_global_OLD := ModiTime_functions_global
Return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
ModiTime_functions_global_dateiende_OLD:=0
UPDATEDSCRIPTfunctions_global_dateiende:
  ScriptName :="functions_global_dateiende.inc.ahk" 
  ScriptFullPath:= A_ScriptDir . "/" . ScriptName
  FileGetAttrib,attribs,%ScriptFullPath%
  ;IfExist,%ScriptFullPath%
    ;MsgBox,exist: ScriptFullPath = %ScriptFullPath%
  FileGetTime, ModiTime_functions_global_dateiende, %ScriptFullPath%, M
  ;IfInString,attribs,A
  if(ModiTime_functions_global_dateiende_OLD > 0 AND ModiTime_functions_global_dateiende > ModiTime_functions_global_dateiende_OLD)
  {
    
    preParser(A_ScriptDir, ScriptName, ScriptFullPath)
    Sleep,500           

    FileSetAttrib,-A,%ScriptFullPath%
    SplashTextOn,,,Updated functions_global_dateiende,
    Sleep,500
    SplashTextOff,Updated functions_global_dateiende
    Reload      ; Script wird neu geladen,neu ausgefï¿½hrt
  }
  ModiTime_functions_global_dateiende_OLD := ModiTime_functions_global_dateiende

;Last_A_This:=A_ThisFunc . A_ThisLabel 
  ;ToolTip1sec(A_LineNumber . " " .  A_LineFile . " " . Last_A_This)
  ; sicherheitshallber mach ich das noch in den update script timer
Return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
preParser(AScriptDir, AScriptName, AScriptFullPath)
{
  return,"actually not needet" ; deprevated
  ;MsgBox,preParser(%AScriptFullPath%)
  FileContent := ""            
  isPreparsedChanged := false
  temFile = %AScriptDir%/11-08-16_19-24%AScriptName%.temp
  FileDelete,%temFile%            
  Loop,9
  {
    if( FileExist ( temFile))
      Sleep,70            
    else
      break
  }
  
  Loop            
  {            
      FileReadLine, line, %AScriptFullPath%, %A_Index%            
      if ErrorLevel            
          break            
      if( instr( line, "bToolTip(" ) )            
      {            
        d := RegExReplace(line, ".*bToolTip\(""([^""]+)""\).*", "$1")        
        if( StrLen(d) < 2 OR instr( d, """" ) OR  instr( d, "(" )  OR  instr( d, ")" )  )            
        {            
          ;~ ToolTip, d = %d%             
          ;~ Sleep,1500          
        }            
        else            
        {            
          ;~ ToolTip, JAAAAA :) !! d = %d%             
          ;~ Sleep,3500          
          isPreparsedChanged := true          
          StringReplace, lineOld2, line, bToolTip(, bToolTip#( , All            
          lineOld2 := "; " . lineOld2              
          ;~ line := bToolTip(d) . "`n `; " . lineOld2 . " `; d = " . d            
          line := bToolTip(d) . "`n `; " . lineOld2 
          blank:= " "
          ToolTip3sec%blank%(line)   
        }       
      }else
      if( instr( line, "bMsgBox(" ) )            
      {            
        d := RegExReplace(line, ".*bMsgBox\(""([^""]+)""\).*", "$1")        
        if( StrLen(d) < 2 OR instr( d, """" ) OR  instr( d, "(" )  OR  instr( d, ")" )  )            
        {            
          ;~ ToolTip, d = %d%             
          ;~ Sleep,1500          
          
        }            
        else            
        {            
          ;~ ToolTip, JAAAAA :) !! d = %d%             
          ;~ Sleep,3500          
          isPreparsedChanged := true          
          StringReplace, lineOld2, line, bMsgBox(, bMsgBox#( , All            
          lineOld2 := "; " . lineOld2              
          ;~ line := bMsgBox(d) . "`n `; " . lineOld2 . " `; d = " . d            
          line := bMsgBox(d) . "`n `; " . lineOld2 
          ;~ ToolTip3sec(line)     
                    blank:= " "
          ToolTip3sec%blank%(line)     
        }       
      }            
      line:=RTrim(line)
      FileAppend, %line% `n ,%temFile%            
  }               
  if(isPreparsedChanged == true )
    FileCopy, %temFile%, %AScriptFullPath%,1            
  return
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 
bToolTip(s)            
{            
  ; creates something like:
  ; ToolTip3sec(" . " hallo = " . hallo   . " du = " . du  ") 
  
  
  ; Achtung hier keinen rekursiven aufruf!!!     
  return bStringPunktNotation(s)            
       
  ;s := "ToolTip, " . RegExReplace(s, "(\w+)", " $1 = %$1% ")  ; Returns "aaaXYZzzz" by means of the $1 backreference.            
  ;s := RegExReplace(s, "(\w+)", " $1 = %$1% ")  ; Returns "aaaXYZzzz" by means of the $1 backreference.            
  StringReplace,s,s,`,, %A_SPACE% , All

  s1 := RegExReplace(s, "(\w+)", " . "" $1 = "" . $1 ")  ; Returns "aaaXYZzzz" by means of the $1 backreference.            
  s2 := RegExReplace(s, "(\w+)", " $1 = %$1% ")  ; Returns "aaaXYZzzz" by means of the $1 backreference.            

  temp1:= " fromline . ""ï¿½"" . A_LineNumber . "":``n"" . " . SubStr(s1 , 4, StrLen(s1) - 4)  
  temp1 := "temp := " . temp1
  
  temp2:= " %fromline% ï¿½ %A_LineNumber%:``n " . SubStr(s2 , 4, StrLen(s2) - 4)  
  temp2 := "temp = " . temp2
  
  temp := temp1  
  temp := temp2  
  
  s := temp . "`nif(isDevellopperMode:= true)`n ToolTip3sec(temp) `; MsgBox,%temp% "
  ;s := "ToolTip3sec(" . temp . " )"      
  ;MsgBox,%s%      
  ;exit      
   ; ToolTip3sec(" . " hallo = " . hallo   . " du = " . du  ")         
  return s            
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 
bMsgBox(s)            
{            
  ; Achtung hier keinen rekursiven aufruf!!!     
  return bStringProzentNotation(s)            
}
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 
bStringProzentNotation(s)            
{            
  ; Achtung hier keinen rekursiven aufruf!!!     
  StringReplace,s,s,`,, %A_SPACE% , All
  ;s2 := RegExReplace(s, "(\w+)", " $1 = %$1% ")  ; Returns "aaaXYZzzz" by means of the $1 backreference.            
  s2 := RegExReplace(s, "(\w+)", " $1 = %$1% ``n ")  ; Returns "aaaXYZzzz" by means of the $1 backreference.            
  temp2:= " %fromline% ï¿½ %A_LineNumber%: ``n``n " . s2 ; . SubStr(s2 , 4, StrLen(s2) - 4)  
  temp2 := "temp = " . temp2
  temp := temp2  
  s := temp . "`nif(isDevellopperMode:= true)`nMsgBox,%temp% `; ToolTip3sec(temp) "
  return s            
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 
bStringPunktNotation(s)            
{            
  ; Achtung hier keinen rekursiven aufruf!!!     
  StringReplace,s,s,`,, %A_SPACE% , All
  s1 := RegExReplace(s, "(\w+)", " . "" $1 = "" . $1 ")  ; Returns "aaaXYZzzz" by means of the $1 backreference.            
  temp1:= " fromline . ""ï¿½"" . A_LineNumber . "": "" . " . SubStr(s1 , 4, StrLen(s1) - 4)  
  temp1 := "temp := " . temp1
  temp := temp1  
  s := temp . "`nToolTip3sec(temp) `; MsgBox,%temp% "      
  return s            
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk ; this is nearly everywwhere insiede

#Include *i %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk