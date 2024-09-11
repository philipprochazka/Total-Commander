// TestFileWrite2.js
// https://t.me/tcimg
// пример запуска скрипта и получение от него данных, переданных через заданный путь файла с данными
// команда запуска:
// aends=@c:\tci_test2.xxx scrpt=Test\TestFileWrite2.js||GLOBALAENDS<1>||&&wait sends=GLOBALAENDS<1>??-1 GLOBALSENDS<a>
// в скрипт должен передаваться путь файла для записи данных
var Cnt=WScript.Arguments.length;
if (Cnt=='0'){WScript.Quit()};
var sFile=WScript.Arguments(0);var idx=sFile.indexOf(':\\');
if (idx==-1){WScript.Quit();}
sFile=sFile.replace('\\', '\\\\');
var sLine='';
for(var i=1;i<101;i++){sLine=sLine+'TestFileWrite2 Line '+i+'\r\n'};
new ActiveXObject('Scripting.FileSystemObject').CreateTextFile(sFile,true,true).Write(sLine);