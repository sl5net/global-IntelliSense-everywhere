; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; config it
fileExtension=php,ahk,js,csv,htm,html,txt,mdb,bas
;>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this is using this script without parameter !!! please use it wieth attribute ! 17.04.2017 16:36
; optonallli you could use a second parameter:
; example:
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; Msgbox,%A_ScriptFullPath% = `n%A_ScriptFullPath%  `n fullfile=%fullfile% `n `n (from: %A_LineFile%~%A_LineNumber%) 
; Msgbox,%A_ScriptDir% = `n%A_ScriptDir%  `n fullfile=%fullfile% `n `n (from: %A_LineFile%~%A_LineNumber%) 

#SingleInstance force
;~ The word IGNORE skips the dialog box and leaves the old instance running. In other words, attempts to launch an already-running script are ignored.


scriptDir := RegExReplace( A_ScriptDir, "(\\AutoHotKey).*" , "$1") ; maybe file is started from subfolder. 18.04.2017 12:18
SetWorkingDir, % scriptDir 

#Include %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

#Include %A_ScriptDir%\inc_ahk\ScriptNameLetterIcon.inc.ahk
;Msgbox,%HardDriveLetter%`n (%A_LineFile%~%A_LineNumber%) 

feedbackMsgBoxCloseAllWindows()
; feedbackMsgBox(A_ScriptName,"18-01-06_16-26")

;<<<<<<<< previous <<<< 171030113549 <<<< 30.10.2017 11:35:49 <<<<
log =
(
---------------------------
SaveLast5_to_BackupSL5.ahk
---------------------------
Could not close the previous instance of this script.  Keep waiting?
---------------------------
Ja   Nein   
---------------------------
)
DetectHiddenWindows,Off
SetTitleMatchMode,1 ; 3 = exactliy
activeTitle=SaveLast5_to_BackupSL5.ahk ahk_class #32770 ahk_exe AutoHotkey.exe
IfWinExist,% activeTitle
{
	Loop,100
	{
		IfWinNotExist,% activeTitle
			break
		WinClose,% activeTitle
		Sleep,100
		WinKill,% activeTitle
		Sleep,100
		; SendMessage,{esc},,,,SaveLast5_to_BackupSL5.ahk ahk_class #32770 ahk_exe AutoHotkey.exe
		IfWinNotExist,% activeTitle
			break
		ToolTip4sec(A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " WinActivate," activeTitle)
	   WinActivate,% activeTitle
	   WinWaitActive,% activeTitle ,,1
	   Send,{Enter}

; ___ 1

		ToolTip,% A_index "`n (" A_LineFile "~" A_LineNumber ")"
		Sleep,100
	}
	; feedbackMsgBoxCloseAllWindows()
	ExitApp
}
;>>>>>>>> previous >>>> 171030113557 >>>> 30.10.2017 11:35:57 >>>>

;

if(0)
{
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ open navigation for ahk-developer
;~ autoload.ahk * SciTE4AutoHotkey [3 of 3] ahk_class SciTEWindow,
IfWinExist, %A_LineFile% * SciTE4AutoHotkey
	run, AHK Code Viewer.ahk "%A_ScriptFullPath%"
else
IfWinExist, %A_LineFile% - SciTE4AutoHotkey
	run, AHK Code Viewer.ahk "%A_ScriptFullPath%"
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}

;~ Loop, %A_ProgramFiles%\*.txt, , 1  ; Recurse into subfolders.
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ next is source folder (variable dir). please config this 20.06.2013
;~ next folder (default was backupAHK) will be created below root Letter of your partition. you find everything there 20.06.2013
subFolderNameForBackUps:= "backup_with_SL5"
subFolderNameForBackUps:= "BackupSaveLast5"
global subFolderNameForBackDRIVE
para1=%1%
para2=%2%
para3=%3%
para4=%4%
para5=%5%

