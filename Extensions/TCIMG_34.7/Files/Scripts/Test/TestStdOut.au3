; TestStdOut.au3
; https://t.me/tcimg
; ������ ������� ������� � ��������� �� ���� ������, ���������� ����� ����� STDOUT
; ������� �������:
; scrpt=Test\TestStdOut.au3||std<2> GLOBALSCRPT<a>
#NoTrayIcon
For $i=1 To 100
  ConsoleWrite('TestStdOut Line '&$i&@CRLF)
Next