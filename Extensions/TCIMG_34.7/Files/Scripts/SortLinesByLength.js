// SortLinesByLength.js
// https://t.me/tcimg
// Сортирует строки массива по Длине строки и по алфавиту
// n=1 по возрастанию + a,b,c...
// n=2 по возрастанию + z,y,x...
// n=3 по убыванию + a,b,c...
// n=4 по убыванию + z,y,x...
function SortLineL(aArray, n)
	{ 
  var lpArr=new VBArray(aArray).toArray(); // это необходимо для преобразования массива, который приходит от Autoit/VBScript
  m=lpArr.length
  if (m=lpArr[0]){lpArr.shift()};n=Number(n);
  switch(n)
  {
    case 1:
      lpArr.sort(function(a, b) {
      if (a.length < b.length) return (0 ? 1 : -1);
      else if (a.length > b.length) return (0 ? -1 : 1);
      else if (a < b) return (0 ?  1 : -1);
      else if (a > b) return (0 ? -1 :  1);
      else return 0; });
      // lpArr.shift();
      break
    case 2:
      lpArr.sort(function(a, b) {
      if (a.length < b.length) return (1 ? 1 : -1);
      else if (a.length > b.length) return (1 ? -1 : 1);
      else if (a < b) return (0 ? 1 : -1);
      else if (a > b) return (0 ? -1 : 1);
      else return 0; });
      // lpArr.pop();
      break
    case 3:
      lpArr.sort(function(a, b) {
      if (a.length < b.length) return (0 ? 1 : -1);
      else if (a.length > b.length) return (0 ? -1 : 1);
      else if (a < b) return (1 ? 1 : -1);
      else if (a > b) return (1 ? -1 : 1);
      else return 0; });
      // lpArr.shift();
      break
    case 4:
      lpArr.sort(function(a, b) {
      if (a.length < b.length) return (1 ? 1 : -1);
      else if (a.length > b.length) return (1 ? -1 : 1);
      else if (a < b) return (1 ? 1 : -1);
      else if (a > b) return (1 ? -1 : 1);
      else return 0; });
      // lpArr.pop();
      break
  }
			return ArrayJStoAutoit(lpArr) ; // Преобразует массив JS для вывода в утилиту TCIMG
}
