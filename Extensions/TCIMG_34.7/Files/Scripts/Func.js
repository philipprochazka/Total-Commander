// Func.js
//========================   Описание   =====================================
// Скрипт-библитотека с различными Функциями, которые можно использовать в командах утилиты TCIMG
// Функции используются в команде funjs
//================   Примеры  использования   ===============================
// aends=<info=q1|encURI|cliptext> GLOBALAENDS<a>
// funjs=encURI|cliptext GLOBALFUNJS1<a>

// Автор:           Аверин Андрей
// Версия:          2.1 (09.05.2017 - 16.01.2024)
// Mail:            Averin-And@yandex.ru
// Help:            http://tcimg.dreamlair.net/TCIMG_ONLINE/html/html/com_funjs.htm
// Site:            http://tc-image.3dn.ru/forum/5-498-1
// Telegram:        https://t.me/tcimg
//========================================================================
	// Для отображение MessageBox зарегистрировать в системе ...\AkelFiles\Plugs\Scripts.dll
	// AkelPad=new ActiveXObject("AkelPad.Document");
// 	AkelPad.MessageBox(0," =>" + Line + "<=", "Переменная Line", 64);
//// ==========
	// Для отображение ToolTip зарегистрировать в системе ...\AutoIt\AutoItX\AutoItX3.dll
// var oAutoIt=new ActiveXObject("AutoItX3.Control");
// oAutoIt.ToolTip( ">>>>>" + Line + "<<<<<", 0, 0);
// oAutoIt.Sleep( 2000);
//// ==========
// WScript.Echo(Cnt);

// Метод encodeURI заменяет все символы, исключая следующие, соответствующими им UTF-8 escape-последовательностями.
function encURI(Line){
	return encodeURI(Line)
}
// Метод encodeURIComponent заменяет все символы, кроме [^a-zA-Zа-яёА-ЯЁ\d_.!~*'()-] escape-последовательностями.
function encodeURI(Line){
	return encodeURIComponent(Line)
}
// Метод decodeURIComponent заменяет все символы, кроме [^a-zA-Zа-яёА-ЯЁ\d_.!~*'()-] escape-последовательностями.
function decodeURI(Line){
	return decodeURIComponent(Line)
}
// Декодирует строку кодированную методом encodeURI
function decURI(Line){
	return decodeURI(Line)
}
// длина строки
function Len(Line){
	return Line.length
}
// function Autoit(A){d=new ActiveXObject('Scripting.Dictionary');d.RemoveAll();for(var i=0;i<A.length;i++){d.Add(i,A[i]);}return d.Items();}
// Преобразует массив JS для вывода в утилиту TCIMG
function ArrayJStoAutoit(arr){
  dicTmp=new ActiveXObject('Scripting.Dictionary');
  dicTmp.RemoveAll();
  for(var i=0;i<arr.length;i++){dicTmp.Add(i,arr[i]);}
  return dicTmp.Items();
}
// function AS(AA){A=new VBArray(AA).toArray();A.shift();return Autoit(A);}
// Удаляет в массиве aArray элемент с индексом 0 и сдвигает остальные элементы на один вниз (медленнее чем _ArrayDelete в Autoit)
function ArrayPush(aArray) {
  var avArray=new VBArray(aArray).toArray();
  avArray.shift()
  return ArrayJStoAutoit(avArray);
}
// function SS(AA,DL){A=new VBArray(AA).toArray();return A.join(DL);}
//Соединяет в строку все элементы массива aArray по заданному разделителю delim (медленнее чем _ArrayToString в Autoit)
function ArrayToString(aArray,delim) {
  var avArray=new VBArray(aArray).toArray();
  return avArray.join(delim);
}
	// Для отображение MessageBox зарегистрировать ...\AkelFiles\Plugs\Scripts.dll
	// Функция просмотра переменной. Если массив, то выводится информация элементов в виде таблицы
function ViewValues(vValue) {
  AkelPad=new ActiveXObject("AkelPad.Document");
  if (typeof(vValue) == "string") {
    AkelPad.MessageBox(0," =>" + vValue + "<=", "Переменная vValue", 64);
  }
  else {
    var sText = "";
    for(var i=0;i<vValue.length;i++) {sText += i + " | " + vValue[i] + "\n"}
    AkelPad.MessageBox(0," =>\n" + sText + "<=", "Массив vValue", 64);
  }
}

