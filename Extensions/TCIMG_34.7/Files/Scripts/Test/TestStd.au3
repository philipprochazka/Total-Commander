; TestStd.au3
; https://t.me/tcimg
; пример запуска скрипта и получение от него данных, переданных через потоки STDOUT и STDERR
; команда запуска:
; scrpt=Test\TestStd.au3||std<6> GLOBALSCRPT<a> GLOBALSCRPT1<a>
#NoTrayIcon
For $i=1 To 100
  ConsoleWrite('TestStdOut Line '&$i&@CRLF)
Next
For $i=1 To 100
  ConsoleWriteError('TestStdErr Line '&$i&@CRLF)
Next