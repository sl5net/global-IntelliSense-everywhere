; please never delete this wordklst 05.08.2017 10:25
___open \_global|rr||ahk|openInEditor,..\_global.ahk
; if this german au is readable your UTF8 is probalby correct: ä

g_IntelliSense
global-IntelliSense-everywhere

change 2 'Bewerbung schreiben'|rr||ahk|sleep,2000 `n WinSetTitle,A,,Bewerbung schreiben `n g_config["list"]["change"]["stopRexExTitle"]:="."
change actionList GUI|rr||ahk|run,..\..\Source\plugins\ahk\giListSELECT.ahk
changeActionList GUI|rr||ahk|run,..\..\Source\plugins\ahk\giListSELECT.ahk

_____repair maybe germen special characters by guessing the probably right umlaut|rr||ahk|run,repair_maybe_germen_special_characters.ahk
repair maybe germen special characters by guessing the probably right umlaut|rr||ahk|run,repair_maybe_germen_special_characters.ahk

global-IntelliSense-everywhere is a Action completion tool for windows OS|r|https://en.wikipedia.org/wiki/Autocomplete#Context_completion
global-IntelliSense-everywhere ist ein Aktionsvervollständigungstool für Windows-Betriebssysteme|r|https://de.wikipedia.org/wiki/Autovervollst%C3%A4ndigung#Programmierung
global-IntelliSense-everywhere wikipedia|rr|https://en.wikipedia.org/wiki/Autocomplete#Context_completion

; '''Action completion''' in applications are standalone tools that add autocomplete functionality to existing applications, similar to word completion, which completes words (or entire phrases) based on the current context. The main advantage of Action completion is the ability to predict anticipated texts or actions. The main disadvantage is the need of a  data set. Most common use of context completion is seen in advanced programming language editors and [[Integrated development environment|IDEs]]. Example of a open source freeware is global-IntelliSense-everywhere for windows <ref>https://sl5net.github.io/global-IntelliSense-everywhere/</ref>.