if(para2){
	StringReplace,para2,para2,/,\,ALL
	subFolderNameForBackDRIVE:=SubStr(para2,1,1)
	subFolderNameForBackUps:=SubStr(para2,4)
	folderAddressBackUps:=para2
msg = 
(
para1=%1% Datei-Vollstaendige-Adresse
para2=%2% Ziel-Ornder
para3=%3%
para4=%4%
para5=%5%
subFolderNameForBackDRIVE= %subFolderNameForBackDRIVE%
%subFolderNameForBackUps% = subFolderNameForBackUps 
(%A_LineFile%~%A_LineNumber%)
)
    ;feedbackMsgBox(A_ScriptName,msg)

	; Msgbox,%subFolderNameForBackDRIVE% `n  %subFolderNameForBackUps%`n (%A_LineFile%~%A_LineNumber%) 
	; subFolderNameForBackUps=fre\private\Google_Drive\fax.sl5net\backup
}
if(para3){
msg = 
(
Fehler para3 sollte nicht belegt sein (ist bisher nicht vorgesehen 07.01.2018 20:17)
para1=%1% Datei-Vollstaendige-Adresse
para2=%2% Ziel-Ornder
para3=%3%
para4=%4%
para5=%5%
subFolderNameForBackDRIVE= %subFolderNameForBackDRIVE%
%subFolderNameForBackUps% = subFolderNameForBackUps 
(%A_LineFile%~%A_LineNumber%)
==> ExitApp
)
    feedbackMsgBox(A_ScriptName,msg)
	Msgbox,% msg 
	ExitApp
}

show_tooltip=0       ; 1=show, anything else means hide
show_tooltip=1       ; 1=show, anything else means hide

backUpFilePostfixModus:= "timestamp"
;~ if you use timestamp your folders explode may one day ;)
backUpFilePostfixModus:="seconds"
;~ seconds is overwriting or so.

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if(!fullfile)
fullfile=%1%
; if(!folderNameForBackUps)
;	folderNameForBackUps=%2%
if(0){
	MsgBox,%fullfile%
	ExitApp
}
if("debugging" AND false)
	fullfile:=A_ScriptFullPath

; Msgbox,%fullfile% `n thanks for going (from: %A_LineFile%~%A_LineNumber%) 


if(not fullfile)
{
	msg=%A_LineFile% expects (first) parameter fullfile `n like this `n %A_LineFile% R:\blabla\someThink.ahk `n i recommand you to use it with tools like `n gulpJS or TheFolderSpy.exe (please read Read me.ahk *f) `n or PsychoFolder.exe from Ferruh Mavituna. `n (%A_LineFile%~%A_LineNumber%)
	feedbackMsgBox(A_ScriptName,msg)
	ExitApp
	
	ToolTip5sec("!! Attension !! config is jet temporary hardcoded in the file !!! `n `n `n it saves last 5 file version to " . HardDriveLetter . ":\" . subFolderNameForBackUps . " of your Drive. `n Creates this folder if not exist. `n Is overwriting needet it overwrites the smaler one of the five files backup-versions. `n")

}
para1:=RegExReplace(fullfile,"^.*\\([^\\]*)\.\w+$","$1")
;~ patternFileNameWithoutDir=.*\\[^\\]*)\.\w+$
;~ To fetch all info:
SplitPath, fullfile, fileNameWithoutDir, dirNameWithoutFile, extName, fileName_no_ext, driveName
;~ fileNameWithoutDir:=RegExReplace(fullfile,"^(.*\\[^\\]*)\.\w+$","$1")
;~ dirNameWithoutFile:=RegExReplace(fullfile,"^(.*).*\\[^\\]*\.\w+$","$1")
;~ MsgBox,dirNameWithoutFile= %dirNameWithoutFile%
;~ ExitApp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; MsgBox,%HardDriveLetter%

Loop
{
	if( A_ComputerName = "22GHZ-8GBRAM" )
	{
			dir:=HardDriveLetter . ":\Zend\Apache2\htdocs\"
	}
	else
	{
		dir:=HardDriveLetter . ":\ZendServer\Apache2\htdocs\"
	}
	if(dirNameWithoutFile)
	{
		dir:=dirNameWithoutFile
		dir:=fullfile
	}
	
	;if(extName) ; <== thats name given over fyyyyyyyyyyyyyyyyyyyyyyyy		fileExtension:=extName
	;~ SplitPath, fullfile, fileNameWithoutDir, dirNameWithoutFile, extName, fileName_no_ext, driveName

msg =
(
dirNameWithoutFile  = %dirNameWithoutFile%
dir  = %dir%
subFolderNameForBackUps  = %subFolderNameForBackUps%
fileExtension            = %fileExtension%
backUpFilePostfixModus   = %backUpFilePostfixModus%
show_tooltip   = %show_tooltip%
A_UserName     = %A_UserName%
%A_LineFile%~%A_LineNumber%
)
	;feedbackMsgBox(A_ScriptName,msg)
	;Msgbox,%msg% `n (%A_LineFile%~%A_LineNumber%)
	versionBackup(dir,subFolderNameForBackUps,fileExtension,backUpFilePostfixModus,show_tooltip)

	if(dirNameWithoutFile){
		msg2 = fullfile=%fullfile%,  fileNameWithoutDir=%fileNameWithoutDir%,  `n dirNameWithoutFile=%dirNameWithoutFile%, extName=%extName%, `n  fileName_no_ext=%fileName_no_ext%, driveName=%driveName% `n 
		msg=dirNameWithoutFile ==> ExitApp %msg2% `n (%A_LineFile%~%A_LineNumber%) 
       ; feedbackMsgBox(A_ScriptName,msg)

		ExitApp
	}

