; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
; these functions handle database conversion
; always set the SetDbVersion default argument to the current highest version

SetDbVersion(dBVersion = 7){

	global g_actionListDB
    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	g_actionListDB.Query("INSERT OR REPLACE INTO LastState VALUES ('databaseVersion', '" . dBVersion . "', NULL);")
}

;<<<<<<<< MaybeConvertDatabase <<<< 180223091829 <<<< 23.02.2018 09:18:29 <<<<
; returns true if we need to rebuild the whole database
MaybeConvertDatabase(){

	; ToolTip5sec("MaybeConvertDatabase() return false " A_LineNumber . " " . RegExReplace(A_LineFile,".*\\") ,1,1)
	return false
CoordMode, ToolTip, Screen


	global g_actionListDB
	databaseVersionRows := g_actionListDB.Query("SELECT lastStateNumber FROM LastState WHERE lastStateItem = 'databaseVersion';")
	if (databaseVersionRows){
		for each, row in databaseVersionRows.Rows
		{
			databaseVersion := row[1]
		}
	}
	
	if (!databaseVersion){
		   tableConverted := g_actionListDB.Query("SELECT tableconverted FROM LastState;")
	} else {
		tableConverted := g_actionListDB.Query("SELECT lastStateNumber FROM LastState WHERE lastStateItem = 'tableConverted';")
	}
   
	if (tableConverted){
		for each, row in tableConverted.Rows
		{
			actionListConverted := row[1]
		}
	}
	
	IfNotEqual, actionListConverted, 1
	{
		Msgbox,RebuildDatabase()`n RebuildDatabase= %RebuildDatabase%`n `n `n (%A_LineFile%~%A_LineNumber%)
		RebuildDatabase()
		return, true
	}
	
	if (!databaseVersion)
	{
		RunConversionOne(actionListConverted)
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
; Rebuilds the Database from scratch as we have to redo the actionList anyway.
RebuildDatabase(){
	if(0){
		tip := "FALSE NOOO RebuildDatabase `n " A_LineNumber . " " . A_LineFile
		ToolTip5sec(tip)
		MsgBox,4 ,% tip,% tip, 5
		return false
	}
;
	global g_actionListDB
	g_actionListDB.BeginTransaction()

    try{
        g_actionListDB.Query("DROP INDEX WordIndex;")
        g_actionListDB.Query("DROP TABLE IF EXISTS  actionLists;")
        g_actionListDB.Query("DROP TABLE IF EXISTS  performance;")
        g_actionListDB.Query("DROP TABLE IF EXISTS  Words;")
        g_actionListDB.Query("DROP TABLE IF EXISTS  cache;")
        g_actionListDB.Query("DROP TABLE IF EXISTS  LastState;")
        g_actionListDB.EndTransaction()


	    } catch e{
            tip := "Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
            sqlLastError := SQLite_LastError()
            tip .= "`n sqlLastError=" sqlLastError
            lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
            tooltip, `% tip
            feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
            Clipboard := tip
            msgbox, % tip "`n `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
        }

	;sleep,1000
	;pause ; tool tool __ tool to toltip olt
	g_actionListDB.BeginTransaction()

	g_actionListDB.Query("DROP INDEX WordIndex;")
	g_actionListDB.Query("DROP TABLE LastState;")
	g_actionListDB.Query("DROP TABLE actionLists;")
	g_actionListDB.Query("DROP TABLE temp;")

	CreateWordsTable()

	CreateWordIndex()

	CreateLastStateTable()

	CREATE_TABLE_actionLists()

    CreateCacheTable()

	Create_PerformanceMeasurementOf_Functions_Table()
	
	SetDbVersion()

    Sql_Temp.file2sqLite()
    Sql_Temp.sqLite2obj()
    if(!Sql_Temp.valueObj)
        msgbox,% " ERROR !Sql_Temp.valueObj `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"

	g_actionListDB.EndTransaction()
}
;\____ RebuildDatabase __ 181123064751 __ 23.11.2018 06:47:51 __/


; to tool tool tooltip toolipt toolip msgbox msgbox ms msgbox msg msg



;Runs the first conversion
RunConversionOne(actionListConverted){

	global g_actionListDB
    INSERT_function_call_time_millis_since_midnight( RegExReplace(A_LineFile,".*\\") , A_ThisFunc , A_LineNumber)
	g_actionListDB.BeginTransaction()
	
	g_actionListDB.Query("ALTER TABLE LastState RENAME TO OldLastState;")
	
	CreateLastStateTable()
	
	g_actionListDB.Query("DROP TABLE OldLastState;")
	g_actionListDB.Query("INSERT OR REPLACE INTO LastState VALUES ('tableConverted', '" . actionListConverted . "', NULL);")
	
	;superseded by conversion 3
	;g_actionListDB.Query("ALTER TABLE Words ADD COLUMN worddescription TEXT;")
	;g_actionListDB.Query("ALTER TABLE Words ADD COLUMN lineNr INTEGER;")

	SetDbVersion(1)
	g_actionListDB.EndTransaction()
	
}

RunConversionTwo()
{
	global g_actionListDB
	
	;superseded by conversion 3
	;g_actionListDB.Query("ALTER TABLE Words ADD COLUMN wordreplacement TEXT;")
	
	;SetDbVersion(2)
}

RunConversionThree()
{
	global g_actionListDB
	g_actionListDB.BeginTransaction()
	
	CreateWordsTable("Words2")
	
	g_actionListDB.Query("UPDATE Words SET wordreplacement = '' WHERE wordreplacement IS NULL;")
	
	g_actionListDB.Query("INSERT INTO Words2 SELECT * FROM Words;")
	
	g_actionListDB.Query("DROP TABLE Words;")
	
	g_actionListDB.Query("ALTER TABLE Words2 RENAME TO Words;")
	
	CreateWordIndex()
	
	SetDbVersion(3)
	g_actionListDB.EndTransaction()
}

; normalize accented characters
RunConversionFour()
{
	global g_actionListDB
	;superseded by conversion 6
	/*g_actionListDB.BeginTransaction()
	
	Words := g_actionListDB.Query("SELECT word, wordindexed, wordreplacement FROM Words;")
   
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
		
		g_actionListDB.Query("UPDATE Words SET wordindexed = '" . WordIndexedTransformedEscaped . "' WHERE word = '" . WordEscaped . "' AND wordindexed = '" . WordIndexEscaped . "' AND wordreplacement = '" . WordReplacementEscaped . "';")
	}
	; Yes, wordindexed is the transformed word that is actually searched upon.

	SetDbVersion(4)
	g_actionListDB.EndTransaction()
	*/
}

;Creates the actionLists table
RunConversionFive(){
	global g_actionListDB
	g_actionListDB.BeginTransaction()
	CREATE_TABLE_actionLists()
	SetDbVersion(5)
	g_actionListDB.EndTransaction()
}

; normalize accented characters
RunConversionSix(){
	; superseded by conversion 7
}

; normalize accented characters
RunConversionSeven(){
	global g_actionListDB
	g_actionListDB.BeginTransaction()
	
	Words := g_actionListDB.Query("SELECT word, wordindexed, wordreplacement FROM Words;")
	WordDescription = 
   
	for each, row in Words.Rows
	{
		Word := row[1]
		WordIndexed := row[2]
		WordReplacement := row[3]
		
		TransformWord(Word, WordReplacement, WordDescription, WordTransformed, WordIndexedTransformed, WordReplacementTransformed, WordDescriptionTransformed)
		
		StringReplace, OldWordIndexedTransformed, WordIndexed, ', '', All
		
		g_actionListDB.Query("UPDATE Words SET wordindexed = '" . WordIndexedTransformed . "' WHERE word = '" . WordTransformed . "' AND wordindexed = '" . OldWordIndexedTransformed . "' AND wordreplacement = '" . WordReplacementTransformed . "';")
	}
	
	SetDbVersion(7)
	g_actionListDB.EndTransaction()
}

CreateLastStateTable(){
	global g_actionListDB

	IF not g_actionListDB.Query("CREATE TABLE LastState (lastStateItem TEXT PRIMARY KEY, lastStateNumber INTEGER, otherInfo TEXT) WITHOUT ROWID;")
	{
		ErrMsg := g_actionListDB.ErrMsg()
		ErrCode := g_actionListDB.ErrCode()
		MsgBox Cannot Create LastState Table - fatal error: %ErrCode% - %ErrMsg%
		ExitApp
	}
}



INSERT_function_call_time_millis_since_midnight( aLineFile , aThisFunc , aLineNumber){
    return

    ; select ROWID,p.small_LineFile,p.A_ThisFunc,p.actionList,p.actionListsize,p.millisec_dif_to_next_function_call from performance p order by p.millisec_dif_to_next_function_call desc limit 3;
	global g_actionListDB
	global actionList
	global actionListsize

if( !actionListSize && actionList)
    FileGetSize, actionListSize, %actionList%

; millis_since_midnight := JEE_millis_since_midnight(vOpt:="") ; <=== works great but for moment also its ok to use := A_Hour*3600000+A_Min*60000+A_Sec*1000+A_MSec
millis_since_midnight := A_Hour*3600000+A_Min*60000+A_Sec*1000+A_MSec ; <== buggy sometimes but maybe faster ????? 18-10-07_09-49 ; todo make desicion
small_LineFile := RegExReplace(aLineFile,".*\\")
sizeHere := (actionListsize)? actionListsize: 0

        sql := "select * from performance"
        sql := "SELECT last_insert_rowid()"
        sql := "select seq from sqlite_sequence where name=""performance"""
        sql := "select ROWID from performance order by ROWID desc limit 1"
        sql := "select ROWID, millis_since_midnight from performance order by ROWID desc limit 1"
		IF not g_actionListDB.Query(sql)
		{
			ErrMsg := g_actionListDB.ErrMsg() . "`n" . sql . "`n"
			ErrCode := g_actionListDB.ErrCode()

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
        res := g_actionListDB.Query(sql)
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
    g_actionListDB.Query(UPDATE)
}


; ToolTip4sec("InitializeListBox `n " A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " " . Last_A_This)
	sql := "INSERT INTO performance ("
	temp =
(

small_LineFile
, A_ThisFunc
, actionList
, actionListsize
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
, '%actionList%'
, %sizeHere%
, %aLineNumber%
, %A_TickCount%
, %millis_since_midnight%
)
sql .= temp ")"
    IF not g_actionListDB.Query(sql)
    {
        ErrMsg := g_actionListDB.ErrMsg() . "`n" . sql . "`n"
        ErrCode := g_actionListDB.ErrCode()
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
	global g_actionListDB
	global actionList
	sql =
(
CREATE TABLE IF NOT EXISTS %performanceTableName%  (
small_LineFile TEXT NOT NULL
, A_ThisFunc TEXT NOT NULL
, actionList TEXT NOT NULL
, actionListsize INTEGER
, A_LineNumber INTEGER
, A_TickCount INTEGER
, millis_since_midnight INTEGER
, millisec_dif_to_next_function_call INTEGER );
)
;clipboard := sql
; tooltip, % sql
	IF not g_actionListDB.Query(sql)
	{
		ErrMsg := g_actionListDB.ErrMsg() . "`n" . sql . "`n"
		ErrCode := g_actionListDB.ErrCode()
		clipboard := sql
		msg := "Cannot Create " performanceTableName " Table - fatal error: " ErrCode " - " ErrMsg
		ToolTip4sec(msg " (" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") " " Last_A_This)
		MsgBox,% msg "(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		ExitApp
	}
} ; endOfFunction




;/¯¯¯¯ CreateWordsTable ¯¯ 181122195232 ¯¯ 22.11.2018 19:52:32 ¯¯\
CreateWordsTable(WordsTableName:="Words"){
		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"lin1 at CREATE_TABLE_wordS")
		global g_actionListDB
		global g_actionListDBfileAdress
		if(!g_actionListDB)
			g_actionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_actionListDBfileAdress ) ;
;
		sql =
(
CREATE TABLE IF NOT EXISTS %WordsTableName%  (
actionListID INTEGER NOT NULL
, wordindexed TEXT NOT NULL
, word TEXT NOT NULL
, lineNr INTEGER
, count INTEGER
, worddescription TEXT
, wordreplacement TEXT NOT NULL
, PRIMARY KEY `(actionListID, word, wordreplacement) );
)

; g_actionListDB.Query("ALTER TABLE Words ADD COLUMN lineNr INTEGER;")

; actionListID,
;clipboard := sql
		IF not g_actionListDB.Query(sql)
		{
			ErrMsg := g_actionListDB.ErrMsg() . "`n" . sql . "`n"
			ErrCode := g_actionListDB.ErrCode()
			clipboard := sql
			msgbox Cannot Create %WordsTableName% Table - fatal error: %ErrCode% - %ErrMsg%
			ExitApp
		}
	} ; endOfFunction
	
	CreateWordIndex(){
		global g_actionListDB
		
		IF not g_actionListDB.Query("CREATE INDEX WordIndex ON Words (actionListID, wordindexed);")
		{
			ErrMsg := g_actionListDB.ErrMsg()
			if(!instr(ErrMsg," already exists" )){ ; todo: dirty bugfix 22.11.2018 22:15
                ErrCode := g_actionListDB.ErrCode()
                tip := "Cannot Create WordIndex Index - fatal error: `n`n" ErrCode " `n`n-`n`n " ErrMsg
                msgbox, % tip "`n `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
                ExitApp
			}
		}
	}
;
;\____ CreateWordsTable __ 181122195242 __ 22.11.2018 19:52:42 __/


	
;<<<<<<<< CREATE_TABLE_actionLists <<<< 180218062159 <<<< 18.02.2018 06:21:59 <<<<
	CREATE_TABLE_actionLists(){

		lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,"lin1 at CREATE_TABLE_actionLists")
		global g_actionListDB
		global g_actionListDBfileAdress
		if(!g_actionListDB)
			g_actionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_actionListDBfileAdress ) ;
		
		sql := "CREATE TABLE IF NOT EXISTS actionLists (id INTEGER PRIMARY KEY AUTOINCREMENT, actionList TEXT, actionListmodified DATETIME, actionListsize INTEGER, lastusedByUser_since_midnight INTEGER)"

		IF not g_actionListDB.Query(sql)
		{
			ErrMsg := g_actionListDB.ErrMsg()
			ErrCode := g_actionListDB.ErrCode()
			clipboard := sql
			msgbox, Cannot Create actionLists Table - fatal error: %ErrCode% - %ErrMsg%  `n sql= %sql% `n  (%A_LineFile%~%A_LineNumber%)
			ExitApp
		}
	}
;>>>>>>>> CREATE_TABLE_actionLists >>>> 180218062205 >>>> 18.02.2018 06:22:05 >>>>

;/¯¯¯¯ CreateActionListsTable ¯¯ 181106182616 ¯¯ 06.11.2018 18:26:16 ¯¯\
	CreateActionListsTable(){
		Msgbox,deprecated ==> return `n (%A_LineFile%~%A_LineNumber%)
		return
		
		global g_actionListDB
		
		sql =
		(
		CREATE TABLE actionLists
		(actionList TEXT PRIMARY KEY
		, actionListmodified DATETIME
		, actionListsize INTEGER
		, lastUsedByUser_since_midnight INTEGER)
		WITHOUT ROWID;
		)

		CREATE_TABLE_actionLists := "CREATE TABLE actionLists (actionList TEXT PRIMARY KEY, actionListmodified DATETIME, actionListsize INTEGER) WITHOUT ROWID;"
		IF not g_actionListDB.Query( CREATE_TABLE_actionLists )
		{
			ErrMsg := g_actionListDB.ErrMsg()
			ErrCode := g_actionListDB.ErrCode()
			clipboard := CREATE_TABLE_actionLists
			msgbox Cannot Create actionLists Table - fatal error: %ErrCode% - %ErrMsg% `n %CREATE_TABLE_actionLists%
			ExitApp
		}
	}
;\____ CreateActionListsTable __ 181106182623 __ 06.11.2018 18:26:23 __/




;/¯¯¯¯ CreateCacheTable ¯¯ 181122195404 ¯¯ 22.11.2018 19:54:04 ¯¯\
CreateCacheTable(){
    global g_actionListDB

    sql =
    (
    CREATE TABLE temp
    (
    key TEXT PRIMARY KEY
    , fileModiTime INTEGER
    , value TEXT
    WITHOUT ROWID  );
    )

    IF not g_actionListDB.Query( sql )
    {
        ErrMsg := g_actionListDB.ErrMsg()
        ErrCode := g_actionListDB.ErrCode()
        clipboard := sql
        msgbox Cannot Create actionLists Table - fatal error: %ErrCode% - %ErrMsg% `n %sql%
        ExitApp
    }
}
;\____ CreateCacheTable __ 181122195408 __ 22.11.2018 19:54:08 __/