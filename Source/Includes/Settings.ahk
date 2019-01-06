; GUI for configuration
; by HugoV / Maniac



LaunchSettings:
    if (g_InSettings == true)
    {
       return
    }
                 lll( A_ThisFunc ":" A_LineNumber , A_LineFile ," InactivateAll_Suspend_ListBox_WinHook() 17-08-04_16-19b")
                 fileAddress := A_ScriptDir . "\log\" . A_ScriptName . ".log.txt"
                 if(FileExist(fileAddress) && !InStr(FileExist(fileAddress), "D") )
                    run,% fileAddress
                else{
                    msg=:( %fileAddress% NOT exist `n (%A_LineFile%~%A_LineNumber%)
                    Msgbox,%msg%`n
                }



    msg=LaunchSettings ??? really ??? next is InactivateAll_Suspend_ListBox_WinHook() `n (%A_LineFile%~%A_LineNumber%)
     Msgbox,%msg%`n
    InactivateAll_Suspend_ListBox_WinHook()



    Menu, Tray, Disable, Settings
    g_InSettings := true
    ClearAllVars(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"),True)
    Menu_OldLearnCount := prefs_LearnCount
    ; initialize this to make sure the object exists
    Menu_ChangedPrefs := Object()
    ConstructGui()
    ; Call "HandleMessage" when script receives WM_SETCURSOR message
    OnMessage(WM_SETCURSOR, "HandleSettingsMessage")
    ; Call "HandleMessage" when script receives WM_MOUSEMOVE message
    OnMessage(WM_MOUSEMOVE, "HandleSettingsMessage")
    ; clear and re-initialize variables after constructing the GUI as some controls call the edit flag immediately
    Menu_ChangedPrefs =
    Menu_ChangedPrefs := Object()
    Menu_ValueChanged := false
Return

;  test

ConstructGui(){
}



SetNotDPIAwareProcess:
GetList("prefs_ListBoxNotDPIAwareProgramExecutables",1)
Return



SetEnableTitles:
GetList("prefs_IncludeProgramTitles",0)
Return



SetDisableTitles:
GetList("prefs_ExcludeProgramTitles",0)
Return



SetEnableProcess:
GetList("prefs_IncludeProgramExecutables",1)
Return



SetDisableProcess:
GetList("prefs_ExcludeProgramExecutables",1)
Return



SetHelpTitles:
GetList("prefs_HelperWindowProgramTitles",0)
Return



SetHelpProcess:
GetList("prefs_HelperWindowProgramExecutables",1)
Return



GetList(TitleType,GetExe)
{



   global Menu_GetExe
   global Menu_TitleType
   global Menu_InProcessList
   global g_ScriptTitle
   global prefs_ListBoxNotDPIAwareProgramExecutables
   global prefs_IncludeProgramTitles
   global prefs_ExcludeProgramTitles
   global prefs_IncludeProgramExecutables
   global prefs_ExcludeProgramExecutables
   global prefs_HelperWindowProgramTitles
   global prefs_HelperWindowProgramExecutables



    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)



   Menu_InProcessList := true
   Menu_GetExe := GetExe
   Menu_TitleType := TitleType
   If (GetExe == 1)
   {
      WinGet, id, list,,, Program Manager
      Loop, %id%
      {
         tmptitle=
         tmpid := id%A_Index%
         WinGet, tmptitle, ProcessName, ahk_id %tmpid%
         If (tmptitle <> "")
            RunningList .= tmptitle "|"
      }
   } Else If (GetExe == 0) ; get list of active window titles
   {
      WinGet, id, list,,, Program Manager
      Loop, %id%
      {
         tmptitle=
         tmpid := id%A_Index%
         WinGetTitle, tmptitle, ahk_id %tmpid%
         If (tmptitle <> "")
            RunningList .= tmptitle "|"
      }
   }



   GuiControlGet, MenuTitleList, MenuGui: , %Menu_TitleType%



   MenuProcessHeight := 380



   Sort,RunningList, D| U	
   Gui, ProcessList:+OwnerMenuGui
   Gui, MenuGui:+Disabled  ; disable main window
   Gui, ProcessList:Add, Text,x10 y10, Select program:
   Gui, ProcessList:Add, DDL, xp+100 yp w250 R10 gToEdit,%RunningList%
   Gui, ProcessList:Add, Text,x10 yp+30, Edit:
   Gui, ProcessList:Add, Edit, xp+100 yp w250
   Gui, ProcessList:Add, Button, xp+260 yp gAddNew1 w40 Default, Add
   if (GetExe == 0)
   {
      Gui, ProcessList:Add, Text,x10 yp+30, Exact Match:
      Gui, ProcessList:Add, Checkbox, xp+100 yp
      MenuProcessHeight += 30
   }
   Gui, ProcessList:Add, Text, x10 yp+30, Current list:
   Gui, ProcessList:Add, ListBox, xp+100 yp w250 r10, %MenuTitleList%
   Gui, ProcessList:Add, Button, xp+260 yp gRemoveNew1 w40 , Del
   Gui, ProcessList:Add, Text, x10 yp+170, a) Select a program or window from the list or type a name in the`n%A_Space%%A_Space%%A_Space%%A_Space%%A_Space%'Edit' control (you may need to edit it further)`nb) Click ADD to add it to the list`nc) To remove a program/title, select an item from the 'current list' and`n%A_Space%%A_Space%%A_Space%%A_Space%click DEL.
   Gui, ProcessList:Add, Button, x10 yp+90 w190 gSaveTitleList, Save 
   Gui, ProcessList:Add, Button, xp+210 yp w190 gCancelTitle, Cancel
   Gui, ProcessList:Show, w420 h%MenuProcessHeight%, %g_ScriptTitle% Settings
   Return
}



