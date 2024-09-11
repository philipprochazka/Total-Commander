; ToolTipClipGet.au3
; ========================   Описание   =====================================
; Отображать изменения буфера обмена в подсказке
; =======================   Параметры  =====================================
; 1-й параметр: Координата всплывающей подсказки по x
; 2-й параметр: Координата всплывающей подсказки по y
; 3-й параметр: Количество выводимых строк
; 4-й параметр: Длина до которой обрезаются длинные строки
; =======================   Дополнение   ====================================
; В 1-м и во 2-м возможны математические действия и использование макросов:
; @DesktopHeight - высота рабочего стола в пикселях 
; @DesktopWidth - ширина рабочего стола в пикселях
; Скрипты располагаются в папке утилиты TCIMG ...\Files\Scripts\ 
; ========================   Примеры   =====================================
; scrpt=ToolTipClipGet.au3||0||0||10||20
; scrpt=ToolTipClipGet.au3||@DesktopWidth-100||@DesktopHeight-200||10||20

; Автор:           Аверин Андрей
; Версия:          1.2 (31.10.2016 - 03.12.2016)
; Mail:            Averin-And@yandex.ru
; Help:            http://tcimg.dreamlair.net/TCIMG_ONLINE/html/html/com_scrpt.htm
; Site:            http://tc-image.3dn.ru/forum/5-498-17032-16-1477929636
; Telegram:        https://t.me/tcimg
;===========================================================================
; Скрипт для запуска через утилиту TCIMG http://tc-image.3dn.ru/forum/5-498-1
;===========================================================================
If 4>$CmdLine[0]Then
  MsgBox(4096+48,"Ошибка","Не хватает параметров."&@CRLF&"Должно быть 4 параметра!",5)
  Exit
EndIf
Local $ClipOld='',$X=Execute($CmdLine[1]),$Y=Execute($CmdLine[2]),$CountLine=$CmdLine[3],$LenLine=$CmdLine[4]
TraySetToolTip('Показ изменения буфера обмена')
Opt('TrayAutoPause',0)
Opt('TrayIconHide',0) 
TraySetState(1)
TraySetIcon('TCIMG.dll',120)

While 1
  Sleep(500)
  $Clip=ClipGet()
  If $ClipOld<>$Clip Then
    ToolTip(_TrimList(_TrimLineCount($Clip,$CountLine),$LenLine),$X,$Y)
    $ClipOld=$Clip
  EndIf
WEnd
; обрезать строки до заданной длины 
Func _TrimList($fLine,$Len)
  Return StringRegExpReplace($fLine,'(?m)([^\r\n]{0,'&$Len&'})([^\r\n]+)?','$1')
EndFunc
; обрезать до нужного количества строк 
Func _TrimLineCount($fLine,$Count)
  Return StringRegExpReplace($fLine&@CRLF,'(?s)(([^\r\n]*[\r\n]+){1,'&$Count&'}).*','$1')
EndFunc