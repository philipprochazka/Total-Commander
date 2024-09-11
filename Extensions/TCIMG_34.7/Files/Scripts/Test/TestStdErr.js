// TestStdErr.js
// https://t.me/tcimg
// пример запуска скрипта и получение от него данных, переданных через поток STDERR
// команда запуска:
// scrpt=Test\TestStdErr.js||std<4> GLOBALSCRPT1<a>
for(var i=1;i<101;i++){WScript.StdErr.WriteLine('TestStdErr Line '+i)}