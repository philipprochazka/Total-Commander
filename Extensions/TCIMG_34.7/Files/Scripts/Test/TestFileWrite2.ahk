; TestFileWrite2.ahk
; https://t.me/tcimg
; ������ ������� ������� � ��������� �� ���� ������, ���������� ����� �������� ���� ����� � �������
; ������� �������:
; aends=@c:\tci_test2.xxx scrpt=Test\TestFileWrite2.ahk||GLOBALAENDS<1>||&&wait sends=GLOBALAENDS<1>??-1 GLOBALSENDS<a>
; � ������ ������ ������������ ���� ����� ��� ������ ������
sFile:=A_Args[1]
Loop,100
{
 n+=1
 sLine=%sLine%TestFileWrite2 Line %n%`r`n
}
FileDelete,%sFile%
FileAppend,%sLine%,%sFile%,UTF-16
