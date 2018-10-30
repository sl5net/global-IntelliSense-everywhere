;These functions and labels are related to the shown list of words


InitializeListBox(){
   global
   
   Gui, ListBoxGui: -DPIScale -Caption +AlwaysOnTop +ToolWindow +Delimiter%g_DelimiterChar%
   
   Local ListBoxFont
   if (prefs_ListBoxFontOverride && prefs_ListBoxFontOverride != "<Default>"){
      ListBoxFont := prefs_ListBoxFontOverride
   } else IfEqual, prefs_ListBoxFontFixed, On
   {
      ListBoxFont = Courier New
   } else {
      ListBoxFont = Tahoma
   }
      ; to ms ms to
   ; Gui, ListBoxGui:Font, s%prefs_ListBoxFontSize%, %ListBoxFont% ;
   if(1 && InStr(A_ComputerName,"SL5"))
    ToolTip5sec( g_ListBoxFontSize " = font size of ListBoxGui `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") )
   Gui, ListBoxGui:Font, s%g_ListBoxFontSize%, %ListBoxFont%

  INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)

   Loop, %prefs_ListBoxRows%
   {
      ; msg= 1: vg_ListBox%A_Index% ,2: R%A_Index% X0 Y0 ,3: T%prefs_ListBoxFontSize% T32 ,4: hwndg_ListBoxHwnd%A_Index%
      ; feedbackMsgBox(g_ListBox%A_Index%,A_LineNumber . " ListBox.ahk")
      GuiControl, ListBoxGui:-Redraw, g_ListBox%A_Index%
      ;can't use a g-label here as windows sometimes passes the click message when spamming the scrollbar arrows
      ;Gui, ListBoxGui: Add, ListBox, vg_ListBox%A_Index% R%A_Index% X0 Y0 T%prefs_ListBoxFontSize% T32 hwndg_ListBoxHwnd%A_Index%
      Gui, ListBoxGui: Add, ListBox, vg_ListBox%A_Index% R%A_Index% X0 Y0 T%g_ListBoxFontSize% T32 hwndg_ListBoxHwnd%A_Index%
   }

  INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)

   Return
}
   ; ______



;/¯¯¯¯ ListBoxClickItem ¯¯ 181022211224 ¯¯ 22.10.2018 21:12:24 ¯¯\
; needet becouse listbox is moveable by click
ListBoxClickItem(wParam, lParam, msg, ClickedHwnd){
   global
   Local NewClickedItem
   Local TempRows
   static LastClickedItem

    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)

   TempRows := GetRows()
   

   if (ClickedHwnd != g_ListBoxHwnd%TempRows%)
   {
      return
   }
   
   ; if we clicked in the scrollbar, jump out
   if (A_GuiX > (g_ListBoxPosX + g_ListBoxContentWidth))
   {
      SetSwitchOffListBoxTimer()
      Return
   }
   

      ; global g_doListBoxFollowMouse  __
      if(g_doListBoxFollowMouse){
            tip=STOP follow listbox mouse `n (from: %A_LineFile%~%A_LineNumber%)
            ToolTip1sec(tip)
            g_doListBoxFollowMouse := false ; togle it. _
            SetTimer,doListBoxFollowMouse,off
            Hotkey, WheelUp, off
            Hotkey, WheelDown, off
      }else{
            tip=START follow listbox mouse `n (from: %A_LineFile%~%A_LineNumber%)
            ToolTip1sec(tip)
            g_doListBoxFollowMouse := true ; togle it.
            SetTimer,doListBoxFollowMouse,200
            Hotkey, WheelUp, on
            Hotkey, WheelDown, on
            ;SetTimer,doListBoxFollowMouse,on ; to
      }
      return


   GuiControlGet, g_MatchPos, ListBoxGui:, g_ListBox%TempRows%
   
   if (msg == g_WM_LBUTTONUP)
   {
      if prefs_DisabledAutoCompleteKeys not contains L
      {
         SwitchOffListBoxIfActive()
         EvaluateUpDown("$LButton")   
      } else {
         ; Track this to make sure we're double clicking on the same item
         NewClickedItem := g_MatchPos
         SetSwitchOffListBoxTimer()
      }
         
   } else if (msg == g_WM_LBUTTONDBLCLK)
   {
      SwitchOffListBoxIfActive()
      
      if prefs_DisabledAutoCompleteKeys contains L
      {
         if (LastClickedItem == g_MatchPos)
         {
            EvaluateUpDown("$LButton")   
         }
      }
   } else {
      SwitchOffListBoxIfActive()
   }
      
   ; clear or set LastClickedItem
   LastClickedItem := NewClickedItem

