; AHK1.ahk
; https://t.me/tcimg
; ������ ������� ������� ps1 � �����������: ������ �������� � �������� ����� ��� ��������
; �������:
; scrpt=AHK1.ahk||%P%N

param1 := A_Args[1]
; param2 := A_Args[2]
MsgBox %param1%

Run, notepad %param1%
