SELECT distinct word, worddescription, wordreplacement
FROM Words
WHERE wordindexed like 's%'
LIMIT 10