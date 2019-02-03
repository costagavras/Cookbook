/*cookie code from https://www.quirksmode.org/js/cookies.html*/

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}

/*read lang cookie and translate categories labels on link click*/

document.addEventListener("DOMContentLoaded", function(){
  var lang = readCookie("lang_locale")
  translateCategories(lang);

});

function translateCategories(lang) {
    var arEnLang = ["ANTIPASTI", "SOUPS", "MAIN COURSE", "SIDES", "DESSERTS"];
    var arItLang = ["ANTIPASTI", "ZUPPE", "PIATTO PRINCIPALE", "CONTORNI", "DOLCI"];
    var arFrLang = ["ANTIPASTI", "SOUPES", "PLAT PRINCIPAL", "ACCOMPAGNEMENT", "DESSERTS"];
    var arRuLang = ["ЗАКУСКИ", "СУПЫ", "ОСНОВНЫЕ БЛЮДА", "ГАРНИР", "ДЕСЕРТЫ"];
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
    // console.log(arCategories[0].innerHTML);
    var iCatLength = arNewCat.length;
    for (var i = 0; i < iCatLength; i++){
      arCategories[i].innerText = arNewCat[i];
    }
}
