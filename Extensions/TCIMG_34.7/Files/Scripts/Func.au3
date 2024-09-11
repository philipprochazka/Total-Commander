; Func.au3
;========================   Описание   =====================================
; Скрипт-библитотека с различными Функциями, которые можно использовать в командах утилиты TCIMG
;================   Примеры  использования   ===============================
; aends=<info=q2|Min|50|100> GLOBALAENDS<a>
; funau=Min|50|100 GLOBALFUNAU1<a>
; funau=Max|60|200 GLOBALFUNAU1<a>
; funau=_ProcessList| GLOBALFUNAU1<a>


; Автор:           Аверин Андрей
; Версия:          1.4 (10.05.2017 - 22.04.2020)
; Mail:            Averin-And@yandex.ru
; Help:            http://tcimg.dreamlair.net/TCIMG_ONLINE/html/html/com_funau.htm
; Site:            http://tc-image.3dn.ru/forum/5-498-1
; Telegram:        https://t.me/tcimg
 ;========================================================================

; Min - Возвращает минимальное значение из 2-х значений
Func Min($k,$n)
  Return Number($k)<Number($n)? $k : $n
EndFunc
; Max - Возвращает максимальное значение из 2-х значений
Func Max($k,$n)
  Return Number($k)>Number($n)? $k : $n
EndFunc
 ; Exec - Выполняет выражение.
Func Exec($s)
  Return Execute($s)
EndFunc
; Replace - Заменяет фрагмент в строке (пример передачи данных макросов @error и @extended через массив)
Func Replace($sText,$sSearchString,$sReplaceString,$iOccurrence=0,$iCasesense=0)
  Local $aResult[4]=[3]
  $aResult[1]=StringReplace($sText,$sSearchString,$sReplaceString,$iOccurrence,$iCasesense)
  $aResult[2]=@error
  $aResult[3]=@extended
  Return $aResult
EndFunc
; _ProcessList - Возвращает двумерный массив, содержащий список выполняемых процессов (имя и PID).
Func _ProcessList($sName='')
  Return $sName=''? ProcessList(): ProcessList($sName)
EndFunc
; GetForismatic - получение случайного афоризма с сайта forismatic.com - sLang='ru' или sLang='en'
Func GetForismatic($sLang='ru')
  Local $sText='',$sURL='http://api.forismatic.com/api/1.0/',$sPostData='method=getQuote&key=457653&format=xml&lang='&$sLang
  $oHTTP=ObjCreate('WinHttp.WinHttpRequest.5.1')
  $oHTTP.Open('POST',$sURL)
  $oHTTP.SetRequestHeader('Content-Type','application/x-www-form-urlencoded')
  $oHTTP.Send($sPostData)
  $oHTTP.WaitForResponse
  Local $sRes=$oHTTP.ResponseText,$aRet=StringRegExp($sRes,'<quoteText>([^<>]*)</quoteText>',3),$sText=IsArray($aRet)? $aRet[0]:'',$aRet=StringRegExp($sRes,'<quoteAuthor>([^<>]*)</quoteAuthor>',3)
  Return IsArray($aRet)? $sText&@CRLF&$aRet[0] : $sText
EndFunc

; GetInfoSite - получение содержимое с сайта с заданными настройками:
; $sURL - адрес сайта
; $sOpen - Запрос POST или GET. Авторизация через логин, обычно  POST
; $iMode - 1 - возвращение контента, 0 - возвращение массива с информацией
; $sProxy - Пример "127.0.0.1:9095"
; $sAgent - User-Agent (идентификатор клиентской программы) отправляемую при запросах
; $sReferer - реферальный URL ? по умолчанию равен $sURL
; $sCookies - "authautologin=cb684c94fed306188ae98557804250fae6af56e1..."
; $sPassword - "login=XXXX&password=YYYY&remember=on&authsubmit=" - Точные данные для авторизации устанавливаются с помощью программы HTTP.Analyzer
Func GetInfoSite($sURL,$sOpen='POST',$iMode=1,$sProxy='',$sAgent='',$sReferer='',$sCookies='',$sPassword='')
  If $sAgent=''Then $sAgent='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101 Firefox/68.0'
  $oHTTP=ObjCreate('WinHttp.WinHttpRequest.5.1')
  $oHTTP.Open($sOpen,$sURL,False) ; Запрос POST или GET. Авторизация через логин, обычно  POST
  $oHTTP.SetTimeouts(30000,60000,30000,30000) ; Время ожидания
  If $sProxy>''Then $oHTTP.SetProxy(2,$sProxy) ; Прокси если нужен
  $oHTTP.SetRequestHeader('User-Agent',$sAgent)
  $oHTTP.SetRequestHeader('Connection','keep-alive')
  $oHTTP.SetRequestHeader('Cache-Control','max-age=0')
  $oHTTP.SetRequestHeader('Upgrade-Insecure-Requests','1')
;$oHTTP.SetRequestHeader("Content-Type", "text/plain;charset=UTF-8") ; Кодировка без неё идет значение по умолчанию как на сервере
  $oHTTP.SetRequestHeader('Accept-Language','en-US,en;q=0.8')
  $oHTTP.SetRequestHeader('Referer',$sReferer>''? $sReferer : $sURL) ; В данном случае не обязательно
  $oHTTP.SetRequestHeader('Content-Type','application/x-www-form-urlencoded') ; Без этого авторизации не будет
  $oHTTP.SetRequestHeader('Accept','text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8')
  If $sCookies>''Then $oHTTP.SetRequestHeader('Cookie', $sCookies) ; Используется только если идет авторизация или проверка на  кукисы
  If $sPassword>''Then
    $oHTTP.Send($sPassword)
  Else
    $oHTTP.Send()
  EndIf
  $oHTTP.WaitForResponse
  $iStatus=$oHTTP.Status ; Получить ответ о статусе файла
  If $iStatus<>200 Then Return $iStatus
  $sHTML=BinaryToString($oHTTP.ResponseText) ; Получение контента ; Конвертация в строковые данные, во избежание кракозябр
  If $iMode=1 Then Return $sHTML
  $sHeaders=$oHTTP.GetAllResponseHeaders() ; Получение заголовка
  $sCookies=$oHTTP.GetResponseHeader('Set-Cookie') ; Получить обратно кукисы
  $sServer=$oHTTP.GetResponseHeader('Server') ; Получить имя сервера
  Dim $aRet=[5,$sHeaders,$sCookies,$sServer,$iStatus,$sHTML]
  Return $aRet
EndFunc