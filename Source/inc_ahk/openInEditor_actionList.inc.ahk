g_config := {}
#Include *i %A_ScriptDir%\inc_ahk\minify\config.minify.inc.ahkSTATIC.ahk


;<<<<<<<< openInEditor <<<< 1810111507 <<<< 01.10.2018 11:54:07 <<<<
; called from 				was_a_Editor_open_command := openInEditor(actionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib) if(was_a_Editor_open_command) return ; endOf function: SendWord(WordIndex, g_Word)

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


    itsAbsolutePath := (RegExMatch(m1, "^\w+\:\\"))
    m1CorrectedAhkFileAddress := (itsAbsolutePath) ? m1 : actionListFolderOfThisActionList "\" m1
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
            msg .= "al1: >>" m1CorrectedAhkFileAddress "<<`n`n"
            msg .= "al2: >>" actionListFolderOfThisActionList "<<`n`n"
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

    if(1 && InStr(A_ComputerName,"SL5") && SubStr( "test.ahk" , -3 ) <> ".ahk")
           Msgbox,plausibilty damage `n %m1CorrectedAhkFileAddress% `n `n (%A_LineFile%~%A_LineNumber%)
	if( SubStr( m1CorrectedAhkFileAddress , -3 ) <> ".ahk" ) ; https://g-intellisense.myjetbrains.com/youtrack/issue/GIS-66
		m1CorrectedAhkFileAddress .= ".ahk"
    else{
        if(SubStr( m1CorrectedAhkFileAddress , -7 ) == ".ahk.ahk")  ; was happend 19-04-04_15-01
           Msgbox,plausibilty damage `n %m1CorrectedAhkFileAddress% `n `n (%A_LineFile%~%A_LineNumber%)
    }

; Tooltip Tool Too Tooltip Tool

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




;/¯¯¯¯ openInEditorFromIntern ¯¯ 181028104913 ¯¯ 28.10.2018 10:49:13 ¯¯\
openInEditorFromIntern(m1CorrectedAhkFileAddress){
    global g_config

    if(!m1CorrectedAhkFileAddress){
        msg =
        (
        >%m1CorrectedAhkFileAddress%< = ...Backup
        )
        if(1 && InStr(A_ComputerName,"SL5")){
            feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( " msg , msg ,1,1)
            ; Msgbox,% msg "`n`n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        }
        return false
    }

    ; fallback if somebody gives addresses like ..\....\G:\\... then take the second absolut path
    m1CorrectedAhkFileAddress_Backup := m1CorrectedAhkFileAddress
    m1CorrectedAhkFileAddress := regexreplace(m1CorrectedAhkFileAddress , "i).*(\b[a-z]\:\\)", "$1" )

    if(RegExMatch(m1CorrectedAhkFileAddress, "^\w+\:\\"))
        itsAbsolutePath := true

    if(!itsAbsolutePath){
        if(g_config.ScriptDir)
            m1CorrectedAhkFileAddress := g_config.ScriptDir "\" m1CorrectedAhkFileAddress
        else{
            ; is needet by very new list. becouse is includet from elsware. from actionNameFilter 19-01-14_01-52
            RegRead, aScriptDir, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, aScriptDir
            m1CorrectedAhkFileAddress := aScriptDir "\" m1CorrectedAhkFileAddress
        }
    }


    		if(InStr(FileExist(m1CorrectedAhkFileAddress ), "D") ){
msg =
(
ops. Cant open a folder?
you try opening:
'%m1CorrectedAhkFileAddress%'
file not folder ecpected.

somme additional info:
%aScriptDir% = aScriptDir
%m1CorrectedAhkFileAddress_Backup% = ...Backup
)
    		    feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( " msg , msg ,1,1)
                Msgbox,% msg "`n`n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    		}

    ; m1CorrectedAhkFileAddress := regexreplace(m1CorrectedAhkFileAddress , "i).*(\b[a-z]\:\\)", "$1" )
    if(0 && InStr(A_ComputerName,"SL5"))
        clipboard := m1CorrectedAhkFileAddress
    if(!isFileExist := FileExist(m1CorrectedAhkFileAddress)){
        m1CorrectedAhkFileAddress .= ".ahk" ; try something. why not 19-02-17_18-20
    }
    if(!isFileExist := FileExist(m1CorrectedAhkFileAddress)){
        ; if(!isFileExist := FileExist(m1CorrectedAhkFileAddress))
        feedbackMsgBox(A_LineNumber ":" A_ScriptName ,":-( File NOT Exist: File: `n`n`n`n >>" m1CorrectedAhkFileAddress "<<`n`n`n`n" , A_LineNumber,1,1)
        if(1 && InStr(A_ComputerName,"SL5")){
            g_configScriptDir := g_config.ScriptDir
            msg =
            (
   Problem: File Not Exist: %m1CorrectedAhkFileAddress%

%itsAbsolutePath% = itsAbsolutePath

%g_configScriptDir% = g_config.ScriptDir

%aScriptDir% = aScriptDir

%m1CorrectedAhkFileAddress_Backup% = m1CorrectedAhkFileAddress_Backup

%m1CorrectedAhkFileAddress% = m1CorrectedAhkFileAddress
            )
            clipboard := msg
            Msgbox,% msg "`n`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        }
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



isEditorExist := false
; For editorName, editorAddress in g_config.editor

;	MsgBox,% n "=" g_config["editor"][n]
for editorName, editorAddress in g_config["editor"]
	if(isEditorExist := FileExist(editorAddress))
	    break
if(!isEditorExist)
    editorAddress = notepad.exe
runString = "%editorAddress%" "%m1CorrectedAhkFileAddress%"
    ; clipboard := runString
    if(0 && InStr(A_ComputerName,"SL5")){
        feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), editorName ": " runString )
        Msgbox,% runString " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    }
run,% runString
return true


    ToolTip,ahk-studio special helps `n (%A_LineFile%~%A_LineNumber%)
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
;\____ openInEditorFromIntern __ 181028104756 __ 28.10.2018 10:47:56 __/



; #Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
; #Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk

