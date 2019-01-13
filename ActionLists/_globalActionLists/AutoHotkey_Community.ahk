#Include,..\_globalActionLists\docs_commands_index.ahk
#Include,..\_globalActionLists\autohotkey_docs_variables_builtIn.ahk
#Include,..\_globalActionLists\autohotkey_gui_comman_property.ahk
#Include,..\_globalActionLists\ahk_commands_ErrorLevel.ahk
#Include,..\_globalActionLists\autohotkey_object_property_method.ahk
#Include,..\_globalActionLists\autohotkey_INSTALLATION_FOLDERS_FILES_REGISTRY_KEYS.ahk
#Include,..\_globalActionLists\autohotkey_Command_Function.ahk


___your library open|rr||ahk|openInEditor,AutoHotkey_Community.ahk
; if this german au is readable your UTF8 is probalby correct: ä



newposts autohotkey.com|rr||ahk|run,https://www.autohotkey.com/boards/search.php?search_id=newposts

Please more details, e.g. your previous source code

; Send,using implicit variably "it" 
Greetings|rr||ahk|(
Greetings.
How are you?
)

; it = (...)
multi MsgBox|rr||ahk|(
huhu
world
)
MsgBox,% it




interesting. what is this? i never saw it.
interesting. i never heard about it.

change 2 '.ahk AutoHotkey_Community'|rr||ahk|sleep,2000 `n WinSetTitle,A,,.ahk AutoHotkey_Community `n g_config["list"]["change"]["stopRexExTitle"]:="."
start changeing list automatically|rr||ahk|g_config["list"]["change"]["stopRexExTitle"]:=false


list|rr||ahk|
s = 
(
[list]
[*]text
[*]text
[/list]
)
Clipboard := s
send, ^v


quote|rr||ahk|
ClipboardBackup := Clipboard
timeoutSec := 9
userNameDefault := "jeeswg joedf"
; InputBox, OutputVar , Title, Prompt, HIDE, Width, Height, X, Y, Font, Timeout, Default
InputBox, userName, userName? (AHK-Community), [quote="%userName%"], , 350, 100,,,,%timeoutSec%,%userNameDefault% 
if ErrorLevel
	return
s = 
(
[quote="%userName%"]
%ClipboardBackup%[/quote]
)
MsgBox,278564,Insert into AHK-Community?,% s
IfMsgBox,yes
{
	Clipboard := s
	Sleep,50
	Suspend,On 
	send, ^v
	Suspend,Off
}

quote End|r|[/quote]

center|rr||ahk|
s = 
(
[center]%clipboard%[/center]
)
Clipboard := s
send, ^v




img image|rr||ahk|
sting = 
(
[img]%clipboard%[/img]
)
Clipboard := sting
send, ^v

docs|rr||ahk|
ahkCode = 
(
[docs] %clipboard%[/docs]
)
Clipboard := ahkCode
send, ^v



code|rr||ahk|
shortName := substr(clipboard,1,20) "..."
ahkCode = 
(
[spoiler2=%shortName%]
[code]
%clipboard%
[/code]
[/spoiler2]
)
Clipboard := ahkCode
send, ^v

stop|r|stop

url|rr|[url=]title[/url]|ahk|send,{left 12}{text}%clipboard% ``n send,{CtrlDown}{ShiftDown}{Left}{ShiftUp}{CtrlUp}

gi-everywhere Command line arg to Start with specific wordList
gi-everywhere keyboard hotkey to quickly switch word lists = ^!+t|r|[url=https://github.com/ManiacDC/gi-everywhere/issues/32]gi-everywhere keyboard hotkey to quickly switch word lists = ^!+t[/url]


AHK-Studio|r|[url=https://github.com/maestrith/AHK-Studio]AHK-Studio[/url]
AutoGUI|r|[url=https://autohotkey.com/boards/viewtopic.php?f=64&t=10157]AutoGUI[/url]
SciTE4AutoHotkey|r|[url=https://autohotkey.com/boards/viewtopic.php?t=62]SciTE4AutoHotkey[/url]
AHK4websites is a actionList used in g_IntelliSense|r|[url=https://github.com/sl5net/global-IntelliSense-everywhere/blob/master/ActionLists/_globalActionListsGenerated/_ahk_global.ahk._Generated.ahk]AHK4websites is a actionList used in g_IntelliSense[/url]
visualstudio code vscode autohotkey plugin|r|[url=https://marketplace.visualstudio.com/items?itemName=slevesque.vscode-autohotkey]visualstudio code vscode autohotkey plugin[/url]



JetBrains|r|[url=https://www.jetbrains.com/help/rider/Keymaps_Comparison_Windows.html]JetBrains[/url]
JetBrains Default Keymap|r|[url=https://www.jetbrains.com/help/rider/Keymaps_Comparison_Windows.html]JetBrains Default Keymap[/url]

global-IntelliSense-everywhere>github|r|[url=https://sl5net.github.io/global-IntelliSense-everywhere]github>g_IntelliSense[/url]
github>g_IntelliSense|r|[url=https://sl5net.github.io/global-IntelliSense-everywhere]github>g_IntelliSense[/url]

[url=https://sl5net.github.io/global-IntelliSense-everywhere]github>g_IntelliSense[/url]
; is using line above
g_IntelliSense github|rr| 

; is using searchend line 
test|rr||ahk|q=JetBrains Default


g_IntelliSense next improvements|r|[url=https://g-intellisense.myjetbrains.com/youtrack/issues?q=State:%20%7BIn%20Progress%7D,%20Incomplete,%20Submitted,%20%7BTo%20be%20discussed%7D%20sort%20by:%20Priority%20asc%20]next improvements[/url]
g_IntelliSense forum|r|[url=https://autohotkey.com/boards/viewtopic.php?t=45684]forum[/url]
forum g_IntelliSense|rr|

onlineAHKprettyfy|r|[url=http://ahkscript.org/boards/viewtopic.php?f=22&t=8678]ahk..org>onlineAHKprettyfy[/url]

Refactoring|r|[url=https://autohotkey.com/boards/viewtopic.php?f=6&t=8628]ahk..com>Refactoring[/url]
riot rooms|r|[url=https://about.riot.im/]#Autohotkey:matrix.org[/url] ([url=https://about.riot.im/need-help/#rooms-sectiong]c[/url])

blue|r|red green

HomeBoard|r|
HomeBoard indexAutoHotkeyBug Reports
Hotkey with ~ modifier has side effects in this case



Autohotkey

explanation

explanation