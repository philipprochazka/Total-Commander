' Func.vbs
'========================   Описание   =====================================
' Скрипт-библитотека с различными Функциями, которые можно использовать в командах утилиты TCIMG
'================   Примеры  использования   ===============================
' aends=<info=q0|GuidName> GLOBALAENDS<a>
' funvb=GuidName||ArrAllPath|%P%N GLOBALFUNVB1<a> GLOBALFUNVB2<a>
' aends=x??-3||##rndm<1|20> GLOBALAENDS<a> funvb=SortArrUpNum|$GLOBALAENDS|1 GLOBALFUNVB1<a>

' Автор:           Аверин Андрей
' Версия:          1.5 (09.05.2017 - 09.02.2023)
' Mail:            Averin-And@yandex.ru
' Help:            http://tcimg.dreamlair.net/TCIMG_ONLINE/html/html/com_funvb.htm
' Site:            http://tc-image.3dn.ru/forum/5-498-1
' Telegram:        https://t.me/tcimg
'========================================================================
' Функция создания уникального Guid имени
Function GuidName : NewGUID = CreateObject("Scriptlet.TypeLib").Guid : GuidName = Left(NewGUID, Len(NewGUID) - 2) End Function

' Возвращает полный путь для заданного относительного пути
Function GetPath(sPath) : GetPath = CreateObject("WScript.Shell").ExpandEnvironmentStrings(sPath) : End Function

' Функция получения массива всех родительских путей
' возвращается массив путей, в нулевой ячейке количество путей
Function ArrAllPath(sPath)
  sPath=GetPath(sPath)
  n = 1
  While a = 0
    If Len(sPath) < 4 Then Exit Function
    sPath = GetFF(sPath, 4)
    ReDim Preserve aArrray(n)
    If Right(sPath, 1) <> "\" Then sPath = sPath & "\"
    aArrray(n) = sPath : aArrray(0) = n : n = n + 1 : ArrAllPath = aArrray
  Wend
End Function

' Функция получения массива различных объектов файла/папки
Function GetArrF(sFile)
  On Error Resume Next
  Dim aArrray(23)
  aArrray(0) = 23
  For i = 1 To 23
    aArrray(i) = GetFF(sFile, i)
  Next
  GetArrF = aArrray
End Function

' Функция получения различных объектов файла и каталога/папки
Function GetFF(sFile, n)
  With CreateObject("Scripting.FileSystemObject")
      Select Case n
        Case 0 k = .GetParentFolderName(sFile) & "\" & .GetBaseName(sFile) & ".ini" ' конфигурационный файл
        Case 1 k = .GetExtensionName(sFile) ' расширение
        Case 2 k = .GetBaseName(sFile) ' имя без расширения
        Case 3 k = .GetFileName(sFile) ' имя с расширением
        Case 4 k = .GetParentFolderName(sFile) ' родительский путь
        Case 5 k = .GetParentFolderName(.GetParentFolderName(sFile)) ' дедушкин путь
        Case 6 k = .GetFile(sFile).ShortPath ' короткий путь к файлу в формате 8.3
        Case 7 k = .GetFile(sFile).ShortName ' короткое имя к файлу в формате 8.3
        Case 8 k = .GetFile(sFile).Drive.DriveLetter ' буква диска, на котором находится файл
        Case 9 k = .GetFile(sFile).DateCreated ' дата создания
        Case 10 k = .GetFile(sFile).DateLastAccessed ' дата последнего доступа
        Case 11 k = .GetFile(sFile).DateLastModified ' дата последней модификации
        Case 12 k = .GetFile(sFile).Size  ' размер
        Case 13 k = .GetFile(sFile).Type  ' тип файла

        Case 14 k = .GetFolder(sFile).ShortPath ' короткий путь к каталогу в формате 8.3
        Case 15 k = .GetFolder(sFile).ShortName ' короткое имя к каталогу в формате 8.3
        Case 16 k = .GetFolder(sFile).Drive.DriveLetter ' буква диска, на котором находится каталог
        Case 17 k = .GetFolder(sFile).DateCreated ' дата создания
        Case 18 k = .GetFolder(sFile).DateLastAccessed ' дата последнего доступа
        Case 19 k = .GetFolder(sFile).DateLastModified ' дата последней модификации
        Case 20 k = .GetFolder(sFile).Size  ' размер
        Case 21 k = .GetFolder(sFile).Type  ' тип каталога
        Case 22 k = .GetFolder(sFile).IsRootFolder   '  корневой каталог (True|False)
        Case 23 k = .GetParentFolderName(sFile) & "\" & .GetBaseName(sFile) ' путь с именем без расширения
      End Select
  End With : GetFF = k
