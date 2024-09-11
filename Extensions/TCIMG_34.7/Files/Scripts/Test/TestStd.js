// TestStd.js
// https://t.me/tcimg
// пример запуска скрипта и получение от него данных, переданных через потоки STDOUT и STDERR
// команда запуска:
// scrpt=Test\TestStd.js||std<6>||stdcnv<?Fvjs1> GLOBALSCRPT<a> GLOBALSCRPT1<a>
for(var i=1;i<101;i++){WScript.StdOut.WriteLine('TestStdOut Line '+i)}
for(var i=1;i<101;i++){WScript.StdErr.WriteLine('TestStdErr Line '+i)}