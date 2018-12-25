; Google Translate Script work for DeepL: https://autohotkey.com/boards/viewtopic.php?p=247016#p247016

if(1){
    global g_ttSpeakObject
    g_ttSpeakObject := new TTS()
    ; s.SetRate(-2)

    ; DEV mode :
    ; g_ttSpeakObject.SetRate(5) ; speed higher value is faster. 2 is about 200 procent. 1 sounds like normal speak

    ; PROD mode:
    g_ttSpeakObject.SetRate(2) ; speed
    ; -1 is very slow
    ; -5 is terrible slow
    ; 0 seems normal
    ; 2 little faster
    ; 5 reaky fast but possible to understand
    ; g_ttSpeakObject.SetPitch(10)
    g_ttSpeakObject.SetPitch(1) ; tonhöhe high, deep. i like 1 and 10
}
Speak("gestartet")


Sound( text ){
    Speak( text )
}
;/¯¯¯¯ speaking ¯¯ 181101030122 ¯¯ 01.11.2018 03:01:22 ¯¯\
Speak( text, mode := "DEV" ){ ;   ;  (DEV, TEST, STAGING, PROD),
    global g_doSound
    ; if(!g_doSound && mode != "PROD")
    if(!g_doSound)
        return
    if(mode != "PROD")
        return
    text := RegExReplace(text, "([a-z])([A-Z])", "$1 $2")
    text := RegExReplace(text, "(_|\-)", " ")
    text := RegExReplace(text, "\bahk\b", "AHK") ; that sound different
    g_ttSpeakObject.Speak(text) ; https://autohotkey.com/boards/viewtopic.php?p=247009#p247009
}
Speak2(text, mode := "DEV" ){
    if(!g_doSound && mode != "PROD")
        return
	ControlSetText,RICHEDIT50W1,% text,QTranslate ahk_class #32770 ahk_exe QTranslate.exe
	ControlClick,Button4,QTranslate ahk_class #32770 ahk_exe QTranslate.exe
}
;\____ speaking __ 181101030106 __ 01.11.2018 03:01:06 __/






;/¯¯¯¯ SoundbeepString2Sound ¯¯ 181031173251 ¯¯ 31.10.2018 17:32:51 ¯¯\
SoundbeepString2Sound( s, mode := "DEV" ){ ;   ;  (DEV, TEST, STAGING, PROD),
    global g_doSound
    if(!g_doSound && mode != "PROD")
        return
    minPitch := 500
    AHKcode := "#" . "NoTrayIcon `n "
    Loop, % StrLen(s)
    {
        c := SubStr(s, A_Index, 1)
        pitch := (Ord(c)-64) * 40 + minPitch ; A = 64
        AHKcode .= "SoundBeep, " pitch ", 100`n"
        if(A_Index >= 3)
            break
        if(A_Index > 50)
            break
    }
    AHKcode .= "sleep,500"
    DynaRun(AHKcode)
    return
}
;\____ SoundbeepString2Sound __ 181031173259 __ 31.10.2018 17:32:59 __/




;<<<<<<<< <<<< 170814130442 <<<< 14.08.2017 13:04:42 <<<<
SoundbeepString2Sound__ccc(s){
    minPitch := 500
    Loop, % StrLen(s)
    {
        c := SubStr(s, A_Index, 1)
        ; msgbox,% Ord(c) "(" A_LineNumber " " RegExReplace(A_LineFile, ".*\\", "") ")"
        pitch := (Ord(c)-64) * 40 + minPitch ; A = 64
        ;SoundBeep, % pitch, 150 ; Play a higher pitch for half a second.
        SoundBeep, % pitch, 100 ; Play a higher pitch for half a second.
        if(A_Index >= 2)
            break
        if(A_Index > 50)
            break
    }
    sleep,500
    return
}
;>>>>>>>> >>>> 170814130447 >>>> 14.08.2017 13:04:47 >>>>




