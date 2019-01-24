commandLine4runnerFilter(ByRef rX, ByRef g_config, ByRef g_Word){
            exe := g_config["codeRunner"][rX["lang"]]
      ; msgbox,% exe "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
; available vars: .. lang := rX["lang"], exe := g_config["codeRunner"][lang]
codeUrlEncode := UrlEncode( rX["code"] )

if(rX["lang"] == "everything"){
	runString := """" exe """ -search """ rX["key"] """" ; thats for the GUI version
}else if(false){
      ;/¯¯¯¯ Reformatting_Autohotkey_Source.php
      ; doSaveFirst := isFileOpendInSciteUnsaved(filename)
       ;~ MsgBox,%filename% = filename (line:%A_LineNumber%) `n %doSaveFirst% = doSaveFirst (line:%A_LineNumber%) `n
       phpFile = %A_ScriptDir%\plugins\php\Reformatting_Autohotkey_Source.php

       argv = --source1="%oSciTE_CurrentFile%" --A_ThisLabel="%A_ThisLabel%" --indentStyle="SL5net_small_v0.1"
       phpCgiExe := g_config["codeRunner"]["php"]
       runPHP_link := getRunPHP_link(phpFile , argv, phpCgiExe)
       ;if(doSaveFirst)
       ;   saveWait(A_ScriptDir)
       run, % runPHP_link ,,Hide
       if(!doSaveFirst)
          Sleep,300
       runPHP_link_runDebug = %runPHP_link% = runPHP_link (line:%A_LineNumber%) `n
       Clipboard := runPHP_link_runDebug " 19-01-24_01-01"
       msg := runPHP_link_runDebug
       feedbackMsgBox(msg,msg,1,1,6)
       ;\____ Reformatting_Autohotkey_Source.php
}else
	runString := """" exe """ ""1=" rX["send"] """ ""2=" rX["key"] """ ""3=" codeUrlEncode """"
; clipboard := runString
run,% runString
; msgbox,% runString "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
}


