



;/¯¯¯¯ setRegistry_actionList ¯¯ 181121115201 ¯¯ 21.11.2018 11:52:01 ¯¯\
setRegistry_actionList( actionListNewTemp_withoutExt ){   ; RegWrite , RegSave , Registry



    if(InStr(actionListNewTemp_withoutExt,"._Generated.ahk._Generated")){
         msg := "Oops. found : ._Generated.ahk._Generated.ahk => ._Generated.ahk `n`n" actionListNewTemp_withoutExt
         ToolTip5sec(msg "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" , 1,1 )



        actionListNewTemp_withoutExt := StrReplace(actionListNewTemp_withoutExt, ".ahk._Generated.ahk._Generated", ".ahk._Generated") ; clean strange wordlists 25.10.2018 20:03
    }



    if( SubStr( actionListNewTemp_withoutExt , -3 ) == ".ahk" )
        actionListNewTemp_withoutExt := SubStr( actionListNewTemp_withoutExt, 1, -4 )



    ; toolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    ; msggb



    if(!actionListNewTemp_withoutExt){
        if(1 && InStr(A_ComputerName,"SL5"))
            ToolTip9sec( "UPS !actionList`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
        return false
    }



    ; fallback if somebody gives addresses like ..\....\G:\\... then take the second absolut path 18-12-29_21-13
    actionListNewTemp_withoutExt := regexreplace(actionListNewTemp_withoutExt , "i).*(\b[a-z]\:\\)", "$1" )



	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, % actionListNewTemp_withoutExt  ; RegWrite , RegSave , Registry



	; millis_since_midnight := JEE_millis_since_midnight(vOpt:="") ; <=== more correct then  := A_Hour*3600000+A_Min*60000+A_Sec*1000+A_MSec
	millis_since_midnight := A_TickCount
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, updatedTimeStamp_millisSinceMidnight, % millis_since_midnight  ; RegWrite , RegSave , Registry



    ; follwing we may dont need:
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionListActive, % actionListNewTemp_withoutExt ; RegWrite , RegSave , Registry
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionListNEW, % actionListNewTemp_withoutExt ; RegWrite , RegSave , Registry



    if(1 && InStr(A_ComputerName,"SL5")){
        y := 1
		MouseGetPos,x,y
		if(y<100)
		    y := 150
       (actionListNewTemp_withoutExt "`n`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1, y )
        }
    return actionListNewTemp_withoutExt
}
;\____ setRegistry_actionList __ 181121115205 __ 21.11.2018 11:52:05 __/



; its called from:
; Ctrl+Shift+F5
; Ctrl+Shift+ESC
setRegistry_toDefault(){
    globalActionListDir := "..\actionLists"
    ; globalActionList := globalActionListDir "\_globalActionListsGenerated\_global.ahk"
    globalActionList := globalActionListDir   "\_globalActionListsGenerated\isNotAProject.ahk"



    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionListDir, %globalActionListDir% ; RegWrite , RegSave , Registry
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionListActive, %globalActionList% ; RegWrite , RegSave , Registry
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionListNEW, %globalActionList% ; RegWrite , RegSave , Registry
    setRegistry_actionList( globalActionList )
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, toDo, A_ScriptName " " A_LineNumber ": "  . " to many. 2 or 3 enough"  ; RegWrite , RegSave , Registry
}



