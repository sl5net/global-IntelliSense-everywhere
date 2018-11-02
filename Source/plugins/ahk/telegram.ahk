#SingleInstance, force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#InstallKeybdHook
;~ http://de.autohotkey.com/wiki/index.php?title=InstallKeybdHook


; #Include %A_ScriptDir%\..\..\inc_ahk\init_global.init.inc.ahk

setCoordModeAll()

needle=Telegram ahk_class Qt5QWindowIcon ; mouseWindowTitle=0x500908  ; 
WinActivate, % needle

;settitlematchmode,2
;#IfWinActive, Telegram ahk_class Qt5QWindowIcon 
; Hotkey, IfWinActive, Telegram ahk_class Qt5QWindowIcon
Hotkey, IfWinActive, ahk_class Qt5QWindowIcon
Hotkey,LButton, lblLButton


settitlematchmode,3

While(1){
    if(A_TimeIdle < 1000 || A_TimeIdlePhysical < 1000){
        sleep,1000
        Continue
    }
        
  ;WinGetActiveStats, at, Width, Height, X, Y 
  ;WinGetClass, ac2 , %at%


    WinGetActiveTitle, at
    WinGetClass, ac , %at%
    tc:= at " ahk_class " ac 
    if(InStr(tc, "tooltip")){
        sleep,1000
        Continue
    }


    workWithNewWindow(tc,at,ac)
    ;ToolTip, % "WinWaitNotActive:" tc
    WinWaitNotActive, % tc
    ;WinWaitNotActive, % ac,,,tooltip,tooltip
    ; WinWaitNotActive, [ WinTitle, WinText, Seconds, ExcludeTitle, ExcludeText], % ac
    ;ToolTip,
    sleep,50
}


lblLButton:
    Suspend,On
    SetTitleMatchMode, 2
    WinGetActiveTitle, at
    WinGetActiveStats, at2, w, h, x, y
    IfWinActive, Telegram ahk_class Qt5QWindowIcon 
    {
        SetTitleMatchMode, 2
        WinSetTitle, ahk_class Qt5QWindowIcon, , Telegram , ToolTip
        ;MsgBox,test 18-06-10_13-55 %at%  %at2% (%A_LineFile%)
        ;ToolTip, 18-06-10_13-55 %at%  %at2% (%A_LineFile%)
        ToolTip5sec(c A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
    }
    MouseClick
    Suspend,Off
    ;ToolTip, % A_LineNumber " : " RegExReplace(A_LineFile,".*\\")
    ToolTip5sec(c A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
return



workWithNewWindow(tc,at,ac){
    needle=Telegram ahk_class Qt5QWindowIcon ; mouseWindowTitle=0x500908  ; 
      if( 1 AND (InStr(tc, needle) ))
      {
         ;ToolTip1sec(A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
         WinGetPos, X, Y, Width, Height, % needle
         ;MouseClick, WhichButton [, X, Y, ClickCount, Speed, D|U, R], left, % X + Width/2 , Y 
         ;MouseClick, left, % X + Width/2 , Y + 55 , 1 , 1 , ,
         MouseGetPos, OutputVarX, OutputVarY, OutputVarWin, OutputVarControl

         Suspend, On
         MouseClick, left, % X + Width/2 - 30 , Y + 55,1,1
         sleep,1500
        MouseClick, left, % X + Width/2 - 30 , Y + 210, 3 , 1
        MouseMove, % OutputVarX, % OutputVarY, 1
        Suspend,off


        SetKeyDelay,180,280
        if(0){
            sleepDelay := 50
            c:=copySelection2clipBoard( sleepDelay )
            if(!c)
                return
            send,{Esc}
        }else{
            clipboardOld := clipboard
            clipboard := ""
            sleep,100
            send,^c 
            sleep,100
            c:=clipboard
            sleep,100
            send,{Esc} 
            if(clipboardOld == c || RegExMatch(c, "^\d"))
                return
        }
         sleep,500

      ;MsgBox, % c " A_LineNumber=" A_LineNumber
      WinSetTitle, % needle, , % c " - Telegram" , ToolTip
      ;ToolTip5sec(c A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
        ;Pause

      }
}

setCoordModeAll(coord = "Screen"){
   if(false)
   {
      coord =
      coord = Client
      coord = Pixel
      coord = Screen
   }
   CoordMode, ToolTip, %coord%
   CoordMode, Pixel, %coord%
   CoordMode, Mouse, %coord%
   CoordMode, Caret, %coord%
   CoordMode, Menu, %coord%
   return coord
}


#Include %A_ScriptDir%\..\..\inc_ahk\move2Img_functions.inc.ahk
#Include %A_ScriptDir%\..\..\inc_ahk\functions_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise mï¿½sen ans Dateiende
#Include %A_ScriptDir%\..\..\inc_ahk\functions_global_dateiende.inc.ahk
#Include %A_ScriptDir%\..\..\inc_ahk\ToolTipSec.inc.ahk
#Include %A_ScriptDir%\..\..\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
;#Include %A_ScriptDir%\..\..\inc_ahk\functions_global.inc.ahk
#Include %A_ScriptDir%\..\..\inc_ahk\copy2clipBoard.functions.inc.ahk

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; #Include *i %A_ScriptDir%\..\..\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