;<<<<<<<< SoundbeepGameOver <<<< 170814130442 <<<< 14.08.2017 13:04:42 <<<<
SoundbeepGameOver(mode := "DEV" ){ ;   ;  (DEV, TEST, STAGING, PROD),
                      global g_doSound
                      if(!g_doSound && mode != "PROD")
                          return
pitch := 750
AHKcode := "#" . "NoTrayIcon `n "
while(--pitch > 350 ){
	pitch -= 40
	ToolTip, % pitch
	AHKcode .= "SoundBeep, " pitch ", 150`n" ; Play a higher pitch for half a second.
	}
	AHKcode .= "SoundBeep, " pitch + 180 ", 550" ; Play a higher pitch for half a second.
	DynaRun(AHKcode)
}
;>>>>>>>> SoundbeepGameOver >>>> 170814130447 >>>> 14.08.2017 13:04:47 >>>>




;<<<<<<<< SoundbeepMissionImpossibleTheme <<<< 170814103348 <<<< 14.08.2017 10:33:48 <<<<
SoundbeepMissionImpossibleTheme( mode := "DEV" ){ ;   ;  (DEV, TEST, STAGING, PROD),
                                    global g_doSound
                                    if(!g_doSound && mode != "PROD")
                                        return

    AHKcode := "#" . "NoTrayIcon `n "

AHKcode2 =
(

Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 659, 75
Soundbeep, 699, 75
Soundbeep, 740, 75
Soundbeep, 784, 75
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 932, 150
sleep, 150
Soundbeep, 523, 150
sleep, 150
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 699, 150
sleep, 150
Soundbeep, 740, 150
sleep, 150
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 932, 150
sleep, 150
Soundbeep, 523, 150
sleep, 150
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 699, 150
sleep, 150
Soundbeep, 740, 150
sleep, 150
Soundbeep, 932, 150
Soundbeep, 784, 150
Soundbeep, 587, 1200
sleep, 75
Soundbeep, 932, 150
Soundbeep, 784, 150
Soundbeep, 554, 1200
sleep, 75
Soundbeep, 932, 150
Soundbeep, 784, 150
Soundbeep, 523, 1200
sleep, 150
Soundbeep, 466, 150
Soundbeep, 523, 150
)
DynaRun(AHKcode AHKcode2)
return
}
;>>>>>>>> SOUNDBEEPMissionImpossibleTheme >>>> 170814103354 >>>> 14.08.2017 10:33:54 >>>>




;<<<<<<<< SoundbeepNoACK <<<< 170814140127 <<<< 14.08.2017 14:01:27 <<<<
SoundbeepNoACK( mode := "DEV" ){ ;   ;  (DEV, TEST, STAGING, PROD),
                   global g_doSound
                   if(!g_doSound && mode != "PROD")
                       return

    SoundbeepGameOver()
}
;>>>>>>>> SoundbeepNoACK >>>> 170814140131 >>>> 14.08.2017 14:01:31 >>>>

;<<<<<<<< SoundbeepACK <<<< 170814140035 <<<< 14.08.2017 14:00:35 <<<<
SoundbeepACK( mode := "DEV" ){ ;   ;  (DEV, TEST, STAGING, PROD),
                 global g_doSound
                 if(!g_doSound && mode != "PROD")
                     return

    ; SoundbeepMissionImpossibleTheme()
    SoundBeep,500,5000 ; high, timemilli 14.08.2017 09:43
}
;>>>>>>>> SoundbeepACK >>>> 170814140038 >>>> 14.08.2017 14:00:38 >>>>

