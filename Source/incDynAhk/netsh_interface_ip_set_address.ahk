; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#SingleInstance, force

if(!address){
	; take address frome command line 02.08.2017 10:21 17-08-02_10-21
	address = %1%
	; Msgbox,%address% `n (%A_LineFile%~%A_LineNumber%) 
}
if(!address){
	Msgbox,:-(  address=%address% `n (%A_LineFile%~%A_LineNumber%) 
	ExitApp
}

; address=9 
; #incDynAhk\netsh_interface_ip_set_address.ahk

doTryWithCmdAdmin := true
doTryWithCmdAdmin := false


if(doTryWithCmdAdmin){
	tc := "cmd.exe (Admin) ahk_class VirtualConsoleClassGhost" ; findet er nicht
	tc := "cmd.exe (Admin)" 
	tc := "Administrator: cmd.exe" 
	; cmd.exe (Admin) ahk_class VirtualConsoleClassGhost
	SetTitleMatchMode,1
	IfWinNotExist, % tc
	{
		Tooltip,:( %tc% not exist `n (from: %A_LineFile%~%A_LineNumber%) 
		Sleep, 2500 
	}
	Wingetactivetitle, activeTitle

	WinActivate, % tc 
	Tooltip,WinWaitActive %tc% `n (from: %A_LineFile%~%A_LineNumber%) 
	WinWaitActive,% tc ,,1
	;sleep,100

	;ControlSend, , test, % tc 
	;sendplay,17-07-28_00-03
	;sendraw,17-07-28_00-04
;
	IfWinNotActive, % tc 
	{
		msgbox,ExitApp 27.07.2017 23:47 17-07-27_23-47
		ExitApp 
	}
}


if(address=="dhcp"){
	; https://de.wikipedia.org/wiki/Netsh#Beispielanwendung
	if(doTryWithCmdAdmin){
		send1=netsh interface ip set address name="SL5Box" source=dhcp
		send,%send1%{enter}
	}else
		send1=netsh interface ip set address name="SL5Box" source=dhcp
    if(isAdministratorAndMsg(send1))
		Run, % send1
	;RunAs, Admin, netsh interface ip set address name="SL5Box" source=dhcp
} else {
	gateway := RegExReplace(address, "d+$","") . "1"
	send1 = netsh interface ip set address "SL5Box" static %address% 255.255.255.0 %gateway%
	if(doTryWithCmdAdmin)
		send,%send1%{enter}
	else if(isAdministratorAndMsg(send1))
		Run, % send1
		;RunAs, Administrator, % send1
	;RunAs, Admin, % send1
	Tooltip,%send1% `n (from: %A_LineFile%~%A_LineNumber%) 
}
; send , :-( address ????? 17-07-27_16-52

Sleep, 1000 ; 1 Sekunde

if(doTryWithCmdAdmin)
{
	WinActivate, % activeTitle
	WinWaitActive,% activeTitle ,,1
	; Tooltip,WinWaitActive %activeTitle% `n (from: %A_LineFile%~%A_LineNumber%) 
	Sleep, 2000 
}

return

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
isAdministratorAndMsg(netshCommand){
if(A_UserName != "Administrator"){
	msg2 := "A_IsAdmin=" . A_IsAdmin
	if(A_IsAdmin)
		msg2 =
    (
    you have admin rights (A_IsAdmin contains 1).

    To have the script restart itself as admin (or show a prompt to the user requesting admin), use Run *RunAs.
    running the script as admin causes all programs launched by the script to also run as admin.
    30.07.2017 11:55
    )

        Clipboard := netshCommand
		tc := "cmd.exe (Admin)" 
		IfWinExist, % tc
			WinActivate, % tc
        Msgbox,:-( Oops ERROR`n netsh `n dont works if user != 'Administrator' `n pls login 'Administrator' and try again. `n 30.07.2017 11:53 17-07-30_11-53 `n %msg2% `n`n command is copied to your Clipboard: `n %Clipboard% `n `n (%A_LineFile%~netsh_interface_ip_set_address.ahk~%A_LineNumber%)
        ;RunAs, Administrator, netsh interface ip set address name="SL5Box" source=dhcp ; Oops doesent work :)
        return false 
    }
	return true
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
