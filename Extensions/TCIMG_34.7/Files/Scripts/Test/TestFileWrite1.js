// TestFileWrite1.js
// https://t.me/tcimg
// пример запуска скрипта и получение от него данных, переданных через создаваемый файл с данными
// команда запуска:
// scrpt=Test\TestFileWrite1.js||&&wait sends=c:\tci_test.xxx??-1 GLOBALSENDS<a>
var sLine=''
for(var i=1;i<101;i++){sLine=sLine+'TestFileWrite1 Line '+i+'\r\n'}
var sFile='c:\\tci_test.xxx'
new ActiveXObject('Scripting.FileSystemObject').CreateTextFile(sFile,true,true).Write(sLine);