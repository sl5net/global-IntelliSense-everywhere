;/Â¯Â¯Â¯Â¯ Sql_Temp Â¯Â¯ 181123025153 Â¯Â¯ 23.11.2018 02:51:53 Â¯Â¯\
class Sql_Temp { ; search help: sqltemp tempsql
    ; Static declarations are evaluated only once, before the auto-execute section,
    ; https://autohotkey.com/docs/Objects.htm#Custom_Classes
    valueObj := {}
    static fileNamePrefix := "select0"
; https://autohotkey.com/boards/viewtopic.php?f=76&t=59215&p=249470#p249470

    ;/Â¯Â¯Â¯Â¯ file2sqLite Â¯Â¯ 181123030022 Â¯Â¯ 23.11.2018 03:00:22 Â¯Â¯\
    file2sqLite(fileNamePrefix := "select0"){ ;  Sql_Temp.file2sqLite()
        if(!fileNamePrefix)
            msgbox,% " ERROR !This.fileNamePrefix `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        This.fileNamePrefix := fileNamePrefix

; too tot too too toot toot t


        o := array()
        loop,7
        {
            fileName := fileNamePrefix (A_Index-1) ".sql"

            fileAdress := A_ScriptDir "\sql\template\" fileName
            if(!FileExist(fileAdress)){
                tip := fileAdress " not exist `n`n("A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
                toolTip2sec( tip )
                continue
            }
            FileGetTime, fileModiTime, % fileAdress ;  YYYYMMDDHH24MISS
            FileRead, SELECT,% fileAdress
            if(!SELECT)
                MsgBox, % "!SELECT  `n`n("A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
            fileIndex := A_Index
            ; for most cases:
            regex := "((GLOB|LIKE)\s*'[^'\w]?)([^']+?)([^'\w]?')"

            ; more open works also for:
            ; WHERE wordindexed GLOB upper('s') || '*'
            regex := "((.)'[^'\w]?)([^']+?)([^'\w]?')"

            if(RegExMatch(SELECT,"Oim)" regex,Found)){
                oWord := { pos : Found.Pos(3), len : Found.Len(3) }
                ; msgbox,% ObjToStrTrim(oWord) "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
            } else
                oWord := "" ; importend add 19-01-11_22-41 ; if you dont set it back it always using the old before
            regex := "actionListID\s+(>\s*\d+)"
            if(RegExMatch(SELECT,"Oim)" regex,Found)){
                oListID := { pos : Found.Pos(1), len : Found.Len(1) }
                ; msgbox,% ObjToStrTrim(oListID) "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
            } else
                oListID := "" ; importend add 19-01-11_22-41 ; if you dont set it back it always using the old before
            o[fileIndex] := { sql: SELECT, word: oWord, listID : oListID }
        } ; endOf loop,7

        jsonStr := json(o)
        ; g_actionListDB.BeginTransaction()

        global g_actionListDB

        if(!g_actionListDB)
            g_actionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_actionListDBfileAdress ) ;
         escaped_string := RegExReplace(jsonStr, "'", "''")
        sql := "REPLACE INTO temp (fileModiTime, key, value) VALUES ('" fileModiTime "', '" fileNamePrefix "','" escaped_string "');"
        ; clipboard := sql

        try{
            g_actionListDB.Query(sql)
        } catch e{
            tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
            sqlLastError := SQLite_LastError()
            tip .= "`n sqlLastError=" sqlLastError "`n " sql " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
            lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
            tooltip, `% tip
            feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
            ; Clipboard := tip
            ; msgbox, % tip
        }
   }
    ;\____ file2sqLite __ 181123030130 __ 23.11.2018 03:01:30 __/


; toot



    ;/Â¯Â¯Â¯Â¯ get_valueObj Â¯Â¯ 181123033300 Â¯Â¯ 23.11.2018 03:33:00 Â¯Â¯\
    get_valueObj(){
        if(!This.valueObj)
            msgbox,% " ERROR !This.valueObj `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        return This.valueObj
    }
    ;\____ get_valueObj __ 181123033303 __ 23.11.2018 03:33:03 __/


    ;/Â¯Â¯Â¯Â¯ sqLite2file Â¯Â¯ 181123030211 Â¯Â¯ 23.11.2018 03:02:11 Â¯Â¯\
    sqLite2obj(){
        if(!This.fileNamePrefix)
            msgbox,% " ERROR !This.fileNamePrefix `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        key := This.fileNamePrefix
        global g_actionListDB
        sql := "select value from temp where key = '" key "';"
        ; clipboard := sql
        try{
            Matches  := g_actionListDB.Query(sql)
        } catch e{
            tip:="Exception:`n" e.What "`n" e.Message "`n" e.File "@" e.Line
            sqlLastError := SQLite_LastError()
            tip .= "`n sqlLastError=" sqlLastError "`n " sql " `n( " RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
            lll( A_ThisFunc ":" A_LineNumber , A_LineFile ,tip)
            tooltip, `% tip
            feedbackMsgBox(A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\"), tip )
            ; Clipboard := tip
            ; msgbox, % tip
        }
        for each, row in Matches.Rows
            valueStr := row[1]
        ; clipboard := valueStr
        This.valueObj := json(valueStr)
    }
    ;\____ sqLite2file __ 181123030328 __ 23.11.2018 03:03:28 __/


    ;/Â¯Â¯Â¯Â¯ msgBoxSelectBuild_example Â¯Â¯ 181123031031 Â¯Â¯ 23.11.2018 03:10:31 Â¯Â¯\
    msgBoxSelectBuild_example( word, listID ){
        if(!This.valueObj){
            This.file2sqLite()
            This.sqLite2obj()
        }
        if(!This.valueObj)
            msgbox,% " ERROR  `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        valueObj := This.valueObj ; Sql_Temp
        sql := Array()
        loop,7
        {
            o := valueObj[A_Index]
            sql["pre_Where"] := substr( o["sql"], 1 , o["word"]["pos"] - 1 )
            sql["postWhere"] := substr( o["sql"] , o["word"]["pos"] + 1, - 1 + o["listID"]["pos"] - o["word"]["pos"] )
            sql["rest"] := substr( o["sql"] , o["listID"]["pos"] + 1 )
            ; msgbox,% valueObj[1]["sql"] "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
            newSelect := sql["pre_Where"] "XXXXXX" sql["postWhere"] " = 5555555" sql["rest"]
            msgbox,% newSelect "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        }
    }
    ;\____ msgBoxSelectBuild_example __ 181123031035 __ 23.11.2018 03:10:35 __/

}
;\____ Sql_Temp __ 181123025608 __ 23.11.2018 02:56:08 __/
