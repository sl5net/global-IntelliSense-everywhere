SELECT distinct word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed LIKE 's%'
     and   ActionListID > 0
     order by ROWID asc
     LIMIT 10
