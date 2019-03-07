/*cookie code from https://www.quirksmode.org/js/cookies.html*/

// function createCookie(name,value,days) {
// 	if (days) {
// 		var date = new Date();
// 		date.setTime(date.getTime()+(days*24*60*60*1000));
// 		var expires = "; expires="+date.toGMTString();
// 	}
// 	else var expires = "";
// 	document.cookie = name+"="+value+expires+"; path=/";
// }

/*read lang cookie and translate categories labels on link click*/

document.addEventListener("DOMContentLoaded", function(){
  var lang = readCookie("lang_locale");
	// debugger;
  translateCategories(lang);
});

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
};
//
// function eraseCookie(name) {
// 	createCookie(name,"",-1);
// }

function translateCategories(lang) {
    var arEnLang = ["antipasti", "soups", "main course", "sides", "desserts"];
    var arItLang = ["antipasti", "zuppe", "piatto principale", "contorni", "dolci"];
    var arFrLang = ["antipasti", "soupes", "plat principal", "accompagnement", "desserts"];
    var arRuLang = ["закуски", "супы", "основные блюда", "гарнир", "десерты"];
    // console.log(lang);
    switch(lang) {
      case "en":
        var arNewCat = arEnLang;
        break;
      case "it":
        var arNewCat = arItLang;
        break;
      case "fr":
        var arNewCat = arFrLang;
        break;
      case "ru":
        var arNewCat = arRuLang;
        break;
      default:
        var arNewCat = arEnLang;
    }

    var arCategories = document.querySelectorAll('.category_names');
    // console.log(arCategories.count);
    // var iCatLength = arNewCat.length;
    for (var i = 0; i < arCategories.length; i++){
			var itemPos = arEnLang.indexOf(arCategories[i].innerText);
			if (itemPos == -1) {
				var itemPos = arItLang.indexOf(arCategories[i].innerText);
			} if (itemPos == -1) {
				var itemPos = arFrLang.indexOf(arCategories[i].innerText);
				} if (itemPos == -1) {
					var itemPos = arRuLang.indexOf(arCategories[i].innerText);
					}

      arCategories[i].innerText = arNewCat[itemPos].toUpperCase();
    }
};
