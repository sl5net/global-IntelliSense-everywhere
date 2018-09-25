; please never delete this wordklst 05.08.2017 10:25

; backupExamplesForBeginners =

___open library|rr||ahk|FileReadLine,WordlistFileAdress, wordlist.txt.status.txt, 1 `n WordlistFileAdress := RegExReplace(WordlistFileAdress, "\._Generated\.ahk\s*$", "") `n run,% WordlistFileAdress

___open libraries Folder|rr||ahk|run,% A_WorkingDir . "\..\ActionLists\" ; works 12.08.2017 10:42
; ___open library|rr||ahk|run,..\%wordlistNEWarchivePath% ; cant work becouse this is a general file without knowledage about your lib 12.08.2017 10:43
; ___library Address|r|%wordlistNEWarchivePath%
; ___library short path|r|%wordlistNEWarchivePath80%
; ___library name|r|%wordlistNEW%

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; the following #include commands work only at the beginning of the file.
; following includes the entire file:
#include,..\_globalWordLists\pfade.ahk
; includes everything from the file that fits on your reg search pattern:
#include,..\_globalWordLists\pfade.ahk | i)^[ab]+
; includiert alles aus der datei was NICHT aufs reg-suchmuster passst:
; includes everything from the file which does NOT fit the reg-search pattern:
#include,..\_globalWordLists\pfade.ahk ! i)^[ab]+
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

WordlistFileAdress|rr||ahk|FileReadLine,WordlistFileAdress, wordlist.txt.status.ahk, 1 `n send, % WordlistFileAdress
activeClass|rr||ahk|FileReadLine,activeClass, wordlist.txt.status.ahk, 2 `n send, % activeClass
activeTitle|rr||ahk|FileReadLine,activeTitle, wordlist.txt.status.ahk, 3 `n send, % activeTitle



   ; FileReadLine,WordlistFileName  ,wordlist.ahk, 1
   ; FileReadLine,activeClass ,wordlist.ahk, 2
   ; FileReadLine,activeTitle ,wordlist.ahk, 3



ScriptDir|rr||ahk|send, % A_ScriptDir ; \\.\pipe 12.08.2017 10:29
WorkingDir|rr||ahk|send, % A_WorkingDir
libraries Folder|rr||ahk|send, % A_WorkingDir . "\..\ActionLists\"

dir of your wordlist OPEN|rr||ahk|#Include,%A_ScriptDir%\..\ActionLists\activeClassManipulation.inc.ahk `n d1 = %A_ScriptDir%\..\ActionLists\%activeClass% `n run, % d1 . " === d1" ; .....\ActionLists\Notepad === d1

; wordlist|rr||ahk|#Include,%A_ScriptDir%\..\ActionLists\activeClassManipulation.inc.ahk `n d1 = %A_ScriptDir%\..\ActionLists\%activeClass% `n #Include,%d1%\wordlistNameFilter.inc.ahk `n send, % wordlistNEW . " === wordlist"  ;;;; sorry we cant do this :)

; wordlist|rr||ahk|#Include,%A_ScriptDir%\..\ActionLists\activeClassManipulation.inc.ahk `n d1 = %A_ScriptDir%\..\ActionLists\%activeClass% `n StringReplace ,d1 ,% d1 , Source\..\ , ,All

;wordlist22|rr||ahk|#Include,%A_ScriptDir%\..\ActionLists\activeClassManipulation.inc.ahk `n d1 = %A_ScriptDir%\..\ActionLists\%activeClass% `n StringReplace ,d1 ,% d1 , Source\..\ , ,All

; wordlist31|rr||ahk|#Include,%A_ScriptDir%\..\ActionLists\activeClassManipulation.inc.ahk `n d1 = %A_ScriptDir%\..\ActionLists\%activeClass% `n StringReplace ,d1 ,% d1 , Source\..\ , ,All `n AHKcode := "SetWorkingDir, %A_ScriptDir% ``n Send,yes1 ``n #" . "Include," . d1 . "\wordlistNameFilter.inc.ahk ``n Send,yes2 ``n " `n DynaRun(AHKcode)


send in ahk in ahk |rr||ahk|#Include,%A_ScriptDir%\..\ActionLists\activeClassManipulation.inc.ahk `n d1 = %A_ScriptDir%\..\ActionLists\%activeClass% `n StringReplace ,d1 ,% d1 , Source\..\ , ,All `n  AHKcode := "Send,yes1 " . A_WorkingDir . " ```n Send,yes2 ``n " `n DynaRun(AHKcode)

