; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
ScriptNameLetter := SubStr(A_ScriptName, 1 , 1)
ScriptNameLetter2 := SubStr(A_ScriptName, 1 , 2)
;~ tatam
if(!iconAdress)
  iconAdress=%A_ScriptDir%\icon\abc123\%ScriptNameLetter2%.ico

; Checks for the existence of a file or folder.
ifexist,%iconAdress%
	Menu, Tray, Icon, %iconAdress%
else
  ToolTip,http://www.branchenbuch-weltweit.dk/img/abc/a.png
  
  ; probably very good icon programm: http://www.mitec.cz/iconex.html
  
  ;~ May useful : http://antifavicon.com/
  ; http://www.grsites.com/generate/group/9000/ hÃ¼bsch? aber sicher?
  ; batch pix to icon http://www.axialis.com/tutorials/tutorial-iw001.html

;~ http://pcwizkidstechtalk.com/index.php/win7-icons.html
;~ Menu, Tray, Icon, shell32.dll, 44 ; thats a pretty star
;~ Menu, Tray, Icon, shell32.dll, 2 ; a ide or floppy
;~ Menu, Tray, Icon, shell32.dll, 250 ; pretty green stick
;~ Menu, Tray, Icon, shell32.dll, 250 ; pretty black stick

;~ Menu, Tray, Icon, shell32.dll, 240 ; pretty green clock
;~ Menu, Tray, Icon, shell32.dll, 266 ; pretty black clock

;~ There are some icons built into the operating system's DLLs and CPLs that might be useful. 
;~ For example: Menu, Tray, Icon, Shell32.dll, 174 ; Omits the DLL's path so that it works on Windows 9x too.