VisitForum:
MsgBox , 36 , Visit %g_ScriptTitle% forum (www.autohotkey.com), Do you want to visit the %g_ScriptTitle% forum on www.autohotkey.com?
IfMsgBox, Yes
	Run, http://www.autohotkey.com/board/topic/49517-ahk-11gi-everywhere-v2198-word-autocompletion-utility/
Return



Restore:
MsgBox, 1, Restore Defaults, This will restore all settings to default. Continue?
IfMsgBox, Cancel
   return
RestoreDefaults()
gosub, Cancel
return



RestoreDefaults()
{
   global g_PrefsFile
   global g_ScriptTitle
   global Menu_OldLearnCount
   global prefs_LearnCount



   ReadPreferences("RestoreDefaults")



   IF ( Menu_OldLearnCount < prefs_LearnCount )
   {
      MsgBox, 1, Restore Defaults, Restoring Defaults will increase the Learn Count value.`r`nWhen exiting %g_ScriptTitle%, this will permanently delete any words`r`nfrom the Learned Words which have been typed less times`r`nthan the new Learn Count. Continue?
      IfMsgBox, Cancel
      {
         ReturnValue := "Cancel"
      }
   }



   if (ReturnValue == "Cancel")
   {
      ReadPreferences(,"RestorePreferences")
      return
   } else {



      IfExist, %g_PrefsFile%
      {
         try {
            FileCopy, %g_PrefsFile%, %PrefsFile%-%A_Now%.bak, 1
            FileDelete, %g_PrefsFile%
         } catch {
            MsgBox,,Restore Defaults,Unable to back up preferences! Canceling...
            ReadPreferences(,"RestorePreferences")
            return
         }
      }



      ApplyChanges()
      MsgBox,,Restore Defaults, Defaults have been restored.
   }



   return
}



MenuGuiGuiEscape:
MenuGuiGuiClose:
CancelButton:
if (Menu_ValueChanged == true)
{
   MsgBox, 4, Cancel, Changes will not be saved. Cancel anyway?
   IfMsgBox, Yes
   {
      gosub, Cancel
   }
} else {
   gosub, Cancel
}
return



