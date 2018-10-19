___open Markdown_Quick_Reference|rr||ahk|run,..\_globalActionLists\Markdown_Quick_Reference.ahk
; if this german au is readable your UTF8 is probalby correct: ä

; Markdown used by: framasphere.org , diaspora, stackoverlow

italic|r|_italic_
bold|r|**bold**
strikethrough|r|~~strikethrough~~
superscript|r|^superscript^
subscript|r|~subscript~
links|r|[Description](https://example.com/)
bare links|r|<https://www.example.com>
code|r|`code`
escape|r|\*escape\*

code multiline python|rr||ahk|
m=
(
``````for python in range(10):
	print(python)
``````
)
Clipboard := m
send,% v

Unordered lists|r|* Unordered lists
Ordered lists|r|1. Ordered lists
blockquoted|r|> blockquoted
Horizontal rule|r|----

Header 1|r|# Header 1
Header 2|r|## Header 2
Header 3|r|### Header 3
Header 4|r|#### Header 4
Header 5|r|##### Header 5
Header 6|r|###### Header 6
