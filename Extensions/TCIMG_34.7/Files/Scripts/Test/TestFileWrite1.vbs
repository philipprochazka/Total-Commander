' TestFileWrite1.vbs
' https://t.me/tcimg
' ������ ������� ������� � ��������� �� ���� ������, ���������� ����� ����������� ���� � �������
' ������� �������:
' scrpt=Test\TestFileWrite1.vbs||&&wait sends=c:\tci_test.xxx??-1 GLOBALSENDS<a>
For i=1 To 100
  sLine=sLine&"TestFileWrite1 Line "&i&vbNewLine
Next
sFile="c:\tci_test.xxx"
CreateObject("Scripting.FileSystemObject").CreateTextFile(sFile,True,True).Write sLine