;~ dir:="R:\fre\private\HtmlDevelop\AutoHotKey\"
	;~ fileExtension=ahk
	;~ versionBackup(dir,subFolderNameForBackUps,fileExtension,backUpFilePostfixModus,show_tooltip)

	;~ dir:="R:\xampp\htdocs\"
	;~ fileExtension=php
	;~ versionBackup(dir,subFolderNameForBackUps,fileExtension,backUpFilePostfixModus,show_tooltip)
	Sleep,9000
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

versionBackup(m_dir, m_subFolderNameForBackUps, m_fileExtension, m_backUpFilePostfixModus, m_show_tooltip=0){
	global HardDriveLetter
	if(m_show_tooltip)
		ToolTip2sec(m_dir . " " . m_fileExtension)

    ;MsgBox,stop `n = FolderAdrBackUp `n (%A_LineFile%~%A_LineNumber%)

	
	;msg = %m_dir% = m_dir `n (%A_LineFile%~%A_LineNumber%)
	;feedbackMsgBox(A_ScriptName,msg)
	
	;~ MsgBox,%m_backUpFilePostfixModus%
	;MsgBox,%HardDriveLetter%
	
	
	if ( FileExist(m_dir) )
	{
		loopFilePattern:=m_dir
		;~ SplitPath, fullfile, fileNameWithoutDir, dirNameWithoutFile, extName, fileName_no_ext, driveName
		SplitPath, m_dir,, dirTemp
		SplitPath, m_dir,, dirTemp
		
	
		global subFolderNameForBackDRIVE
		if(subFolderNameForBackDRIVE)
			StringReplace,dirTemp,dirTemp, %HardDriveLetter%:\,%subFolderNameForBackDRIVE%:\
		msg = fileCreateDirS(%dirTemp% ... ) `n (%A_LineFile%~%A_LineNumber%)
		;feedbackMsgBox(A_ScriptName,msg)

global folderAddressBackUps
		backUpFolderRoot := folderAddressBackUps ; fileCreateDirS(dirTemp, m_subFolderNameForBackUps)
        msg =
(
%dirTemp% = dirTemp
%m_subFolderNameForBackUps% = m_subFolderNameForBackUps
%backUpFolderRoot% = backUpFolderRoot `n (%A_LineFile%~%A_LineNumber%)
)
        ;feedbackMsgBox(A_ScriptName,msg)

	}
	else
	{
		loopFilePattern=%m_dir%\*.*
		global subFolderNameForBackDRIVE
		if(subFolderNameForBackDRIVE)
			StringReplace,m_dir,dirTemp, %HardDriveLetter%:\,%subFolderNameForBackDRIVE%:\
		msg = fileCreateDirS(%dirTemp% ... ) `n (%A_LineFile%~%A_LineNumber%)
		if(!dirTemp){
		    feedbackMsgBox(A_ScriptName,"Oops !dirTemp " . msg)
		}
		backUpFolderRoot := fileCreateDirS(dirTemp, m_subFolderNameForBackUps)
        msg = %backUpFolderRoot% = backUpFolderRoot `n (%A_LineFile%~%A_LineNumber%)
        feedbackMsgBox(A_ScriptName,msg)
		;msgbox,% msg
		exitapp
	}
	msg = %loopFilePattern% `n (%A_LineFile%~%A_LineNumber%)
	;feedbackMsgBox(A_ScriptName,msg)
	
	Loop, %loopFilePattern%, , 1
	{
		;~ MsgBox,A_LoopFileDir = %A_LoopFileDir%
		if(InStr(A_LoopFileDir, m_subFolderNameForBackUps))
			continue
		
		isUsefulFileExt:=false
		
		this_ext:=""
		StringSplit, fileExtensionArray, m_fileExtension, `,
		Loop, %fileExtensionArray0%
		{
			this_ext := fileExtensionArray%a_index%
			;~ MsgBox, %a_index%: this_ext=%this_ext%
			
			StringLower, this_ext, this_ext
			StringLower, loopExt, A_LoopFileExt
			if( this_ext == loopExt )
			{
				isUsefulFileExt:=true
				break
			}
		}
		if(isUsefulFileExt == false){
			msg=this_ext=%this_ext% `n loopExt=%loopExt% `n isUsefulFileExt == false `n ==> continue (%A_LineFile%~%A_LineNumber%) 
			; feedbackMsgBox(A_ScriptName,msg)
			continue
		}
		
		
		FolderAdrBackUp:=backUpFolderRoot . SubStr(A_LoopFileDir,3)


		; MsgBox,backUpFolderRoot=%backUpFolderRoot% A_LoopFileDir=%A_LoopFileDir% `n (%A_LineFile%~%A_LineNumber%) 
		;~ ExitApp
		
		
		if(m_show_tooltip)
			ToolTip2sec(RegExReplace(A_LineFile,".*\\")  . ": FolderAdrBackUp=" . FolderAdrBackUp)
		
		msg = 
(
%A_LineFile%~%A_LineNumber%
%loopFilePattern% = loopFilePattern
%fileExtensionArray0% = fileExtensionArray0
%A_LoopFileDir% = A_LoopFileDir
%backUpFolderRoot% = backUpFolderRoot
%FolderAdrBackUp% = FolderAdrBackUp
fileCreateDirS(%FolderAdrBackUp%,"")  `n (%A_LineFile%~%A_LineNumber%)
)
;feedbackMsgBox(A_ScriptName,msg)

		fileCreateDirS(FolderAdrBackUp,"")
		;~ FolderAdrBackUp:=A_LoopFileDir . "\" . m_subFolderNameForBackUps
		
		; MsgBox,%FolderAdrBackUp%  `n = FolderAdrBackUp `n (%A_LineFile%~%A_LineNumber%) 

		if(isDir(A_LoopFileFullPath))
		{
			;~ MsgBox,%dir% \ %A_LoopFileName%
		}
		
		; strang signs in dir name ... better continue this
		FoundPos := RegExMatch(m_dir,"[%]+")
		if(FoundPos>0)
			{
			msg=strang signs in dir name ... better continue this `n (%A_LineFile%~%A_LineNumber%) 
			feedbackMsgBox(A_ScriptName,msg)
			continue
		}

		
		
		FoundPos := RegExMatch(m_dir,"[%]+")
		if(FoundPos>0){
			msg=better continue this `n (%A_LineFile%~%A_LineNumber%) 
			feedbackMsgBox(A_ScriptName,msg)
			continue
		}
		FoundPos := RegExMatch(A_LoopFileName,"[%]+")
		if(FoundPos>0){
			msg=better continue this `n (%A_LineFile%~%A_LineNumber%) 
			feedbackMsgBox(A_ScriptName,msg)
			continue
		}
		FileGetSize,FileSize,%A_LoopFileFullPath%
		
		if(FileSize <= 0 )
		{
			;~ ToolTip, :-(	%A_LoopFileName% dir=%dir% FileSize=%FileSize%
			if(m_show_tooltip)
				ToolTip2sec(":( FileSize <= 0 :" . A_LoopFileName . "           bzw " . A_LoopFileFullPath)
			msg=better continue this `n (%A_LineFile%~%A_LineNumber%) 
			feedbackMsgBox(A_ScriptName,msg)
			continue
		}

		if(m_show_tooltip)
			ToolTip2sec(":) FileSize > 0 `n" . A_LoopFileName )


		sizeTxtFilePath=%FolderAdrBackUp%\size_txt
		
		;~ if(m_show_tooltip)
			;~ ToolTip5sec(RegExReplace(A_LineFile,".*\\")  . ": `nFolderAdrBackUp=" . FolderAdrBackUp . "`nsizeTxtFilePath=" . sizeTxtFilePath)

		fileCreateDirS(sizeTxtFilePath,"")
		
			;MsgBox,%sizeTxtFilePath%  `n = sizeTxtFilePath `n %FolderAdrBackUp%  `n = FolderAdrBackUp `n %FileAdrBackup% = FileAdrBackup `n (%A_LineFile%~%A_LineNumber%) 
			
		; Path ??
		if(not FileExist(sizeTxtFilePath))
		{
			; Clipboard=%sizeTxtFilePath%
			msg=hï¿½? exit `n not FileExist(%sizeTxtFilePath%) 
			feedbackMsgBox(A_ScriptName,msg)
			ExitApp
		}
		
		;~ MsgBox,%sizeTxtFilePath%
		;~ ExitApp
		
		sizeTxtFileAdr=%sizeTxtFilePath%\%A_LoopFileName%.size.txt
		;~ MsgBox,%sizeTxtFileAdr%
		IfExist,%sizeTxtFileAdr%
		{
			FileReadLine, FileSizeOld, %sizeTxtFileAdr%, 1
			;~ MsgBox,FileSizeOld=%FileSizeOld%
			if(FileSize == FileSizeOld)
				continue
			FileDelete,%sizeTxtFileAdr%
		}
		
		
		IfExist,%sizeTxtFileAdr%
		{
			; should never happen. is in development mode
			msg=IfExist %sizeTxtFileAdr% :( `n should never happen. is in development mode
			feedbackMsgBox(A_ScriptName,msg)
			ExitApp
		}
		FileAppend,%FileSize%, %sizeTxtFileAdr%
		
		
		
		if( m_backUpFilePostfixModus = "seconds")
		{
			; A_DD Current 2-digit day of the month (01-31). Synonymous with A_MDay.
			;~ 1 = overwrite existing files	
			if( NOT FileAdrBackup){
				if(1){
   	; fileCopy_NAME_INJECTION(m_source, m_destination, m_dest_injectString_type, m_dest_ext)
    ; Msgbox,%m_source% %m_destination% %m_dest_injectString_type% %m_dest_ext% `n (%A_LineFile%~%A_LineNumber%)
		; FileAdrBackupDAY=%m_destination%.%inJ%.%m_dest_ext%
		FolderAdrBackUpROOT := FolderAdrBackUp
		; FolderAdrBackUp := FolderAdrBackUp . "." . A_Index
		;msgbox,(%A_LineFile%~%A_LineNumber%)
		;fileCreateDirS(FolderAdrBackUp,"")
		; destinationDirBackup := destinationDir . "." . inJ 
		FileAdrBackup := FolderAdrBackUp . "\" . A_LoopFileName
msg=
(
%FolderAdrBackUp% 
%FileAdrBackup% = FileAdrBackup
(%A_LineFile%~%A_LineNumber%)
)
;feedbackMsgBox(A_ScriptName,msg)
	}
			}
			fileSMALEST := FileAdrBackup

