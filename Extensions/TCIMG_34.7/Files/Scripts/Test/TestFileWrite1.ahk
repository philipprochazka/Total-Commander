; TestFileWrite1.ahk
; https://t.me/tcimg
; ������ ������� ������� � ��������� �� ���� ������, ���������� ����� ����������� ���� � �������
; ������� �������:
; scrpt=Test\TestFileWrite1.ahk||&&wait sends=c:\tci_test.xxx??-1 GLOBALSENDS<a>
Loop,100
{
 n+=1
 sLine=%sLine%TestFileWrite1 Line %n%`r`n
}
sFile=c:\tci_test.xxx
FileDelete,%sFile%
FileAppend,%sLine%,%sFile%,UTF-16