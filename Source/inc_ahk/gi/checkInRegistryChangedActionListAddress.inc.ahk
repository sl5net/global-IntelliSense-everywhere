; ActiveTitleOLD2 := activeTitleOLD
;/Â¯Â¯Â¯Â¯ checkInRegistryChangedActionListAddress Â¯Â¯ 181025104242 Â¯Â¯ 25.10.2018 10:42:42 Â¯Â¯\
; it reads: RegRead, actionListNewTemp_RAW, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; SetTimer,checkInRegistryChangedActionListAddress,2000 ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList
; called from \Window.ahk > WinChanged( :
; SetTimer,checkInRegistryChangedActionListAddress,on
checkInRegistryChangedActionListAddress:
    if(0 && InStr(A_ComputerName,"SL5"))
        Speak(A_ThisLabel, "PROD" )  ;  (DEV, TEST, STAGING, PROD),
    ; return ; it seems we need this function ????? 18-12-27_20-50

if(g_config.actionList.onlyThisList){
    actionList := g_config.actionList.onlyThisList
    toolTipGui(actionList " (" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" , x:=0, y:=0, "_" ,A_LineNumber,"Yellow")


    gosub actionListOLD_actionList
    return
}


    ;toolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    if(g_doListBoxFollowMouse){
        if(0 && InStr(A_ComputerName,"SL5"))
            ToolTip9sec( "g_doListBoxFollowMouse`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"1,1,20 )
        ; soundBeep,2000
        return
    }
    if(g_itsProbablyArecentUpdate){
        if(0 && InStr(A_ComputerName,"SL5"))
            ToolTip9sec( "g_itsProbablyArecentUpdate`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",1,1,20 )
        ; soundBeep,4000
        return
    }

    if( milliesTried_getNewListFromRegistry >= 5000){
        milliesTried_getNewListFromRegistry := 0
        g_itsProbablyArecentUpdate := true ; may the registry not changing anymore. this is the last try
        ; msgbox,% "(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        if(1 && InStr(A_ComputerName,"SL5"))
            ToolTip9sec( "milliesTried_getNewListFromRegistry`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",1,1,20 )
        return
    }



    if(0 && InStr(A_ComputerName,"SL5"))
        SoundbeepString2Sound("a")


    ; todo: simplify: g_stop_list_change || g_config["list"]["change"]["stopRexExTitle"]=="."
    ; ^- delete one of them 19-01-17_21-16
    ; RegRead, g_stop_list_change, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change ; todo: 02.03.2018 12:55 18-03-02_12-55
    ; if(g_stop_list_change == 2 ){ ; || g_config["list"]["change"]["stopRexExTitle"]=="."){ ; inside checkInRegistryChangedActionListAddress:
    if(g_config["list"]["change"]["stopRexExTitle"]=="."){ ; inside checkInRegistryChangedActionListAddress:
        g_is_correct_list_found := true

        temp := g_config["list"]["change"]["stopRexExTitle"]
        tip = stopRexExTitle is >%temp%< %actionList%
        ToolTip5sec(tip " (" A_LineNumber " " lineFileName . " )",1,-33 )
        if(0 && InStr(A_ComputerName,"SL5"))
            Speak("Return in " A_LineNumber, "PROD" )
        else
            Speak("Return in " A_LineNumber)

        ; postFixGenerated := "._Generated.ahk"
        ; actionListPostFix  := SubStr(rtrim(actionList), - StrLen(postFixGenerated) + 1 ) ; That works I've tested it 01.11.2018 14:59
        ; itsAGeneratedList := ( postFixGenerated == actionListPostFix )
        ; if(itsAGeneratedList){ ; todo: becouse we dont know if there was an update
        ;     ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))
        ; }


        return
    }
    ; else if(g_stop_list_change == 1)
    ;    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change, 2



    global g_SingleMatch
    global g_FLAGmsgbox



    SetTitleMatchMode,2
    if( g_actionList_UsedByUser_since_midnight[g_actionListID] ){
        If(WinExist("actionListChangedInRegistry") )
            winClose,actionListChangedInRegistry
        winWaitclose,actionListChangedInRegistry, , 2
        g_FLAGmsgbox := false
    }else if( actionListSize > g_minBytesNeedetToAskBevoreChangingActionList)
        If(WinExist("actionListChangedInRegistry") ){
                g_FLAGmsgbox := true
                Speak("Return in " A_LineNumber)
                if(0 && InStr(A_ComputerName,"SL5"))
                    Speak("Return in " A_LineNumber, "PROD" )
                return ; no update jet
        }



    if(1){
        ; not needet to check, but maybe mmore pretty coding ?? 20.03.2018 18:34 TODO
        ; its more pretty to have a updated text inside this box, therfore close it first. 20.03.2018 18:35
        name := "actionListChangedInRegistry ahk_class #32770"
        while(WinExist(name) && A_Index < 9){
            WinClose,% name
            winWaitclose,% name,,1
        }
        while(WinExist(name) && A_Index < 9){
            WinKill,% name
            winWaitclose,% name,,1
        }
        If(WinExist("actionListChangedInRegistry") ){
            tooltip,Oops  `n should never happen BUG `n was not able to close actionListChangedInRegistry `n`n  ==> reload in 9Seconds (%A_LineFile%~%A_LineNumber%) 20.03.2018 18:54
            sleep,9000
            ; reload
            RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; in checkInRegistryChangedActionListAddress
            if(0 && InStr(A_ComputerName,"SL5"))
                Speak("Return in " A_LineNumber, "PROD" )
            else
                Speak("Return in " A_LineNumber)
            return
        }
    }



    RegRead, actionListNewTemp_RAW, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList

    actionListNewTemp_withoutExt := actionListNewTemp_RAW
    if( SubStr( actionListNewTemp_withoutExt , -3 ) == ".ahk" ){
        ; dirty bugFix
        actionListNewTemp_withoutExt := SubStr( actionListNewTemp_withoutExt,1 , -4 )
        setRegistry_actionList( actionListNewTemp_withoutExt )
        if(0 && InStr(A_ComputerName,"SL5")){
            m := "dirty bugfix. It is more common to specify the list without extension "
            Speak(m " in " A_LineNumber , "PROD")
            ToolTip9sec(m "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
            lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,m)
            ; msgbox,% m " " actionListNewTemp_withoutExt "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        }
    }



    if(!timeFirstTry_getNewListFromRegistry)
        timeFirstTry_getNewListFromRegistry := A_TickCount
    milliesTried_getNewListFromRegistry := A_TickCount - timeFirstTry_getNewListFromRegistry



    actionListFileName := RegExReplace(actionListNewTemp_withoutExt,".*\\")
    actionListFileName := RegExReplace(actionListFileName,"(\w+).*","$1")
    ; Speak("registry read: " ceil(milliesTried_getNewListFromRegistry / 1000) " Sekunden: " actionListFileName " in Line " A_LineNumber)
    ;sleep,1000



; if(actionList == actionList_isNotAProject){ ; it happens: 23.10.2018 10:33 but maybe its wrong... so chekc the next
;    ; msgBox,% "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
;    Speak("return: is Not A Project")
    ; return
; }



    isRegListChanged := (actionListNewTemp_withoutExt && actionList <> actionListNewTemp_withoutExt)
    ; if(!isRegListChanged || !actionListNewTemp_withoutExt || A_TimeIdle < 1333){
    if(!isRegListChanged || !actionListNewTemp_withoutExt ){
        ; happens if already correct loadet
        if(1 && InStr(A_ComputerName,"SL5"))
            Speak("Return in " A_LineNumber ": probably correct loadet. wahrscheinlich richtig geladen.")
            ; Speak("Return in " A_LineNumber " probably correct loadet", "PROD" )
        return
    }



    is_AL_without_fileName := ( InStr( actionListNewTemp_withoutExt, "\.ahk") )
     if( is_AL_without_fileName ){ ; without file name 25.10.2018 11:33
        ; Msgbox,InStr( actionListNewTemp_withoutExt, "\.ahk") ==> RETURN `n (%A_LineFile%~%A_LineNumber%)
        log =
        (
        Oops: InStr( AL, "\.ahk")
        This may happen for example with Java applications. JetBrains IDE Search Window or so.
        A_ThisFunc = %A_ThisFunc%
        )
        log .= "`n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
    }



    ; actionList := StrReplace(actionList, ".ahk._Generated.ahk._Generated.ahk", ".ahk._Generated.ahk") ; clean strange wordlists 25.10.2018 20:03
    actionListNewTemp_withoutExt := StrReplace(actionListNewTemp_withoutExt, ".ahk._Generated.ahk._Generated.ahk", ".ahk._Generated.ahk") ; clean strange wordlists 25.10.2018 20:03



; GitKraken ahk_class Chrome_WidgetWin_1 ; mouseWindowTitle=0x236113c  ;
;  WinMove,GitKraken ahk_class Chrome_WidgetWin_1 ,, 2264,218, 1900,925

; actionListNEW := "..\
; \..\actionLists\actionList_db
;  (WinChanged checkInRegistryChangedActionListAddress.inc.ahk:224)
; \..\actionLists\checkInRegistryChangedActionListAddress_inc (WinChanged checkInRegistryChangedActionListAddress.inc.ahk:224)

/*
checkInRegistryChangedActionListAddress_inc
( checkInRegistryChangedActionListAddress.inc.ahk:213)
checkInRegistryChangedActionListAddress_inc
( checkInRegistryChangedActionListAddress.inc.ahk:213)
*/
; actionListNewTemp_withoutExt

    ; global actionListDirBase
    if(false && !actionListDirBase){
         Msgbox,% ":( ERROR: !actionListDirBase"  "`n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
         exitApp
    }
    ; actionListNewTemp_withoutExt := actionListDirBase "\" actionListNewTemp_withoutExt
    if(0 && InStr(A_ComputerName,"SL5")){
        ; clipboard := actionListNewTemp_withoutExt " (" RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        ToolTip4sec( "clipboard := actionList`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
    }
    ;/¯¯¯¯ !fileExist ¯¯ 190211093902 ¯¯ 11.02.2019 09:39:02 ¯¯\
    if(!fileExist(actionListNewTemp_withoutExt ".ahk")){ ; addet 01.11.2018 10:48
        m := "not exist."
        if(0 && InStr(A_ComputerName,"SL5")){
            Speak(m "Return in " A_LineNumber " Registry is empty", "PROD")
            c =
            (
            /*
            actionListNewTemp_RAW = %actionListNewTemp_RAW%
            actionListDirBase = %actionListDirBase%
            actionListNewTemp_withoutExt = %actionListNewTemp_withoutExt%
            )
            c .= "`n`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
            c .= "`n*/"
            toolTip9sec(c)
            clipboard := c
            pause
            sleep,3000
            /*
            checkInRegistryChangedActionListAddress_inc
            ( checkInRegistryChangedActionListAddress.inc.ahk:224)
            */
            ; msgbox,%actionListNewTemp_withoutExt% `n(%A_LineFile%~%A_LineNumber%)
        }
        if(actionListNewTemp_RAW){
            if(1 && InStr(A_ComputerName,"SL5"))
                Speak(m "Return in " A_LineNumber ". " actionListNewTemp_RAW, "PROD")
            ;toolTip2sec(actionListNewTemp_RAW "`n`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") )
            ;clipboard := actionListNewTemp_withoutExt
            ;Sleep,1000
        }else
            Speak(m "Return in " A_LineNumber " Registry is empty", "PROD")

        if(substr(actionListNewTemp_withoutExt,-strlen("isNotAProject")) <> "\isNotAProject" ){
            isNotYet_actionList := actionListNewTemp_withoutExt
            setRegistry_actionList( isNotYet_actionList, "isNotYet_actionList250" )   ; RegWrite , RegSave , Registry
            setRegistry_actionList( isNotYet_actionList, "isNotYet_actionList" )   ; RegWrite , RegSave , Registry
        }


        actionListNewTemp_withoutExt := actionList_isNotAProject_withoutExt ; as long as nothing else would be found
        ; msgbox,%actionListNewTemp_withoutExt% `n(%A_LineFile%~%A_LineNumber%)
        if(0 && InStr(A_ComputerName,"SL5")){
            Speak(m "Return in " A_LineNumber " Registry is empty", "PROD")
            sleep,1000
        }
    } ;\____ !fileExist __ 190211093916 __ 11.02.2019 09:39:16 __/

    if(!fileExist(actionListNewTemp_withoutExt ".ahk")){ ; addet 26.4.2018 12:58 becouse of mistourios things
        m =
        (
        actionListNewTemp_withoutExt = %actionListNewTemp_withoutExt%
        )
        ;
        ; msgbox,% m  " `n`n AL NOT exist(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
        if(1 && InStr(A_ComputerName,"SL5"))
            ToolTip2sec("pls Fix:  ...multi_clone writes sometimles AL with extension into registry. ..._Generated.ahk ..." A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
        actionListNewTemp_withoutExt := get_Action_Lists_without_Extension_and_send_warning(actionListNewTemp_withoutExt)
        if( !fileExist(actionListNewTemp_withoutExt ".ahk") ){
            m =
            (
            NOT fileExist(%actionListNewTemp_withoutExt% ".ahk"
            activeTitle = %activeTitle%
            activeTitleOLD = %activeTitleOLD%



global-IntelliSense-everywhere-Nightly-Build [G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build] - ...\Source\gi-everywhere.ahk [global-IntelliSense-everywhere-Nightly-Build] - IntelliJ IDEA (Administrator)
            )
            Speak("Return in " A_LineNumber " file not exist")
            if(0 && InStr(A_ComputerName,"SL5"))
                Speak("Return in " A_LineNumber " file not exist", "PROD" )



            clipboard := activeTitle
            if(1 && InStr(A_ComputerName,"SL5"))
                MsgBox,% activeTitle "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
            EnableKeyboardHotKeys()
            EnableWinHook()
            if(1 && InStr(A_ComputerName,"SL5"))
                Speak("Return in " A_LineNumber , "PROD" )
            return
        }
        Speak("Return in " A_LineNumber)
        if(1 && InStr(A_ComputerName,"SL5"))
            Speak("Return in " A_LineNumber, "PROD" )
        return
        ; ToolTip2sec(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
    }


;/¯¯¯¯ plausibility ¯¯ 190210175751 ¯¯ 10.02.2019 17:57:51 ¯¯\
/*
actionListNewTemp_RAW = Gmail_Label_in_fax_sl5net_Google_Chrome
actionListNEW =
activeClass =
SunAwtDialog = WinGetClass, activeClass, A

:318 checkInRegistryChangedActionListAddress.inc.ahk
*/
;plausibility tests
if(!instr(actionListNewTemp_RAW,"\")){
; g_doSound := TRUE
Speak(" " A_LineNumber, "PROD" )
WinGetClass, nowWinGetClass, A
feedback =
(
/*
actionListNewTemp_RAW = %actionListNewTemp_RAW%
actionListNEW = %actionListNEW%
activeClass = %activeClass%
%nowWinGetClass% = WinGetClass, activeClass, A
)
feedback .= "`n`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
feedback .= "`n*/"
toolTip9sec(feedback)
; clipboard := feedback
; toolTipGui(feedback  ,,-250,"|_",A_LineNumber,"Red")  ; x will be offset if y is symbolic

Sleep,3000
;pause


}
;\____ plausibility __ 190210175755 __ 10.02.2019 17:57:55 __/



    RegRead, stop_list_change, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, stop_list_change ; todo: 02.03.2018 12:55 18-03-02_12-55
    if(stop_list_change){
        msg = action list wurde gesetzt und soll nicht geÃ¤ndert werden.
        ; aber eventuell neu geladen.
        ToolTip3sec(msg "`n" A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This,400,100,9)
    }
; ; SetTimer,checkInRegistryChangedActionListAddress,off ; RegRead, actionListActive, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, actionList



    if(g_config["list"]["change"]["stopRexExTitle"]){
        regExPattern := g_config["list"]["change"]["stopRexExTitle"]
        ; regExPattern := g_config\["list"\]\["change"\]\["stopRexExTitle"\]\s*:=\s*(\w+)
        foundPos := RegExMatch( actionListNewTemp_withoutExt, regExPattern ,  matchs )
        if(foundPos)
            return



    }

    ; takes a little time to read data von database. 19.10.2018 12:21
	if(A_TickCount > 4000 && !g_actionList_UsedByUser_since_midnight[g_actionListID] && g_doAskBevoreChangingActionList && actionListSize > g_minBytesNeedetToAskBevoreChangingActionList){
        AHKcodeMsgBox := "#" . "NoTrayIcon `n "
        ; temp = msgbox,,actionListChangedInRegistry, Would you use new list now? ``n (new ``n Say goodbye to? (%actionListSize% bytes > %g_minBytesNeedetToAskBevoreChangingActionList%) ``n  %actionList% ``n exitApp
        ; %actionList%
        temp =
        (
        ; msgbox,262176,actionListChangedInRegistry, Would you use new list now? ``n ``n Say goodbye to? (%actionListSize% bytes > %g_minBytesNeedetToAskBevoreChangingActionList%) ``n  That msgBox works like change list stopper ``n  ``n  F1=WebSearch
        msgbox,262176,actionListChangedInRegistry, Would you use new list now? ``n ``n Say goodbye to  ``n  %actionList% ``n ? ``n  That msgBox works like change list stopper ``n  (%actionListSize% bytes > %g_minBytesNeedetToAskBevoreChangingActionList%) ``n  ``n  F1=WebSearch
        #ifwinactive,actionListChangedInRegistry
        f1::
        run,https://www.google.de/search?q=actionListChangedInRegistry global-IntelliSense-everywhere
        WinWaitActive,actionListChangedInRegistry global-IntelliSense-everywhere,,3
        sleep,1000
        IfWinActive,
        {
            sleep,60
            send,^f actionListChangedInRegistry
        }
        if IsFunc("Speak")
            Speak("Return in " A_LineNumber)
        return
        exitApp
        )
		AHKcodeMsgBox .= temp
        if(g_FLAGmsgbox){
            g_FLAGmsgbox := false ; just clicked msgboxWindow
        }else{
            DynaRun(AHKcodeMsgBox) ; wait for user decision
            tooltip,WinWait actionListChangedInRegistry  `n (%A_LineFile%~%A_LineNumber%)
            ;WinWait,actionListChangedInRegistry
            WinWait,actionListChangedInRegistry,,1
            ;msgbox,18-03-02_17-42 %AHKcodeMsgBox%
            tooltip,
            if(1 && InStr(A_ComputerName,"SL5"))
                Speak("Return in " A_LineNumber , "PROD" )
            return ; no update jet
        }
    }



    actionListNewTemp_withoutExt := RegExReplace(actionListNewTemp_withoutExt, "i)(\.ahk\b)+$") ; clean strange wordlists ectension 27.10.2018 23:47



   if( !FileExist(actionListNewTemp_withoutExt ".ahk") ){
        msg := "actionList >"actionListNewTemp_withoutExt ".ahk< `n = actionListNewTemp_withoutExt (=clipBoard) `n actionList NOT exist"
        msg := ":( ERROR: " msg "`n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        if(1 && InStr(A_ComputerName,"SL5")){
            ; clipBoard := removesSymbolicLinksFromFileAdress(A_ScriptDir "\" actionListNewTemp_withoutExt ".ahk")
            ToolTip3sec(msg "`n" A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This,1,1)
             Msgbox,% ":( ERROR: " msg "`n (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        }



        ; feedbackMsgBox(msg,msg,1,1,6)
        ; actionList := globalActionListDir   "\_globalActionListsGenerated\isNotAProject.ahk"
        actionListNewTemp_withoutExt := actionList_isNotAProject_withoutExt ; as long as nothing else would be found
        ;actionListNewTemp := actionList_isNotAProject ; as long as nothing else would be found



        ;sleep,1000
        ; actionListOLD := "" ; probably programmer want a reloud soon. quck an dirty ???
        ; return
    }



; returns the position of an occurrence of the string Needle in the string Haystack. Position 1 is the first character; this is because 0 is synonymous with "false",
   if( FileExist(actionListNewTemp_withoutExt ".ahk._Generated.ahk") && !InStr(actionListNewTemp_withoutExt, "._Generated.ahk") ){

        actionList := actionListNewTemp_withoutExt ".ahk._Generated.ahk" ; that's probably did wrong place. But is a working bugfix. fallback. 25.10.2018 19:48
    }else
        actionList := actionListNewTemp_withoutExt ".ahk"


if(0 && InStr(A_ComputerName,"SL5")
&& InStr(actionList,"._Generated.ahk._Generated.ahk")){
             ToolTip5sec(";] Oopsfound ._Generated.ahk._Generated.ahk => ._Generated.ahk `n`n" actionList "`n" A_LineNumber RegExReplace(A_LineFile,".*\\"), 1,1 )



    actionList := StrReplace(actionList, ".ahk._Generated.ahk._Generated.ahk", ".ahk._Generated.ahk") ; clean strange wordlists 25.10.2018 20:03
        }



    ; tool too tool07.11.2018 23:07.11.2018 23:07.11.2018 ddddÃ¶Ã¶07.11.2018 23:l LLL 07.11.2018 23:02lll07.11.2018 23:0207.11.2018 23:03



	; millis_since_midnight := JEE_millis_since_midnight(vOpt:="") ; <=== more correct then  := A_Hour*3600000+A_Min*60000+A_Sec*1000+A_MSec
	millis_since_midnight := A_TickCount  ; <=== more correct then  := A_Hour*3600000+A_Min*60000+A_Sec*1000+A_MSec
	RegRead, updatedTimeStamp_millisSinceMidnight, HKEY_CURRENT_USER, SOFTWARE\sl5net\gi, updatedTimeStamp_millisSinceMidnight  ; RegWrite , RegSave , Registry
	milliSinceLastRegistryUpdate := millis_since_midnight - updatedTimeStamp_millisSinceMidnight
	milliSinceLastRegistryUpdate_sec := round((millis_since_midnight - updatedTimeStamp_millisSinceMidnight)/1000)



    g_is_correct_list_found :=  true
    g_itsProbablyArecentUpdate := (milliSinceLastRegistryUpdate < 2000 )  ; probalby correct



        m =
        (
        milliSinceLastRegistryUpdate = %milliSinceLastRegistryUpdate%
        g_itsProbablyArecentUpdate = %g_itsProbablyArecentUpdate%
        %actionListOLD% ?= %actionList%
        )
    ; toolTip2sec(m "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
    ;msgbox,% m "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"



    if(0 && actionListOLD == actionList){ ; thats fixed that the list is lcoaed always to early with ClearAllVars
        ; Speak("" A_LineNumber ": List not changed: " actionListFileName ". Return. " RegExReplace(A_LineFile,".*\\"))
        EnableKeyboardHotKeys()
        EnableWinHook()
        msgbox,% m "`n(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
        return
    }



    ; g_is_correct_list_found :=  (g_itsProbablyArecentUpdate || actionListOLD <> actionList)
        ; timeFirstTry_getNewListFromRegistry := JEE_millis_since_midnight(vOpt:="")



    ; Number_of_attempts_to_pick_new_list_from_Registry := 0
    if(g_itsProbablyArecentUpdate)
        SetTimer,checkInRegistryChangedActionListAddress,off ; will set on again inside WinChanged( 31.10.2018 18:52



    if(0 && actionListOLD <> actionList && !instr(actionList,"\isNotAProject" ) && speakedLastActionList <> actionList ){
        Speak(actionListFileName " found ", "PROD" )  ;  (DEV, TEST, STAGING, PROD),
    if(0 && InStr(A_ComputerName,"SL5"))
        Speak(actionListFileName " found ", "PROD" )  ;  (DEV, TEST, STAGING, PROD),
    speakedLastActionList := actionList



    if( SubStr( actionList , -3 ) <> ".ahk" ) ; 06.03.2018 13:09
        actionList_withExt := actionList ".ahk"
    else
        actionList_withExt := actionList



        ; ApplyChanges() ; It works also without this line. maybe the changes/first build is faster loadet 05.11.2018 13:37



        if(0 && InStr(A_ComputerName,"SL5") && actionListFileName == "AutoHotkey_Community"){



            ; g_Word := "___"
            ; clipboard := actionListFileName
            newFontSize := recreateListBox_IfFontSizeChangedAndTimeIdle(12, 14)
            ; ShowListBox(g_ListBoxX,g_ListBoxY)
            ; InitializeListBox() ; --> Error same variable I can use twice
            ; reload_IfNotExist_ListBoxGui()
            ; ApplyChanges()

; tool toolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )

        if IsFunc("Speak")
            Speak("ShowListBox", "PROD" )  ;  (DEV, TEST, STAGING, PROD),



            tooltip,% " actionListFileName (" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
        }



    }

actionListOLD_actionList:

    actionListOLD := actionList
    ; g_actionListID := getActionListID(sql_template_dir, actionList) ; 24.03.2018 23:02

    if(!g_actionListID := getActionListID(g_config["sql"]["template"]["dir"], actionList)){ ; 24.03.2018 23:02
		if(0 && InStr(A_ComputerName,"SL5")) ; prob no error. whey not
			Speak("actionListID Not Exist!", "PROD" )  ;  (DEV, TEST, STAGING, PROD),
        ; happen for eg if i calling the autohotkey webseite. 19-01-09_19-31
    }



    ;tip=%actionList% (%actionListSize%) `n%actionListOLD% (%actionListLastSize%) = old `n ( %A_LineFile%~%A_LineNumber% )
    ;ToolTip4sec(tip)
    ;msgbox,%actionList%  (%A_LineFile%~%A_LineNumber%)

    ;/Â¯Â¯Â¯Â¯ very_happy Â¯Â¯ 181024144052 Â¯Â¯ 24.10.2018 14:40:52 Â¯Â¯\
InactivateAll_Suspend_ListBox_WinHook() ; addet 24.10.2018 14:16

    ; This is to blank all vars related to matches, ListBox and (optionally) word
   ; ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),True) ; 24.10.2018 14:16 may help listBoxGUI NEVER HANGS TODO:check it
    ; I think it might be handy if the search word is already on the next list. Therefore I commented this line out today 24.10.2018 14:48
    ;\____ very_happy __ 181024144106 __ 24.10.2018 14:41:06 __/


; To Tooltip Tooltip

; ..\actionLists\
if(g_config.infoBox[1]["showName"]){

; Tooo too

    ; DetectHiddenWindows,On
    ; settitlematchmode,1
    title := A_LineNumber
    title2 := A_LineNumber
    needle := title " ahk_class AutoHotkeyGUI" ; mouseWindowTitle=0x7d1d2c  ;
    tip := ""
    tip .= "SQLs:>" g_config.sql.template.maxNnumberUsedTemplates "<`n"
    tip .= "al:>" substr(actionList,16) "< `n"
    tip .= "db:>" g_actionListDBfileAdress "< `n"
    tip .= "t:>" g_Active_Title "<" ; some title use spaces inside ; no space to prevent lineBreaks
    tipLast := a_hour ":" a_min ":" a_sec str_repeat(".", 150)
    ; tipLast := str_repeat(".", 5) " " A_DDD A_DD "." A_MM " " a_hour ":" a_min ":" a_sec str_repeat(".", 150)
    IfWinNotExist,% needle
    {
        tip := "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")`n`" tip "`n"
        tip .= tipLast " drag+drop "
        toolTipGui(tip, x:=-strlen(actionList)*8, y:=0, g_config.infoBox[1]["showName"] ,title,"Green")
    } else{
    	winGetPos,x,y,,,% needle
    	; winmove,% needle,% x, % y
    	x += 80
    	y += 15
        tip := "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")`n`" tip "`n"
        tip .= tipLast
        tip := RegExReplace(tip, "[\n\r]+","`n")
        toolTipGui(tip, x, y, ,title2,"Black")
    }
}

; Tooltip Tooltip

if(0 && InStr(A_ComputerName,"SL5")) ; prob no error. whey not
	Speak("Now Read actionList: " actionList, "PROD" )  ;  (DEV, TEST, STAGING, PROD),
ParseWordsCount := ReadActionList(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))

        ;if(g_FLAGmsgbox == 0)
RecomputeMatches(A_ThisFunc A_ThisLabel ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")) ; in checkInRegistryChangedActionListAddress

    ; gosub onLink2actionListChangedInRegistry ; ToolTip3sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)

    ; SetTimer,checkInRegistryChangedActionListAddress,off ; will set on again inside WinChanged( 31.10.2018 18:52
    ; SetTimer,checkInRegistryChangedActionListAddress,off ; will set on again inside WinChanged( 31.10.2018 18:52
    ; SoundbeepString2Sound("zzz")
    ;Speak(actionListFileName " in " ceil(milliesTried_getNewListFromRegistry / 1000) " Sekunden gefunden.")

    ; Speak(actionListFileName " updated for " milliSinceLastRegistryUpdate_sec " Sekunden.") ; <====== interesting for developwers

EnableKeyboardHotKeys() ; seems needet 01.11.2018 19:04
InitializeHotKeys()
RecomputeMatches(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"))

m =
            (
            g_itsProbablyArecentUpdate = %g_itsProbablyArecentUpdate%
            g_is_correct_list_found = %g_is_correct_list_found%

            milliSinceLastRegistryUpdate = %milliSinceLastRegistryUpdate%
            milliesTried_getNewListFromRegistry = %milliesTried_getNewListFromRegistry%

            timeFirstTry_getNewListFromRegistry = %timeFirstTry_getNewListFromRegistry%

            %actionList%
            )
        ; toolTip9sec(m "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
        ; toolTip, % m "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
return
;\____ checkInRegistryChangedActionListAddress __ 181025104318 __ 25.10.2018 10:43:18 __/
