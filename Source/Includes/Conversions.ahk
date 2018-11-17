; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
; these functions handle database conversion
; always set the SetDbVersion default argument to the current highest version

SetDbVersion(dBVersion = 7){

	global g_ActionListDB
    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	g_ActionListDB.Query("INSERT OR REPLACE INTO LastState VALUES ('databaseVersion', '" . dBVersion . "', NULL);")
}

;<<<<<<<< MaybeConvertDatabase <<<< 180223091829 <<<< 23.02.2018 09:18:29 <<<<
; returns true if we need to rebuild the whole database
MaybeConvertDatabase(){

	; ToolTip5sec("MaybeConvertDatabase() return false " A_LineNumber . " " . RegExReplace(A_LineFile,".*\\") ,1,1)
	return false
CoordMode, ToolTip, Screen


	global g_ActionListDB
	databaseVersionRows := g_ActionListDB.Query("SELECT lastStateNumber FROM LastState WHERE lastStateItem = 'databaseVersion';")
	if (databaseVersionRows){
		for each, row in databaseVersionRows.Rows
		{
			databaseVersion := row[1]
		}
	}
	
	if (!databaseVersion){
		   tableConverted := g_ActionListDB.Query("SELECT tableconverted FROM LastState;")
	} else {
		tableConverted := g_ActionListDB.Query("SELECT lastStateNumber FROM LastState WHERE lastStateItem = 'tableConverted';")
	}
   
	if (tableConverted){
		for each, row in tableConverted.Rows
		{
			ActionListConverted := row[1]
		}
	}
	
	IfNotEqual, ActionListConverted, 1
	{
		Msgbox,RebuildDatabase()`n RebuildDatabase= %RebuildDatabase%`n `n `n (%A_LineFile%~%A_LineNumber%)
		RebuildDatabase()
		return, true
	}
	
	if (!databaseVersion)
	{
		RunConversionOne(ActionListConverted)
	}
	
	if (databaseVersion < 2)
	{
		RunConversionTwo()
	}
	
	if (databaseVersion < 3)
	{
		RunConversionThree()
	}
	
	if (databaseVersion < 4)
	{
		RunConversionFour()
	}
	
	if (databaseVersion < 5)
	{
		RunConversionFive()
	}
	
	if (databaseVersion < 6)
	{
		RunConversionSix()
	}
	
	if (databaseVersion < 7)
	{
		RunConversionSeven()
	}
	
	return, false
}


;/¯¯¯¯ RebuildDatabase ¯¯ 181027180644 ¯¯ 27.10.2018 18:06:44 ¯¯\
; Rebuilds the Database from scratch as we have to redo the ActionList anyway.
RebuildDatabase(){
	if(0){
		tip := "FALSE NOOO RebuildDatabase `n " A_LineNumber . " " . A_LineFile
		ToolTip5sec(tip)
		MsgBox,4 ,% tip,% tip, 5
		return false
	}
;
	global g_ActionListDB
	g_ActionListDB.BeginTransaction()
	g_ActionListDB.Query("DROP TABLE Words;")
	g_ActionListDB.Query("DROP INDEX WordIndex;")
	g_ActionListDB.Query("DROP TABLE LastState;")
	g_ActionListDB.Query("DROP TABLE ActionLists;")
	
	CreateWordsTable()
	CreateWordIndex()

	CreateLastStateTable()
	CREATE_TABLE_ActionLists()

	Create_PerformanceMeasurementOf_Functions_Table()
	
	SetDbVersion()
	g_ActionListDB.EndTransaction()
}

;Runs the first conversion
RunConversionOne(ActionListConverted){

	global g_ActionListDB
    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	g_ActionListDB.BeginTransaction()
	
	g_ActionListDB.Query("ALTER TABLE LastState RENAME TO OldLastState;")
	
	CreateLastStateTable()
	
	g_ActionListDB.Query("DROP TABLE OldLastState;")
	g_ActionListDB.Query("INSERT OR REPLACE INTO LastState VALUES ('tableConverted', '" . ActionListConverted . "', NULL);")
	
	;superseded by conversion 3
	;g_ActionListDB.Query("ALTER TABLE Words ADD COLUMN worddescription TEXT;")
	;g_ActionListDB.Query("ALTER TABLE Words ADD COLUMN lineNr INTEGER;")

	SetDbVersion(1)
	g_ActionListDB.EndTransaction()
	
}

RunConversionTwo()
{
	global g_ActionListDB
	
	;superseded by conversion 3
	;g_ActionListDB.Query("ALTER TABLE Words ADD COLUMN wordreplacement TEXT;")
	
	;SetDbVersion(2)
}

RunConversionThree()
{
	global g_ActionListDB
	g_ActionListDB.BeginTransaction()
	
	CreateWordsTable("Words2")
	
	g_ActionListDB.Query("UPDATE Words SET wordreplacement = '' WHERE wordreplacement IS NULL;")
	
	g_ActionListDB.Query("INSERT INTO Words2 SELECT * FROM Words;")
	
	g_ActionListDB.Query("DROP TABLE Words;")
	
	g_ActionListDB.Query("ALTER TABLE Words2 RENAME TO Words;")
	
	CreateWordIndex()
	
	SetDbVersion(3)
	g_ActionListDB.EndTransaction()
}

; normalize accented characters
RunConversionFour()
{
	global g_ActionListDB
	;superseded by conversion 6
	/*g_ActionListDB.BeginTransaction()
	
	Words := g_ActionListDB.Query("SELECT word, wordindexed, wordreplacement FROM Words;")
   
	for each, row in Words.Rows
	{
		Word := row[1]
		WordIndexed := row[2]
		WordReplacement := row[3]		
		
		WordIndexedTransformed := StrUnmark(WordIndexed)
		
		StringReplace, WordIndexedTransformedEscaped, WordIndexedTransformed, ', '', All		
		StringReplace, WordEscaped, Word, ', '', All
		StringReplace, WordIndexEscaped, WordIndexed, ', '', All
		StringReplace, WordReplacementEscaped, WordReplacement, ', '', All
		
		g_ActionListDB.Query("UPDATE Words SET wordindexed = '" . WordIndexedTransformedEscaped . "' WHERE word = '" . WordEscaped . "' AND wordindexed = '" . WordIndexEscaped . "' AND wordreplacement = '" . WordReplacementEscaped . "';")
	}
	; Yes, wordindexed is the transformed word that is actually searched upon.

	SetDbVersion(4)
	g_ActionListDB.EndTransaction()
	*/
}

;Creates the ActionLists table
RunConversionFive(){
	global g_ActionListDB
	g_ActionListDB.BeginTransaction()
	CREATE_TABLE_ActionLists()
	SetDbVersion(5)
	g_ActionListDB.EndTransaction()
}

; normalize accented characters
RunConversionSix(){
	; superseded by conversion 7
}

; normalize accented characters
RunConversionSeven(){
	global g_ActionListDB
	g_ActionListDB.BeginTransaction()
	
	Words := g_ActionListDB.Query("SELECT word, wordindexed, wordreplacement FROM Words;")
	WordDescription = 
   
	for each, row in Words.Rows
	{
		Word := row[1]
		WordIndexed := row[2]
		WordReplacement := row[3]
		
		TransformWord(Word, WordReplacement, WordDescription, WordTransformed, WordIndexedTransformed, WordReplacementTransformed, WordDescriptionTransformed)
		
		StringReplace, OldWordIndexedTransformed, WordIndexed, ', '', All
		
		g_ActionListDB.Query("UPDATE Words SET wordindexed = '" . WordIndexedTransformed . "' WHERE word = '" . WordTransformed . "' AND wordindexed = '" . OldWordIndexedTransformed . "' AND wordreplacement = '" . WordReplacementTransformed . "';")
	}
	
	SetDbVersion(7)
	g_ActionListDB.EndTransaction()
}

CreateLastStateTable(){
	global g_ActionListDB

	IF not g_ActionListDB.Query("CREATE TABLE LastState (lastStateItem TEXT PRIMARY KEY, lastStateNumber INTEGER, otherInfo TEXT) WITHOUT ROWID;")
	{
		ErrMsg := g_ActionListDB.ErrMsg()
		ErrCode := g_ActionListDB.ErrCode()
		MsgBox Cannot Create LastState Table - fatal error: %ErrCode% - %ErrMsg%
		ExitApp
	}
}



INSERT_function_call_time_millis_since_midnight( aLineFile , aThisFunc , aLineNumber){
    return

    ; select ROWID,p.small_LineFile,p.A_ThisFunc,p.ActionList,p.ActionListsize,p.millisec_dif_to_next_function_call from performance p order by p.millisec_dif_to_next_function_call desc limit 3;
	global g_ActionListDB
	global ActionList
	global ActionListsize

if( !ActionListSize && ActionList)
    FileGetSize, ActionListSize, %ActionList%

; millis_since_midnight := JEE_millis_since_midnight(vOpt:="") ; <=== works great but for moment also its ok to use := A_Hour*3600000+A_Min*60000+A_Sec*1000+A_MSec
millis_since_midnight := A_Hour*3600000+A_Min*60000+A_Sec*1000+A_MSec ; <== buggy sometimes but maybe faster ????? 18-10-07_09-49 ; todo make desicion
small_LineFile := RegExReplace(aLineFile,".*\\")
sizeHere := (ActionListsize)? ActionListsize: 0

        sql := "select * from performance"
        sql := "SELECT last_insert_rowid()"
        sql := "select seq from sqlite_sequence where name=""performance"""
        sql := "select ROWID from performance order by ROWID desc limit 1"
        sql := "select ROWID, millis_since_midnight from performance order by ROWID desc limit 1"
		IF not g_ActionListDB.Query(sql)
		{
			ErrMsg := g_ActionListDB.ErrMsg() . "`n" . sql . "`n"
			ErrCode := g_ActionListDB.ErrCode()

            ;tool tip msgbox too too too mmgw() msg t MsgBox,% msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
            ; tooltip

            sqlLastError := SQLite_LastError()
            if( instr(sqlLastError, "no such table") ){
    			Create_PerformanceMeasurementOf_Functions_Table()
    			MsgBox,% ErrMsg " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
               return
            }


			return
			; clipboard := sql
			; msgbox Cannot select performance Table - fatal error: %ErrCode% - %ErrMsg%
			, ExitApp
		}
        res := g_ActionListDB.Query(sql)
        For each, id in res.Rows
        {
            last_insert_rowid := id[1]
            last_millis_since_midnight := id[2]
            ; msgbox,% last_millis_since_midnight  " = last_millis_since_midnight(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        }
        ; msgbox,% res  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"

                sql := "select ROWID, millis_since_midnight from performance order by ROWID desc limit 1"

;
millis_since_midnight := JEE_millis_since_midnight(vOpt:="")
if(last_millis_since_midnight && millis_since_midnight){
    if(millis_since_midnight < last_millis_since_midnight){
        msgbox,":( that could not happen (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        return
    }
    millisec_dif_to_next_function_call := millis_since_midnight - last_millis_since_midnight
    millisec_dif_to_next_function_call := (millisec_dif_to_next_function_call)? millisec_dif_to_next_function_call: 0
    UPDATE := "Update performance SET millisec_dif_to_next_function_call = " millisec_dif_to_next_function_call " where ROWID = " last_insert_rowid ";"
    g_ActionListDB.Query(UPDATE)
}


; ToolTip4sec("InitializeListBox `n " A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
	sql := "INSERT INTO performance ("
	temp =
(

small_LineFile
, A_ThisFunc
, ActionList
, ActionListsize
, A_LineNumber
, A_TickCount
, millis_since_midnight
)
sql .= temp
	sql .= ") VALUES ("
temp =
(
'%small_LineFile%'
, '%aThisFunc%'
, '%ActionList%'
, %sizeHere%
, %aLineNumber%
, %A_TickCount%
, %millis_since_midnight%
)
sql .= temp ")"
    IF not g_ActionListDB.Query(sql)
    {
        ErrMsg := g_ActionListDB.ErrMsg() . "`n" . sql . "`n"
        ErrCode := g_ActionListDB.ErrCode()
        ; clipboard := sql
        msg := "Cannot insert performance Table - fatal error: " ErrCode " - " ErrMsg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        ; msgbox, % "Cannot insert performance Table - fatal error: " ErrCode " - " ErrMsg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
        ToolTip4sec(msg " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
        return
        ;ExitApp
    }
    ;clipboard := sql
    ;msgbox, % sql  "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
}



; sqlite  auto-incrementing :
; You get one for free, called ROWID. This is in every SQLite table whether you ask for it or not.
; If you include a column of type INTEGER PRIMARY KEY, that column points at (is an alias for) the automatic ROWID column.
; you can use ROWID in your select statement e.g. select rowid from people;

; Performance_measurement_functions_Table
Create_PerformanceMeasurementOf_Functions_Table(performanceTableName := "performance"){
	lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"lin1 at CREATE_TABLE_performance")
	global g_ActionListDB
	global ActionList
	sql =
(
CREATE TABLE IF NOT EXISTS %performanceTableName%  (
small_LineFile TEXT NOT NULL
, A_ThisFunc TEXT NOT NULL
, ActionList TEXT NOT NULL
, ActionListsize INTEGER
, A_LineNumber INTEGER
, A_TickCount INTEGER
, millis_since_midnight INTEGER
, millisec_dif_to_next_function_call INTEGER );
)
;clipboard := sql
; tooltip, % sql
	IF not g_ActionListDB.Query(sql)
	{
		ErrMsg := g_ActionListDB.ErrMsg() . "`n" . sql . "`n"
		ErrCode := g_ActionListDB.ErrCode()
		clipboard := sql
		msg := "Cannot Create " performanceTableName " Table - fatal error: " ErrCode " - " ErrMsg
		ToolTip4sec(msg " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
		MsgBox,% msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		ExitApp
	}
} ; endOfFunction
	
	CreateWordsTable(WordsTableName:="Words"){
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"lin1 at CREATE_TABLE_wordS")
		global g_ActionListDB
		global g_ActionListDBfileAdress
		if(!g_ActionListDB)
			g_ActionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_ActionListDBfileAdress ) ;
;
		sql =
(
CREATE TABLE IF NOT EXISTS %WordsTableName%  (
ActionListID INTEGER NOT NULL
, wordindexed TEXT NOT NULL
, word TEXT NOT NULL
, lineNr INTEGER
, count INTEGER
, worddescription TEXT
, wordreplacement TEXT NOT NULL
, PRIMARY KEY `(ActionListID, word, wordreplacement) );
)

; g_ActionListDB.Query("ALTER TABLE Words ADD COLUMN lineNr INTEGER;")

; ActionListID,
;clipboard := sql
		tooltip, % sql
		IF not g_ActionListDB.Query(sql)
		{
			ErrMsg := g_ActionListDB.ErrMsg() . "`n" . sql . "`n"
			ErrCode := g_ActionListDB.ErrCode()
			clipboard := sql
			msgbox Cannot Create %WordsTableName% Table - fatal error: %ErrCode% - %ErrMsg%
			ExitApp
		}
	} ; endOfFunction
	
	CreateWordIndex(){
		global g_ActionListDB
		
		IF not g_ActionListDB.Query("CREATE INDEX WordIndex ON Words (ActionListID, wordindexed);")
		{
			ErrMsg := g_ActionListDB.ErrMsg()
			ErrCode := g_ActionListDB.ErrCode()
			msgbox Cannot Create WordIndex Index - fatal error: %ErrCode% - %ErrMsg%
			ExitApp
		}
	}
;
	
;<<<<<<<< CREATE_TABLE_ActionLists <<<< 180218062159 <<<< 18.02.2018 06:21:59 <<<<
	CREATE_TABLE_ActionLists(){
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"lin1 at CREATE_TABLE_ActionLists")
		global g_ActionListDB
		global g_ActionListDBfileAdress
		if(!g_ActionListDB)
			g_ActionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_ActionListDBfileAdress ) ;
		
		sql := "CREATE TABLE IF NOT EXISTS ActionLists (id INTEGER PRIMARY KEY AUTOINCREMENT, ActionList TEXT, ActionListmodified DATETIME, ActionListsize INTEGER, lastusedByUser_since_midnight INTEGER)"

		IF not g_ActionListDB.Query(sql)
		{
			ErrMsg := g_ActionListDB.ErrMsg()
			ErrCode := g_ActionListDB.ErrCode()
			clipboard := sql
			msgbox, Cannot Create ActionLists Table - fatal error: %ErrCode% - %ErrMsg%  `n sql= %sql% `n  (%A_LineFile%~%A_LineNumber%)
			ExitApp
		}
	}
;>>>>>>>> CREATE_TABLE_ActionLists >>>> 180218062205 >>>> 18.02.2018 06:22:05 >>>>

;/¯¯¯¯ CreateActionListsTable ¯¯ 181106182616 ¯¯ 06.11.2018 18:26:16 ¯¯\
	CreateActionListsTable()
	{
		Msgbox,deprecated ==> return `n (%A_LineFile%~%A_LineNumber%)
		return
		
		global g_ActionListDB
		
		sql =
		(
		CREATE TABLE ActionLists
		(ActionList TEXT PRIMARY KEY
		, ActionListmodified DATETIME
		, ActionListsize INTEGER
		, lastUsedByUser_since_midnight INTEGER)
		WITHOUT ROWID;
		)

		CREATE_TABLE_ActionLists := "CREATE TABLE ActionLists (ActionList TEXT PRIMARY KEY, ActionListmodified DATETIME, ActionListsize INTEGER) WITHOUT ROWID;"
		IF not g_ActionListDB.Query( CREATE_TABLE_ActionLists )
		{
			ErrMsg := g_ActionListDB.ErrMsg()
			ErrCode := g_ActionListDB.ErrCode()
			clipboard := CREATE_TABLE_ActionLists
			msgbox Cannot Create ActionLists Table - fatal error: %ErrCode% - %ErrMsg% `n %CREATE_TABLE_ActionLists%
			ExitApp
		}
	}
;\____ CreateActionListsTable __ 181106182623 __ 06.11.2018 18:26:23 __/