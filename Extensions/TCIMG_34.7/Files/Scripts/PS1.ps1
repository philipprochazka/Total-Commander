# PS1.ps1
# https://t.me/tcimg
# Пример запуска скрипта ps1, передача параметров и получение их обратно

# примеры команд запуска:
# global cmdbt=PowerShell~~-ExecutionPolicy~~Bypass~~-File~~''$f210\PS1.ps1''~~-Param1~~''111111''~~-Param2~~''222222''||0||redir<1> GLOBALCMDBT<a>
# global cmdbt=PowerShell~~-ExecutionPolicy~~Bypass~~-File~~''$f210\PS1.ps1''~~-Param1~~''%P%N''~~-Param2~~''%T%M''||0||redir<1> GLOBALCMDBT<a>
# scrpt=PS1.ps1||param<-Param1~~''%P%N''~~-Param2~~''%T%M''>||std<2>||redir<1> GLOBALSCRPT<a>

param ([string]$Param1,[string]$Param2)
$N1 = "Параметр1: " + $Param1
$N2 = "Параметр2: " + $Param2
write-output $N1
write-output $N2