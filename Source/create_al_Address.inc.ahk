;/¯¯¯¯ create_al_Address ¯¯ 181023091625 ¯¯ 23.10.2018 09:16:25 ¯¯\
/*
	will fetched before call:
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change, % ""

	will fetched inside this function:
	WinGetClass, activeClass, % activeTitleREAL

	WinGetActiveTitle, activeTitleREAL
	activeTitle := activeTitleREAL ; this will manipulated and reused in many other files and includes 12.08.2017 00:11
*/
create_al_Address(actionList ,activeTitle,activeClass,controlName, stop_list_change  , actionListDirBase ){

toolTipGui_yOffsetNr := 0

; toolTipGui("(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Purple",,1)  

if(lineNumberFrom := dontChangeRoute(actionList,activeTitle,activeClass,controlName,stop_list_change)
|| lineNumberFrom := create_al_Address_getParametersCheckErrorMsg(actionList,activeTitle,activeClass,controlName,stop_list_change,actionListDirBase ))
    return lineNumberFrom

alTitle := regexreplace(activeTitle, " TOP "), alClass := activeClass, alControl := controlName
; alTitle := 1, alClass := 2, alControl := 3
alClass:=RegExReplace(alClass,"\W+","_") , alTitle:=RegExReplace(alTitle,"\W+","_") ,  alControl:=RegExReplace(alControl,"\W+","_")

;/¯¯¯¯ experimental ¯¯ 190219183643 ¯¯ 19.02.2019 18:36:43 ¯¯\
; actionListNEW := "" , actionListNEW .= alTitle , actionListNEW .= (alControl) ? "-" alControl : ""
;\____ experimental __ 190219183646 __ 19.02.2019 18:36:46 __/
actionListNEW := "" , actionListNEW .= alTitle
; actionListNEW_experimental := alClass "-" alTitle "-" alControl

; toolTipGui("alTitle := activeTitle, alClass := activeClass, alControl := controlName " ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Green",,1)  
; toolTipGui("a: " actionListNEW " . . . . . . . . . . . . . " ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Green",,1)  

; tooltip,% A_ScriptDir " token:asdfasdfasdfSTTTlolololo"
; clipboard := A_ScriptDir " 19-03-18_00-15" ; yes its Source folder 19-03-18_00-21

; # Include %A_ScriptDir% ; at the beginning of the script https://www.autohotkey.com/boards/viewtopic.php?f=76&t=62795
#Include keyWaitReleased.ahk ; \Source\keyWaitReleased.ahk
; # Include *i keyWaitReleased.ahk ; \Source\keyWaitReleased.ahk

; toolTipGui("c: " alClass " . . . . . . . . . . . . . " ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Green",,1)
alClass := activeClassManipulation(activeClass, activeTitle)
;	activeClass := "_globalActionListsGenerated"
; toolTipGui("c: " alClass " . . . . . . . . . . . . . " ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Green",,1)

actionListFilterPathNEWdir := actionListDirBase "\" alClass "\"
actionListFilterPathNEW := actionListFilterPathNEWdir "al-route.inc.ahk"

; alTitle := "_global" ; used till 07.10.2018 10:12 18-10-07_10-12
; alTitle := "isNotAProject" ; isNotAProject.ahk ; todo: not very pretty silly. 28.10.2018 11:33
	
;/¯¯¯¯ missionCompleted ¯¯ 181024170958 ¯¯ 24.10.2018 17:09:58 ¯¯\
; inside while(true)
SetTitleMatchMode,1
temp :="created token=17-08-10_16-17" ; ahk_class #32770"
if(RegExMatch(activeTitle, temp )){
        ;/¯¯¯¯ try_faster_reload_if_created ¯¯ 181025152605 ¯¯ 25.10.2018 15:26:05 ¯¯\
        ; success. that seems working nice. takes about 2 seconds 25.10.2018 15:35
        ; I hope the with this method is reloaded after creating a new list (much faster). 25.10.2018 15:25
        ;\____ try_faster_reload_if_created __ 181025153223 __ 25.10.2018 15:32:23 __/
    	WinClose, % temp
        ; msgbox,closed ???
        ; box has mission completed. it just changed a short time the actionList. thats all 13.05.2018 19:01
        ; created_token_17-08-10_16-17
        ;tooltip, WinWaitNotActive,actionListChangedInRegistry  `n (%A_LineFile%~%A_LineNumber%)
	WinWaitNotActive, % temp
	tooltip,
	msg:="mission completed. your menu should change. `n use it in seconds (__ ...)" ; thats all 13.05.2018 19:01
	msg.= "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	MsgBox , 64 , mission completed, % msg, 3 ; project created
	return "mission completed" ; continue ;
}
;\____ missionCompleted __ 181024170947 __ 24.10.2018 17:09:47 __/

; toolTipGui("a: " actionListNEW "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Purple",,1)

; ; toolTipGui("alTitle := activeTitle, alClass := activeClass, alControl := controlName " ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Green",,1)
actionListDir := actionListDirBase "\" alClass
if(!actionListDirBase)
    MsgBox,% "ups !actionListDir (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
if(!actionListDir)
    MsgBox,% "ups !actionListDir (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"


actionListFilterPath    := actionListDirBase "\" "al-route-header.inc.ahk"
actionListFilterPathNEW := actionListDirBase "\" activeClass "\" "al-route.inc.ahk"

;/¯¯¯¯ run createIfFileNotExist_al_route_InNewDir ¯¯ 190217154816 ¯¯ 17.02.2019 15:48:16 ¯¯\
; make sure we get no errors by including %actionListFilterPath% ... create actionList inside className folder
fileExist_class_actionListFilter  := fileExist(actionListFilterPathNEW)
ahkCode1 := getAhkCodeInsideFile(actionListDir , actionListFilterPathNEW  )
; todo: creating always is useless. please create only if user want create a actionList explizit
; may only do it if _create_own_project.flag is inside....
fileAddress_flag := actionListDir "\_create_own_project.flag"
if(FileExist(fileAddress_flag) && !InStr(FileExist(fileAddress_flag), "D"))
	createIfFileNotExist_al_route_InNewDir( actionListDir , actionListFilterPathNEW , ahkCode1)
;\____ run createIfFileNotExist_al_route_InNewDir __ 190219160631 __ 19.02.2019 16:06:31 __/

 if(!actionListDirBase){
      actionListDirBase := "..\actionLists"
  }


;/¯¯¯¯ actionListFilterPath2Abs ¯¯ 190219164334 ¯¯ 19.02.2019 16:43:34 ¯¯\
actionListFilterPath := actionListDirBase "\" "al-route-header.inc.ahk"
if(1){ ; absolute path
    ; will later used in dynahk: actionListFilterPath2Abs
	actionListFilterPath2 := actionListDir "\" "al-route.inc.ahk"

 ; toolTipGui(fileExist(actionListFilterPath2) ":" actionListFilterPath2 ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Purple",,1)

; ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )

	if(substr(actionListFilterPath2,1,1) == "."){
	    actionListFilterPath2Abs := A_ScriptDir "\" actionListFilterPath2
	    ; StringReplace, actionListFilterPath2Abs, actionListFilterPath2Abs, \.\ , \
	}else{
	    actionListFilterPath2Abs := actionListFilterPath2
	}
    actionListFilterPath2Abs := removesSymbolicLinksFromFileAdress(actionListFilterPath2Abs)

}else
	actionListFilterPath2 :=  actionListDirBase . activeClass . "\" "al-route.inc.ahk" ; todo: doesent work :( 28.03.2017 20:20 17-03-28_20-20
;\____ actionListFilterPath2Abs __ 190219164339 __ 19.02.2019 16:43:39 __/


#Include load_al-route_as_dynahk.inc.ahk

; toolTipGui("reg: " actionListReg "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" ,,80*(toolTipGui_yOffsetNr++),"|¯",A_LineNumber,"Green",,1)


#Include create_al_Address-result_plausibility_check.inc.ahk ; al_result_plausibility_check(actionListNEW)

    return A_LineNumber " endOfFunction" ;
}
;\____ create_al_Address __ 190219164510 __ 19.02.2019 16:45:10 __/


#Include .\..\actionLists\al-route-functions.inc.ahk
#Include create_al_Address-functions.inc.ahk
; #Include %A_ScriptDir%\inc_ahk\toolTipGui.inc.ahk ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=62078&p=263824#p263824
#Include inc_ahk\toolTipGui.inc.ahk ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=62078&p=263824#p263824
#Include .\..\actionLists\activeClassManipulation.inc.ahk

#Include stopIfWinTitleExist_giListSELECT.inc.ahk ; Source\stopIfWinTitleExist_giListSELECT.inc.ahk
