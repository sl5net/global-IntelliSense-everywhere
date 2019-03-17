; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
;~ subroutinen mï¿½ssen ans ende sonst blocken die
;~ #Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

msg:=""
ToolTip,%msg%
ToolTip1sec%blank%(msg)

;/¯¯¯¯ preParser ¯¯ 190217162253 ¯¯ 17.02.2019 16:22:53 ¯¯\
preParser(AScriptDir, AScriptName, AScriptFullPath){
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
;\____ preParser __ 190217162304 __ 17.02.2019 16:23:04 __/


;/¯¯¯¯ bToolTip ¯¯ 190217162312 ¯¯ 17.02.2019 16:23:12 ¯¯\
bToolTip(s) {
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
;\____ bToolTip __ 190217162333 __ 17.02.2019 16:23:33 __/


;/¯¯¯¯ bMsgBox ¯¯ 190217162338 ¯¯ 17.02.2019 16:23:38 ¯¯\
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
bStringPunktNotation(s){
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

toolTipGui("(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,,"|_",A_LineNumber,"Purple")  ; x will be offset if y is symbolic
; #Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk ; this is nearly everywwhere insiede

toolTipGui("(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,,"|_",A_LineNumber,"Purple")  ; x will be offset if y is symbolic
#Include *i %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk