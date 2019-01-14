g_config := {}
#Include %A_ScriptDir%\inc_ahk\minify\config.minify.inc.ahkSTATIC.ahk


;<<<<<<<< openInEditor <<<< 1810111507 <<<< 01.10.2018 11:54:07 <<<<
; called from 				was_a_Editor_open_command := openInEditor(actionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib) if(was_a_Editor_open_command) return ; endOf function: SendWord(WordIndex)

; tooltip tool ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
; ToolTip5sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )


;/¯¯¯¯ openInEditor ¯¯ 181028104913 ¯¯ 28.10.2018 10:49:13 ¯¯\
; isStartingUnderline deprecated 01.12.2018 19:20
; edit: Opens the indicated file for editing. It might not work if the indicated file's type does not have an "edit" action associated with it.
openInEditor(actionListFolderOfThisActionList
            , isAHKcode
            , AHKcode
            , isStartingUnderline
            , is_OpenA_edit_open_lib
            , isDeprecated_OpenA_edit_open_lib){
    if(!AHKcode){
        return false
        Clipboard := AHKcode
        Msgbox,% ":( ups is empty: " AHKcode "=AHKcode `n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        ExitApp, 
    }
    ; open ahk_global|rr||ahk|openInEditor,_ahk_global.ahk
    ;
    foundPos := RegExMatch( AHKcode , "i)^\s*(?:AHK-Studio|AutoGUI|openInEditor|edit)\s*,?\s*(.+\.ahk)\s*$\b$" ,  m )
    ; ifIsIt := (isStartingUnderline && is_OpenA_edit_open_lib && foundPos )
    ifIsIt := (is_OpenA_edit_open_lib && foundPos )
    if(!ifIsIt){
        m =
        (
        isStartingUnderline = %isStartingUnderline%
        is_OpenA_edit_open_lib = %is_OpenA_edit_open_lib%
        foundPos = %foundPos%
        )
        ; msgbox,% "return false `n" m "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
        return false
    }
    ; edit open script
    ; msgb tool ___ ___ ___
   ; ___global generated open|rr||ahk|run,..\_globalActionListsGenerated\_global.ahk
   ;

    ; if(InStr(text,"cannot be opened"))

    if( 0 && isAbsPath := RegExMatch( m1 , "i)^[a-z]:\\" ))
        msgbox,% "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    ;msgbox,% isAbsPath  "`n" m1 "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"


    m1CorrectedAhkFileAddress := actionListFolderOfThisActionList "\" m1
    ;Msgbox,% m1CorrectedAhkFileAddress "=m1CorrectedAhkFileAddress `n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    m1ListFileName := RegExReplace(m1,"i)([\w\d_-\.]+\.ahk)\b\s*$","$1")
    ;Msgbox,% m1 "=m1 `n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    ;Msgbox,% m1ListFileName "=m1ListFileName `n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    ; ____
    if(!FileExist(m1CorrectedAhkFileAddress)){
        m1CorrectedAhkFileAddress := RegExReplace(m1CorrectedAhkFileAddress,"WordList", "actionList") ; my a old database 23.10.2018 12:01
         ; ..\_globalActionListsGenerated\_ahk_global.ahk.Generated.ahk
     m1CorrectedAhkFileAddress :=  StrReplace(m1CorrectedAhkFileAddress, "..\actionLists\", "..\" ) ; qickk and dirty
     m1CorrectedAhkFileAddress :=  StrReplace(m1CorrectedAhkFileAddress, "..\_globalActionListsGenerated\..\_globalActionListsGenerated", "..\_globalActionListsGenerated" ) ; qickk and dirty
      ; ..\_globalActionListsGenerated\..\_globalActionListsGenerated\_ahk_global.ahk.Generated.ahk

lll( A_ThisFunc ":" A_LineNumber , A_LineFile)
      if(!FileExist(m1CorrectedAhkFileAddress)){
lll( A_ThisFunc ":" A_LineNumber , A_LineFile)
            msg := ":( action list is not exist. `n"
            msg .= "al: " m1CorrectedAhkFileAddress "`n"
            msg .= A_WorkingDir " = A_WorkingDir `n"
            Msgbox,% msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
            return false
        }
    }
    if(!FileExist(m1CorrectedAhkFileAddress)){
lll( A_ThisFunc ":" A_LineNumber , A_LineFile)
        Msgbox,:( action list `n %m1CorrectedAhkFileAddress% `n is not exist. `n (%A_LineFile%~%A_LineNumber%)
        return false
    }

	if( SubStr( m1CorrectedAhkFileAddress , -3 ) <> ".ahk" ) ; https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-66
		m1CorrectedAhkFileAddress .= ".ahk"

    ; SaveLast5_to_BackupSL5.ahk "..\actionLists\_globalActionListsGenerated\_ahk_global.ahk" "..\..\gi-actionLists-Bakcups"
    ; actionList := removesSymbolicLinksFromFileAdress(actionList)
; SaveLast5_to_BackupSL5.ahk "..\actionLists\_globalActionListsGenerated\_ahk_global.ahk" "..\..\gi-actionLists-Bakcups"
; SaveLast5_to_BackupSL5.ahk "G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\actionLists\_globalActionListsGenerated\_ahk_global.ahk" "G:\fre\git\github\gi-actionLists-Backups"

    para1FileAddress := removesSymbolicLinksFromFileAdress( A_ScriptDir "\" m1CorrectedAhkFileAddress )
    para2BackupFolder := removesSymbolicLinksFromFileAdress(A_ScriptDir "\..\..\gi-actionLists-Backups")
       commandLine := "SaveLast5_to_BackupSL5.ahk """ para1FileAddress """ """ para2BackupFolder """"
    ; clipboard := commandLine
    ; msgbox,% commandLine "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
    RunWait, % commandLine, % A_ScriptDir
    return openInEditorFromIntern(m1CorrectedAhkFileAddress)
}
;\____ openInEditor __ 181028104756 __ 28.10.2018 10:47:56 __/




;/¯¯¯¯ openInEditor ¯¯ 181028104913 ¯¯ 28.10.2018 10:49:13 ¯¯\
openInEditorFromIntern(m1CorrectedAhkFileAddress){
    global g_config

    ; clipboard := g_config["editor"]["AHKStudioAHK"]
    ; G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\Source\..\AHK_Studio\AHK_Studio.ahk
    if(!isEditorExist_AHKStudio := FileExist(g_config["editor"]["AHKStudioAHK"])){
        ; feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( Editor NOT Exist: AHKStudioAHK: `n`n`n`n >>" g_config["editor"]["AHKStudioAHK"] "<<`n`n`n`n" , A_LineNumber,1,1)
        if(1 && InStr(A_ComputerName,"SL5"))
            sleep,1000
    }
    ; feedbackMsgBox(A_LineNumber ":" A_ScriptName ,g_config["editor"]["tryThisEditorFirst"] "`n" m1CorrectedAhkFileAddress , A_LineNumber,1,1)

    ; editorName := "AHK-Studio"
    ; isEditorExist_AHKStudio := FileExist("..\" editorName "\" editorName ".ahk")


; edit: Opens the indicated file for editing. It might not work if the indicated file's type does not have an "edit" action associated with it.

    ; editorName := "Notepad++"
    ; NotepadPPExe := "..\" editorName "\unicode\" editorName ".exe"

    NotepadPPExe := FileExist(g_config["editor"]["NotepadPPExe"])

    if(1 && InStr(A_ComputerName,"SL5"))
        g_config["editor"]["NotepadPPExe"] := "C:\Program Files\Notepad++\notepad++.exe"
    isEditorExist_NotepadPP := FileExist(NotepadPPExe)
    if(!isEditorExist_NotepadPP := FileExist(g_config["editor"]["NotepadPPExe"])){
        ; feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( Editor NOT Exist: NotepadPPExe: `n`n`n`n >>" g_config["editor"]["NotepadPPExe"] "<<`n`n`n`n" , A_LineNumber,1,1)
        if(1 && InStr(A_ComputerName,"SL5"))
            sleep,1000
    }

    ; editorName := "AutoGUI"
    ; isEditorExist_AutoGUI := FileExist("..\" editorName "\" editorName ".ahk")
    if(!isEditorExist_AutoGUI := FileExist(g_config["editor"]["AutoGUIAHK"])){
        ; feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( Editor NOT Exist: AutoGUIAHK: `n`n`n`n >>" g_config["editor"]["AutoGUIAHK"] "<<`n`n`n`n" , A_LineNumber,1,1)
        if(1 && InStr(A_ComputerName,"SL5"))
            sleep,1000
    }

    ; fallback if somebody gives addresses like ..\....\G:\\... then take the second absolut path
    m1CorrectedAhkFileAddress := regexreplace(m1CorrectedAhkFileAddress , "i).*(\b[a-z]\:\\)", "$1" )
    if(g_config.ScriptDir)
        m1CorrectedAhkFileAddress := g_config.ScriptDir "\" m1CorrectedAhkFileAddress
    else{
        RegRead, aScriptDir, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, aScriptDir
        m1CorrectedAhkFileAddress := aScriptDir "\" m1CorrectedAhkFileAddress
    }
    ; m1CorrectedAhkFileAddress := regexreplace(m1CorrectedAhkFileAddress , "i).*(\b[a-z]\:\\)", "$1" )
    if(0 && InStr(A_ComputerName,"SL5"))
        clipboard := m1CorrectedAhkFileAddress
    if(!isFileExist := FileExist(m1CorrectedAhkFileAddress)){
        ;feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( File NOT Exist: File: `n`n`n`n >>" m1CorrectedAhkFileAddress "<<`n`n`n`n" , A_LineNumber,1,1)
        if(!isFileExist := FileExist(m1CorrectedAhkFileAddress))
            feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( File NOT Exist: File: `n`n`n`n >>" m1CorrectedAhkFileAddress "<<`n`n`n`n" , A_LineNumber,1,1)
        if(1 && InStr(A_ComputerName,"SL5"))
            sleep,5000
        return false
    }
    c =
    (
    m1CorrectedAhkFileAddress = %m1CorrectedAhkFileAddress%
    )
    ; clipboard := c

    if( 0 && isAbsPath := RegExMatch( m1CorrectedAhkFileAddress , "i)^[a-z]:\\" ))
        msgbox,% isAbsPath  "`n" m1CorrectedAhkFileAddress "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
    ; msgbox,% isAbsPath  "`n" m1CorrectedAhkFileAddress "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
     ; feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( !FileExist" isAbsPath  "`n" m1CorrectedAhkFileAddress , A_LineNumber,1,1)
     ; feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( !FileExist(" . fileName . ") `n runIfNotExist, line = " . doFeedbackMsgBox . ">" . A_LineNumber,1,1)

temp =
(
inside ahk-studio:
Default_Project_Folder(){ ...
FileSelectFolder,directory,`% "*" Dir,3,`% "Current Default Folder: " Settings.SSN("//directory").text

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\AHK-Studio\shell\edit\command]
@="\"G:\\fre\\git\\github\\global-IntelliSense-everywhere-Nightly-Build\\AHK-Studio\\AHK-Studio.ahk\" \"`%1\""
the emeditor.ahk is going to be the name of the program then the file extension. the path can be edited to whatever you want. Works in windows 7.
)


    if(false){
        noOp := 1
    }else if( g_config["editor"]["tryThisEditorFirst"] == "Notepad" && isEditorExist_NotepadPP){
        editorAddress := g_config["editor"]["NotepadPPExe"]
    }else if(g_config["editor"]["tryThisEditorFirst"] == "AHKStudio" && isEditorExist_AHKStudio){
        ; 28.09.2018 15:48 2,6 MB opens with error warnings
        ; i got problems relacing some with umlaute (ue) 29.09.2018 12:04
        editorAddress := g_config["editor"]["AHKStudioAHK"]
    }else if(g_config["editor"]["tryThisEditorFirst"] == "AutoGUI" && isEditorExist_AutoGUI){
        ; 28.09.2018 15:48 6,1 MB opens without error warnings
        editorAddress := g_config["editor"]["AutoGUIAHK"]
    }else{ ; fallback
        editorAddress = notepad.exe
        tip := "fallback: open with `n`n" runString "`n`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        ToolTip5sec( tip )
        ; feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
        if(1 && InStr(A_ComputerName,"SL5"))
            sleep,2600
    }
    runString = "%editorAddress%" "%m1CorrectedAhkFileAddress%"
    ; Msgbox,% runString " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    run,% runString
    return true


    ToolTip,`n (%A_LineFile%~%A_LineNumber%)
    AHKcode =
    (
    winTitleError := " ahk_class #32770"
    SetTitleMatchMode,2
        loop,70
        {
            winclose,`% winTitleError,Error ; thats disturbing opening ahk-studio. if closed ahk-studio opens
            winkill,`% winTitleError,Error ; thats disturbing opening ahk-studio. if closed ahk-studio opens
            winclose,`% winTitleError,Script file not found ; thats disturbing opening ahk-studio. if closed ahk-studio opens
            winkill,`% winTitleError,Script file not found ; thats disturbing opening ahk-studio. if closed ahk-studio opens
        	if(1 && InStr(A_ComputerName,"SL5"))
        	    Tooltip,`% A_index " " A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") , 30,30
            sleep,50
        }
    )
    DynaRun(AHKcode)

    ;msg=%runString% `n %m1% `n deprecated: `n please open by using AHK-Studio instead run`n
    ;msgbox, % msg "`n" A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")   " "   Last_A_This
    ;ToolTip5sec(msg A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
    return true
}
;\____ openInEditor __ 181028104756 __ 28.10.2018 10:47:56 __/



; #Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
; #Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk

