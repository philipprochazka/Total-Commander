' TestStd.vbs
' https://t.me/tcimg
' ������ ������� ������� � ��������� �� ���� ������, ���������� ����� ������ STDOUT � STDERR
' ������� �������:
' scrpt=Test\TestStd.vbs||std<6>||stdcnv<?Fvjs1> GLOBALSCRPT<a> GLOBALSCRPT1<a>
For i=1 To 100
  WScript.StdOut.WriteLine "TestStdOut Line "&i
Next
For i=1 To 100
  WScript.StdErr.WriteLine "TestStdErr Line "&i
Next    