' TestFileWrite2.vbs
' https://t.me/tcimg
' ������ ������� ������� � ��������� �� ���� ������, ���������� ����� �������� ���� ����� � �������
' ������� �������:
' aends=@c:\tci_test2.xxx scrpt=Test\TestFileWrite2.vbs||GLOBALAENDS<1>||&&wait sends=GLOBALAENDS<1>??-1 GLOBALSENDS<a>
' � ������ ������ ������������ ���� ����� ��� ������ ������
With WScript Cnt=.Arguments.Count
  If Cnt=0 Then .Quit ' ���� �������� �� ���������, �� �����
  sFile=.Arguments(0)
  If InStr(sFile, ":\")=0 Then .Quit
End With

For i=1 To 100
  sLine=sLine & "TestFileWrite2 Line "&i&vbNewLine
Next
CreateObject("Scripting.FileSystemObject").CreateTextFile(sFile,True,True).Write sLine