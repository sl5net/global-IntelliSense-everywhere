g_config.editor := { 
	AHKStudioAHK : "..\AHK_Studio\AHK_Studio.ahk",
	NotepadPPExe : "C:\Program Files\Notepad++\notepad++.exe",
	AutoAHK : "..\AutoGUI\AutoGUI.ahk"
}
g_config.Send := { 
	RealisticDelayDynamic: false
}
g_config.list := { 
	change: { stopRexExTitle: false } 
}
g_config.sql := { 
	select: { 
		ignReg: "m)^((?!\bActionListID\b\s*[><=]).)*$" ,
		ignIfWhereIsWithoutListID : false
	},
	DB_Browser: "C:\Program Files (x86)\DB Browser for SQLite\DB Browser for SQLite.exe"
}
g_config.FuzzySearch := {
	enable: true,
	MAXlines : 87654,
	keysMAXperEntry : 6,
	minKeysLen: 4,
	doValueCopy : false
}

  ; difficult to implement symlink copy for not rr lines doValueCopy. todo: issue . doValueCopy : false  is not fully implemented
 ; g_config["sql"["select"]["ignIfWhereIsWithoutListID"]
 ; is matching some at the end: at the moment SQL Nr 6,7 and the magic selects later are without ListID 11.01.2019 23:05
 ; g_config["sql"["select"]["ignReg"] not implemented yet 19-01-11_21-39
 ; the regEx .^ never match anything. 
 ; the regEx . ignore all
 ; select: { ignReg: ".^" } 
 ; select: { ignReg: ".^" } 
 ; select: { ignReg: "m)^((?!\bActionListID\b\s*[><=]).)*$" ; <= try to ignore all selects without actioinList in where condition
 