//  ===========================================================================
// Xor кодирование/декодирование строки
function xorEncode(txt,pass){
  var ord=[]
  var buf=''
  for(z=1;z<=65535; z++){ord[fixedFromCharCode(z)]=z}
  for(j=z=0;z<txt.length; z++){
      buf+=fixedFromCharCode(ord[txt.substr(z,1)]^ord[pass.substr(j,1)])
      j=(j<pass.length)?j+1:0
  }
  return buf
}
// заплатка для String.fromCharCode()
function fixedFromCharCode(codePt){ 
  if(codePt>0xFFFF){ 
    codePt-=0x10000; 
    return String.fromCharCode(0xD800+(codePt>>10),0xDC00+(codePt&0x3FF)); 
  }else{ 
    return String.fromCharCode(codePt); 
  } 
}
//  ===========================================================================
// Base58 кодирование/декодирование строки
// кодирование строки
function Base58Encode(text) {
 return Base58.encode(toBytes(text));
}
// кодирование массива
function Base58EncodeA(aArray) {
  var arrTXT=new VBArray(aArray).toArray()
  var Cnt = arrTXT.length;
  for(var i = 1; i < Cnt; ++i) {
    arrTXT[i] = Base58.encode(toBytes(arrTXT[i]));
  }
  return ArrayJStoAutoit(arrTXT);
}
// декодирование строки
function Base58Decode(text) {
 return fromBytes(Base58.decode(text.split("")));
}
// декодирование массива
function Base58DecodeA(aArray) {
  var arrTXT=new VBArray(aArray).toArray()
  var Cnt = arrTXT.length;
  for(var i = 1; i < Cnt; ++i) {
    // arrTXT[i] = Base58.encode(toBytes(arrTXT[i]));
    arrTXT[i] = fromBytes(Base58.decode(arrTXT[i].split("")))
  }
  return ArrayJStoAutoit(arrTXT);
}

function toBytes(text) { // See https://www.browserling.com/js/tools-impl/base58-encode.js
   var bytes = [];
   for(var i = 0, l = text.length; i < l; ++i)
      bytes.push(text.charCodeAt(i));
   return bytes;
}
function fromBytes(bytes) {
   var out = [];
   for(var i = 0, l = bytes.length; i < l; ++i)
      out.push(String.fromCharCode(bytes[i]));
   return out.join("");
}

