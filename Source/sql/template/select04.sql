SELECT distinct word, worddescription, wordreplacement
FROM Words
WHERE wordindexed like '%s%'
and   ActionListID > 0
LIMIT 10