End Function

' Функция сортировки элементов цифрового массива по возрастанию
 '  iStart - с какого элемента начать
Function SortArrUpNum(aArrray, iStart) k = Ubound(aArrray)
  If k > 0 Then
    For j = 0 To k - 1
      For i = iStart To k - 1 - j
        If CLng(aArrray(i)) > CLng(aArrray(i + 1)) Then SwapValue aArrray(i), aArrray(i + 1)
      Next
    Next : SortArrUpNum = aArrray
  End If
End Function

' Функция сортировки элементов цифрового массива по убыванию
 '  iStart - с какого элемента начать
Function SortArrDownNum(aArrray, iStart) k = Ubound(aArrray)
  If k > 0 Then
    For j = 0 To k - 1
      For i = iStart To k - 1 - j
        If CLng(aArrray(i)) < CLng(aArrray(i + 1)) Then SwapValue aArrray(i), aArrray(i + 1)
      Next
    Next : SortArrDownNum = aArrray
  End If
End Function

' Функция просмотра содержимого переменной или 1D массива
Function ViewValues(varAray, varTitle)
  varArr = varAray
  If IsArray(varArr) Then
    iUb = Ubound(varArr)
    varTitle = "Массив :: Размер [" & iUb & "] [" & varTitle & "]"
    ListArr = ""
    If iUb > 60 Then iUb = 60
    For ih = 0 To iUb
      ListArr = ListArr & ih & ">" & varArr(ih) & vbNewLine
    Next
    ListArr = varTitle & vbNewLine & ListArr
  Else
    If varArr > "" Then varArr = Left(varArr, 5000)
    ListArr = "Переменная" & vbNewLine & "<" & varArr & ">"
  End If : MsgBox ListArr , vbOKOnly , varTitle
'   End If : AkelPad.MessageBox AkelPad.GetMainWnd(), ListArr, varTitle, 0, 0, 1, "OK", 1
End Function

' Процедура меняет местами  значения 2-х переданных переменных
Sub SwapValue(ByRef Value1, ByRef Value2)
  Temp = Value1 : Value1 = Value2 : Value2 = Temp
End Sub

' Функция возвращает 2D массив с информацией о специальных папках системы
Function SpecFold
  On Error Resume Next
  Set List = CreateObject("Scripting.Dictionary")
  List.Add &H1d, "ALTSTARTUP"
  List.Add &H1a, "APPDATA"
  List.Add &Ha, "BITBUCKET"
  List.Add &H1e, "COMMONALTSTARTUP"
  List.Add &H23, "COMMONAPPDATA"
  List.Add &H19, "COMMONDESKTOPDIR"
  List.Add &H1f, "COMMONFAVORITES"
  List.Add &H17, "COMMONPROGRAMS"
  List.Add &H16, "COMMONSTARTMENU"
  List.Add &H18, "COMMONSTARTUP"
  List.Add &H3, "CONTROLS"
  List.Add &H21, "COOKIES"
  List.Add &H0, "DESKTOP"
  List.Add &H10, "DESKTOPDIRECTORY"
  List.Add &H11, "DRIVES"
  List.Add &H6, "FAVORITES"
  List.Add &H14, "FONTS"
  List.Add &H22, "HISTORY"
  List.Add &H20, "INTERNETCACHE"
  List.Add &H1c, "LOCALAPPDATA"
  List.Add &H27, "MYPICTURES"
  List.Add &H13, "NETHOOD"
  List.Add &H12, "NETWORK"
  List.Add &H5, "PERSONAL"
  List.Add &H4, "PRINTERS"
  List.Add &H1b, "PRINTHOOD"
  List.Add &H28, "PROFILE"
  List.Add &H26, "PROGRAMFILES"
  List.Add &H2, "PROGRAMS"
  List.Add &H8, "RECENT"
  List.Add &H9, "SENDTO"
  List.Add &Hb, "STARTMENU"
  List.Add &H7, "STARTUP"
  List.Add &H25, "SYSTEM"
  List.Add &H15, "TEMPLATES"
  List.Add &H24, "WINDOWS"
  List.Add &H30, "Администрирование"
  List.Add &H1, "Internet Explorer"
  List.Add &H31, "Сетевые подключения"
  
  Dim aArrray(2,39) : aArrray(0,0) = 39 : n = 1
  For Each Element In List
     With CreateObject("Shell.Application").NameSpace(Element)
       aArrray(0,n) = List.Item(Element)
       aArrray(1,n) = .Self.Path
       aArrray(2,n) = .Title
     End With
     If Err.Number <> 0 Then
       aArrray(1,n) = " Папка не найдена" : Err.Clear
     End If
     n = n + 1
  Next  
  SpecFold = aArrray