; this function works only by using mouse click. but ClickedItem is always empty
;   Msgbox, '%ClickedItem%' = ClickedItem  n (line:%A_LineNumber%) n

   Return
}
;\____ ListBoxClickItem __ 181022211307 __ 22.10.2018 21:13:07 __/





;/¯¯¯¯ SetSwitchOffListBoxTimer ¯¯ 181022211331 ¯¯ 22.10.2018 21:13:31 ¯¯\
SetSwitchOffListBoxTimer(){
    ; is for e.g. triggerd if listbox is scrolled 22.10.2018 21:21
   static DoubleClickTime

   if !(DoubleClickTime)
   {
      DoubleClickTime := DllCall("GetDoubleClickTime")
   }
   ;When single click is off, we have to wait for the double click time to pass
   ; before re-activating the edit window to allow double click to work
   SetTimer, SwitchOffListBoxIfActiveSub, -%DoubleClickTime%
}
;\____ SetSwitchOffListBoxTimer __ 181022211336 __ 22.10.2018 21:13:36 __/



SwitchOffListBoxIfActiveSub:
SwitchOffListBoxIfActive()
Return


;/¯¯¯¯ ListBoxScroll ¯¯ 181022211707 ¯¯ 22.10.2018 21:17:07 ¯¯\
ListBoxScroll(Hook, Event, EventHwnd){
   global

   Local MatchEnd
   Local SI
   Local TempRows
   Local Position

    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
   if (g_ListBox_Id)
   {
   
      TempRows := GetRows()
      if (g_ListBoxHwnd%TempRows% != EventHwnd)
      {
         return
      }
      
      if (Event == g_EVENT_SYSTEM_SCROLLINGSTART)
      {
         ; make sure the timer is clear so we don't switch while scrolling
         SetTimer, SwitchOffListBoxIfActiveSub, Off
         return
      }
      
      SI:=GetScrollInfo(g_ListBoxHwnd%TempRows%)
   
      if (!SI.npos){
         return
      }
   
      if (SI.npos == g_MatchStart){
         return
      }
   
      g_MatchStart := SI.npos
   
      SetSwitchOffListBoxTimer()   
   }
}
;\____ ListBoxScroll __ 181022211719 __ 22.10.2018 21:17:19 __/



; based on code by HotKeyIt
;  http://www.autohotkey.com/board/topic/78829-ahk-l-scrollinfo/
;  http://www.autohotkey.com/board/topic/55150-class-structfunc-sizeof-updated-010412-ahkv2/
GetScrollInfo(ctrlhwnd) {

  global g_SB_VERT
  global g_SIF_POS
    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
  SI:=new _Struct("cbSize,fMask,nMin,nMax,nPage,nPos,nTrackPos")
  SI.cbSize:=sizeof(SI)
  SI.fMask := g_SIF_POS
  If !DllCall("GetScrollInfo","PTR",ctrlhwnd,"Int",g_SB_VERT,"PTR",SI[""])
    Return false
  else Return SI
}

ListBoxChooseItem(Row)
{

   global
    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
   GuiControl, ListBoxGui: Choose, g_ListBox%Row%, %g_MatchPos%
}

; tooo tool msgbo too

