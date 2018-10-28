; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
; 

temp =
(
Herzliche Grüße/Herzlichen Gruß
Schöne Grüße/Schönen Gruß
Liebe Grüße/Lieben Gruß
Viele Grüße
Beste Grüße
Freundliche Grüße
Einen guten Start in die Woche/… ins Wochenende
Ein tolles Wochenende
Ein schönes Wochenende
Eine tolle Woche
Noch eine erfolgreiche Woche
Noch einen schönen [Montag]/angenehmen Wochenausklang
Mit den besten Wünschen für …
… in diesem Sinne schöne Grüße
Ich freue mich auf [ein Wiedersehen, das Treffen etc.]
Alles Gute und viele Grüße
Vielen Dank und bis bald!
Ich freue mich auf Ihre Rückmeldung und verbleibe mit herzlichen Grüßen …
Liebe Grüße aus [Wien] nach [München]
Schöne/herbstliche/frühlingshafte Grüße aus dem heute sonnigen [Wien]
)
; Noch einen schönen MontagEinen guten Start in die Woche
; Noch einen schönen [Montag]/angenehmen Wochenausklang
; Einen guten Start in die Woche
Random,r,1,10
if(r == 10 )
  send,Noch einen schönen %A_DDDD% ; Montag / Dienstag usw.
else
; A_WDay Current 1-digit day of the week (1-7). 1 is Sunday in all locales. 
if ( A_WDay  == 6  )  ; 6 freitag
  Send, Noch einen angenehmen Wochenausklang`,
else 
if ( A_WDay  == 7 OR A_WDay  == 1 ) { ; 7 samstag ,  1 sonntag
  ; http://www.zeitblueten.com/news/grussformeln/
  ; https://www.google.de/webhp?q=gru%C3%9Fformeln
;  Einen guten Start in die Woche/… ins Wochenende

; Ein tolles Wochenende
Random, r ,1,2
if( r == 1 )
  Send, Ein schönes Wochenende`,
else
  Send, Einen guten Start ins Wochenende`,
} else
if ( A_WDay  == 2  ) { ; 2 montag 
  ; http://www.zeitblueten.com/news/grussformeln/
  ; https://www.google.de/webhp?q=gru%C3%9Fformeln
;  Einen guten Start in die Woche/… ins Wochenende

; Ein tolles Wochenende
Send, Ihnen einen guten Start in die Woche`,
; 2
}  else
if ( A_WDay  == 3  ) { ; 2 dienstag
; https://www.google.de/webhp?q=%2Bweiterhin+eine+erfolgreiche+Woche+dienstag
; Noch eine gute / erfolgreiche Woche
; Send, Ihnen einen guten Start in die Woche`,
; Send, Ihnen einen guten Start in die Woche`,
Send, Beste Grüße, ; gute Alternative für alle, die eine Variante zwischen freundlichen und herzlichen Grüßen suchen. (https://www.impulse.de/management/unternehmensfuehrung/grussformeln/2182826.html)
; „Viele Grüße“ sind als Grußformel geeignet, wenn man informell und wiederholt schreibt. ( https://www.impulse.de/management/unternehmensfuehrung/grussformeln/2182826.html )
}  else
  Send, Beste Grüße,
  ;Send, Viele Grüße,
; Guten Abend

;
; Send , % A_WDay 
; 22Einen guten Start in die Woche/… ins Wochenende
;  "... bis dahin verbleibe ich mit freundlichen Grüßen" 
; Sonnige Grüße - wenn es die Wetterlage zulässt
