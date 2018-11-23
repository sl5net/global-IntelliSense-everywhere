SELECT distinct word, worddescription, wordreplacement
FROM
     (
SELECT word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed GLOB 's%'
     and   ActionListID > 0
     order by ROWID asc
     LIMIT 5
     ) t1
UNION ALL
SELECT *
FROM
     (
SELECT distinct word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed LIKE 's%'
     and   ActionListID > 0
     order by ROWID asc
     LIMIT 10
     ) t2
UNION ALL
SELECT *
FROM
     (
SELECT distinct word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed GLOB '%s%'
     and   ActionListID > 0
     order by ROWID desc
     LIMIT 10
     ) t3
UNION ALL
SELECT *
FROM
     (
     SELECT distinct word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed like '%s%'
     and   ActionListID > 0
     LIMIT 2
     ) t4
SELECT *
FROM
     (
     SELECT distinct word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed like 's%'
     LIMIT 2
     ) t5
SELECT *
FROM
     (
     SELECT distinct word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed like '%s%'
     LIMIT 2
     ) t6
limit 10;