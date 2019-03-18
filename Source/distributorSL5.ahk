/* 
	https://www.autohotkey.com/boards/viewtopic.php?f=76&t=62758
	### using 1: ###
	comandLine parameter (list=yourList):
	a List-address with file addresses into (each line a fileAddress)
	
	Example: 
	list := "C:\AutoHotKey\syncSomeAHKLists\" A_ScriptName ".txt"
	if(!FileExist(list))
		list := "syncSomeAHKLists\" A_ScriptName ".txt"
	Run, syncSomeAHK.ahk "list=%list%", %A_scriptDir%
	
	
	### using 2:###
	comandLine parameter:
	scriptName.ahk
	
	save a List with file addresses into (each line a fileAddress):
	.\syncSomeAHKLists\scriptName.ahk.txt
	
	Example: Run, \syncSomeAHK.ahk "%A_ScriptFullPath%", %A_scriptDir%
	Example: Run, \syncSomeAHK.ahk "myHelloWorld.ahk", c:\myScriptsFolder
	
	
	if list exist script finds the newest and remembers the newest.
		next it copies the newest to the other addresses in the list (if the files exist is default config).
	
	tip for tool: use tool Everything 1.4.1.935 for searching simular scripts. select results to clipboard and copy this to your new list.
	
	
	no warranty of any kind
	no warranty of any kind
	no warranty of any kind
	19-03-15_01-45, SL5net
*/

; # SingleInstance,Force
; Sleep,90
; #NoTrayIcon

para1 = %1%
arg_key := SubStr(para1,1,5)
clipboard := arg_key = arg_val
if(arg_key == "list="){
	arg_val := SubStr(para1,6)	
	listAddress := arg_val 
}else 
	para1 := arg_val 
; Msgbox, >%arg_key%< = >%arg_val%< , >%listAddress%<


if(0){
	DetectHiddenWindows,On
	SetTitleMatchMode,2
	needle := syncSomeAHK.ahk ahk_class AutoHotkey
	WinWaitClose,% needle, ,2
	IfWinExist, % needle 
		ExitApp
}

isDevellopperMode:= true ; enthällt auch update script.
; #Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#SingleInstance,Off
; SetTimer,lblCheckTrayIconStatus,100 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
; SetTimer,timerLbl2000,2000 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!

config := { createFileIfNotExist: false }

if(!listAddress){ ; backward compatible
	dirName := SubStr(A_ScriptName,1,-4) "Lists"
	if(! FileExist(dirName) ){
		FileCreateDir, % dirName 
	}
}
main(listAddress,para1,config,dirName)

; SetTitleMatchMode,2
; WinWaitClose,% A_ScriptName

ExitApp
MsgBox, reload
reload

