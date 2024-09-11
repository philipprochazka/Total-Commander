; AHK1.ahk
; https://t.me/tcimg
; Пример запуска скрипта ps1 с параметрами: запуск блокнота и открытие файла под курсором
; Команда:
; scrpt=AHK1.ahk||%P%N

param1 := A_Args[1]
; param2 := A_Args[2]
MsgBox %param1%

Run, notepad %param1%
