; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
; #Include,activeClassManipulation.inc.ahk
if(!ActiveClass){
      ActiveClass := activeClass
      if(!ActiveClass)
            WinGetClass,activeClass, A
}

ActiveClass := activeClassManipulation(ActiveClass, activeTitle)
activeClass := ActiveClass ; ActiveClass is deprecated but in use ;) 10.08.2017 21:45

; Tooltip,>%ActiveClass%< = ActiveClass  `n >%activeTitle%< = activeTitle  `n (from: activeClassManipulation.inc.ahk / %A_LineFile% ~%A_ThisFunc%~%A_LineNumber%) token:1708112343


activeClassManipulation(ActiveClass, activeTitle := ""){
	
	if(RegExMatch( ActiveClass , "^_" )){ ; dont tuch this !! :) 11.08.2017 21:44
        ;tip = :) found `n "^_" `n >%ActiveClass%< = ActiveClass  `n >%activeTitle%< = activeTitle  `n (from: activeClassManipulation.inc.ahk / %A_LineFile% ~%A_ThisFunc%~%A_LineNumber%) token:1708120003
        ;Tooltip,% tip
        ; lll(A_LineNumber, "activeClassManipulation.inc.ahk", tip )
		
        ; msgbox,:) found `n "^_" `n %ActiveClass% `n (activeClassManipulation.inc.ahk / %A_LineFile% ~%A_ThisFunc%~%A_LineNumber%)
        ; ExitAPp
        ;Sleep,1000
		return, % ActiveClass
	}
	activeClass := RegExReplace( activeClass, "[\W_]+", "")
	activeClass := (activeClass) ? activeClass  : "noName"
	
	if(false){ ; dont tuch this !! :) 11.08.2017 21:44
		return, % ActiveClass
	}
	else if(ActiveClass == "CabinetWClass")
		ActiveClass := "ChromeWidgetWin1" ; thats also found inside google chrome
	
	else if(InStr(activeTitle,"Q-Dir" ) || ActiveClass == "ATL000000014013EB90")
		ActiveClass := "Q-Dir" 
	
	else if(InStr(activeTitle,"- AtmelStudio" ) || ActiveClass == "HwndWrapperDefaultDomain0eaa8e46bf964d15b780fbf9aace0b41")
		ActiveClass := "AtmelStudio" 
	
	else if((InStr(activeTitle,"SKYPE" ) && !InStr(activeTitle,"Gmail" )) || ActiveClass == "TConversationForm")
		ActiveClass := "skype"
	
	else if( 1 && (InStr(activeTitle,"eyeDesign" ) || ActiveClass == "WindowsForms10Window8app0141b42ar16ad1") )
		ActiveClass := "eyeDesign"
	
      ;else if( 1 && InStr(activeTitle,"TightVNC" ) && (ActiveClass == "32770" || ActiveClass == "TightVNC" ) )
      ;      ActiveClass := "TightVNC"
	
	return, % ActiveClass
}
