; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#SingleInstance, force
; Hallo Hallo 05
send,% getDaytimeHello() . " "
getDaytimeHello(){
  helloHour=Hallo
  ; if(A_Hour > 5) weil man wohl schon vor 5 nicht schreibn soll ?
  if(A_Hour >= 5) 
    helloHour=Guten Morgen

  ; Guten Tag sag ich ,wenn ich frï¿½h aufgestanden bin, ab 11Uhr.
  if(A_Hour >= 11)
    helloHour=Guten Tag 

  ;Ich denke in Deutschland sagt man so ab 17:00h guten Abend, da haben viele Leute Feierabend 
  if(A_Hour >= 17)
    helloHour=Guten Abend 

    ;helloHour=Hallole
 return helloHour
}