msg=
(
fileSMALEST = %fileSMALEST%
%FolderAdrBackUp% = FolderAdrBackUp
%FileAdrBackup% = FileAdrBackup
(%A_LineFile%~%A_LineNumber%)
)
 ;feedbackMsgBox(A_ScriptName,msg)



			Loop,5
			{
			    aIndex_54321 := 5 + (1 - A_Index)

				s:=SubStr(A_Sec,1,1) ; only one digit. its enough
				if(1){
   	; fileCopy_NAME_INJECTION(m_source, m_destination, m_dest_injectString_type, m_dest_ext)
    ; Msgbox,%m_source% %m_destination% %m_dest_injectString_type% %m_dest_ext% `n (%A_LineFile%~%A_LineNumber%)
		; FileAdrBackupDAY=%m_destination%.%inJ%.%m_dest_ext%
		; FolderAdrBackUp := FolderAdrBackUp . "." . aIndex_54321
				;msgbox,(%A_LineFile%~%A_LineNumber%)

		; fileCreateDirS(FolderAdrBackUp,"")
		;feedbackMsgBox(A_ScriptName,msg)
		; destinationDirBackup := destinationDir . "." . inJ

		FileAdrBackup := FolderAdrBackUpROOT . ".1-5\" . aIndex_54321 . "\" . A_LoopFileName

            ;msg=%aIndex_54321% = aIndex_54321 %A_LineFile%~%A_LineNumber%
            ;feedbackMsgBox(A_ScriptName,msg)
			if(A_Index = 1){
                fileAdr1 := FolderAdrBackUpROOT . ".1-5\1\" . A_LoopFileName
                if(!FileExist(fileAdr1)){ ; damit ganz am anfang,, wenn noch nie was gespeichert wurde auch die erste kiste voll ist... wird dann unten gleich weiter kopiert... also nicht performant. aber funktioniert ... egal erstmal... 07.01.2018 12:46
                    fileCopy_NAME_INJECTION(m_source, fileAdr1, "folder", m_dest_ext)
msg=
(
%m_source% = m_source
%fileAdr1% = fileAdr1
%m_dest_ext% = m_dest_ext
%A_LineFile%~%A_LineNumber%
)
;feedbackMsgBox(A_ScriptName,msg)
;msgbox,% msg
                }

			    ; alle einmal durchrÃ¼cken FileMove, C:\*.txt, C:\My Folder
                Loop,4
                {
                    aIndex_move4321 := 4 + (1 - A_Index)
                    fileAdr4 := FolderAdrBackUpROOT . ".1-5\" .  aIndex_move4321      . "\" . A_LoopFileName
                    if(FileExist(fileAdr4)){
                        fileDir5 := FolderAdrBackUpROOT . ".1-5\" . (aIndex_move4321 + 1)
                        fileAdr5 := fileDir5 . "\" . A_LoopFileName
                        FileCreateDir,% fileDir5 ; create all parent directories given in DirName if they do not already exist.
                        FileCopy, % fileAdr4, % fileAdr5, 1
                    }
msg=
(
FileCopy,
  %fileAdr4%,
  %fileAdr5%, 1
(%A_LineFile%~%A_LineNumber%)
)
;feedbackMsgBox(A_ScriptName,msg)

                }
                fileAdr1 := FolderAdrBackUpROOT . ".1-5\" .  aIndex_move4321      . "\" . A_LoopFileName
                FileDelete, % fileAdr1 ; platz frei machen fÃ¼r neues
                FileAdrBackup := fileAdr1 ; platz festlegen fÃ¼r neues
			}


       	fileCopy_NAME_INJECTION(m_source, FileAdrBackup, "folder", m_dest_ext)
msg=
(
FolderAdrBackUpROOT = %FolderAdrBackUpROOT%
%FolderAdrBackUp% = FolderAdrBackUp
%A_LineFile%~%A_LineNumber%
)
;feedbackMsgBox(A_ScriptName,msg)
;		msgbox,% msg
;		exitapp
		;feedbackMsgBox(A_ScriptName,msg)
msg =
(
%A_LineFile%~%A_LineNumber%
m_source = %m_source%
dir = %dir%
m_destination    = %m_destination%
destinationDir = %destinationDir%
destinationName = %destinationName%
FileAdrDirBackup = %FileAdrDirBackup%
FileAdrBackup = %FileAdrBackup%
m_dest_injectString_type = %m_dest_injectString_type%
m_dest_ext = %m_dest_ext%
A_UserName = %A_UserName%
)
}
	;feedbackMsgBox(A_ScriptName,ltrim(msg))
				
				
				
				IfNotExist,%FileAdrBackup%
				{
					; fileSMALEST:=FileAdrBackup ; name not perfect. anyway. wasting time
					; fileSMALEST:=A_LoopFileFullPath
					; FileCopy,% A_LoopFileFullPath, % FileAdrBackup
                    fileCopy_NAME_INJECTION(A_LoopFileFullPath, FileAdrBackup, "folder", m_dest_ext)

					msg= break `n IfNotExist,%FileAdrBackup% `n (%A_LineFile%~%A_LineNumber%)
					; feedbackMsgBox(A_ScriptName,msg)
					break
				}
				FileGetSize,fileSize,%FileAdrBackup%
				if(fileSize < fileSizeOLDEST)
				{
					fileSizeSMALEST:=fileSize
					fileSMALEST:=FileAdrBackup
					msg=fileSMALEST = %fileSMALEST%  `n (%A_LineFile%~%A_LineNumber%)
					feedbackMsgBox(A_ScriptName,msg)
				}
			}
			;~ ToolTip,aIndex_54321=%aIndex_54321% : FileSize=%FileSize% FileSizeOld=%FileSizeOld% OK? sizeTxtFileAdr=%sizeTxtFileAdr%
