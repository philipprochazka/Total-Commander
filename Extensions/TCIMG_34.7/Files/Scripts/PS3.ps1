# PS3.ps1
# https://t.me/tcimg
# Пример запуска скрипта ps1 с параметрами: запуск блокнота и открытие файла под курсором

# Команда:
# scrpt=PS3.ps1||%P%N

param ([string]$Param1)
notepad $Param1