Class TTS { ; https://autohotkey.com/boards/viewtopic.php?p=247009#p247009
	VoiceList := []
	VoiceAssoc := {}
	VoiceCount := 0
	VoiceNumber := 0
	VoiceName := ""

	__New(){

	    if(!A_Is64bitOS)
	        return

		this.oVoice := ComObjCreate("SAPI.SpVoice")
		this._GetVoices()
		this.SetVoice(this.VoiceList.1)
	}

	ToggleSpeak(text){
		Status := this.oVoice.Status.RunningState
		if Status = 1
			this.oVoice.Speak(text,0x1)
		Else if Status = 0
		{
			this.oVoice.Resume
			this.oVoice.Speak("",0x1|0x2)
			this.oVoice.Speak(text,0x1)
		}
		Else if Status = 2
			this.oVoice.Speak("",0x1|0x2)
	}

	Speak(text){
		Status := this.oVoice.Status.RunningState
		if Status = 0
			this.oVoice.Resume
		try{
		this.oVoice.Speak("",0x1|0x2)
		this.oVoice.Speak(text,0x1)
        } catch e{
            ;throw Exception("Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line, -1)
            tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
            if(1 && InStr(A_ComputerName,"SL5"))
                tooltip, % tip , 1,1
        }
	}

	SpeakWait(text){
		Status := this.oVoice.Status.RunningState
		if Status = 0
			this.oVoice.Resume
		this.oVoice.Speak("",0x1|0x2)
		this.oVoice.Speak(text,0x0)
	}

	Pause(){
		Status := this.oVoice.Status.RunningState
		if Status = 0
			this.oVoice.Resume
		else if Status = 2
			this.oVoice.Pause
	}

	Stop(){
		Status := this.oVoice.Status.RunningState
		if Status = 0
			this.oVoice.Resume
		this.oVoice.Speak("",0x1|0x2)
	}

	SetRate(rate){
		this.oVoice.Rate := rate
	}

	SetVolume(vol){
		this.oVoice.Volume := vol
	}

	SetPitch(pitch){
        try{
            this.oVoice.Speak("<pitch absmiddle = '" pitch "'/>",0x20)
        } catch e{
            if(1 && InStr(A_ComputerName,"SL5") ){
                m := "this.oVoice.Speak failed `n`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
                ToolTip5sec( m "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")", 1 , 1 )
                lll( A_ThisFunc ":" A_LineNumber , A_LineFile , m )
            }
        }

	}

	SetVoice(VoiceName){
		if (!ObjHasKey(this.VoiceAssoc, VoiceName))
			return 0
		While !(this.oVoice.Status.RunningState = 1)
			Sleep, 20
		this.oVoice.Voice := this.oVoice.GetVoices("Name=" VoiceName).Item(0)
		this.VoiceName := VoiceName
		this.VoiceNumber := this.VoiceAssoc[VoiceName]
		return 1
	}

	SetVoiceByIndex(VoiceIndex){
		return this.SetVoice(this.VoiceList[VoiceIndex])
	}

	NextVoice(){
		v := this.VoiceNumber + 1
		if (v > this.VoiceCount)
			v := 1
		return this.SetVoiceByIndex(v)
	}

	GetVoices(){
		return this.VoiceList
	}

	GetStatus(){
		Status := this.oVoice.Status.RunningState
		if Status = 0
			Return "paused"
		Else if Status = 1
			Return "finished"
		Else if Status = 2
			Return "reading"
	}

	GetCount(){
		return this.VoiceCount
	}

	SpeakToFile(param1, param2){
		oldAOS := this.oVoice.AudioOutputStream
		oldAAOFCONS := this.oVoice.AllowAudioOutputFormatChangesOnNextSet
		this.oVoice.AllowAudioOutputFormatChangesOnNextSet := 1

		SpStream := ComObjCreate("SAPI.SpFileStream")
		FileDelete, % param2
		SpStream.Open(param2, 3)
		this.oVoice.AudioOutputStream := SpStream
		this.TTS("SpeakWait", param1)
		SpStream.Close()
		this.oVoice.AudioOutputStream := oldAOS
		this.oVoice.AllowAudioOutputFormatChangesOnNextSet := oldAAOFCONS
	}

	_GetVoices(){
		this.VoiceList := []
		this.VoiceAssoc := {}
		this.VoiceCount := this.oVoice.GetVoices.Count
		Loop, % this.VoiceCount
		{
			Name := this.oVoice.GetVoices.Item(A_Index-1).GetAttribute("Name")
			this.VoiceList.push(Name)
			this.VoiceAssoc[Name] := A_Index
		}
	}
}