msg=
(
FileAdrDirBackup = %FileAdrDirBackup%
FolderAdrBackUpROOT = %FolderAdrBackUpROOT%
%fileSMALEST% = fileSMALEST
%FolderAdrBackUp% = FolderAdrBackUp
destinationDir = %destinationDir%
%A_LineFile%~%A_LineNumber%
)
; feedbackMsgBox(A_ScriptName,msg)
;tooltip, % msg
;msgbox, % msg

;IfExist,%fileSMALEST%
    if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUpROOT . "\" . A_LoopFileName, "A_DD", this_ext))
        if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUpROOT . "\" . A_LoopFileName, "A_MM", this_ext))
            if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUpROOT . "\" . A_LoopFileName, "A_YYYY", this_ext))
							ToolTip,
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		if(1)
		{
			msg=%fileSMALEST% = fileSMALEST  (%A_LineFile%~%A_LineNumber%)
			;feedbackMsgBox(A_ScriptName,msg)
			ExitApp
		}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

            msg= FileCopy,%A_LoopFileFullPath%,%fileSMALEST% `n (%A_LineFile%~%A_LineNumber%)
            feedbackMsgBox(A_ScriptName,msg)

			FileCopy,%A_LoopFileFullPath%,%fileSMALEST%,1
			if(m_show_tooltip)
				ToolTip2sec("FileCopy," . A_LoopFileFullPath . ", " . fileSMALEST . ",1")
		}

		 ;~ MsgBox,%A_LoopFileName% dir=%dir% FileSize=%FileSize%
		;Sleep,1000
		
		if(m_show_tooltip)
			ToolTip, %A_LoopFileName% `n %A_LineNumber%: %A_LineFile%
	}
	;~ ToolTip,sync finished :)
	return
	
	sec:=1000
	s10:=1000*10
	m:=60*sec
	m5:=5*m
	m1:=1*m
	Sleep,%m1%
	;~ Sleep,%s10%
	;~ Sleep,%sec%
	;~ MsgBox,sdfdfg
	return
}


