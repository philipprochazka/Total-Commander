; TestFileWrite1.au3
; https://t.me/tcimg
; ������ ������� ������� � ��������� �� ���� ������, ���������� ����� ����������� ���� � �������
; ������� �������:
; scrpt=Test\TestFileWrite1.au3||&&wait sends=c:\tci_test.xxx??-1 GLOBALSENDS<a>
#NoTrayIcon
$sLine=''
For $i=1 To 100
  $sLine&='TestFileWrite1 Line '&$i&@CRLF
Next
$sFile='c:\tci_test.xxx'
_FileCreate($sFile,32+2,$sLine)

Func _FileCreate($sFile,$b,$sText)
  $hFile=FileOpen($sFile,$b)
  If $hFile=-1 Then Return
  FileWrite($hFile,$sText)
  FileClose($hFile)
EndFunc