' TestStdErr.vbs
' https://t.me/tcimg
' ������ ������� ������� � ��������� �� ���� ������, ���������� ����� ����� STDERR
' ������� �������:
' scrpt=Test\TestStdErr.vbs||std<4> GLOBALSCRPT1<a>
For i=1 To 100
  WScript.StdErr.WriteLine "TestStdErr Line "&i
Next