' TestStdOut.vbs
' https://t.me/tcimg
' пример запуска скрипта и получение от него данных, переданных через поток STDOUT
' команда запуска:
' scrpt=Test\TestStdOut.vbs||std<2>||stdcnv<?Fvjs1> GLOBALSCRPT<a>
For i=1 To 100
  WScript.StdOut.WriteLine "TestStdOut Line "&i
Next