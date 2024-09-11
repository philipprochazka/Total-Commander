; TestStdOut.au3
; https://t.me/tcimg
; пример запуска скрипта и получение от него данных, переданных через поток STDOUT
; команда запуска:
; scrpt=Test\TestStdOut.au3||std<2> GLOBALSCRPT<a>
#NoTrayIcon
For $i=1 To 100
  ConsoleWrite('TestStdOut Line '&$i&@CRLF)
Next