save_timeStampModi_1_Address(timeStampModi, timeStampModi_1_Address){ 
	tempFileAddress := A_ScriptDir "\" A_TickCount ".temp." A_ThisFunc ".txt"
	FileAppend, % timeStampModi , % tempFileAddress
	FileCopy,% tempFileAddress, % timeStampModi_1_Address, 1
	Sleep,90
	FileDelete,% tempFileAddress
}
main(listAddress:="",para1:="",config:="",dirName:=""){
	;  only save if the newest need set to the top of the list (if its not already there).
	
	if(!para1){
		return
		Msgbox, % " error `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
	}
	
	if(!dirName){
		dirName := RegExReplace( listAddress, "\\[^\\]+$") 
		if(!dirName)
			dirName := A_ScriptDir
	}
	in := {}
	in["scriptFullPath"] := para1
	in["scriptName"] := RegExReplace( in["scriptFullPath"], "^.+\\([^\\]+)$" , "$1") ; cut away folder name
	; in["scriptNameWithoutPATHandEXT"] := RegExReplace( in["scriptFullPath"], ".*\\([\w\s\._]+)\.\w+$", "$1")	
	if(!in["scriptName"] ) ; || !in["scriptNameWithoutPATHandEXT"])
		Msgbox, % " error `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" 
	
	;listAddress := dirName "\" in["scriptNameWithoutPATHandEXT"] ".txt"
	if(!listAddress){
		listAddress := dirName "\" in["scriptName"] ".txt"
	}
	out := {}
	out["setToEndOfList"][1] := { timeStampModi: 0, fileAddress: 0 }
	if(FileExist(listAddress)){
		FileRead,listContent,% listAddress
		listContent := rTrim(listContent," `t`r`n") . "`n"
		timeStampModi_1_AddressDir := dirName "\." SubStr(A_ScriptName,1,-4)
		if(!FileExist(timeStampModi_1_AddressDir))
			FileCreateDir, % timeStampModi_1_AddressDir
		timeStampModi_1_Address := timeStampModi_1_AddressDir "\" in["scriptName"] ".timeStampModi_1.txt"
		if(listContent){
			; find newest
			indexEndOfList := 1
			lastIndex := 1
			Loop, parse, listContent, `n, `r  ; Specifying `n prior to `r allows both Windows and Unix files to be parsed.
			{
				fileAddress1 := A_LoopField
				if(!A_LoopField){
					Continue
					Msgbox, Oops 19-03
				}
				FileGetTime,timeStampModi,% fileAddress1,M
				;ToolTip,% timeStampModi
				;out[A_Index] := { timeStampModi: 0, fileAddress:0 }
				; Msgbox, %indexEndOfList% : %timeStampModi% : %fileAddress1% 
				if(timeStampModi > timeStampModi_1) { ; only the newest set to the top of the list.
					timeStampModi_1 := timeStampModi
					if(A_Index > 1){ 
						;dont work: out["setToEndOfList"][indexEndOfList] := { timeStampModi: out[1].timeStampModi, fileAddress: out[1].fileAddress }
						; out.setToEndOfList[indexEndOfList] := out[1]
						; out.setToEndOfList[indexEndOfList].timeStampModi := out[1].timeStampModi
						out.setToEndOfList[indexEndOfList] := { fileAddress : out[1].fileAddress }
						out[1] := { timeStampModi: timeStampModi_1, fileAddress:fileAddress1 }
						; MsgBox,% A_LineNumber ":" out[1].fileAddress
						; MsgBox,% A_LineNumber ":" out.setToEndOfList[indexEndOfList].fileAddress 
						indexEndOfList++
						; list order changed. save it again.
						;lastIndex--
						continue
					}
				}
				; out[A_Index].timeStampModi := timeStampModi_1
				; out[A_Index].fileAddress := fileAddress1
				out[lastIndex] := { timeStampModi: timeStampModi_1, fileAddress:fileAddress1 }
				lastIndex++
				if(!out[A_Index].fileAddress)
					MsgBox,% A_LineNumber ": Oops " out[A_Index].fileAddress
				; out[A_Index].fileAddress := "test"
			} ; loopEnd
			lastIndex--
			indexEndOfList--
			
			if(indexEndOfList>=1){ ; first entry did not changed
				listContentNew := ""
				if(!lastIndex){
					MsgBox,% A_LineNumber ": Oops "
				}
				Loop,% lastIndex
				{
					; if(out[A_Index].fileAddress)
					if(!out[A_Index].fileAddress){
						MsgBox,% A_LineNumber ": Oops : out[" A_Index "].fileAddress = " out[A_Index].fileAddress
					}
					listContentNew .= out[A_Index].fileAddress "`n"
				}
				; MsgBox,% A_LineNumber ": listContentNew = >" listContentNew "< "
				Loop,% indexEndOfList
				{
					lastIndex += 1
					; out[lastIndex].fileAddress := out.setToEndOfList[A_Index].fileAddress
					out[lastIndex] := { timeStampModi: out.setToEndOfList[A_Index].timeStampModi, fileAddress:out.setToEndOfList[A_Index].fileAddress }
					; MsgBox,% A_LineNumber ": out.setToEndOfList[" A_Index "].fileAddress = " out.setToEndOfList[A_Index].fileAddress 
					if(!out.setToEndOfList[A_Index].fileAddress){
						break
						MsgBox,% A_LineNumber ": Oops : out.setToEndOfList[" A_Index "].fileAddress = " out.setToEndOfList[A_Index].fileAddress 
					}
					if(!out[lastIndex].fileAddress){
						MsgBox,% A_LineNumber ": Oops : out[" lastIndex "].fileAddress = " out[lastIndex].fileAddress
					}
					listContentNew .= out[lastIndex].fileAddress "`n"
				}
				; MsgBox,% A_LineNumber ": listContentNew= " listContentNew
				; MsgBox,% A_LineNumber ": " out[2]["fileAddress"]
				; MsgBox,% A_LineNumber ": " out[2].fileAddress
			; MsgBox,% listContentNew
			; MsgBox,% out.setToEndOfList[1].fileAddress
			; MsgBox,% out[1].fileAddress
				if(listContentNew){
					; MsgBox,% A_LineNumber ": >" listContentNew "< from " listAddress
					tempFileAddress := A_ScriptDir "\" A_TickCount ".temp." A_ThisFunc ".txt"
					FileAppend, % listContentNew , % tempFileAddress
					FileCopy,% tempFileAddress, % listAddress, 1
					Sleep,90
					FileDelete,% tempFileAddress
				}
				; timeStampModi_1_Address := dirName "\" in["scriptName"] ".timeStampModi_1.txt"
				save_timeStampModi_1_Address(out[1].timeStampModi, timeStampModi_1_Address)
				;MsgBox,% A_LineNumber ">" listContentNew "< from " listAddress
				do_overwrite_allFiles_with_newest_version := true
			}else{
				FileRead, timeStampModi_1_fromLogFile, % timeStampModi_1_Address
				if(timeStampModi_1_fromLogFile <> out[1].timeStampModi){
					save_timeStampModi_1_Address(out[1].timeStampModi, timeStampModi_1_Address)
					do_overwrite_allFiles_with_newest_version := true
					; MsgBox,% A_LineNumber ": Oops. whats next? 19-03-14_23-29" 
				}else
					do_overwrite_allFiles_with_newest_version := false
				; MsgBox,% A_LineNumber ">" listContent "< lastIndex=" lastIndex ", doOverwrite=" do_overwrite_allFiles_with_newest_version
			}
			
			if(do_overwrite_allFiles_with_newest_version){
				tip := "config.createFileIfNotExist = " config.createFileIfNotExist "`n"
				Loop,% lastIndex
				{
					
					if(A_Index == 1 
						|| !config.createFileIfNotExist && !fileExist(out[A_Index]["fileAddress"]))
						Continue
					tip  .= "FileCopy, " out[1]["fileAddress"] "," out[A_Index]["fileAddress"] "`n"
					FileCopy,% out[1]["fileAddress"],% out[A_Index]["fileAddress"], 1
					; Sleep,90
					;if(out[A_Index]["fileAddress"])
				}
				; ToolTip,% tip
				; MsgBox,% tip
			}
		} ; end of listConten
	}
	;o["scriptFullPath"]
	; Msgbox,% in["scriptFullPath"]  " 19-03-14_16-45 " in["scriptNameWithoutPATHandEXT"]
	;FileRead,list,% scriptFullPath
}
	
	
; Msgbox,% dirName
; ToolTip,test 19-03-14_16-35
; SoundBeep,5000
;	while(1)
;		Sleep,90
; ~^s::
; Run, syncSomeAHK.ahk "%A_ScriptFullPath%", %A_ScriptDir%
;Reload
; return
	ExitApp
	
	lblCheckTrayIconStatus:
; showTempTrayIf_isNearTrayMenue(iconAdress)		
	DetectHiddenWindows,Off
	IfWinExist,%A_ScriptName%_icon,ExitApp %A_ScriptName% ; message from child DynaRun() script
	{
		WinClose,%A_ScriptName%_icon
		ExitApp
	}
	return
	
	
	
	timerLbl2000:
	return
	
	
; #Include *i %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
; #Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
; #Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
; #Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk 
	