;------------------------------------------------------------------------
; SciTEWindow\_global.ahk __SunAwtFrame\.txt
; __SciTEWindow\_global.ahk
CloseListBox(calledFromStr){
   global g_ListBox_Id
   RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, % A_ThisFunc , % calledFromStr
   IfNotEqual, g_ListBox_Id,
   {
   ; thats the place were listbox will be closed  17-03-17_17-12 17.03.2017 17:12
   ; tooltip, '%g_ListBox_Id%' = g_ListBox_Id  `n (line:%A_LineNumber%) `n
   ; clipboard := g_ListBox_Id ; 0xe012bc 0x30098c
   ; msgbox, `n '%g_ListBox_Id%' = g_ListBox_Id  `n (line:%A_LineNumber%) `n
   ; sleep,1000
      Gui, ListBoxGui: Hide
      ListBoxEnd()
   }
   Return
}

DestroyListBox(){
    global g_ListBoxTitle
    ; Msgbox,DestroyListBox`n (%A_LineFile%~%A_LineNumber%)
   Gui, ListBoxGui:Destroy
   ListBoxEnd()
   g_ListBoxTitle := ""
   Return
}

ListBoxEnd() {
   global g_ScrollEventHook
   global g_ScrollEventHookThread
   global g_ListBox_Id
   global g_WM_LBUTTONUP
   global g_WM_LBUTTONDBLCLK

   ;Msgbox, ListBoxEnd() `n (%A_LineFile%~%A_LineNumber%)
   g_ListBox_Id =
   
   OnMessage(g_WM_LBUTTONUP, "")
   OnMessage(g_WM_LBUTTONDBLCLK, "")

   if (g_ScrollEventHook) {
      DllCall("UnhookWinEvent", "Uint", g_ScrollEventHook)
      g_ScrollEventHook =
      g_ScrollEventHookThread =
      MaybeCoUninitialize()
   }
   lll(A_LineNumber, A_LineFile, "DisableKeyboardHotKeys()")
   DisableKeyboardHotKeys()
   return
}
;
;------------------------------------------------------------------------

SavePriorMatchPosition(){
   global g_MatchPos
   global g_MatchStart
   global g_OldMatch
   global g_OldMatchStart
   global g_SingleMatch
   global prefs_ArrowKeyMethod
   
   if !(g_MatchPos)
   {
      g_OldMatch =
      g_OldMatchStart = 
   } else IfEqual, prefs_ArrowKeyMethod, LastWord
   {
      g_OldMatch := g_SingleMatch[g_MatchPos]
      g_OldMatchStart = 
   } else IfEqual, prefs_ArrowKeyMethod, LastPosition
   {
      g_OldMatch := g_MatchPos
      g_OldMatchStart := g_MatchStart
   } else {
      g_OldMatch =
      g_OldMatchStart =
   }
      
   Return
}

SetupMatchPosition(){
   global g_MatchPos
   global g_MatchStart
   global g_MatchTotal
   global g_OldMatch
   global g_OldMatchStart
   global g_SingleMatch
   global prefs_ArrowKeyMethod
   global prefs_ListBoxRows
   
   IfEqual, g_OldMatch, 
   {
      IfEqual, prefs_ArrowKeyMethod, Off
      {
         g_MatchPos = 
         g_MatchStart = 1
      } else {
         g_MatchPos = 1
         g_MatchStart = 1
      }
   } else IfEqual, prefs_ArrowKeyMethod, Off
   {
      g_MatchPos = 
      g_MatchStart = 1
   } else IfEqual, prefs_ArrowKeyMethod, LastPosition
   {
      IfGreater, g_OldMatch, %g_MatchTotal%
      {
         g_MatchStart := g_MatchTotal - (prefs_ListBoxRows - 1)
         IfLess, g_MatchStart, 1
            g_MatchStart = 1
         g_MatchPos := g_MatchTotal
      } else {
         g_MatchStart := g_OldMatchStart
         If ( g_MatchStart > (g_MatchTotal - (prefs_ListBoxRows - 1) ))
         {
            g_MatchStart := g_MatchTotal - (prefs_ListBoxRows - 1)
            IfLess, g_MatchStart, 1
               g_MatchStart = 1
         }
         g_MatchPos := g_OldMatch
      }
   
   } else IfEqual, prefs_ArrowKeyMethod, LastWord
   {
      ListPosition =
      Loop, %g_MatchTotal%
      {
         if ( g_OldMatch == g_SingleMatch[A_Index] )
         {
            ListPosition := A_Index
            Break
         }
      }
      IfEqual, ListPosition, 
      {
         g_MatchPos = 1
         g_MatchStart = 1
      } Else {
         g_MatchStart := ListPosition - (prefs_ListBoxRows - 1)
         IfLess, g_MatchStart, 1
            g_MatchStart = 1
         g_MatchPos := ListPosition
      }
   } else {
      g_MatchPos = 1
      g_MatchStart = 1
   }
             
   g_OldMatch = 
   g_OldMatchStart = 
   Return
}


RebuildMatchList(){
   global g_Match
   global g_MatchLongestLength
   global g_MatchPos
   global g_MatchStart
   global g_MatchTotal
   global g_OriginalMatchStart
   global prefs_ListBoxRows
   
   g_Match = 
   g_MatchLongestLength =
   
   if (!g_MatchPos)
   {
      ; do nothing
   } else if (g_MatchPos < g_MatchStart)
   {
      g_MatchStart := g_MatchPos
   } else if (g_MatchPos > (g_MatchStart + (prefs_ListBoxRows - 1)))
   {
      g_MatchStart := g_MatchPos - (prefs_ListBoxRows -1)
   }
   
   g_OriginalMatchStart := g_MatchStart
   
   MaxLength := ComputeListBoxMaxLength()
   HalfLength := Round(MaxLength/2)
   
   Loop, %g_MatchTotal%
   {
      CurrentLength := AddToMatchList(A_Index, MaxLength, HalfLength, 0, true)
      IfGreater, CurrentLength, %LongestBaseLength%
         LongestBaseLength := CurrentLength      
   }
   
   Loop, %g_MatchTotal%
   {
      CurrentLength := AddToMatchList(A_Index, MaxLength, HalfLength, LongestBaseLength, false)
      IfGreater, CurrentLength, %g_MatchLongestLength%
         g_MatchLongestLength := CurrentLength      
   }
   StringTrimRight, g_Match, g_Match, 1        ; Get rid of the last linefeed 
   Return
}

AddToMatchList(position, MaxLength, HalfLength, LongestBaseLength, ComputeBaseLengthOnly){

   global g_DelimiterChar
   global g_Match
   global g_MatchStart
   global g_NumKeyMethod
   global g_SingleMatch
   global g_SingleMatchDescription
   global g_SingleMatchReplacement
   global prefs_ListBoxFontFixed

    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
   blankprefix = `t
   
   IfEqual, g_NumKeyMethod, Off
   {
      prefix := blankprefix
   } else IfLess, position, %g_MatchStart%
   {
      prefix := blankprefix
   } else if ( position > ( g_MatchStart + 9 ) )
   {
      prefix := blankprefix
   } else {
      prefix := Mod(position - g_MatchStart +1,10) . "`t"
   }
   
   prefixlen := 2
   
   ; CurrentMatch := Trim( g_SingleMatch[position] )
   CurrentMatch := g_SingleMatch[position] 

   global g_regExReplaceInVisibleLine
   CurrentMatchBackup := CurrentMatch
   lenCurrentMatchBackup  := StrLen(CurrentMatchBackup)
   CurrentMatch := RegExReplace(CurrentMatch, g_regExReplaceInVisibleLine,"$1 > $2")
   lenCurrentMatch  := StrLen(CurrentMatch)
   islenPlus3 := (lenCurrentMatch == lenCurrentMatchBackup + 3) 
   if(1 && islenPlus3){
         ; probalbly $2 is empty. lets pretify it (18-06-10_10-24)
            CurrentMatch := SubStr(CurrentMatch, 1 , lenCurrentMatchBackup)
            ; msgbox,%s% ?= %CurrentMatchBackup%
            ; tooltip,%s% islenPlus3=%islenPlus3% `n>%CurrentMatch%< ?= `n>%CurrentMatchBackup%<  (%lenCurrentMatch% ?=  %lenCurrentMatchBackup%)
            ;sleep, 8000
   }

   if (g_SingleMatchReplacement[position] || g_SingleMatchDescription[position]){
      AdditionalDataExists := true
      BaseLength := HalfLength
   } else if (ComputeBaseLengthOnly) {
      ; we don't need to compute the base length if there
      ; is no Replacement or Description

      ; ToolTip1sec(BaseLength "= BaseLength `n (" A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    ")")
      Return, 0
   } else {
      BaseLength := MaxLength ; was default before 01.04.2018 14:23 18-04-01_14-23
      BaseLength := HalfLength ; addet at 01.04.2018 14:24 18-04-01_14-24 so |rr| replacements also work more prety
      ;ToolTip1sec(BaseLength "= BaseLength `n (" A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    ")")
   }

   CurrentMatchLength := StrLen(CurrentMatch) + prefixlen
   
   if (CurrentMatchLength > BaseLength){
      CompensatedBaseLength := BaseLength - prefixlen
      ; remove 3 characters so we can add the ellipsis
      StringLeft, CurrentMatch, CurrentMatch, CompensatedBaseLength - 3
      CurrentMatch .= "..."
   
      CurrentMatchLength := StrLen(CurrentMatch) + prefixlen
   }
   
   if (ComputeBaseLengthOnly){
      Return, CurrentMatchLength
   }
   
   Iterations := 0
   Tabs = 
   Remainder := 0
   
   if (AdditionalDataExists) {
      if (g_SingleMatchReplacement[position]){
         CurrentMatch .= " " . chr(26) . " " . g_SingleMatchReplacement[position]
      }
      if (g_SingleMatchDescription[position]){
         ;;CurrentMatch .= "|" . g_SingleMatchDescription[position]
         IfEqual, prefs_ListBoxFontFixed, On
         {
            Iterations := Ceil(LongestBaseLength/8) - Floor((strlen(CurrentMatch) + prefixlen)/8)
         
            Remainder := Mod(strlen(CurrentMatch) + prefixlen, 8)
         
            Loop, %Iterations%
            {
               Tabs .= Chr(9)
            }
         } else {
            Iterations := 1
            Remainder := 0
            Tabs := Chr(9)
         }
         
         CurrentMatch .= Tabs . "|" . g_SingleMatchDescription[position]
      }
         
      CurrentMatchLength := strlen(CurrentMatch) + prefixlen - strlen(Tabs) + (Iterations * 8) - Remainder
      
      ;MaxLength - prefix length to make room for prefix
      if (CurrentMatchLength > MaxLength)
      {
         CompensatedMaxLength := MaxLength - prefixlen + strlen(Tabs) - (Iterations * 8) + Remainder
         ; remove 3 characters so we can add the ellipsis
         StringLeft, CurrentMatch, CurrentMatch, CompensatedMaxLength - 3
         CurrentMatch .= "..."
         CurrentMatchLength := strlen(CurrentMatch) + prefixlen - strlen(Tabs) + (Iterations * 8) - Remainder
      }
   }



   g_Match .= prefix . CurrentMatch
   
   g_Match .= g_DelimiterChar
   Return, CurrentMatchLength
}

;------------------------------------------------------------------------

; find out the longest length we can use in the listbox
; Any changes to this function probably need to be reflected in ShowListBox() or ForceWithinMonitorBounds
ComputeListBoxMaxLength(){
   global g_ListBoxCharacterWidthComputed
   global g_MatchTotal
   global g_SM_CMONITORS
   global g_SM_CXFOCUSBORDER
   global g_SM_CXVSCROLL
   global prefs_ListBoxMaxWidth
   
   ; grab the width of a vertical scrollbar

   Rows := GetRows()
   
   IfGreater, g_MatchTotal, %Rows%
   {
      SysGet, ScrollBarWidth, %g_SM_CXVSCROLL%
      if ScrollBarWidth is not integer
         ScrollBarWidth = 17
   } else ScrollBarWidth = 0

   ; Grab the internal border width of the ListBox box
   SysGet, BorderWidthX, %g_SM_CXFOCUSBORDER%
   If BorderWidthX is not integer
      BorderWidthX = 1
   
   ;Use 8 pixels for each character in width
   ListBoxBaseSizeX := g_ListBoxCharacterWidthComputed + ScrollBarWidth + (BorderWidthX * 2)

global ListBoxPosX
global ListBoxPosY
if(g_ListBoxX) ; if g_ListBoxX (not false > 0) it never usses CaretXorMouseXfallback . if you want go back to default, reload the script
    ListBoxPosX := g_ListBoxX - 60
else
   ListBoxPosX := CaretXorMouseXfallback()
if(g_ListBoxY)  ; if g_ListBoxY (not false > 0) it never usses  CaretYorMouseYfallback
   ListBoxPosY := g_ListBoxY -  60
else
   ListBoxPosY := CaretYorMouseYfallback()
   
   SysGet, NumMonitors, %g_SM_CMONITORS%

   IfLess, NumMonitors, 1
      NumMonitors =1
         
   Loop, %NumMonitors%
   {
      SysGet, Mon, Monitor, %A_Index%
      IF ( ( ListBoxPosX < MonLeft ) || (ListBoxPosX > MonRight ) || ( ListBoxPosY < MonTop ) || (ListBoxPosY > MonBottom ) )
         Continue
      
      MonWidth := MonRight - MonLeft
      break
   }
   
   if !prefs_ListBoxMaxWidth
   {
      Width := MonWidth
   } else if (prefs_ListBoxMaxWidth < MonWidth){
      Width := prefs_ListBoxMaxWidth
   } else {
      Width := MonWidth
   }
   
   return Floor((Width-ListBoxBaseSizeX)/ g_ListBoxCharacterWidthComputed)
}
   

;Show matched values
; Any changes to this function may need to be reflected in ComputeListBoxMaxLength()
ShowListBox(paraX:="",paraY:=""){

   global
    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
    g_ListBoxTitle := "käsewurscht"
    g_ListBoxTitle_firstTimeInMilli := A_TickCount ; milliseconds


   IfNotEqual, g_Match,
   {
      Local BorderWidthX
      Local ListBoxActualSize
      Local ListBoxActualSizeH
      Local ListBoxActualSizeW
      Local ListBoxPosY
      Local ListBoxSizeX
      Local ListBoxThread
      Local MatchEnd
      Local Rows
      Local ScrollBarWidth
      static ListBox_Old_Cursor

      Rows := GetRows()
      
      IfGreater, g_MatchTotal, %Rows%
      {
         SysGet, ScrollBarWidth, %g_SM_CXVSCROLL%
         if ScrollBarWidth is not integer
            ScrollBarWidth = 17
      } else ScrollBarWidth = 0
   
      ; Grab the internal border width of the ListBox box
      SysGet, BorderWidthX, %g_SM_CXFOCUSBORDER%
      If BorderWidthX is not integer
         BorderWidthX = 1
      
      ;Use 8 pixels for each character in width
      ListBoxSizeX := g_ListBoxCharacterWidthComputed * g_MatchLongestLength + g_ListBoxCharacterWidthComputed + ScrollBarWidth + (BorderWidthX * 2)
      
      g_ListBoxPosX := CaretXorMouseXfallback()
      ListBoxPosY := CaretYorMouseYfallback()
      ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
SetTitleMatchMode,2
IfWinActive,SciTE4AutoHotkey ahk_class SciTEWindow
  g_ListBoxPosX += 160 ; was addet from sl5.net 11.03.2017 21:51 17-03-11_21-51

if(WinActive("PhpStorm", "", ".ahk") || WinActive("New File ahk_class SunAwtDialog") || WinActive("Rename ahk_class SunAwtDialog") )  {
   ;ToolTip9sec(A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
; SetKeyDelay,290,125 ; <=== this doesent has any effect.

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; please use something like
; mouseViewPosEndlessLoop.ahk
; this program is changing the title bar. with xy coordination of the actual mouse coordination's.
; for find your preferred configuration 03.05.2017 18:36
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><

if(paraX && paraY){
      g_ListBoxPosX := paraX
      ListBoxPosY := paraY   
}
if(g_ListBoxX && g_ListBoxY){
      g_ListBoxPosX := g_ListBoxX
      ListBoxPosY := g_ListBoxY
}
else if(0){
    ;1920
    ;1080
;    msgbox, thats a stup . its not working. 03.05.2017 17:29
;    exit ;
      g_ListBoxPosX := 370
      ListBoxPosY := -541
       ; x=395,y=19,t=0x380c6a

       ; w=1278,
       ; x=603,y=16,t=0x380c6a
}
else if(0){
      ; laptop mit 1600 auflösung, skalieung 120prozent
      g_ListBoxPosX := 918 ; was addet from sl5.net 04.04.2017 19:07 17-04-04_19-08
      ListBoxPosY := 500 ; was addet from sl5.net 04.04.2017 19:07 17-04-04_19-08
}
else if(1){
      ; laptop mit 1680 auflösung, skalieung 120prozent
      g_ListBoxPosX := 1681
      ListBoxPosY := (1050 - 798) + 15
}
else if(0){
; mitte lappi mit maximaler auflösung und skalierung von 200proz
; rechts usb monitor mit höhe von 798 und monitor ganz unten böndig
      g_ListBoxPosX := 2885 ; was addet from sl5.net 04.04.2017 19:07 17-04-04_19-08
      ListBoxPosY := (1620 - 798) + 15 ; 15 pixel sicherheitshalber wegen vielleicht falscher positionierung 24.04.2017 18:57
}      ; ListBoxPosY := 798
}
      ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




      ; In rare scenarios, the Cursor may not have been detected. In these cases, we just won't show the ListBox.
      IF (!(g_ListBoxPosX) || !(ListBoxPosY))
      {
         return
      }
      
      MatchEnd := g_MatchStart + (prefs_ListBoxRows - 1)
      
      Loop, %prefs_ListBoxRows%
      { 
         IfEqual, A_Index, %Rows%
         {
            GuiControl, ListBoxGui: -Redraw, g_ListBox%A_Index%
            GuiControl, ListBoxGui: Move, g_ListBox%A_Index%, w%ListBoxSizeX%
            GuiControl, ListBoxGui: ,g_ListBox%A_Index%, %g_DelimiterChar%%g_Match%
            IfNotEqual, g_MatchPos,
            {
               GuiControl, ListBoxGui: Choose, g_ListBox%A_Index%, %MatchEnd%
               GuiControl, ListBoxGui: Choose, g_ListBox%A_Index%, %g_MatchPos%
            }
            GuiControl, ListBoxGui: +AltSubmit +Redraw, g_ListBox%A_Index%
            GuiControl, ListBoxGui: Show, g_ListBox%A_Index%
            GuiControlGet, ListBoxActualSize, ListBoxGui: Pos, g_ListBox%A_Index%
            Continue
         }
         GuiControl, ListBoxGui: Hide, g_ListBox%A_Index%
         GuiControl, ListBoxGui: -Redraw, g_ListBox%A_Index%
         GuiControl, ListBoxGui: , g_ListBox%A_Index%, %g_DelimiterChar%
      }

      ; that box is not out of monitor, out of sceen:
      ForceWithinMonitorBounds(g_ListBoxPosX,ListBoxPosY,ListBoxActualSizeW,ListBoxActualSizeH)
      
      g_ListBoxContentWidth := ListBoxActualSizeW - ScrollBarWidth - BorderWidthX
      
      IfEqual, g_ListBox_Id,
      {
         
         if prefs_DisabledAutoCompleteKeys not contains L
         {
            if (!ListBox_Old_Cursor){
               ListBox_Old_Cursor := DllCall(g_SetClassLongFunction, "Uint", g_ListBoxHwnd%Rows%, "int", g_GCLP_HCURSOR, "int", g_cursor_hand)
            }
            
            DllCall(g_SetClassLongFunction, "Uint", g_ListBoxHwnd%Rows%, "int", g_GCLP_HCURSOR, "int", g_cursor_hand)
            
         ; we only need to set it back to the default cursor if we've ever unset the default cursor
         } else if (ListBox_Old_Cursor){
            DllCall(g_SetClassLongFunction, "Uint", g_ListBoxHwnd%Rows%, "int", g_GCLP_HCURSOR, "int", ListBox_Old_Cursor)
         }
            
      }


try {
       g_ListBoxTitle := "ListBoxTitle (sec=" A_Sec ")"
      Gui, ListBoxGui: Show, NoActivate X%g_ListBoxPosX% Y%ListBoxPosY% H%ListBoxActualSizeH% W%ListBoxActualSizeW%,% g_ListBoxTitle
      Gui, ListBoxGui: +LastFound +AlwaysOnTop
      g_ListBoxTitle_firstTimeInMilli := A_TickCount ; milliseconds
      ; Msgbox,ListBoxGui created`n (%A_LineFile%~%A_LineNumber%)
          ; ToolTip,%g_ListBoxTitle% = g_ListBoxTitle `n (%A_LineFile%~%A_LineNumber%)
         ; Msgbox,%g_ListBoxTitle% = g_ListBoxTitle `n (%A_LineFile%~%A_LineNumber%)

} catch {
   lll(A_LineNumber, A_LineFile, "ERROR Gui, ListBoxGui proably not ready ")
   return 
}      
      
      IfEqual, g_ListBox_Id,
      {
      ; lll(A_LineNumber, A_LineFile, "")
         lll(A_LineNumber, A_LineFile, "EnableKeyboardHotKeys()")
         EnableKeyboardHotKeys()
      }
      
      WinGet, g_ListBox_Id, ID, % g_ListBoxTitle
      
      ListBoxThread := DllCall("GetWindowThreadProcessId", "Ptr", g_ListBox_Id, "Ptr", g_NULL)
      if (g_ScrollEventHook && (ListBoxThread != g_ScrollEventHookThread)){
         DllCall("UnhookWinEvent", "Uint", g_ScrollEventHook)
         g_ScrollEventHook =
         g_ScrollEventHookThread =
         MaybeCoUninitialize()
      }
         
      if (!g_ScrollEventHook) {
         MaybeCoInitializeEx()
         g_ScrollEventHook := DllCall("SetWinEventHook", "Uint", g_EVENT_SYSTEM_SCROLLINGSTART, "Uint", g_EVENT_SYSTEM_SCROLLINGEND, "Ptr", g_NULL, "Uint", g_ListBoxScrollCallback, "Uint", g_PID, "Uint", ListBoxThread, "Uint", g_NULL)
         g_ScrollEventHookThread := ListBoxThread
      }
      
      OnMessage(g_WM_LBUTTONUP, "ListBoxClickItem")
      OnMessage(g_WM_LBUTTONDBLCLK, "ListBoxClickItem")
      
      IfNotEqual, prefs_ListBoxOpacity, 255
         WinSet, Transparent, %prefs_ListBoxOpacity%, ahk_id %g_ListBox_Id%
   }
}

; Any changes to this function may need to be reflected in ComputeListBoxMaxLength()
ForceWithinMonitorBounds(ByRef ListBoxPosX, ByRef ListBoxPosY, ListBoxActualSizeW, ListBoxActualSizeH){

   global g_ListBoxFlipped
   global g_SM_CMONITORS
   global g_ListBoxCharacterWidthComputed
   global g_ListBoxOffsetComputed
   global g_ListBoxMaxWordHeight
    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
   ;Grab the number of non-dummy monitors
   SysGet, NumMonitors, %g_SM_CMONITORS%
   
   IfLess, NumMonitors, 1
      NumMonitors =1
         
   Loop, %NumMonitors%
   {
      SysGet, Mon, Monitor, %A_Index%
      IF ( ( ListBoxPosX < MonLeft ) || (ListBoxPosX > MonRight ) || ( ListBoxPosY < MonTop ) || (ListBoxPosY > MonBottom ) )
         Continue
      
      if (ListBoxActualSizeH > g_ListBoxMaxWordHeight) {
         g_ListBoxMaxWordHeight := ListBoxActualSizeH
      }
      
      ; + g_ListBoxOffsetComputed Move ListBox down a little so as not to hide the caret. 
      ListBoxPosY := ListBoxPosY + g_ListBoxOffsetComputed
      if (g_ListBoxFlipped) {
         ListBoxMaxPosY := CaretYorMouseYfallback() - g_ListBoxMaxWordHeight
         
         if (ListBoxMaxPosY < MonTop) {
            g_ListBoxFlipped =
         } else {
           ListBoxPosY := CaretYorMouseYfallback() - ListBoxActualSizeH
         }
      }
      
      ; make sure we don't go below the screen.
      If ( (ListBoxPosY + g_ListBoxMaxWordHeight ) > MonBottom ){
         ListBoxPosY := CaretYorMouseYfallback() - ListBoxActualSizeH
         g_ListBoxFlipped := true
      }
      
      ; make sure we don't go above the top of the screen.
      If (ListBoxPosY < MonTop) {
         ListBoxPosY := MonTop
         ; Try to move over horizontal position to leave some space, may get overridden later.
         ListBoxPosX += g_ListBoxCharacterWidthComputed
      }
      
      If ( (ListBoxPosX + ListBoxActualSizeW ) > MonRight ){
         ListBoxPosX := MonRight - ListBoxActualSizeW
         If ( ListBoxPosX < MonLeft )
            ListBoxPosX := MonLeft
      }
         
         
      Break
   }

   Return      
}

;------------------------------------------------------------------------

GetRows()
{
   global g_MatchTotal
   global prefs_ListBoxRows
   IfGreater, g_MatchTotal, %prefs_ListBoxRows%
      Rows := prefs_ListBoxRows
   else Rows := g_MatchTotal
   
   Return, Rows
}
;------------------------------------------------------------------------

; function to grab the X position of the caret for the ListBox
CaretXorMouseXfallback() {
   global g_DpiAware
   global g_DpiScalingFactor
   global g_Helper_Id
   global g_Process_DPI_Unaware

    global g_ListBoxX
    if( g_ListBoxX )
        return g_ListBoxX


   WinGetPos, HelperX,,,, ahk_id %g_Helper_Id% 
   if HelperX !=
   { 
      return HelperX
   } 
   if ( CheckIfCaretNotDetectable() )
   { 
      MouseGetPos, MouseX
      return MouseX
   }
   ; non-DPI Aware
   if (g_DpiAware == g_Process_DPI_Unaware) {
      return (A_CaretX * g_DpiScalingFactor)
   }
   
   return A_CaretX 
} 

;------------------------------------------------------------------------

; function to grab the Y position of the caret for the ListBox
CaretYorMouseYfallback() {
   global g_DpiAware
   global g_DpiScalingFactor
   global g_Helper_Id
   global g_Process_DPI_Unaware

    global g_ListBoxY
    if( g_ListBoxY )
        return g_ListBoxY

   WinGetPos,,HelperY,,, ahk_id %g_Helper_Id% 
   if HelperY != 
   { 
      return HelperY
   } 
   if ( CheckIfCaretNotDetectable() ){ 
      MouseGetPos, , MouseY
      return MouseY + (20*g_DpiScalingFactor)
   }
   if (g_DpiAware == g_Process_DPI_Unaware) {
      return (A_CaretY * g_DpiScalingFactor)
   }
   
   return A_CaretY 
}

;------------------------------------------------------------------------

CheckIfCaretNotDetectable()
{
   ;Grab the number of non-dummy monitors
   SysGet, NumMonitors, 80
   
   IfLess, NumMonitors, 1
      NumMonitors = 1
   
   if !(A_CaretX)
   {
      Return, 1
   }
   
   ;if the X caret position is equal to the leftmost border of the monitor +1, we can't detect the caret position.
   Loop, %NumMonitors%
   {
      SysGet, Mon, Monitor, %A_Index%
      if ( A_CaretX = ( MonLeft ) )
      {
         Return, 1
      }
      
   }
   
   Return, 0
}