End Function

' Функция удаляет 1-ю ячейку массива если она равна размеру... (формат массива TCIMG)
Function Delete0Aray(aArrray)
  If Ubound(aArrray) = aArrray(0) Then
    Text = Join(aArrray, vbNewLine)
    Text = Mid(Text, Len(aArrray(0) & vbNewLine) + 1)
    aArrray =  Split(Text, vbNewLine)
  End If
  Delete0Aray = aArrray
End Function

' Функция собирает строки в колонки
 ' 1-й параметр Text - текст или массив
 ' 2-й параметр iMode - режим сборки: 0 - последовательный (по умолчанию), 1 - поочерёдный
 ' 3-й параметр: iColumn - по сколько столбцов (по умолчанию 2)
 ' 4-й параметр: min - количество символов-разделителей между колонками (по умолчанию 5)
 ' 5-й параметр: Sym - символ-разделитель (по умолчанию пробел)
Function LinesInCol(Text, iMode, iColumn, min, Sym)
  vb = vbNewLine : n = 0 : max=0 : Delim = "" : nDelim = 0 : min = CInt(min) : iMode = CInt(iMode) : iColumn = CInt(iColumn)
  If IsArray(Text) Then
    aArrray = Text : u = 1
    aArrray = Delete0Aray(aArrray)
  Else
    aArrray = Split(Text, vb) : u = 0
  End If
  x = Ubound(aArrray) : j = Int((x-1) / iColumn) : Count = x - j * iColumn + j : aArrray2 = CreateArray(Count)
  
  If iMode = 1 Then
    aArrray3 = CreateArray(iColumn)
    For i = 0 To x
      If (i Mod iColumn) = 0 And i <> 0 Then n = 0
      If i < iColumn Then
        Delim = ""
      Else
        Delim = vb
      End If
      aArrray3(n) = aArrray3(n) & Delim & aArrray(i)
      n = n + 1
    Next
    aArrray = Split(Join(aArrray3, vb), vb) : n = 0
  End If
  
  For i = 0 To x
    If (i Mod Count) = 0 And i <> 0 Then : nDelim = max + min : n = 0 : max=0 : End If
    If nDelim > 0 Then
      h = Len(aArrray(i - Count))
      Delim = StringCountLine(Sym, nDelim - h)
    Else
      Delim = ""
    End If
    aArrray2(n) = aArrray2(n) & Delim & aArrray(i)
    m = Len(aArrray(i))
    If m > max Then max = m
    n = n + 1
  Next
  
  If u = 1 Then
    LinesInCol = aArrray2
  Else
    LinesInCol = Join(aArrray2, vb)
  End If
End Function

' Функция создаёт массив с заданным количеством ячеек
Function CreateArray(Count) CreateArray = Split(Space(Count-1)) End Function