send workingDir of ahkInAhk|rr||ahk|d0 = %A_ScriptDir% `n d0 := StrReplace(d0,"\Source","") `n AHKcode := "Send,% A_WorkingDir " `n DynaRun(AHKcode)

; #Include,%A_ScriptDir%\..\ActionLists\activeClassManipulation.inc.ahk

; :D following has no error but also no result :D :D :D :D :D ?????? 12.08.2017 16:06
include wordlistNameFilter and global functions|rr||ahk|SetWorkingDir,% A_WorkingDir . "\..\ " `n  #Include , ..\ActionLists\activeClassManipulation.inc.ahk `n Send,% " _1_ " . activeClass . activeTitle . wordlistNEW . wordlistDir  `n AHKcode := "wordlistDir =" . A_WorkingDir . "\ActionLists\" . activeClass . " `;```n SetWorkingDir," . A_WorkingDir .      " `;```n #" . "Include , ActionLists\" . activeClass . "\wordlistNameFilter.inc.ahk `;```n  clipboard := "" _2_ "" . activeClass . activeTitle . wordlistNEW . wordlistDir  `;```n " . "#" . "Include , inc_ahk\functions_global_dateiende.inc.ahk  `;```n  clipboard := "" _3_ ""  `;```n" `n AHKcode .=  "msg := ""##"" . activeClass . activeTitle . wordlistNEW `;```n clipboard := msg `;```n Send,% msg `;```n  tooltip,% msg `;```n sleep,5000 " `n DynaRun(AHKcode) `n sleep,100 `n  DynaRun(AHKcode) `n sleep,500 `n msgbox,% AHKcode
; ==>> best thing i could learn from that: do it in different way !!! usa a clipboard or a file data-shuttle :D



; :D following has no error but also no result :D :D :D :D :D ?????? 12.08.2017 16:06
include wordlistNameFilter and global functions|rr||ahk|SetWorkingDir,% A_WorkingDir . "\..\ " `n  #Include , ..\ActionLists\activeClassManipulation.inc.ahk `n Send,% activeClass . activeTitle . wordlistNEW  `n AHKcode := "SetWorkingDir," . A_WorkingDir .      " `;```n #" . "Include , inc_ahk\functions_global_dateiende.inc.ahk `;```n " . "#" . "Include , ActionLists\" . activeClass . "\wordlistNameFilter.inc.ahk `;```n" `n AHKcode .=  "msg := ""##"" . activeClass . activeTitle . wordlistNEW `;```n clipboard := msg `;```n Send,% msg `;```n  tooltip,% msg `;```n sleep,5000 " `n DynaRun(AHKcode) `n sleep,100 `n  DynaRun(AHKcode) `n sleep,500 `n msgbox,% AHKcode
; ==>> best thing i could learn from that: do it in different way !!! usa a clipboard or a file data-shuttle :D




include wordlistNameFilter|rr||ahk|SetWorkingDir,% A_WorkingDir . "\..\ " `n  #Include , ..\ActionLists\activeClassManipulation.inc.ahk `n Send,% activeClass `n AHKcode := "SetWorkingDir," . A_WorkingDir . "```n #" . "Include , ActionLists\" . activeClass . "\wordlistNameFilter.inc.ahk `;```n" `n AHKcode .=  "Send,% activeClass" `n DynaRun(AHKcode)

get activeClass from ahk|rr||ahk|SetWorkingDir,% A_WorkingDir . "\..\ " `n  #Include , ..\ActionLists\activeClassManipulation.inc.ahk `n Send,% activeClass


get activeClass from ahkInahk|rr||ahk|SetWorkingDir,% A_WorkingDir . "\..\ " `n AHKcode := "SetWorkingDir," . A_WorkingDir . "```n #" . "Include , ActionLists\activeClassManipulation.inc.ahk ``; ```n" `n AHKcode .=  "Send,% activeClass" `n DynaRun(AHKcode)

set SetWorkingDir for both in root  ahkInAhk|rr||ahk|SetWorkingDir,% A_WorkingDir . "\..\ " `n AHKcode := "SetWorkingDir," . A_WorkingDir `n DynaRun(AHKcode)
set SetWorkingDir for both in root  ahkInAhk|rr||ahk|SetWorkingDir,% A_WorkingDir . "\..\ " `n AHKcode := "SetWorkingDir," . A_WorkingDir `n DynaRun(AHKcode)


; cannot be opended 12.08.2017 15:03: include activeClassManipulation.inc.ahk ahkInAhk|rr||ahk|AHKcode := "SetWorkingDir,% A_WorkingDir . ""\..\ "" ```n #" . "Include , .\ActionLists\activeClassManipulation.inc.ahk" `n DynaRun(AHKcode)

set workingDir of ahkInAhk to TypingAid-master|rr||ahk|AHKcode := "Send,% A_WorkingDir ```n SetWorkingDir,% A_WorkingDir . ""\..\"" ```n Send,% A_WorkingDir " `n DynaRun(AHKcode)


