;/¯¯¯¯ Sql_Temp ¯¯ 181123025153 ¯¯ 23.11.2018 02:51:53 ¯¯\
class Sql_Temp {
    ; Static declarations are evaluated only once, before the auto-execute section,
    ; https://autohotkey.com/docs/Objects.htm#Custom_Classes
    valueObj := {}
    static fileNamePrefix := "select0"
; https://autohotkey.com/boards/viewtopic.php?f=76&t=59215&p=249470#p249470
    ;/¯¯¯¯ file2sqLite ¯¯ 181123030022 ¯¯ 23.11.2018 03:00:22 ¯¯\
    file2sqLite(fileNamePrefix := "select0"){ ;  Sql_Temp.file2sqLite()
        if(!fileNamePrefix)
            msgbox,% " ERROR !This.fileNamePrefix `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        This.fileNamePrefix := fileNamePrefix

; too

        o := array()
        loop,6
        {
            fileName := fileNamePrefix A_Index ".sql"
            fileAdress := A_ScriptDir "\sql\template\" fileName
            if(!FileExist(fileAdress))
                MsgBox,  % fileAdress " not exist `n`n("A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
            FileRead, SELECT,% fileAdress
            if(!SELECT)
                MsgBox, % "!SELECT  `n`n("A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
            fileIndex := A_Index
            regex := "((GLOB|LIKE)\s*'[^'\w]?)([^']+?)([^'\w]?')"
            if(RegExMatch(SELECT,"Oim)" regex,Found)){
                oWord := { pos : Found.Pos(3), len : Found.Len(3) }
                ; msgbox,% ObjToStrTrim(oWord) "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
            }
            regex := "ActionListID\s+(>\s*\d+)"
            if(RegExMatch(SELECT,"Oim)" regex,Found)){
                oListID := { pos : Found.Pos(1), len : Found.Len(1) }
                ; msgbox,% ObjToStrTrim(oListID) "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
            }
            o[fileIndex] := { sql: SELECT, word: oWord, listID : oListID }
        }
        jsonStr := json(o)
        ; g_ActionListDB.BeginTransaction()

        global g_ActionListDB

        if(!g_ActionListDB)
            g_ActionListDB := DBA.DataBaseFactory.OpenDataBase("SQLite", g_ActionListDBfileAdress ) ;
         escaped_string := RegExReplace(jsonStr, "'", "''")
        sql := "INSERT INTO temp (key, value) VALUES ('" fileNamePrefix "','" escaped_string "');"
        ; clipboard := sql

        try{
            g_ActionListDB.Query(sql)
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



    ;/¯¯¯¯ get_valueObj ¯¯ 181123033300 ¯¯ 23.11.2018 03:33:00 ¯¯\
    get_valueObj(){
        if(!This.valueObj)
            msgbox,% " ERROR !This.valueObj `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        return This.valueObj
    }
    ;\____ get_valueObj __ 181123033303 __ 23.11.2018 03:33:03 __/


    ;/¯¯¯¯ sqLite2file ¯¯ 181123030211 ¯¯ 23.11.2018 03:02:11 ¯¯\
    sqLite2obj(){
        if(!This.fileNamePrefix)
            msgbox,% " ERROR !This.fileNamePrefix `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        key := This.fileNamePrefix
        global g_ActionListDB
        sql := "select value from temp where key = '" key "';"
        ; clipboard := sql
        try{
            Matches  := g_ActionListDB.Query(sql)
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


    ;/¯¯¯¯ msgBoxSelectBuild_example ¯¯ 181123031031 ¯¯ 23.11.2018 03:10:31 ¯¯\
    msgBoxSelectBuild_example( word, listID ){
        if(!This.valueObj){
            This.file2sqLite()
            This.sqLite2obj()
        }
        if(!This.valueObj)
            msgbox,% " ERROR  `n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")"
        valueObj := This.valueObj ; Sql_Temp
        sql := Array()
        loop,6
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
