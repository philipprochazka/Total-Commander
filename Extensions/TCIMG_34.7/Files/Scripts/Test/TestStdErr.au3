; TestStdErr.au3
; https://t.me/tcimg
; ������ ������� ������� � ��������� �� ���� ������, ���������� ����� ����� STDERR
; ������� �������:
; scrpt=Test\TestStdErr.au3||std<4> GLOBALSCRPT1<a>
#NoTrayIcon
For $i=1 To 100
  ConsoleWriteError('TestStdErr Line '&$i&@CRLF)
Next