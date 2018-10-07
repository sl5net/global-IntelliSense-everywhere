; sure you could run a external ahk simply by using the run command.
; this example shows howto use inline multiline ahk without run a external ahk
; feature addet 07.10.2018 21:36

multi|rr||ahk|
	MouseMove,50,0, 9, R
	MouseMove,0,50, 9, R
	MouseMove,-50,0, 9, R
	MouseMove,0,-50, 9, R

