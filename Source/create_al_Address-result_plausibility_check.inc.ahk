

errorMsg := ""
;/¯¯¯¯ al_result_plausibility_check ¯¯ 190219210216 ¯¯ 19.02.2019 21:02:16 ¯¯\
	;al_result_plausibility_check(actionListNEW){
    ; plausibility check of result
    ; actionListReg
    RegRead, actionListReg, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
    if(!actionListNEW){
        errorMsg :=  actionListNEW ": ups !actionListNEW `n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    }
    else if(substr(rtrim(actionListNEW),-4) == "\.ahk")
        errorMsg :=  actionListNEW "`n`n ups actionListNEW `n `n is \.ahk?`n`n" thisLine "=thisLine`n`n " actionListNEW "`n=actionListNEW`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

    else if(substr(actionListReg,-0) == "\"){
        errorMsg :=  actionListReg "`n ups actionListReg `n is folder?`n = `n`n" "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    }

    else if(actionListReg == ".ahk" || substr(actionListReg,-4)  == "\.ahk" ){
        errorMsg :=  actionListReg "`n`n ups actionListReg `n `n is \.ahk?`n`n" thisLine "=thisLine`n`n " actionListNEW "`n=actionListNEW`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

        RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList, % "" ;  , ValueName, Value
        sleep,5000
        return ; we are not inside a functon
        ; reload ; <===================== quck and dirtey. todo: happen with googlecalender in chrome, with telegam desptop app 19-03-15_22-45
        ; ToolTooltip, `n (from: %A_LineFile%~%A_LineNumber%)
   }

;\____ al_result_plausibility_check __ 190219210219 __ 19.02.2019 21:02:19 __/r

if(errorMsg){
    run,tools\DebugVars\DebugVars.ahk
    msgbox, % errorMsg " `n`n(" RegExReplace(A_LineFile,".*\\") ":" A_LineNumber

errorsLog =
(
activeTitle = Anki - User 1...
activeTitle_short = Anki - User 1...
alTitle = Anki_User_1
actionListNEW = Anki_User_1
actionListReg = ..\actionLists\Qt5QWindowIcon\.ahk
)

}

;  tip, `n (from: %A_LineFile%~%A_LineNumber%) settitle setTitleMatchMode