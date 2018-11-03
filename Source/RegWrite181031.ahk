setRegistry_ActionList( ActionListNewTemp_withoutExt ){   ; RegWrite , RegSave , Registry

    if( SubStr( ActionListNewTemp_withoutExt , -3 ) == ".ahk" )
        ActionListNewTemp_withoutExt := SubStr( ActionListNewTemp_withoutExt, 1, -4 )

	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionList, % ActionListNewTemp_withoutExt  ; RegWrite , RegSave , Registry

	; millis_since_midnight := JEE_millis_since_midnight(vOpt:="") ; <=== more correct then  := A_Hour*3600000+A_Min*60000+A_Sec*1000+A_MSec
	millis_since_midnight := A_TickCount
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, updatedTimeStamp_millisSinceMidnight, % millis_since_midnight  ; RegWrite , RegSave , Registry

    ; follwing we may dont need:
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListActive, % ActionListNewTemp_withoutExt ; RegWrite , RegSave , Registry
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, ActionListNEW, % ActionListNewTemp_withoutExt ; RegWrite , RegSave , Registry

    if(1 && InStr(A_ComputerName,"SL5"))
        ToolTip8sec(ActionListNewTemp_withoutExt "`n" A_LineNumber " " RegExReplace(A_LineFile,".*\\") )
    return ActionListNewTemp_withoutExt
}




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

