#SingleInstance, force

; example call: helloCommandLine.ahk para1 para2 para3

someLinks =
(
    https://autohotkey.com/docs/Scripts.htm#cmd
    
    https://stackoverflow.com/questions/49905729/autohotkey-ahk-param-1-not-accessible-within-a-function

    https://autohotkey.com/board/topic/125733-simple-command-line-script/
)

if 0 < 1  ; The left side of a non-expression if-statement is always the name of a variable.
{
    MsgBox This script requires at least 1 incoming parameters but it only received %0%.
    ExitApp
}

; Send,greetings from %A_LineFile%`n

for n, param in A_Args  ; For each parameter:
{
    msgbox, Parameter number %n% is %param%.`n
    ; Send, Parameter number %n% is %param%.`n
}

if(false){
	Loop, %0%  ; For each parameter:
	{
		param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
		;MsgBox, 4,, Parameter number %A_Index% is %param%.  Continue?
		Send,Parameter number %A_Index% is %param%.`n
		;IfMsgBox, No
		;    break
	}
}

; MsgBox, endOfScript 
