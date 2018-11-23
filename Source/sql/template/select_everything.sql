SELECT distinct word, worddescription, wordreplacement
FROM
     (
SELECT word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed GLOB 'to'
     and   ActionListID = 6
     order by ROWID asc
     LIMIT 5
     ) t1
UNION ALL
SELECT *
FROM
     (
SELECT distinct word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed LIKE 'to'
     and   ActionListID = 6
     order by ROWID asc
     LIMIT 10
     ) t2
UNION ALL
SELECT *
FROM
     (
SELECT distinct word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed GLOB '%to'
     and   ActionListID = 6
     order by ROWID desc
     LIMIT 10
     ) t3
UNION ALL
SELECT *
FROM
     (
     SELECT distinct word, worddescription, wordreplacement
     FROM Words
     WHERE wordindexed like '%to'
     and   ActionListID = 6
     order by ROWID desc
     LIMIT 2
     ) t4
limit 10;