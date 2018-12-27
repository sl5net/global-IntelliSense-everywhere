

;/¯¯¯¯ setRegistry_ActionList ¯¯ 181121115201 ¯¯ 21.11.2018 11:52:01 ¯¯\
setRegistry_ActionList( ActionListNewTemp_withoutExt ){   ; RegWrite , RegSave , Registry

    if(InStr(ActionListNewTemp_withoutExt,"._Generated.ahk._Generated")){
         msg := "Oops. found : ._Generated.ahk._Generated.ahk => ._Generated.ahk `n`n" ActionListNewTemp_withoutExt
         ToolTip5sec(msg "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" , 1,1 )

        ActionListNewTemp_withoutExt := StrReplace(ActionListNewTemp_withoutExt, ".ahk._Generated.ahk._Generated", ".ahk._Generated") ; clean strange wordlists 25.10.2018 20:03
    }

    if( SubStr( ActionListNewTemp_withoutExt , -3 ) == ".ahk" )
        ActionListNewTemp_withoutExt := SubStr( ActionListNewTemp_withoutExt, 1, -4 )

    ; toolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    ; tool

    if(!ActionList){
        if(1 && InStr(A_ComputerName,"SL5"))
            ToolTip9sec( "UPS !ActionList`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
        return false
    }

	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionList, % ActionListNewTemp_withoutExt  ; RegWrite , RegSave , Registry

	; millis_since_midnight := JEE_millis_since_midnight(vOpt:="") ; <=== more correct then  := A_Hour*3600000+A_Min*60000+A_Sec*1000+A_MSec
	millis_since_midnight := A_TickCount
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, updatedTimeStamp_millisSinceMidnight, % millis_since_midnight  ; RegWrite , RegSave , Registry

    ; follwing we may dont need:
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListActive, % ActionListNewTemp_withoutExt ; RegWrite , RegSave , Registry
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListNEW, % ActionListNewTemp_withoutExt ; RegWrite , RegSave , Registry

    if(1 && InStr(A_ComputerName,"SL5")){
        y := 1
		MouseGetPos,x,y
		if(y<100)
		    y := 150
       (ActionListNewTemp_withoutExt "`n`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),1, y )
        }
    return ActionListNewTemp_withoutExt
}
;\____ setRegistry_ActionList __ 181121115205 __ 21.11.2018 11:52:05 __/



; its called from:
; Ctrl+Shift+F5
; Ctrl+Shift+ESC
setRegistry_toDefault(){
    globalActionListDir := "..\ActionLists"
    ; globalActionList := globalActionListDir "\_globalActionListsGenerated\_global.ahk"
    globalActionList := globalActionListDir   "\_globalActionListsGenerated\isNotAProject.ahk"

    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListDir, %globalActionListDir% ; RegWrite , RegSave , Registry
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListActive, %globalActionList% ; RegWrite , RegSave , Registry
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListNEW, %globalActionList% ; RegWrite , RegSave , Registry
    setRegistry_ActionList( globalActionList )
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, toDo, A_ScriptName " " A_LineNumber ": "  . " to many. 2 or 3 enough"  ; RegWrite , RegSave , Registry
}