Cancel:
Gui, MenuGui:Destroy
; Clear WM_SETCURSOR action
OnMessage(g_WM_SETCURSOR, "")
; Clear WM_MOUSEMOVE action
OnMessage(g_WM_MOUSEMOVE, "")
;Clear mouse flags
HandleSettingsMessage("", "", "", "")
g_InSettings := false
Menu, Tray, Enable, Settings
GetIncludedActiveWindow()
Return



Save:
Save()
return



Save()
{
   global prefs_ArrowKeyMethod, prefs_DisabledAutoCompleteKeys, prefs_LearnCount, prefs_ListBoxOpacity, prefs_NoBackSpace, prefs_SendMethod
   global Menu_ChangedPrefs, Menu_ListBoxOpacityUpDown, Menu_OldLearnCount
   global g_ScriptTitle
   ; should only save preferences.ini if different from defaults
   Menu_ChangedPrefs["prefs_ArrowKeyMethod"] := prefs_ArrowKeyMethod
   Menu_ChangedPrefs["prefs_DisabledAutoCompleteKeys"] := prefs_DisabledAutoCompleteKeys
   Menu_ChangedPrefs["prefs_NoBackSpace"] := prefs_NoBackSpace
   Menu_ChangedPrefs["prefs_SendMethod"] := prefs_SendMethod
   Gui, MenuGui:Submit
   prefs_ListBoxOpacity := Menu_ListBoxOpacityUpDown



   IF (Menu_OldLearnCount < prefs_LearnCount )
   {   
      MsgBox, 1, Save, Saving will increase the Learn Count value.`r`nWhen exiting %g_ScriptTitle%, this will permanently delete any words`r`nfrom the Learned Words which have been typed less times`r`nthan the new Learn Count. Continue?
      IfMsgBox, Cancel
      {
         ReturnValue := "Cancel"
      }
   }



   If ( ReturnValue == "Cancel" )
   {
      ReadPreferences(,"RestorePreferences")
   } else {
      SaveSettings()
      ApplyChanges()
   }
   gosub, Cancel
   Return
}



SaveSettings()
{
   Global



   Local Menu_PrefsToSave
   Local Split
   Local Split0
   Local Split1



   Local key
   Local value



   Menu_PrefsToSave := Object()



   Loop, parse, Menu_SendMethodOptionsCode, | ; get sendmethod
   {
      If (Menu_SendMethodC = A_Index)
         prefs_SendMethod:=A_LoopField
   }



   prefs_DisabledAutoCompleteKeys=
   If (Menu_CtrlEnter = 0)
      prefs_DisabledAutoCompleteKeys .= "E"
   If (Menu_Tab = 0)
      prefs_DisabledAutoCompleteKeys .= "T"
   If (Menu_CtrlSpace = 0)
      prefs_DisabledAutoCompleteKeys .= "S"
   If (Menu_RightArrow = 0)
      prefs_DisabledAutoCompleteKeys .= "R"
   If (Menu_NumberKeys = 0)
      prefs_DisabledAutoCompleteKeys .= "N"
   If (Menu_Enter = 0)
      prefs_DisabledAutoCompleteKeys .= "U"
   If (Menu_SingleClick = 0)
      prefs_DisabledAutoCompleteKeys .= "L"
   If (Menu_NumpadEnter = 0)
      prefs_DisabledAutoCompleteKeys .= "M"



   Loop, parse, Menu_ArrowKeyMethodOptionsText, |
   {
      StringSplit, Split, A_LoopField, -
      Split1 := Trim(Split1)
      If (prefs_ArrowKeyMethod = A_Index)
      {
         prefs_ArrowKeyMethod := Split1
      }   
   }



   If (Menu_CaseCorrection = "on")
      prefs_NoBackSpace=Off
   Else If (Menu_CaseCorrection = "off")
      prefs_NoBackSpace=On



   ; Determine list of preferences to save
   For key, value in Menu_ChangedPrefs
   {
      IF (%key% <> value)
      {
         Menu_PrefsToSave.Insert(key)
      }
   }



   SavePreferences(Menu_PrefsToSave)
}



