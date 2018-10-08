; sure you could run a external ahk simply by using the run command.
; this example shows howto use inline multiline ahk without run a external ahk
; it ends with a blank newline. you could us style 1 or style 2. recomandet is style 1
; feature addet 07.10.2018 21:36

multi 1|rr||ahk|
	MouseMove,50,0, 9, R
	MouseMove,0,50, 9, R
	MouseMove,-50,0, 9, R
	MouseMove,0,-50, 9, R

multi 2|rr||ahk|
; Gi: indexFollowingLines4search = true 
MouseMove,50,0, 9, R
MouseMove,0,50, 9, R
MouseMove,-50,0, 9, R
MouseMove,0,-50, 9, R


