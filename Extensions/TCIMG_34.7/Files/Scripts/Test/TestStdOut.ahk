; TestStdOut.ahk
; https://t.me/tcimg
; ������ ������� ������� � ��������� �� ���� ������, ���������� ����� ����� STDOUT
; ������� �������:
; scrpt=Test\TestStdOut.ahk||std<2> GLOBALSCRPT<a>
Loop,100
{
 n+=1
 FileAppend, TestStdOut Line %n%`r`n,*
}