' Функция дублирования строки (быстрее цикла FOR ...)
Function StringCountLine(ssLine, jj)
  nn = Int(jj) : sfLine = "" : spLine = ssLine
  If Len(spLine) < 0 Or nn <= 0 Then
    StringCountLine = ""
    Exit Function
  End If
  Do While nn > 1
    If nn And 1 Then sfLine = sfLine & spLine
    spLine = spLine & spLine
    nn = Int(nn / 2)
  Loop
  StringCountLine = spLine & sfLine
End Function

' Функция поиска с помощью регулярных выражений
 ' rText - текст
 ' rRgEp - регулярное выражение,
 ' mm - 1 - Многострочно 0 - нет
 ' ic - 1 - Игнорировать регистр символов 0 - учитывать регистр символов
 ' gl - 1 - Проверять по всему тексту 0 - Проверять до первого соответствия
 ' param - возвращает:
 ' 1. Количество совпадений
 ' 2. Массив найденных подстрок
 ' 3. Массив всех индексов первого символа найденных подстрок в тексте
 ' 4. Массив всех длин найденных подстрок
 ' 5. 2-мерный массив (N,0) найденных подстрок, (N,1) индекс первого символа найденной подстроки в тексте, (N,2) длина найденной подстроки
 ' 6. В массив попадают подстроки относительно условий длины "6=30" (длина подстроки равна 30), "6>10" (длина больше 10), "6<5" (длина меньше 5) , "6<>17" (длина не равна 17) 
Function RegExpSearchPlus(rText, rRgEp, mm, ic, gl, param)
  Dim AR()
  With CreateObject("VBScript.RegExp")
    If mm = 1 Then .Multiline = True Else .Multiline = False End If
    If ic = 1 Then .IgnoreCase = True Else .IgnoreCase = False End If
    If gl = 1 Then .Global = True Else .Global = False End If
    If Left(param, 1) = 6 Then
      sCondition = Mid(param, 2)
      iCount = 0
      param = 6
    End If
    .Pattern = rRgEp : Set objMatches = .Execute(rText) : n = objMatches.Count
    If n > 0 And param > 1 Then
      If param = 5 Then ReDim Preserve AR(n-1, 2) Else ReDim Preserve AR(n - 1) End If
      For i = 0 To n - 1
        Set objMatch = objMatches.Item(i)
        Select Case param
          Case 2 AR(i) = objMatch.Value
          Case 3 AR(i) = objMatch.FirstIndex
          Case 4 AR(i) = objMatch.Length
          Case 5 AR(i, 0) = objMatch.Value : AR(i, 1) = objMatch.FirstIndex : AR(i, 2) = objMatch.Length
          Case 6 
            If Eval(objMatch.Length & sCondition) Then
              AR(iCount) = objMatch.Value
              iCount = iCount + 1
            End If
        End Select
      Next
      If param = 6 Then ReDim Preserve AR(iCount-1)
      RegExpSearchPlus = AR
    Else
      RegExpSearchPlus = n
    End If
  End With : QuitM
End Function

Sub QuitM : Set objMatch = Nothing : Set objMatches = Nothing : End Sub

' Функция замены с помощью регулярных выражений
 ' pText - текст, в котором будет происходить поиск\замена
 ' pFindStr - строка для поиска
 ' pNewStr - строка для замены
 ' mm - 1 - Многострочно 0 - нет
 ' ic - 1 - Игнорировать регистр символов 0 - учитывать регистр символов
 ' gl - 1 - Проверять по всему тексту 0 - Проверять до первого соответствия
Function RegExpReplace(pText, pFindStr, pNewStr, mm, ic, gl)
  pNewStr = Replace(Replace(pNewStr, "\n", Chr(13)), ":n:", "\n") : Set objRegExp = New RegExp
  With objRegExp
    If mm = 1 Then .Multiline = True Else .Multiline = False End If
    If ic = 1 Then .IgnoreCase = True Else .IgnoreCase = False End If
    If gl = 1 Then .Global = True Else .Global = False End If
    .Pattern = pFindStr : RegExpReplace = .Replace(pText, pNewStr)
  End With : Set objRegExp = Nothing
End Function

