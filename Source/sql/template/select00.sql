SELECT distinct ltrim(word), ltrim(worddescription), ltrim(wordreplacement)
     FROM Words
     WHERE word LIKE 's%'  ESCAPE '~'
     and   ActionListID > 0
      order by ActionListID, word
     LIMIT 2
-- An underscore ("_") in the LIKE pattern matches any single character in the string.
-- you need to reload the script after each change. be careful by changing the ware statment. its will later parsed by script.
-- prp probab ür probab pro proba qahk s changin pro probab pro probab p proba