ApplyChanges(){
   ValidatePreferences()
   ParseTerminatingCharacters()
   InitializeHotKeys()
   DestroyListBox()
   InitializeListBox()



   Return



}   



EditValue:
Menu_ValueChanged := true
IF (A_GuiControl && !(SubStr(A_GuiControl ,1 ,5) == "Menu_") )
{
   Menu_ChangedPrefs[A_GuiControl] := %A_GuiControl%
}
Return



HelpMe:
HelpMe()
return



HelpMe()
{
   global g_ScriptTitle
   Loop, Parse, %A_GuiControl%,`r`n
   {
      IF ( SubStr(A_LoopField, 1,1) = ";")
      {
         Menu_Help .= SubStr(A_LoopField,2) . "`r`n"
      } else {
         Menu_Help .= A_LoopField . "`r`n"
      }
   }
   MsgBox , 32 , %g_ScriptTitle% Help, %Menu_Help%
   return
}



; derived from work by shimanov, 2005
; http://www.autohotkey.com/forum/viewtopic.php?p=37696#37696
HandleSettingsMessage( p_w, p_l, p_m, p_hw )
{
   Global g_IDC_HELP, g_IMAGE_CURSOR, g_LR_SHARED, g_NULL, g_WM_SETCURSOR, g_WM_MOUSEMOVE, g_cursor_hand
   Static Help_Hover, h_cursor_help, URL_Hover, h_old_cursor, Old_GuiControl



   ; pass in all blanks to clear flags
   if ((!p_w) && (!p_l) && (!p_m) && (!p_hw)) {
      Help_Hover =
      URL_Hover =
      h_old_cursor =
      Old_GuiControl =
   }



   if ( p_m = g_WM_SETCURSOR )
   {
      if ( Help_Hover || URL_Hover)
         return, true
   } else if (A_GuiControl == Old_GuiControl)
   {
      return
   } else if ( p_m = g_WM_MOUSEMOVE )
	{
      if (Help_Hover || URL_Hover)
      {



			Gui, MenuGui:Font, cGreen     ;;; xyz
			GuiControl, MenuGui:Font, %Old_GuiControl% ;;; xyz
      }



      if ( SubStr(A_GuiControl, 1, 9) == "helpinfo_" ){
			if !(Help_Hover){
				IF !(h_cursor_help)
				{
					h_cursor_help := DllCall( "LoadImage", "Ptr", g_NULL, "Uint", g_IDC_HELP , "Uint", g_IMAGE_CURSOR, "Int", g_NULL, "Int", g_NULL, "Uint", g_LR_SHARED ) 
				}
				old_cursor := DllCall( "SetCursor", "Uint", h_cursor_help )
				Help_Hover := true
				URL_Hover = 
				Gui, MenuGui:Font, cBlue        ;;; xyz
				GuiControl, MenuGui:Font, %A_GuiControl% ;;; xyz
			}
		} else if (A_GuiControl == "Menu_VisitForum"){
			if !(URL_Hover)
			{
				old_cursor := DllCall( "SetCursor", "uint", g_cursor_hand )
				URL_Hover := true
				Help_Hover =
				Gui, MenuGui:Font, cRed ; cBlue        ;;; xyz g
				GuiControl, MenuGui:Font, %A_GuiControl% ;;; xyz
			}



		} else if (Help_Hover || URL_Hover)
      {
			DllCall( "SetCursor", "Uint", h_old_cursor )
			Help_Hover=
			URL_Hover=
			h_old_cursor=
		}
		IF !(h_old_cursor)
		{
			h_old_cursor := old_cursor
      }



      Old_GuiControl := A_GuiControl
   }
}



SaveTitleList:
SaveTitleList()
return



