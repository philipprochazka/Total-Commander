; TestFileWrite2.au3
; https://t.me/tcimg
; пример запуска скрипта и получение от него данных, переданных через заданный путь файла с данными
; команда запуска:
; aends=@c:\tci_test2.xxx scrpt=Test\TestFileWrite2.au3||GLOBALAENDS<1>||&&wait sends=GLOBALAENDS<1>??-1 GLOBALSENDS<a>
; в скрипт должен передаваться путь файла для записи данных
#NoTrayIcon
If 0=$CmdLine[0]Or 0=StringInStr($CmdLine[1],':\')Then Exit
$sLine=''
For $i=1 To 100
  $sLine&='TestFileWrite2 Line '&$i&@CRLF
Next
$sFile=$CmdLine[1]
_FileCreate($sFile,32+2,$sLine)

Func _FileCreate($sFile,$b,$sText)
  $hFile=FileOpen($sFile,$b)
  If $hFile=-1 Then Return
  FileWrite($hFile,$sText)
  FileClose($hFile)
EndFunc