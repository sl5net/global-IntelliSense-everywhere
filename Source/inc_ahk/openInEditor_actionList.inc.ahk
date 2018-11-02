;<<<<<<<< openInEditor <<<< 1810111507 <<<< 01.10.2018 11:54:07 <<<<
; called from 				was_a_Editor_open_command := openInEditor(ActionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib) if(was_a_Editor_open_command) return ; endOf function: SendWord(WordIndex)



;/¯¯¯¯ openInEditor ¯¯ 181028104913 ¯¯ 28.10.2018 10:49:13 ¯¯\
openInEditor(ActionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib){
    if(!AHKcode){
        return false
        Clipboard := AHKcode
        Msgbox,% ":( ups is empty: " AHKcode "=AHKcode `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        ExitApp, 
    }
    foundPos := RegExMatch( AHKcode , "^\s*(?:AHK-Studio|AutoGUI|openInEditor)\s*,?\s*(.+\.ahk)\s*$\b$" ,  m )
    ifIsIt := (isStartingUnderline && is_OpenA_edit_open_lib && foundPos ) 
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
    m1CorrectedAhkFileAddress := ActionListFolderOfThisActionList "\" m1
    ;Msgbox,% m1CorrectedAhkFileAddress "=m1CorrectedAhkFileAddress `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    m1ListFileName := RegExReplace(m1,"i)([\w\d_-\.]+\.ahk)\b\s*$","$1")
    ;Msgbox,% m1 "=m1 `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    ;Msgbox,% m1ListFileName "=m1ListFileName `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    ; ____
    if(!FileExist(m1CorrectedAhkFileAddress)){
        m1CorrectedAhkFileAddress := RegExReplace(m1CorrectedAhkFileAddress,"WordList", "ActionList") ; my a old database 23.10.2018 12:01
         ; ..\_globalActionListsGenerated\_ahk_global.ahk.Generated.ahk
     m1CorrectedAhkFileAddress :=  StrReplace(m1CorrectedAhkFileAddress, "..\ActionLists\", "..\" ) ; qickk and dirty
     m1CorrectedAhkFileAddress :=  StrReplace(m1CorrectedAhkFileAddress, "..\_globalActionListsGenerated\..\_globalActionListsGenerated", "..\_globalActionListsGenerated" ) ; qickk and dirty
      ; ..\_globalActionListsGenerated\..\_globalActionListsGenerated\_ahk_global.ahk.Generated.ahk


      if(!FileExist(m1CorrectedAhkFileAddress)){
            msg := ":( action list is not exist. `n"
            msg .= "al: " m1CorrectedAhkFileAddress "`n"
            msg .= A_WorkingDir " = A_WorkingDir `n"
            Msgbox,% msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
            return false
        }
    }
    if(!FileExist(m1CorrectedAhkFileAddress)){
        Msgbox,:( action list `n %m1CorrectedAhkFileAddress% `n is not exist. `n (%A_LineFile%~%A_LineNumber%)
        return false
    }

    ; SaveLast5_to_BackupSL5.ahk "..\ActionLists\_globalActionListsGenerated\_ahk_global.ahk" "..\..\gi-ActionLists-Bakcups"
    ; ActionList := removesSymbolicLinksFromFileAdress(ActionList)
; SaveLast5_to_BackupSL5.ahk "..\ActionLists\_globalActionListsGenerated\_ahk_global.ahk" "..\..\gi-ActionLists-Bakcups"
; SaveLast5_to_BackupSL5.ahk "G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build\ActionLists\_globalActionListsGenerated\_ahk_global.ahk" "G:\fre\git\github\gi-ActionLists-Backups"

    para1FileAddress := removesSymbolicLinksFromFileAdress( A_ScriptDir "\" m1CorrectedAhkFileAddress )
    para2BackupFolder := removesSymbolicLinksFromFileAdress(A_ScriptDir "\..\..\gi-ActionLists-Backups")
       commandLine := "SaveLast5_to_BackupSL5.ahk """ para1FileAddress """ """ para2BackupFolder """"
    ; clipboard := commandLine
    ; msgbox,% commandLine "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
    RunWait, % commandLine, % A_ScriptDir
    return openInEditorFromIntern(m1CorrectedAhkFileAddress)
}
;\____ openInEditor __ 181028104756 __ 28.10.2018 10:47:56 __/

;/¯¯¯¯ openInEditor ¯¯ 181028104913 ¯¯ 28.10.2018 10:49:13 ¯¯\
openInEditorFromIntern(m1CorrectedAhkFileAddress){
    editorName := "AHK-Studio"
    isEditorExist_AHKStudio := FileExist("..\" editorName "\" editorName ".ahk")

    editorName := "Notepad++"
    NotepadPPExe := "..\" editorName "\unicode\" editorName ".exe"
    isEditorExist_NotepadPP := FileExist(NotepadPPExe)

    editorName := "AutoGUI"
    isEditorExist_AutoGUI := FileExist("..\" editorName "\" editorName ".ahk")

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
    }else if( 0 ){
        runString = notepad.exe "%m1CorrectedAhkFileAddress%"
        run,% runString
        return true
    }else if(1 && isEditorExist_NotepadPP){
        runString = %NotepadPPExe% "%m1CorrectedAhkFileAddress%"
        run,% runString
        return true
    }else if(1 && isEditorExist_AHKStudio){
        ; 28.09.2018 15:48 2,6 MB opens with error warnings
        ; i got problems relacing some with umlaute (ue) 29.09.2018 12:04
        runString = AHK-Studio.ahk "%m1CorrectedAhkFileAddress%"
        ;Msgbox,% runString " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        ;Pause
        run,% runString, ..\AHK-Studio
    }else if(1 && isEditorExist_AutoGUI){ ; fallback
        ; 28.09.2018 15:48 6,1 MB opens without error warnings
        runString = AutoGUI.ahk "%m1CorrectedAhkFileAddress%"
        run,% runString, ..\AutoGUI
        return true
    }else if(1){ ; fallback
        runString = %NotepadPPExe% "%m1CorrectedAhkFileAddress%"
        run,% runString
        return true
    }


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
        	    Tooltip,`% A_index ", " A_LineNumber " " RegExReplace(A_LineFile,".*\\") , 30,30
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