(function() {
  var ALPHABET, ALPHABET_MAP, Base58, i;
  //Base58 = (typeof module !== "undefined" && module !== null ? module.exports : void 0) || (window.Base58 = {});
  new Function("x", "Base58 = x;")((Base58 = {}));
  ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
  ALPHABET_MAP = {};
  i = 0;
  while (i < ALPHABET.length) {
    ALPHABET_MAP[ALPHABET.charAt(i)] = i;
    i++;
  }

  Base58.encode = function(buffer) {
    var carry, digits, j;
    if (buffer.length === 0) {
      return "";
    }
    i = void 0;
    j = void 0;
    digits = [0];
    i = 0;
    while (i < buffer.length) {
      j = 0;
      while (j < digits.length) {
        digits[j] <<= 8;
        j++;
      }
      digits[0] += buffer[i];
      carry = 0;
      j = 0;
      while (j < digits.length) {
        digits[j] += carry;
        carry = (digits[j] / 58) | 0;
        digits[j] %= 58;
        ++j;
      }
      while (carry) {
        digits.push(carry % 58);
        carry = (carry / 58) | 0;
      }
      i++;
    }
    i = 0;
    while (buffer[i] === 0 && i < buffer.length - 1) {
      digits.push(0);
      i++;
    }
    //return digits.reverse().map(function(digit) {
    //  return ALPHABET[digit];
    //}).join("");
    digits.reverse();
    for(var i = 0, l = digits.length; i < l; ++i)
       digits[i] = ALPHABET.charAt(digits[i]);
    return digits.join("");
  };

  Base58.decode = function(string) {
    var bytes, c, carry, j;
    if (string.length === 0) {
      return [];
    }
    i = void 0;
    j = void 0;
    bytes = [0];
    i = 0;
    while (i < string.length) {
      c = string[i];
      if (!(c in ALPHABET_MAP)) {
        throw "Base58.decode received unacceptable input. Character '" + c + "' is not in the Base58 alphabet.";
      }
      j = 0;
      while (j < bytes.length) {
        bytes[j] *= 58;
        j++;
      }
      bytes[0] += ALPHABET_MAP[c];
      carry = 0;
      j = 0;
      while (j < bytes.length) {
        bytes[j] += carry;
        carry = bytes[j] >> 8;
        bytes[j] &= 0xff;
        ++j;
      }
      while (carry) {
        bytes.push(carry & 0xff);
        carry >>= 8;
      }
      i++;
    }
    i = 0;
    while (string[i] === "1" && i < string.length - 1) {
      bytes.push(0);
      i++;
    }
    return bytes.reverse();
  };

}).call(this);
// Возвращает количество секунд прошедших с 1970 года
function Times() {
  return new Date().getTime()/1000;
}
//  ===========================================================================
function TranslateBing(Line, langSource, langTarget) {
// AkelPad.MessageBox(0," =>" + Line + "<=", "Переменная Line", 64);
  var req = createRequestObject();
  var resultText;
  var sAPIkey = "49F91281913BE5C04C18F184C4A14ED6097F6AD3"
  var params = sAPIkey + "&from=" + langSource + "&to=" + langTarget + "&text=" + Line
  var url = "http://api.microsofttranslator.com/V2/Http.svc/Detect?appId=" + params;
//   // "http://api.microsofttranslator.com/V2/Http.svc/Detect?appId=" + sAPIkey + "&from=" + langSource + "&to=" + langTarget + "&text=" + Line
  req.open("POST", url, falses);
  
  req.send(params);
  resultText = req.responseText;
AkelPad.MessageBox(0," =>" + resultText + "<=", "Переменная resultText", 64);
  
//       sFromLang = req.responseText.substring(req.responseText.indexOf(">") + 1, req.responseText.lastIndexOf("<"));
// AkelPad.MessageBox(0," =>" + sFromLang + "<=", "Переменная sFromLang", 64);

}
//  ===========================================================================
// Google перевод данных массива
function TranslateA(aArray, langSource, langTarget) {
  var arrTXT=new VBArray(aArray).toArray()
  var Cnt = arrTXT.length;
  for(var i = 1; i < Cnt; ++i) {
    arrTXT[i] = Translate(arrTXT[i], langSource, langTarget)
  }
  return ArrayJStoAutoit(arrTXT);
}
// Код соединён из кусков 2-х скриптов AkelPad: TranslateWithGoogleAPI.js (автор VladSh) и Translator.js (автор KDJ)
// Google перевод строки или многострочного теста
function Translate(Line, langSource, langTarget) {
  var req = createRequestObject();
  var resultText;
  if (req) {
  	if (Line) {
  		idx = Line.search("[\r\n]");
// AkelPad.MessageBox(0," =>" + Line + "<=", "Переменная Line", 64);
  		Line = encodeURIComponent(Line);
// AkelPad.MessageBox(0," =>" + Line + "<=", "Переменная Line", 64);
  		Line = Line.replace(/^[ \t\r\n]+|[ \t\r\n]+$/, "");
  		var url = "http://translate.google.com/translate_a/single";
  		var params = "client=qlt&dt=bd&dt=t&sl=" + langSource + "&tl=" + langTarget + "&q=" + Line;
  		try {
  			req.open("POST", url, false);
  			req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  			req.onreadystatechange = function() {
  				if (req.readyState == 4) {
  					if (req.status == 200) {
  						try {
  							resultText = req.responseText;
  							eval("var resultObject = " + resultText);
  							if (idx == -1)
  							{
           resultText = resultObject[0][0][0];
           resultText = resultText.replace(/&/gm, '&');
           resultText = resultText.replace(/</gm, '<');
           resultText = resultText.replace(/>/gm, '>');
           resultText = resultText.replace(/"/gm, '"');
  							}
  						else
  						{
    						for (i = 0, resultText = ""; i < resultObject[0].length; ++i)
            resultText += resultObject[0][i][0];
    
          if (resultObject[1])
          {
            for (i = 0; i < resultObject[1].length; ++i)
            {
              resultText += "\n\n" + resultObject[1][i][0] + ":";
    
              for (k = 0; k < resultObject[1][i][2].length; ++k)
              {
                resultText += "\n" + (k + 1) + ". " + resultObject[1][i][2][k][0];
    
                if (resultObject[1][i][2][k][1])
                {
                  for (n = 0, resultText += " ("; n < resultObject[1][i][2][k][1].length; ++n)
                    resultText += resultObject[1][i][2][k][1][n] + ((n < resultObject[1][i][2][k][1].length - 1) ? ", " : ")");
                }
              }
            }
          }
  						}
  						}
  						catch (e) {
  							return "";
  						}
  					}
  					else {
  						return "";
  					}
  				}
  			};
  			req.send(params);
  		}
  		catch(e)
  			{
  			  return "";
  			}
  	}
	}
	resultText = resultText.replace(/(\r\n|\r|\n)/g, '\r\n');
	return resultText;
}

function createRequestObject() {
	if (typeof(XMLHttpRequest) === 'undefined') {
		XMLHttpRequest = function() {
			try { return new ActiveXObject("Msxml2.XMLHTTP"); }
			catch(e) {
				try { return new ActiveXObject("Microsoft.XMLHTTP"); }
				catch(e) {
					throw new Error("Your system does not support XMLHttpRequest.");
				}
			}
		};
	}
	return new XMLHttpRequest();
}
// GetForismatic - получение случайного афоризма с сайта forismatic.com // sLang='ru' или sLang='en'
function GetForismatic(sLang) {
  var req=new ActiveXObject('WinHttp.WinHttpRequest.5.1');
  var sText
  if (req) {
  		var resultText;
  		var url='http://api.forismatic.com/api/1.0/';
  		var params='method=getQuote&key=457653&format=xml&lang='+sLang;
 			req.open('POST',url,false);
 			req.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
 			req.send(params);
 			req.waitForResponse;
    resultText=req.responseText;
    sText=resultText.replace(/.*<quoteText>(.*)<\/quoteText>.*/g,'$1');
    s=resultText.replace(/.*<quoteAuthor>(.*)(<\/quoteAuthor>.*)/g,'$1');
    if (s>'') {sText+='\n '+s}
  }
  return sText
}

function getText(cFile) {
  var oFSO = new ActiveXObject("Scripting.FileSystemObject");
  var oFile = oFSO.OpenTextFile(cFile);
  return oFile.ReadAll();
}
// взято https://stackoverflow.com/questions/17184813/how-to-encode-decode-ascii85-in-javascript
// кодирование в ASCII85 - только для для латинских символов
// если у вас есть более интереное решение - присылайте - вставлю
function Encode_ASCII85(a) {
  var b, c, d, e, f, g, h, i, j, k;
  for (!/[^\x00-\xFF]/.test(a), b = "\x00\x00\x00\x00".slice(a.length % 4 || 4), a += b, 
  c = [], d = 0, e = a.length; e > d; d += 4) f = (a.charCodeAt(d) << 24) + (a.charCodeAt(d + 1) << 16) + (a.charCodeAt(d + 2) << 8) + a.charCodeAt(d + 3), 
  0 !== f ? (k = f % 85, f = (f - k) / 85, j = f % 85, f = (f - j) / 85, i = f % 85, 
  f = (f - i) / 85, h = f % 85, f = (f - h) / 85, g = f % 85, c.push(g + 33, h + 33, i + 33, j + 33, k + 33)) :c.push(122);
  return function(a, b) {
    for (var c = b; c > 0; c--) a.pop();
  }(c, b.length), "<~" + String.fromCharCode.apply(String, c) + "~>";
}
// декодирование в ASCII85
function Decode_ASCII85(a) {
  var c, d, e, f, g, h = String, l = "length", w = 255, x = "charCodeAt", y = "slice", z = "replace";
  for ("<~" === a[y](0, 2) && "~>" === a[y](-2), a = a[y](2, -2)[z](/\s/g, "")[z]("z", "!!!!!"), 
  c = "uuuuu"[y](a[l] % 5 || 5), a += c, e = [], f = 0, g = a[l]; g > f; f += 5) d = 52200625 * (a[x](f) - 33) + 614125 * (a[x](f + 1) - 33) + 7225 * (a[x](f + 2) - 33) + 85 * (a[x](f + 3) - 33) + (a[x](f + 4) - 33), 
  e.push(w & d >> 24, w & d >> 16, w & d >> 8, w & d);
  return function(a, b) {
    for (var c = b; c > 0; c--) a.pop();
  }(e, c[l]), h.fromCharCode.apply(h, e);
}

// время с начала интернета в миллисекундах по всемирному координированному времени
function Datatime(){
var ms = new Date(); 
return ms.getTime();
}