SaveTitleList()
{
   global Menu_InProcessList
   global Menu_TitleType
   ControlGet, MenuTitleList, List, , ListBox1
   Menu_InProcessList := false
   Gui, ProcessList:Destroy
   Gui, MenuGui:-Disabled  ; enable main window
   Gui, MenuGui:Show
   StringReplace, MenuTitleList, MenuTitleList, `n, |, All



   GuiControl, MenuGui:Text, %Menu_TitleType%, %MenuTitleList%
   Menu_ChangedPrefs[Menu_TitleType] := %Menu_TitleType%



   return
}



ProcessListGuiEscape:
ProcessListGuiClose:
CancelTitle:
Menu_InProcessList := false
Gui, ProcessList:Destroy
Gui, MenuGui:-Disabled ; enable main window
Gui, MenuGui:Show
Return



ToEdit:
ToEdit()
return



ToEdit()
{
   GuiControlGet, MenuOutputVar, ProcessList:,ComboBox1
   GuiControl, ProcessList:, Edit1, 
   GuiControl, ProcessList:, Edit1, %MenuOutputVar%
   ControlFocus, Edit1
   return
}



AddNew1:
AddNew1()
return



AddNew1()
{
   global Menu_GetExe
   if (Menu_GetExe == 0)
   {
      GuiControlGet, MenuExactMatch, ProcessList:, Button2
   } else {
      MenuExactMatch := 0
   }
   GuiControlGet, MenuOutputVar, ProcessList:,Edit1
   ControlGet, MenuTitleList, List, , ListBox1



   if (MenuExactMatch == 1)
   {
      MenuOutputVar := """" . MenuOutputVar . """"
   }



   StringReplace, MenuTitleList, MenuTitleList, `n, |, All
   MenuTitleList := "|" . MenuTitleList . "|"



   SearchString := "|" . MenuOutputVar . "|"



   IfInString, MenuTitleList, |%MenuOutputVar%|
   {
      MsgBox, 16, , Duplicate entry.
      return
   }



   GuiControl, ProcessList:, ListBox1, %MenuOutputVar%|
   GuiControl, ProcessList:, Edit1, 
   if (Menu_GetExe == 0)
   {
      GuiControl, ProcessList:, Button2, 0
   }
   ControlFocus, Edit1
   return
}



RemoveNew1:
RemoveNew1()
return



RemoveNew1()
{
   GuiControlGet, MenuOutputVar, ProcessList:, Listbox1
   ControlGet, MenuTitleList, List, , ListBox1
   StringReplace, MenuTitleList, MenuTitleList, `n, |, All
   MenuTitleList := "|" . MenuTitleList . "|"
   StringReplace, MenuTitleList, MenuTitleList, |%MenuOutputVar%|, |, all
   StringTrimRight, MenuTitleList, MenuTitleList, 1
   GuiControl, ProcessList:, ListBox1, |
   GuiControl, ProcessList:, ListBox1, %MenuTitleList%



   return
}



; copied from font explorer http://www.autohotkey.com/forum/viewtopic.php?t=57501&highlight=font
Writer_enumFonts()
{
   global g_NULL
   Writer_enumFontsProc(0, 0, 0, 0,"Clear")
   hDC := DllCall("GetDC", "Uint", g_NULL) 
   DllCall("EnumFonts", "Uint", hDC, "Uint", g_NULL, "Uint", RegisterCallback("Writer_enumFontsProc", "F"), "Uint", g_NULL) 
   DllCall("ReleaseDC", "Uint", g_NULL, "Uint", hDC)



   return Writer_enumFontsProc(0, 0, 0, 0, "ReturnS")
}



Writer_enumFontsProc(lplf, lptm, dwType, lpData, Action = 0)
{
   static s



   ifEqual, Action, Clear
   {
      s=
      return
   }



   ifEqual, Action, ReturnS, return s



   s .= DllCall("MulDiv", "Int", lplf+28, "Int",1, "Int", 1, "str") "|"
   return 1
}