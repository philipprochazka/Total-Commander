' TestStdErr.vbs
' https://t.me/tcimg
' пример запуска скрипта и получение от него данных, переданных через поток STDERR
' команда запуска:
' scrpt=Test\TestStdErr.vbs||std<4> GLOBALSCRPT1<a>
For i=1 To 100
  WScript.StdErr.WriteLine "TestStdErr Line "&i
Next