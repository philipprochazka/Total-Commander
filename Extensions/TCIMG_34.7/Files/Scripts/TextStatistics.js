// Расширенная статистика в выделенном
// (c) Infocatcher
// mod Andrey_A by TCIMG 1.2 09.07.2021
// http://tc-image.3dn.ru/forum/5-498-1
// https://t.me/tcimg

function getTextStatistics(cFile,ln) {
  var oFSO = new ActiveXObject("Scripting.FileSystemObject");
  if (oFSO.FileExists(cFile))
  {
    var oFile = oFSO.OpenTextFile(cFile);
    var txt = oFile.ReadAll();
    var n = 1
  }else{
    var txt = cFile
    var n = 0
  }
// 	var txt = getText(cFile);
	if(!txt)
		return _localize("Text missing!",ln);
	var txtn = txt.replace(/\r\n|\n\r|\n|\r/g, "\n"); // Strange things happens with \r\n
	var res = "\n\n"
	if (n)
	{
	  var res = cFile ? cFile + ":\n\n" : "";
	}
	

	res +=          _localize("Lines: ",ln)       + formatNum(countOf(txt, /\r\n|\n\r|\n|\r/g) + 1) + "\n";
	res += "  – " + _localize("Only spaces: ",ln) + formatNum(countOf(txt, /^[\t ]+$/mg)) + "\n";
	res += "  – " + _localize("Empty: ",ln)       + formatNum(countOf(txtn, /^$/mg)) + "\n";

	res += "\n";

	var longestLine  = -1,       longestLineNum,  longestLineText;
	var shortestLine = Infinity, shortestLineNum, shortestLineText;
	var lines = txtn.split("\n");
	var curLine, curLen;
	var tabStop = 1 // --------------
	for(var i = 0, l = lines.length; i < l; i++) {
		curLine = lines[i];
		curLen = curLine.length;

		if(curLine.indexOf("\t") != -1) {
			var tabWidth, dw;
			for(var j = 0, column = 0, ll = curLen; j < ll; j++, column++) {
				if(curLine.charAt(j) != "\t")
					continue;
				tabWidth = tabStop - column % tabStop;
				if(tabWidth <= 1)
					continue;
				dw = tabWidth - 1;
				curLen += dw;
				column += dw;
			}
		}

		if(curLen > longestLine) {
			longestLine = curLen;
			longestLineNum = i + 1;
			longestLineText = curLine;
		}
		if(curLen < shortestLine) {
			shortestLine = curLen;
			shortestLineNum = i + 1;
			shortestLineText = curLine;
		}
	}

	res +=          _localize("Longest line: #",ln) + formatNum(longestLineNum) + "\n";
	res += "  – " + _localize("Length: ",ln) + formatNum(longestLine) + "\n";
	res += "  – " + _localize("Line: “%S”",ln).replace("%S", formatLine(longestLineText)) + "\n";
	res +=          _localize("Shortest line: #",ln) + formatNum(shortestLineNum) + "\n";
	res += "  – " + _localize("Length: ",ln) + formatNum(shortestLine) + "\n";
	res += "  – " + _localize("Line: “%S”",ln).replace("%S", formatLine(shortestLineText)) + "\n";

	res += "\n";

	res+=_localize("Symbols: ")+formatNum(txt.length)+"\n";
	res += "  – "    + _localize("Cyrillic: ",ln)               + formatNum(countOf(txt, /[а-яё]/ig)) + "\n";
	res += "  – "    + _localize("Latin: ",ln)                  + formatNum(countOf(txt, /[a-z]/ig)) + "\n";
	res += "  – "    + _localize("Digits: ")                 + formatNum(countOf(txt, /\d/g)) + "\n";
	res += "  – "    + _localize("Space symbols: ",ln)          + formatNum(countOf(txt, /\s/g)) + "\n";
	res += "     = " + _localize("Spaces: ",ln)                 + formatNum(countOf(txt, / /g)) + "\n";
	res += "     = " + _localize("Tabs: ",ln)                   + formatNum(countOf(txt, /\t/g)) + "\n";
	res += "     = " + _localize("Carriage returns (\\r): ",ln) + formatNum(countOf(txt, /\r/g)) + "\n";
	res += "     = " + _localize("Line feeds (\\n): ",ln)       + formatNum(countOf(txt, /\n/g)) + "\n";

	res += "\n";

	var wordsCyr = countOf(txt, /[а-яё]+(-[а-яё]+)*/ig);
	var wordsLat = countOf(txt, /[a-z]+(-[a-z]+)*('[st])?/ig);
	res +=          _localize("Words: ",ln)    + formatNum(wordsCyr + wordsLat) + "\n";
	res += "  – " + _localize("Cyrillic: ",ln) + formatNum(wordsCyr) + "\n";
	res += "  – " + _localize("Latin: ",ln)    + formatNum(wordsLat) + "\n";

	res += "\n";

	var numsDec = countOf(txt, /(^|\W)\d+([.,]\d+)?(?=(\W|$))/g); // Be careful with numbers like "0,2"
	var numsHex = countOf(txt, /(^|\W)0x[\da-f]+(?=(\W|$))/ig);
	res +=          _localize("Numbers: ",ln)     + formatNum(numsDec + numsHex) + "\n";
	res += "  – " + _localize("Decimal: ",ln)     + formatNum(numsDec) + "\n";
	res += "  – " + _localize("Hexadecimal: ",ln) + formatNum(numsHex) + "\n";

	return res;
}
function countOf(txt, regexp) {
	var m = txt.match(regexp);
	return m ? m.length : 0;
}
function formatNum(n) {
	return String(n).replace(/(\d)(?=(\d{3})+(\D|$))/g, "$1 ");
}
function formatLine(s) {
	var maxLength = 45;
	var tabWidth = 8;
	var tab = new Array(tabWidth + 1).join(" ");
	var ret = s.substr(0, maxLength);
	while(ret.replace(/\t/g, tab).length > maxLength)
		ret = ret.substr(0, ret.length - 1);
	return ret == s
		? ret
		: ret + "\u2026"; // "..."
}

function _localize(s,ln) {
	var strings = {
		"Text missing!": {
			ru: "Текст отсутствует!"
		},
		"Lines: ": {
			ru: "Строки: "
		},
		"Only spaces: ": {
			ru: "Только пробельные символы: "
		},
		"Empty: ": {
			ru: "Пустые: "
		},
		"Shortest line: #": {
			ru: "Самая короткая строка: №"
		},
		"Longest line: #": {
			ru: "Самая длинная строка: №"
		},
		"Length: ": {
			ru: "Длина: "
		},
		"Line: “%S”": {
			ru: "Строка: «%S»"
		},
		"Symbols: ": {
			ru: "Символы: "
		},
		"Cyrillic: ": {
			ru: "Кириллица: "
		},
		"Latin: ": {
			ru: "Латиница: "
		},
		"Digits: ": {
			ru: "Цифры: "
		},
		"Space symbols: ": {
			ru: "Пробельные символы: "
		},
		"Spaces: ": {
			ru: "Пробелы: "
		},
		"Tabs: ": {
			ru: "Табуляции: "
		},
		"Carriage returns (\\r): ": {
			ru: "Возвраты каретки (\\r): "
		},
		"Line feeds (\\n): ": {
			ru: "Переводы строки (\\n): "
		},
		"Words: ": {
			ru: "Слова: "
		},
		"Cyrillic: ": {
			ru: "Кириллица: "
		},
		"Latin: ": {
			ru: "Латиница: "
		},
		"Numbers: ": {
			ru: "Числа: "
		},
		"Decimal: ": {
			ru: "Десятичные: "
		},
		"Hexadecimal: ": {
			ru: "Шестнадцатеричные: "
		}
	};
	var lng = ln ? "eng" : "ru";

	_localize = function(s) {
		return strings[s] && strings[s][lng] || s;
	};
	return _localize(s);
}