set workingDir of ahkInAhk to c:\|rr||ahk|AHKcode := "Send,% A_WorkingDir ```n SetWorkingDir,c:\ ```n Send,% A_WorkingDir " `n DynaRun(AHKcode)

set workingDir to root|rr||ahk|d0 = %A_ScriptDir% `n d0 := StrReplace(d0,"\Source","") `n AHKcode := "Send,="" . A_WorkingDir . "" ```n SetWorkingDir, " . d0 . " ```n ```n Send,yes2="" . A_WorkingDir . "" " `n DynaRun(AHKcode)


wordlist0000|rr||ahk|d0 = %A_ScriptDir% `n d0 := StrReplace(d0,"\Source","")  `n d1 := d0 . "\ActionLists" `n AHKcode := "Send,yes1 ```n SetWorkingDir, " . d0 . " ```n #" . "Include," . d0 . "\ActionLists\wordlistNameFilter.inc.ahk `;```n Send,yes2 ``n " `n DynaRun(AHKcode)



wordlist36|rr||ahk|#Include,%A_ScriptDir%\..\ActionLists\activeClassManipulation.inc.ahk `n d0 = %A_ScriptDir% `n StringReplace ,d0 ,% d0 , \Source , ,All `n  d1 = %A_ScriptDir%\..\ActionLists\%activeClass% `n StringReplace ,d1 ,% d1 , Source\..\ , ,All `n  AHKcode := "Send,yes1 ```n SetWorkingDir, " . A_WorkingDir . "\Source ```n #" . "Include," . d1 . "\wordlistNameFilter.inc.ahk `;```n Send,yes2 ``n " `n DynaRun(AHKcode)


 
 ; send, % wordlistNEW 

AHKdyn in AHKdyn|rr||ahk|AHKcode=Send,hi 17-08-12_13-02 `n DynaRun(AHKcode)

Sebastian|d|d stands for description :)
FileCreateShortcut,|d|Target, ShortcutFile [, WorkingDir, Args, Description, IconFile, ShortcutKey, IconNumber, RunState]

Sebastian|r|Sebastian Lauffer


affe¸|rr|it may helps to store the lib file as  ... see notepad++ > codeing OR Phpstorm > file encoding to > windows ...

AHKdyn example 000|r|thats example 0
AHKdyn example |rr||ahk|Send,{Enter}hi baum :-)
AHKdyn example returns ente|rr||ahk|m := "hi {Enter}ente :-)" `n Send, %m%
AHKdyn example returns `%m`%|rr||ahk|m := "hi {Enter}fuchs :-)" `n Send, `%m`%

AHKdyn example A_... AHK4381756<~>4<|rr||ahk|Send,A_LineFile und A_LineNumber=>%A_LineFile%<~>%A_LineNumber%<


AHKdyn newline ##  buggy :(|rr||ahk|m := "hi " . Chr(96) . "n" `n Send,%m% 1 {enter} 2 ``n 3 ``n 4 ``n 5 ``n 
AHKdyn newline ### buggy :(|rr||ahk|m := "ho" `n Send,%m% 1 {enter} 2 ```n 3 ```n 4 ```n 5 ```n 

AHKdyn example    Wald selection|rr|Msgbox,|ahk|m = Neuer ````n Wald `n lm:=strlen(m)+1 `n send,%m% {left %lm%}{shift down}{right %lm%}{shift up}


AHKdyn wordlist buggy :(|rr|hi :-) welcome to example 6|ahk|send, {enter} your wordlist is here: %wordlistDir%{enter}%wordlistNEW% {enter} activeTitle=%activeTitle%  activeTitle=`%activeTitle`% {enter}(line:%A_LineNumber%)


AHKdyn A_ScriptDir|rr||ahk|Send,`%A_ScriptDir`%

AHKdyn login by calling a ahk-script into your wordlist folder|rr||ahk|#include,`%A_ScriptDir`%\..\ActionLists\ChromeWidgetWin1\LoginSecret.ahk

now|rr||ahk|Send,% A_NOw

A_Working|rr||ahk|send,% A_Working " =A_Working"
AWorking|rr||ahk|send,% A_Working " =A_Working"
A_ScriptDir|rr||ahk|send,% A_ScriptDir " =A_ScriptDir"
AScriptDir|rr||ahk|send,% A_ScriptDir " =A_ScriptDir"
