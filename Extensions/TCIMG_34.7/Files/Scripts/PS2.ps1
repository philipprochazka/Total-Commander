# PS2.ps1
# https://t.me/tcimg
# ѕример запуска скрипта ps1, передача пути файла, чтение 1-й строки и передача обратно

# примеры команд запуска:
# global cmdbt=PowerShell~~-ExecutionPolicy~~Bypass~~-File~~''$f210\PS2.ps1''~~-Param1~~''%P%N''||0||redir<1> GLOBALCMDBT<a>
# scrpt=PS2.ps1||param<-Param1~~''%P%N''>||std<2>||redir<1> GLOBALSCRPT<a>

param ([string]$Param1)
$file = new-object System.IO.StreamReader($Param1)
write-output $file.ReadLine()