fileCopy_NAME_INJECTION(m_source, m_destination, m_dest_injectString_type, m_dest_ext)
{
					;~ if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUp . A_LoopFileName, "A_DD", this_ext))
						;~ if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUp . A_LoopFileName, "A_MM", this_ext))
							;~ if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUp . A_LoopFileName, "A_YYYY", this_ext))


	inJ:=""
	if(m_dest_injectString_type = "A_DD")
		inJ:="d" . A_DD
	else if(m_dest_injectString_type = "A_MM")
		inJ:="m" . A_MM
	else if(m_dest_injectString_type = "A_YYYY")
		inJ:="y" . A_YYYY
	else if(m_dest_injectString_type = "folder")
		inJ:=""
	; else if(RegExMatch(m_dest_injectString_type,"^\d+$")) ; Nummern von 1 bis 5
	;	inJ:="\" . m_dest_injectString_type

	if( strlen(inJ) < 1 && m_dest_injectString_type <> "folder" ){
		msg= ( strlen(inJ) < 1 ) `n %m_dest_injectString_type% = m_dest_injectString_type `n (%A_LineFile%~%A_LineNumber%)
		feedbackMsgBox(A_ScriptName,msg)
		return,false
	}
		;return,false
	
	if(1){

destinationDir := RegExReplace(m_destination, "[\\/][^\\/]+$")
destinationName := SubStr(m_destination , Strlen(destinationDir) + 2 )
   	; fileCopy_NAME_INJECTION(m_source, m_destination, m_dest_injectString_type, m_dest_ext)
    ; Msgbox,%m_source% %m_destination% %m_dest_injectString_type% %m_dest_ext% `n (%A_LineFile%~%A_LineNumber%)
		; FileAdrBackupDAY=%m_destination%.%inJ%.%m_dest_ext%
		destinationDirBackupDAY := destinationDir . "." . inJ 
		FileAdrBackupDAY := destinationDirBackupDAY . "\" . destinationName
		msg =
(
m_source = %m_source%
dir = %dir%
m_destination    = %m_destination%
destinationDir = %destinationDir%
destinationName = %destinationName%
destinationDirBackupDAY = %destinationDirBackupDAY%
FileAdrBackupDAY = %FileAdrBackupDAY%
m_dest_injectString_type = %m_dest_injectString_type%
m_dest_ext = %m_dest_ext%
A_UserName = %A_UserName%
%A_LineFile%~%A_LineNumber%
)

		;Msgbox,%msg% `n (%A_LineFile%~%A_LineNumber%)
		;Msgbox,FileAdrBackupDAY=%FileAdrBackupDAY% `n (%A_LineFile%~%A_LineNumber%)
		;ExitApp
		if(!FileExist(destinationDirBackupDAY)){
				;msgbox,(%A_LineFile%~%A_LineNumber%)

			fileCreateDirS(destinationDirBackupDAY,"")
			;Msgbox,destinationDirBackupDAY=%destinationDirBackupDAY% `n (%A_LineFile%~%A_LineNumber%)
		}
		if(!InStr(FileExist(destinationDirBackupDAY), "D")){
			msg=ERROR: its not Exist of is not a Folder `n %destinationDirBackupDAY% `n (%A_LineFile%~%A_LineNumber%) 
			feedbackMsgBox(A_ScriptName,msg)
		}
	}
	IfNotExist,%FileAdrBackupDAY%
	{
		FileCopy,%m_source%,%FileAdrBackupDAY%,0 ; dont overwrite = 0
		;Msgbox,FileAdrBackupDAY=%FileAdrBackupDAY% `n (%A_LineFile%~%A_LineNumber%)

		return,true
	}
	return,false
}

; isFile(Path)
; {
   ; Return !InStr(FileExist(Path), "D") 
; }

; isDir(Path)
; {
;    Return !!InStr(FileExist(Path), "D") 
; }

fileCreateDirS(dir,addSecondDir)
{
	growingPath := ""
	Loop, parse, dir, \
	{
		if(A_Index > 1)
			growingPath := growingPath . "\" . A_LoopField
		if(A_Index = 1)
		{
			growingPath := A_LoopField
			if(!FileExist(growingPath))
			{
				msg=
(
%A_ThisFunc% = A_ThisFunc
A_Index=%A_Index%: = A_Index
!FileExist(%growingPath%) 
dir=%dir% 
addSecondDir=%addSecondDir% 
%A_LineFile%~%A_LineNumber%
)
				;feedbackMsgBox(A_ScriptName,msg)
				ExitApp
			}
			if(StrLen(addSecondDir)>0)
				growingPath := growingPath . "\" . addSecondDir
			backUpFolderRoot:=growingPath
		}
		if(!FileExist(growingPath))
		{
			;~ MsgBox, %A_Index% is %growingPath%.
					;msgbox,(%A_LineFile%~%A_LineNumber%)
			FileCreateDir,%growingPath%
		}
	}
	;~ MsgBox, %growingPath%.
	backUpFolder := growingPath
	return,backUpFolderRoot
} ; END OF fileCreateDirS



#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk

#Include *i %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk