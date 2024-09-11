; TestStdOut.ahk
; https://t.me/tcimg
; пример запуска скрипта и получение от него данных, переданных через поток STDOUT
; команда запуска:
; scrpt=Test\TestStdOut.ahk||std<2> GLOBALSCRPT<a>
Loop,100
{
 n+=1
 FileAppend, TestStdOut Line %n%`r`n,*
}
