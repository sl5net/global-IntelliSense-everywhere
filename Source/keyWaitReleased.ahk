;If (A_TimeIdle < 50 || GetKeyState("ctrl", "P") || GetKeyState("Alt", "P") || GetKeyState("Shift", "P") || GetKeyState("LWin", "P") || GetKeyState("RWin", "P")  || GetKeyState("LButton", "P") ){

	If (true){
		if(GetKeyState("ctrl", "P"))
			KeyWait, ctrl

		if(GetKeyState("Alt", "P"))
			KeyWait, Alt

		if(GetKeyState("Shift", "P"))
			KeyWait, Shift

		if(GetKeyState("LWin", "P"))
			KeyWait, RButton

		if(GetKeyState("RWin", "P"))
			KeyWait, RWin

		if(GetKeyState("LButton", "P"))
			KeyWait, LButton

		if(GetKeyState("RButton", "P"))
			KeyWait, RButton
	}
