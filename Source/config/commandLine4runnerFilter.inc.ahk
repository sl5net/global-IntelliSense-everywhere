; available vars: .. lang := rX["lang"], exe := g_config["codeRunner"][lang]
codeUrlEncode := UrlEncode( rX["code"] )

if(rX["lang"] == "everything"){
	runString := """" exe """ -search """ rX["key"] """" ; thats for the GUI version
}else
	runString := """" exe """ ""1=" rX["send"] """ ""2=" rX["key"] """ ""3=" codeUrlEncode """"
; clipboard := runString
run,% runString
; msgbox,% runString "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