' Функция читает файл в заданной кодировке 
 ' strFileName - путь к текстовому файлу
 ' strCharset - кодировка, может быть "Windows-1251", "UTF-8", "Unicode", "ASCII", ..., "utf-16"
Function ReadAllTextFile(strFileName, strCharset)
  Set objADOStream = CreateObject("ADODB.Stream")
  objADOStream.CharSet = strCharset
  objADOStream.Open
  objADOStream.LoadFromFile(strFileName)
  ReadAllTextFile = objADOStream.ReadText()
  objADOStream.Close
  Set objADOStream = Nothing
End Function

' Функция проверки орфографии слов с помощью Microsoft Word (он должен быть установлен)
 ' Модификация 27.12.2022
 ' sWords - варианты:
 '   1. список проверяемых слов, каждое слово с новой строки vbNewLine
 '   2. File - путь к файлу со списком слов, каждое слово с новой строки vbNewLine, кодировка файла "utf-8"
 ' sCheckWords - 
 '   1. пользовательский список правильных слов для проверки, каждое слово с новой строки vbNewLine
 '   2. File - путь к файлу со списком пользовательских слов, кодировка файла "utf-8"
 '   - не все слова входят в словарь Microsoft Word - с помощью sCheckWords вы можете подключать свой список
 ' sMode - режим проверки:
 '    "0" - проверяется только словарь Microsoft Word
 '    "1" - проверяется только словарь списка sCheckWords
 '    "0,1" - проверяется словарь Microsoft Word, затем словарь списка sCheckWords
 '    "1,0" - проверяется словарь списка sCheckWords, затем словарь Microsoft Word
 ' возвращается:
 '   -1 - если нет слов для проверки, sWords - пустой список
 '   -2 - нет списка правильных слов для проверки
 '   если вначале sMode прописан "+", то возвращаются правильные слова
 '   если вначале sMode прописан "-", то возвращаются ошибочные слова + правильные слова через разделитель "|"
 '   если вначале sMode не прописан "-" или "+", то возвращаются слова с ошибками
Function GetSpellCheck(sWords, sCheckWords, sMode)
  GetSpellCheck = ""
  Set FSO = CreateObject("Scripting.FileSystemObject")
  sFile = GetPath(sWords)
  If FSO.FileExists(sFile) Then sWords = ReadAllTextFile(sFile, "utf-8")
  sFile = GetPath(sCheckWords)
  If FSO.FileExists(sFile) Then sCheckWords = ReadAllTextFile(sFile, "utf-8")
  If sWords = "" Then
    GetSpellCheck = -1 ' нет слов для проверки
    Exit Function
  End If
  Select Case Left(sMode, 1)
    Case "+" ' получить правильные слова
      sMode = Mid(sMode, 2)
      xMode = 1
    Case "-" ' получить ошибочные слова + правильные слова через разделитель "|"
      sMode = Mid(sMode, 2)
      xMode = 2
    Case Else ' получить ошибочные слова
      xMode = 0
  End Select
  
  If sCheckWords = "" And InStr(sMode, "1") > 0 Then
    If InStr(sMode, "0") > 0 Then
      sMode = "0"
    Else
      GetSpellCheck = -2 ' нет пользовательского списка правильных слов для проверки
      Exit Function
    End If
  End If
  If InStr(sMode, "0") > 0 Then
    Set oWD = CreateObject("Word.Application")
    If Err.Number <> 0 Then
      oWD.Quit : Set oWD = Nothing
      If InStr(sMode, "1") > 0 Then
        sMode = "1"
      Else
        GetSpellCheck = -3 ' Microsoft Word не установлен
        Exit Function
      End If
    Else
      oWD.Visible = False
      oWD.Documents.Add "", 0, 0
    End If
  End If
