; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ please use this ! as first line in every script before all includes! :)
isDevellopperMode:= true ; enthällt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i init_global.init.inc.ahk


; https://autohotkey.com/boards/viewtopic.php?p=251486#p251486
; by used LoadPicture() ; 05.12.2018 07:50
; load picture to cache before loop lots of pictures, imageSearch can reduce 90% time!

;<<<<<<<< move2ImgORImg <<<< 170826132919 <<<< 26.08.2017 13:29:19 <<<<
move2ImgORImg(i, i2 , textInfo, mm, variation := 85){
   if(!i || !i2 || !textInfo)
   {
      MsgBox, '%i%' = i `n '%i2%' = i2  `n   %textInfo% = textInfo (line:%A_LineNumber%) `n
      return
   }
   kundencenter_Googl = Kundencenter - Google Chrome ahk_class Chrome_WidgetWin_1 ;  

   CoordMode , Pixel , Screen
   CoordMode , Mouse , Screen
   ToolTip, ; clean from distubing tooltips
   ;~ ImageSearch, XPos, YPos, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 %i%
   ; 	 number between 0 and 255 (inclusive) to indicate the allowed number of shades of variation 
   MsgBox, repair... buggy .... move2ImgORImg
   ImageSearch, XPos, YPos1,  0, mm["left"] , mm["top"] , mm["left"] + mm["width"] , mm["top"] + mm["height"] , *%variation% %i%
   ImageSearch, XPos, YPos1, 0, mm["left"] , mm["top"] , mm["width"] , mm["height"] , *%variation% %i%

; https://autohotkey.com/boards/viewtopic.php?p=251486#p251486
; by used LoadPicture()
; load picture to cache before loop lots of pictures, imageSearch can reduce 90% time!
   
   if( YPos1 < 1 )
      
   ImageSearch, XPos, YPos2, 0, mm["left"] , mm["top"] , mm["width"] , mm["height"] , *100 %i2% 
   ImageSearch, XPos, YPos2, 0, mm["left"] , mm["top"] , mm["left"] + mm["width"] , mm["top"] + mm["height"] , *100 %i2% 
      if(!YPos1)
YPos1 := YPos2 ; try prevent empty variables
      if(!YPos2)
YPos2 := YPos1 ; try prevent empty variables

   if(YPos1 < YPos2) ; take the smaler yPos
      YPos :=  YPos1
   else
      YPos :=  YPos2
   ;~ ImageSearch, XPos, YPos, 0, 0, A_ScreenWidth, A_ScreenHeight,  %i%
   if ErrorLevel = 2
   {
      ; 2 if there was a problem that prevented the command from conducting the search (such as failure to open the image file or a badly formatted option).
      ;~ ToolTip2sec(" ErrorLevel = " . ErrorLevel . "`n  :(  `n textInfo =`n" . textInfo . A_LineNumber  ) 
      IfNotExist,%i%
         MsgBox,%i% existiert nicht. `n `n  %i% = i (line:%A_LineNumber%) `n 
      return false
   }
   
   else if ErrorLevel = 1
   {
       msg = ErrorLevel: %ErrorLevel%  `n textInfo =`n '%textInfo%'  `n`n '%i%' `n  '%i2%' `n  `n  :( Icon could not be found on the screen.  `n `n   (line:%A_LineNumber%) `n
      ToolTip4sec(msg)  
      Sleep,4000
         MSgbox,`n (%A_LineFile%~%A_LineNumber%) `
      return false
   }
   
   ;~ MsgBox Das Icon wurde bei %XPos%x%YPos% gefunden.
   CoordMode, Mouse, Screen ; 
   MouseMove,% XPos ,% YPos , 0
   ;~ MouseMove,
   ;~ SetKeyDelay,50,50
   ;~ MouseClick,left,% XPos + 20 ,% YPos + 20 
   return true
}
;>>>>>>>> move2ImgORImg >>>> 170826132937 >>>> 26.08.2017 13:29:37 >>>>

;<<<<<<<< move2Img <<<< 170826132943 <<<< 26.08.2017 13:29:43 <<<<
move2Img(i , textInfo, mm, variation := 85){
   if(!i || !textInfo)
   {
      MsgBox, '%i%' = i (line:%A_LineNumber%) `n  ||  %textInfo% = textInfo (line:%A_LineNumber%) `n
       MSgbox,`n (%A_LineFile%~%A_LineNumber%) `
      return false
   }
   if(mm["left"] == "" || mm["top"] == "" || !mm["width"] || !mm["height"] )
   {
      msg=A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") . " " . A_ThisFunc . A_ThisLabel
      	ToolTip1sec(msg)
mm_left := mm["left"]
mm_top := mm["top"]
mm_width := mm["width"]
mm_height := mm["height"]
msg =
(
'%mm_left%' = mm_left  
'%mm_top%' = mm_top  
'%mm_width%' = mm_width   
'%mm_height%' = mm_height
mm := {left:%mm_left%, top:%mm_top%, width:%mm_width%, height:%mm_height%}
mm := {left:0, top:0, width:A_ScreenWidth, height:A_ScreenHeight}
)

      t =  %msg% `n move2Img_functions.inc.ahk 109:   `n  :( %msg% `n  '%mm%' = mm `n %textInfo% `n  (line:%A_LineNumber%, `n move2Img_functions.inc.ahk )
      ToolTip1sec( t )
       MSgbox,t='%t%' `n (%A_LineFile%~%A_LineNumber%) `
      return false
   }
 coord = Screen
 ;~ coord = Client
   CoordMode, ToolTip, %coord%
CoordMode, Pixel, %coord%
CoordMode, Mouse, %coord%
CoordMode, Caret, %coord%
CoordMode, Menu, %coord%
;~ CoordMode,Client
; 
   ;~ CoordMode , Mouse , Screen
   ;~ CoordMode , Caret , Screen
   ToolTip, ; clean from distubing tooltips
   ;~ ImageSearch, XPos, YPos, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 %i%
   ; 	 number between 0 and 255 (inclusive) to indicate the allowed number of shades of variation 
   ;~ ImageSearch, XPos, YPos, 0, % yOffset , A_ScreenWidth, A_ScreenHeight, *85 %i%
   mmRight := mm["left"] + mm["width"] 
   mmBottom := mm["top"] + mm["height"] 
   ;~ MsgBox, '%variation%' = variation (line:%A_LineNumber%) `n 
   ImageSearchStrig := "XPos, YPos, " . mm["left"] . ", " . mm["top"] . ", " . mmRight . ", " . mmBottom . ", *" . variation . " " . i
   
   global doClickImgWithGreenShotHelp
   ; showGreenShot()
   ; endGreenShot()

   if(doClickImgWithGreenShotHelp){
      showGreenShot() ; endGreenShot() ; 
   }
   ImageSearch       ,  XPos, YPos,     mm["left"]    ,     mm["top"]    ,     mmRight    ,     mmBottom    , *%variation% %i%
   if(doClickImgWithGreenShotHelp){
      endGreenShot() ; showGreenShot()
   }
   ;if no match is found, the variables are made blank
   offset139:=600
   speed:=0
   if(!XPos){

      MouseMove,-%offset139%,-%offset139%,%speed%,R
      if(doClickImgWithGreenShotHelp){
         showGreenShot() ; endGreenShot() ; 
      }
      ImageSearch       ,  XPos, YPos,     mm["left"]    ,     mm["top"]    ,     mmRight    ,     mmBottom    , *%variation% %i%
      MouseMove,%offset139%,%offset139%,%speed%,R
      if(doClickImgWithGreenShotHelp){
         endGreenShot() ; showGreenShot() ; 
      }

   }
   if(!XPos){
      MouseMove,%offset139%,%offset139%,%speed%,R
      if(doClickImgWithGreenShotHelp){
         showGreenShot() ; endGreenShot() ; 
      }
      ImageSearch       ,  XPos, YPos,     mm["left"]    ,     mm["top"]    ,     mmRight    ,     mmBottom    , *%variation% %i%
      if(doClickImgWithGreenShotHelp){
         endGreenShot() ; showGreenShot() ; 
      }
      MouseMove,-%offset139%,-%offset139%,%speed%,R
   }
   
   ;ToolTip3sec(ImageSearchStrig . "`n`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
   ;msgbox,% ImageSearchStrig . "`n`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") . " " . Last_A_This
   ;~ ImageSearch, XPos, YPos, 0, 0, A_ScreenWidth, A_ScreenHeight,  %i%
      ;~ MsgBox,%ErrorLevel% = ErrorLevel (line:%A_LineNumber%) `n %textInfo% = textInfo `n 

   if ErrorLevel = 2
   {
      ; 2 if there was a problem that prevented the command from conducting the search (such as failure to open the image file or a badly formatted option).
      tip := ImageSearchStrig . "`n`n" . " ErrorLevel = " . ErrorLevel . "`n  :( Die Suche konnte nicht durchgeführt werden.  `n textInfo =`n" . textInfo
      ToolTip3sec(tip . "`n`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
      msgbox, % tip . "`n`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") . " " . Last_A_This
      Sleep,3000
      IfNotExist,%i%
         MsgBox,%i% existiert nicht. `n `n  %i% = i (line:%A_LineNumber%) `n 
      return false
   }
   else if ErrorLevel = 1
   {
       msg = ErrorLevel: %ErrorLevel%  `n textInfo =`n '%textInfo%'  `n '%i%' `n  `n  :( Icon could not be found on the screen.  `n `n   (line:%A_LineNumber%) `n
      ToolTip3sec(msg)
      Sleep,2000
         ;MsgBox,%msg% `n `n  %i% = i (line:%A_LineNumber%) `n
      ;~ Sleep,1000
      return false
   }
   
   ;~ MsgBox Das Icon wurde bei %XPos%x%YPos% gefunden.
   CoordMode, Mouse, Screen
   MouseMove,% XPos ,% YPos , 0
   ;~ MouseMove,
   ;~ SetKeyDelay,50,50
   ;~ MouseClick,left,% XPos + 20 ,% YPos + 20 

   ; foundPos := {left:%XPos% , top:%YPos% }
   ;found := {left:%XPos% , top:%YPos% } ; wrong ! not work ! 01.11.2017 11:11
   found := {left:XPos , top:YPos }
   ; msgbox,% foundPos["left"] . "= foundPos[''left''] `n XPos=" . XPos . "`n foundPos=" . foundPos
   ;msgbox,% found["left"] . "= found[''left''] `n XPos=" . XPos . "`n found=" . found
   return found
}
;>>>>>>>> move2Img >>>> 170826133004 >>>> 26.08.2017 13:30:04 >>>>

clickImg(i, textInfo, mm, offset = 20, variation := 85){
   
   ;global doClickImgWithGreenShotHelp
   ; showGreenShot()
   ; endGreenShot()

   
   ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   ; offset , mm are assoziativ arrays
   ; offset could given as number. then it will converted to assoziativ array
   ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

   ret := move2Img(i, textInfo, mm, variation := 85)

   if(ret)
   {
      if(RegExMatch(offset,"\d+"))
      {
         ;~ MsgBox,%offset% = offset (line:%A_LineNumber%) `n 
         ;~ return
         offset := {left: offset, top:offset}  
      }
      ;~ else
         ;~ offset["left"] , offset["top"]
      CoordMode,Mouse
      SetKeyDelay,50,50
      ;~ MouseClick,left,% XPos + 20 ,% YPos + 20 , 1, , R
      MouseClick,left, offset["left"] , offset["top"] , , 0 , ,  R
      if(false){
      ToolTip, its clicked `n  %textInfo% = textInfo (line:%A_LineNumber%) `n 
      Sleep,3000
      ToolTip
   }
      ;~ MouseClick,
      return ret
   }
   return ret
}

setChromeDefaultZoom(kundencenter_Googl, errorLogMetho=""){
   return true
   WinGetActiveTitle,activeTitle
   ;~ Ctrl+0 for default zoom.
   IfWinNotExist,%kundencenter_Googl% 
   {
      SoundBeepString("MsgBox") 
      MsgBox,:( webSite `n  %kundencenter_Googl% `n  not found (line:%A_LineNumber%) `n
      return false
   }
   WinActivate,%kundencenter_Googl% 
   WinWaitActive,%kundencenter_Googl% 
   Send,^0
   WinActivate,%activeTitle%
   Sleep,200
   return  true
}
deselectAllSelectedHtmlFiles(mm)
{

   SetMouseDelay,50
   SetMouseDelay, 80 ; needet. if its to fast clicks ar not recognized
   MouseGetPos,mX,mY
   Loop,99
   {
         MouseMove,0,0,0 ; move out

   if(!clickImg(htmlSelectedPNG,"htmlSelectedPNG",mm) ) 
      break
   }
   
   Loop,99
   {  
   MouseMove,0,0,0 ; move out

   if(!clickImg(phpSelectedPNG,"phpSelectedPNG",mm) ) 
      break
   }
   if(false)
   Loop,99
   {
   MouseMove,0,0,0 ; move out

   if(!clickImg(selectedUserNumber,"selectedUserNumber",mm) ) 
      break
   }
   if(0)
   Loop,99
   {
   MouseMove,0,0,0 ; move out

   if(!clickImg(orangeArea,"orangeArea",mm) ) 
      break
   }
   MouseMove, % mX,% mY,0
   ;~ MsgBox,all deselectAllSelectedHtmlFiles ?
   return
}
downloadAllHtmlFiles_OLD(htmlPNG, tmplPNG,downloadPNG, AktuellesVerzeichnisPNG, symLinksPNGbottom, dirLocal, xM1)
{
    winWaitCorrectWindow() 
   countDownload := 0
   MouseMove,0,100,0,R
   loop,500 ; move pages down
   {
      winWaitCorrectWindow() 
      Send,{WheelDown}
      Sleep,800
      MouseGetPos,xM , yM
downloadEachVisibleHtmlFile( htmlPNG, tmplPNG,  downloadPNG, AktuellesVerzeichnisPNG,  dirLocal, xM0 , yM0 )
 ;     if(move2Img(symLinksPNGbottom, "symLinksPNGbottom")) {
   ; we are at end of file list
   return countDownload
   }}




getAktuellesVerzeichnis(AktuellesVerzeichnisPNG){
 winWaitCorrectWindow() 


   MouseMove,0 , 400, , R
   if(clickImg(AktuellesVerzeichnisPNG,"AktuellesVerzeichnisPNG",mm)){
            ; 222 is not enough for such long names like: Aktuelles Verzeichnis: /html/t3neu/typo3/typo3conf/ext/extension_builder/Resources/Private/CodeTemplates/Extbase/Partials

; thats to long: we cant capture that:
; Aktuelles Verzeichnis: /html/t3neu/typo3/typo3conf/ext/extension_builder/Resources/Private/CodeTemplates/Extbase/Partials/Classes/Model/Methods

   MouseClickDrag, Left, 0, 0, 640, 0, 0, R
   Sleep,20
   SetKeyDelay,40,70
      
   c := sendStrgC()
   
   c := RegExReplace( c  ,"^[^/]*","")
   
   ;~ MsgBox,%c% = c (line:%A_LineNumber%) `n 
   c := RegExReplace( c  ,"\s+","")
   ;~ MsgBox,%c% = c (line:%A_LineNumber%) `n 
   c := Trim( RegExReplace( Trim( c ) ,"^[^/]+?\/","/")) . "/"
   ;~ MsgBox,%c% = c (line:%A_LineNumber%) `n 
   c := RegExReplace( c  ,"/+","\")
   ;~ StringReplace,c,c,/,\,All

   }
   return c
   }
 

moveFilesAndFolders(SourcePattern, DestinationFolder, DoOverwrite := false)
; Moves all files and folders matching SourcePattern into the folder named DestinationFolder and
; returns the number of files/folders that could not be moved. This function requires v1.0.38+
; because it uses FileMoveDir's mode 2.
{
	if DoOverwrite = 1
		DoOverwrite = 2  ; See FileMoveDir for description of mode 2 vs. 1.
	; First move all the files (but not the folders):
    if( !SourcePattern || !DestinationFolder){
	MsgBox,, :( , source or destination could not be empty `n `n  '%SourcePattern%' -> '%DestinationFolder%', 4
      return false
 }
	FileMove, %SourcePattern%, %DestinationFolder%, %DoOverwrite%
	ErrorCount := ErrorLevel
	; Now move all the folders:
	Loop, %SourcePattern%, 2  ; 2 means "retrieve folders only".
	{
		FileMoveDir, %A_LoopFileFullPath%, %DestinationFolder%\%A_LoopFileName%, %DoOverwrite%
		ErrorCount += ErrorLevel
		if ErrorLevel  ; Report each problem folder by name.
			MsgBox Could not move %A_LoopFileFullPath% into %DestinationFolder%.
	}
	return ErrorCount
}

isDirEmpty(Dir){
   Loop %Dir%\*.*, 0, 1
      return false
   return true
}
downloadSelected( downloadPNG, AktuellesVerzeichnisPNG, dirLocal ){
   sleepTime:=150
   ;~ MsgBox,%countDownload% = countDownload (line:%A_LineNumber%) `n 
   downloadPNG =
   ToolTip,clickDownloadButtton
   FileCreateDir,% dirLocal
   Sleep,% sleepTime
   c_Users_lauffer_Dow = C:\Users\lauffer\Downloads
   if(!isDirEmpty){
      timeStamp= %A_YYYY%%A_MM%%A_DD%%A_Min%%A_Sec%
      c_Users_lauffer_DowBACK := c_Users_lauffer_Dow . timeStamp
      FileMoveDir,% c_Users_lauffer_Dow, % c_Users_lauffer_DowBACK
      if ErrorLevel 1 ; if there was a problem or 0 otherwise.
      {
      ToolTip3sec("ErrorLevel is set to 1 if there was a problem or 0 otherwise.") ; 
      }
      Sleep,% sleepTime
      FileCreateDir, % c_Users_lauffer_Dow
      Sleep,% sleepTime
      FileCreateDir, % c_Users_lauffer_DowBACK
      Sleep,% sleepTime
      ;~ MsgBox,rename download folder if not empty
   } ; endOf isDirEmpty
   
   ;~ MsgBox,click downlaod  (line:%A_LineNumber%) `n -, %data% = data (line:%A_LineNumber%) `n 
   clickDownload(downloadPNG,mm, AktuellesVerzeichnisPNG)
   Loop,10
   {
      Sleep,2000
      ErrorCount := MoveFilesAndFolders(c_Users_lauffer_Dow . "\*.*", dirLocal )
      if ErrorCount <> 0
      {
errorCount_files := ErrorCount . " files/folders could not be moved. `n `n  (line: " . A_LineNumber . ") `n "
         ToolTip3sec(errorCount_files)
         MsgBox,%errorCount_files% `n `n  (line:%A_LineNumber%) `n 
      }
   else
      break
   } 
   
   ; reload view completly. thats deselects all. we dont need search up/down pages
   webFtpPNG =
   clickImg(webFtpPNG,"webFtpPNG",mm)
   
   return 
}  

   clickDownload(downloadPNG,mm,AktuellesVerzeichnisPNG){
   scrollToTop(AktuellesVerzeichnisPNG)
   MouseMove,0,350,0,R
   Sleep,200
;~ MsgBox,15-08-09_16-50 ; 
   ToolTip,
   Sleep,10
   if(!clickImg(downloadPNG,"downloadPNG",mm))
   {
      MsgBox,,:( no download, download image was was not searches suggessful `n  (line:%A_LineNumber%) `n  , 4
      ;~ MsgBox,,
   ; reload view completly. thats deselects all. we dont need search up/down pages
   webFtpPNG =
   clickImg(webFtpPNG,"webFtpPNG",mm)
   

}
   return 
}


scrollToTop(AktuellesVerzeichnisPNG){

winWaitCorrectWindow() 
WebFTPManagerPNG = E:\fre\private\office\j...image\2015-08-08 23_05_08-.png
loop,5
{
   res := clickImg(WebFTPManagerPNG,"WebFTPManagerPNG",mm) 
   if(res)
      break
   Sleep,200
}
   if(!res ) {
      MsgBox, , Oops ,:( Oops %WebFTPManagerPNG% = WebFTPManagerPNG (line:%A_LineNumber%) `n , 4
      
   webFtpPNG =
   clickImg(webFtpPNG,"webFtpPNG",mm)

   }

 
   ;~ MouseMove, 0, 200 , , R
   Loop,30
   {
   Send,{WheelUp}
   }
   Sleep,200
   return  
}

getNextNotSelectedDirName(openFoderPNG, mm, variation := 85){
   winWaitCorrectWindow() 

   if( !move2Img(openFoderPNG , "openFoderPNG", mm, variation := 85) )
      return ""
   MouseClickDrag, Left, 0, 0, 180, 0, 0, R
   
   dir := Trim( sendStrgC() )
   toolTip3sec( dir . " = c (line:%A_LineNumber%) `n ")
   return dir 
}
getNextNotSelectedAbsDir_localNotExist( openFoderPNG, mm, dirLocal ){
   Loop,20
   {
      ;~ if InStr(  dirLocal , "\html\panmobil.de\media") 
         ;~ MsgBox,%dirLocal% 1
      
      dir :=""
      dir := getNextNotSelectedDirName(openFoderPNG, mm)
      if( !dir )
         return ""
      ToolTip ,%dir% = dir
      ;~ Sleep,1000
      if( SubStr(dir,1,1)=="." || dir == "www"   || dir == "etc"  || dir == "dev"  || dir == "files"  || dir == "logs"  || dir == "fetchmail" || dir == "tmp" || dir == "bullets" || dir == "buttons" || dir == "emoticons" || dir == "flags" || dir  ==  "logos" ||  (  InStr(  dirLocal , "\html\...edia") > 0 && dir == "frames" )  ||  dir == "backup"  )
      {
         ToolTip, dont use %dir% = dir (line:%A_LineNumber%) `n 
         continue
      }
      dirAbs := trim( RegExReplace( dirLocal . "\" . dir  ,"\s*\\+\s*", "\")  )
      if( !FileExist(dirAbs) ) 
      break
   }
   return  dirAbs
} 


clickOpenFolder(xM1, yM1){
   winWaitCorrectWindow() 
   MouseGetPos, xM2, yM2
   xOffset := xM1 - xM2
   SetKeyDelay,80,40
   SetMouseDelay,80,40
   MouseMove , -%xOffset%, 0 , 50 , R
   MouseClick, left, , , 2
   ;~ MouseClick , left , -%xOffset% , 0 , 2 , 50 , D, R
   ;~ MouseClick , left , -100 , 0 , 2 , 50 , D, R
   return ;~ MouseClick , left , -100 , 0 , 2 , 50 , D, R
}
winWaitCorrectWindow(){
   return true
   kundencenter_Googl = Kundencenter - Google Chrome ahk_class Chrome_WidgetWin_1
   SetTitleMatchMode,1
   IfWinNotActive ,%kundencenter_Googl% 
   {
      WinWaitActive,%kundencenter_Googl% 
      MsgBox,your back in focus. keep on running the script?
   }
   return  
}

downloadAllHtmlFiles( htmlPNG, tmplPNG,  downloadPNG,  symLinksPNGbottom, AktuellesVerzeichnisPNG, dirLocal, xM0, yM0 ) {
           if(!xM0 || !yM0) 
         MsgBox, !xM0 || !yOffset , '%xM0%' = xM0 `n '%yOffset%' = yOffset (line:%A_LineNumber%) `n 

   countFoundEndOfPage := 0
   Loop,299
   {
         ; focus the middle window area
         if(!clickImg(AktuellesVerzeichnisPNG,"AktuellesVerzeichnisPNG",mm)) 
            ToolTip, :( Oops %AktuellesVerzeichnisPNG% = AktuellesVerzeichnisPNG (line:%A_LineNumber%) `n 

      
      winWaitCorrectWindow() 
      countDownload := downloadEachVisibleHtmlFile( htmlPNG, tmplPNG, downloadPNG, AktuellesVerzeichnisPNG,  dirLocal, xM0, yM0 )
      
      if(countDownload) 
      {
         ToolTip,%countDownload% = countDownload (line:%A_LineNumber%) `n 
         ; all files of this pages are downloadet :) great . :) 15-08-12_00-56
      }
   
      ;  are at end of file list ?
      if(move2Img(symLinksPNGbottom, "symLinksPNGbottom", mm, variation := 85)) 
      {
         countFoundEndOfPage := countFoundEndOfPage +1 
         if(countFoundEndOfPage > 0) ; we need to be sure that no file is jumped over. needs proof long enough
         {
            ;~ MsgBox,%countFoundEndOfPage% = countFoundEndOfPage  `n `n %countDownload% = countDownload (line:%A_LineNumber%) `n 
         return true
      }
      }
      Tip= try page down  `n  (line:%A_LineNumber%) `n
      ToolTip, % Tip
      ;~ MsgBox, % Tip
      pageDown()
   }
   return false
}

   ;~ if(	clickImg(htmlPNG, tmplPNG,"htmlPNG, tmplPNG", yM) ) {
downloadEachVisibleHtmlFile( htmlPNG, tmplPNG,  downloadPNG, AktuellesVerzeichnisPNG,  dirLocal, xM0, yM0 ){ 
  winWaitCorrectWindow() 
        if(!xM0 || !yM0) 
         MsgBox, !xM0 || !yM0 , '%xM0%' = xM0 `n '%yOffset%' = yOffset (line:%A_LineNumber%) `n 
countDownload:=0
  yOffset := 0
   loop,99
   {
      if(!fileName := getHtmlFileNameFromScreen(htmlPNG, tmplPNG, xM0 , yOffset )){
         ;~ MsgBox,return ""
         return countDownload
         return ""
      }
      MouseGetPos,xM , yM
      yOffset := yM + 20
;~ ToolTip   , %yOffset% = yOffset (line:%A_LineNumber%) `n    
;~ Sleep,3000
;~ MsgBox   , %yOffset% = yOffset (line:%A_LineNumber%) `n    
      ; 
      fileAdress := dirLocal . fileName
      if(FileExist(fileAdress)){
         MouseClick, :) already saved `n `n  %fileAdress% = fileAdress (line:%A_LineNumber%) `n 
         continue
      }
      countDownload := countDownload + 1
      downloadSelected( downloadPNG, AktuellesVerzeichnisPNG, dirLocal )
      deselectAllSelectedHtmlFiles(mm)
      ;~ MsgBox, all deselect ? `n hopefully `n  (line:%A_LineNumber%) `n 
   }
   return countDownload
}
pageDown(){
  winWaitCorrectWindow() 
  ;~ send,{PgDn}  ; woks not good enoug
  MouseGetPos,xM,yM
  MouseMove,0,150,0,R
  send,{WheelDown}{WheelDown}{WheelDown}
  MouseMove,% xM, % yM, 0
  Sleep,150
  return
}

getHtmlFileNameFromScreen(htmlPNG, tmplPNG, xM0, yOffset){
   ;~ if(yOffset < 150 ) 
      ;~ yOffset := 150
  winWaitCorrectWindow() 
   fileName := ""
   if(	move2ImgORImg(htmlPNG, tmplPNG,"htmlPNG, tmplPNG", yOffset, variation := 85) ) {
      ToolTip1sec("html-file found . line: " .  A_LineNumber) ;
      ;~ MouseGetPos,xM , yM
      ;~ MouseMove,% xM1, % yM, 0
      ; 222 is not enough for such long names like: Aktuelles Verzeichnis: /html/t3neu/typo3/fileadmin/partnerdownloads/mediadownload 
      if(!xM0 ) 
         MsgBox,  %xM0% = xM0 (line:%A_LineNumber%) `n  ||  %yOffset% = yOffset (line:%A_LineNumber%) `n  
      MouseGetPos,xM, yM
      MouseMove,% xM0 , % yM, 0
      MouseClickDrag, Left, 0, 0, 222, 0, 0, R
      fileName := Trim( sendStrgC() ) 
      fileName := RegExReplace(fileName,"\s+.+","") ; cut of second column
      fileExt := SubStr(fileName,-3)
      if(fileExt <> "tmpl" && fileExt <> "html" && fileExt <> ".htm" ) {
            ;~ MsgBox, Oops. wrong extension . `n '%fileName%' = fileName `n %fileExt% = fileExt `n  %yOffset% = yOffset`n   (line:%A_LineNumber%) 
            Sleep,500
            MouseClick,left
         deselectAllSelectedHtmlFiles(mm)
         fileName := ""
      }
      ;~ MsgBox, %fileExt% = fileExt (line:%A_LineNumber%) `n 
   ;~ MsgBox,'%fileName%' = fileName `n  %fileExt% = fileExt `n `n %yOffset% = yOffset`n   (line:%A_LineNumber%) `n 
   } 
   return fileName
}

getMultiMonitor()
{
	;~ Run, "C:\Windows\System32\rundll32.exe" shell32`.dll`,Control_RunDLL desk`.cpl ; opens the monitor dialog window

	;~ SysGet, MouseButtonCount, 43
	SysGet, VirtualScreenWidth, 78
	SysGet, VirtualScreenHeight, 79
    VirtualMonitorLeft := 0
    VirtualMonitorTop := 0

	SysGet, MonitorCount, MonitorCount
	;~ SysGet, MonitorPrimary, MonitorPrimary
	;~ Message .= "Monitor Count:`t" MonitorCount "`nPrimary Monitor:`t" MonitorPrimary
	Loop, %MonitorCount%
	{
		;~ SysGet, MonitorName, MonitorName, %A_Index%
		;~ SysGet, Monitor, Monitor, %A_Index%
		SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
		;~ Message .= "`n`nMonitor:`t#" A_Index "`nName:`t" MonitorName "`nLeft:`t" MonitorLeft "(" MonitorWorkAreaLeft " work)`nTop:`t" MonitorTop " (" MonitorWorkAreaTop " work)`nRight:`t" MonitorRight " (" MonitorWorkAreaRight " work)`nBottom:`t" MonitorBottom "(" MonitorWorkAreaBottom " work)"
      if( VirtualMonitorLeft > MonitorWorkAreaLeft) 
         VirtualMonitorLeft := MonitorWorkAreaLeft
        if( VirtualMonitorTop > MonitorWorkAreaTop) 
         VirtualMonitorTop := MonitorWorkAreaTop
        
	}
;~ Message .= "`n`n VirtualScreenWidth = " . VirtualScreenWidth
;~ Message .= "`n VirtualScreenHeight = " . VirtualScreenHeight
;~ Message .= "`n`n VirtualMonitorLeft = " . VirtualMonitorLeft
;~ Message .= "`n VirtualMonitorTop = " . VirtualMonitorTop
	;~ msgbox % Message
    mm := {left:VirtualMonitorLeft, top:VirtualMonitorTop, width:VirtualScreenWidth, height:VirtualScreenHeight}
	Return mm
}


mouseMove( p, speed = 0 ) {
   if(!p["x"] && !p["y"] )
   {
      p["x"]:=p["left"]
      p["y"] := p["top"]
   }
      if(!p["x"] || !p["y"] )
      {
      msg=A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\") . " " . A_ThisFunc . A_ThisLabel
      ToolTip3sec(msg)
     For key,value in p
      msg .= "`n" key . " = " . value

      MsgBox, :(  `n  (line:%A_LineNumber%) `n  %msg%
      return false
      }
      
      if(0)
      {
            For key,value in p
      msg .= "`n" key . " = " . value

      MsgBox, :(  `n  (line:%A_LineNumber%) `n  %msg%
  
      }
      
   MouseMove,p["x"], p["y"] , speed
}

getMousePos(){
	CoordMode, Mouse, Screen
	MouseGetPos,x , y, id, control
if(StrLen(x) < 1  )
{
   MsgBox, ERROR : '%x%' = x (line:%A_LineNumber%) `n 
}
if(StrLen(y) < 1  )
{
   MsgBox, ERROR : '%y%' = y (line:%A_LineNumber%) `n 
}

    
	p := {x:x, y:y}
	return p
}

MouseMoveRectrangle(mm){
   mm_left := mm["left"]
   mm_top := mm["top"]
   mm_width := mm["width"]
   mm_height := mm["height"]
   speed := 60
   MouseMove, % mm_left , % mm_top, % speed
   MouseMove, % mm_width , 0, % speed , R
   MouseMove, 0 , % mm_height, % speed , R
   MouseMove, % -mm_width , 0, % speed , R
   MouseMove, 0 , % -mm_height, % speed , R
}
 
MsgBoxMM(mm)
{
mm_left := mm["left"]
mm_top := mm["top"]
mm_width := mm["width"]
mm_height := mm["height"]
msg =
(
'%mm_left%' = mm_left
'%mm_top%' = mm_top  
'%mm_width%' = mm_width   
'%mm_height%' = mm_height   
)
      MsgBox, ,  %msg% , :( %msg% `n  '%mm%' = mm `n  `n  (line:%A_LineNumber%) `n , 8
}


;<<<<<<<< endGreenShot <<<< 171010010036 <<<< 10.10.2017 01:00:36 <<<<
; showGreenShot()
endGreenShot(){
Suspend,On
Loop,10
{
   IfWinNotExist,Greenshot capture
      break
   ; this works for closing greenshot 26.08.2017 14:49
   Send,{esc} ; end greenshot
   WinClose,Greenshot capture
   IfWinExist,Greenshot capture
      WinKill,Greenshot capture

   Sleep,100
}
IfWinExist,greenshot capture
{
   WinClose,greenshot capture
   WinKill,greenshot capture
   Send,{esc} ; end greenshot
}
Suspend,Off
;Send,{esc} ; end greenshot
;Send,{esc} ; end greenshot
}
;>>>>>>> endGreenShot >>>> 171010010043 >>>> 10.10.2017 01:00:43 >>>>

;<<<<<<<< showGreenShot <<<< 171010010011 <<<< 10.10.2017 01:00:11 <<<<
showGreenShot(){
	DetectHiddenWindows,On ; needs for finding Avira
SetTitleMatchMode,1
SetTitleMatchMode,Slow
Suspend,On
Loop,9
{
; in some caseses it helps me very very mucht, gives better results if i started grennshot app before
;ControlSend,,{PrintScreen},Greenshot
   ; send,{PrintScreen} ; becouse it triggered. so make a sofisticated config llike below: 29.08.2017 16:11
   Send,{CtrlDown}{ShiftDown}{AltDown}q{AltUp}{ShiftUp}{CtrlUp}
   ; 
IfWinExist,Greenshot capture form
   break
Sleep,40
Sleep,% A_Index * 200
}

}
;>>>>>>>> showGreenShot >>>> 171010010017 >>>> 10.10.2017 01:00:17 >>>>

;<<<<<<<< winActiveCheck <<<< 171030140209 <<<< 30.10.2017 14:02:09 <<<<
winActiveCheck(winExpected , fromLine){
   Loop,5
   {
      WinActivate, % winExpected
      WinWaitActive,% winExpected,,1
      IfWinActive,% winExpected
         break
      Sleep,30
   }
   IfWinNotActive, % winExpected
      MsgBox,%fromLine%>%A_LineNumber%:  `n :( not active `n %winExpected%  
   return
}
;>>>>>>>> winActiveCheck >>>> 171030140214 >>>> 30.10.2017 14:02:14 >>>>


#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise müsen ans Dateiende
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
return 