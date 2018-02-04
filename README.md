 

# global-IntelliSense-everywhere

download: https://github.com/sl5net/global-IntelliSense-everywhere
 
examples: https://github.com/sl5net/global-IntelliSense-everywhere/blob/master/Wordlists/_globalWordLists/examplesForBeginners.txt

start: start.ahk

Please configure wordlist by hit _ key.
and you may wanna edit the wordlistNameFilter.inc.ahk inside your new folder ( Wordlists/YourNewClass/wordlistNameFilter.inc.ahk ).
There is also a global 
/Wordlists/wordlistNameFilter.inc.ahk
you may wanna edit ( Wordlists/YourNewClass/wordlistNameFilter.inc.ahk ).
The wordlistNameFilter.inc.ahk files are meant to be redirected to wordlists (superglobal, global or local, ...) if you do not have the normal configuration.
Please handle the global wordlistNameFilter.inc.ahk carefully, as it could be sinst that the whole script does not work anymore.
The first steps will probably be that you only edit the Wordlists / YourNewClass / yourNewTitle.txt. The simplest change is just to add one line of text.


scheduled features for the next update: it will load much faster (loading is actully little slow with big wordlists)



global IntelliSense everywhere for windows with autohotkey
Video: https://www.youtube.com/watch?v=elLsl8lj0K8

its using (many thanks for it):
regex (very often)
windows OS
autohotkey
TypingAid.ahk
ADO.ahk
ArchLogger.ahk
Base.ahk
clean.bat
Collection, ahk
DataBaseAbstract. ahk
DataBaseADO.ahk
DataBaseFactory.ahk
DataBaseMySQL.ahk
DataBaseSQLLite .ahk
DBA.ahk
MemoryBufFer.ahk
mySQL.ahk
RecordSetADO.ahk
RecordSetMySQL, ahk
RecordSetSqlLite .ahk
sizeof.ahk
SQLite_L.ahk