'   через oDict возможно быстрее, но при большом списке sCheckWords зависание и ненужные уведомления...
'   If InStr(sMode, "1") > 0 Then
'     sDIC = RegExpReplace(sCheckWords, "(\r\n|\r|\n)+", "$1", 1, 0, 1)
'     Arrr = Split(sDIC, vbNewLine)
'     Dim oDict, Item : Set oDict = CreateObject("Scripting.Dictionary")
'     oDict.CompareMode = 1
'     For Each Item In Arrr
' '       oDict.Add Item, 0
' '       If Len(Item) > 0 Then oDict.Add Item,1
'       If Len(Item) > 0 And Not oDict.Exists(Item) Then oDict.Add Item, 0
'     Next
'   End If
  aWD = Split(sWords, vbNewLine) : aWD2 = Split(Replace(sWords, ".", ""), vbNewLine) : aMode = Split(sMode, ",") : uMode = Ubound(aMode)
  
  For i = 0 To Ubound(aWD)
    n = 0
    For j = 0 To uMode
      Select Case aMode(j)
        Case "0"
          If oWD.CheckSpelling(aWD(i)) Then
            sTextYes = sTextYes & aWD(i) & vbNewLine
            Exit For
          End If
        Case "1"
          ' If oDict.Exists(aWD(i)) Or oDict.Exists(Replace(aWD(i), ".", "")) Then Exit For
          ' If oDict.Exists(aWD(i)) Or oDict.Exists(aWD2(i)) Then Exit For
          If InStr(1, sCheckWords, vbNewLine & aWD2(i) & vbNewLine, 1) > 0 Then
            sTextYes = sTextYes & aWD2(i) & vbNewLine
            Exit For
          End If
      End Select
      n = n + 1
      If n = uMode + 1 Then sText = sText & aWD2(i) & vbNewLine
    Next
  Next
  Select Case xMode
    Case 1 ' "+" - получить правильные слова
      n = Len(sTextYes)
      If n > 0 Then sTextYes = Left(sTextYes, n - 2)
      GetSpellCheck = sTextYes
    Case 2 ' "-" -  получить ошибочные слова + правильные слова через разделитель "|"
      n = Len(sTextYes)
      If n > 0 Then sTextYes = Left(sTextYes, n - 2)
      n = Len(sText)
      If n > 0 Then sText = Left(sText, n - 2)
      GetSpellCheck = sText & "|" & sTextYes
    Case Else ' получить ошибочные слова
      n = Len(sText)
      If n > 0 Then sText = Left(sText, n - 2)
      GetSpellCheck = sText
  End Select

'   If InStr(sMode, "1") > 0 Then Set oDict = Nothing
  If InStr(sMode, "0") > 0 Then oWD.Quit : Set oWD=Nothing : End If
End Function

' Функция возвращает массив, созданный путём фильтрации переданного массива по заданным критериям
 ' aArrray - одномерный массив, в котором происходит поиск
 ' sString - строка, критерий отбора
 ' iInc - 1 - в массив попадут строки, которые имеют вхождение sString; 0 - строки, не имеющих вхождения sString
 ' iCompare - тип сравнения: 0 - не учитывать регистр символов (бинарное сравнение), 1 - учитывать регистр символов(текстовое сравнение).
 ' Добавлено 20.07.2022
Function ArrayFilter(aArrray, sString, iInc, iCompare)
  ArrayFilter = Filter(aArrray, sString, iInc, iCompare)
End Function

' Функция возвращает относительный путь к каталогу
 ' sPath  - путь к файлу или папке
 ' sFolder - путь каталога, оносительно которого создаётся путь
 ' Добавлено 09.02.2023
Function GetRelativePathA(sPath, sFolder)
  GetRelativePathA = sPath
  If sPath = sFolder Then Exit Function
  If Right(sFolder, 1) <> "\" Then sFolder = sFolder & "\"
  If sPath = sFolder Then Exit Function
  aPath = Split(sPath, "\") : aFolder = Split(sFolder, "\")
  If aPath(0) <> aFolder(0) Then Exit Function ' диски путей разные, относительный путь не получить
  nP = UBound(aPath) : nF = UBound(aFolder)
  For i = 0 To nP
    If i > nF Or aPath(i) <> aFolder(i) Then Exit For
  Next
  For j = i To nF - 1
    relativePath = relativePath & "..\"
  Next
  For j = i To nP- 1
    relativePath = relativePath & aPath(j) & "\"
  Next
  GetRelativePathA = relativePath & aPath(nP)
End Function


