document.addEventListener("DOMContentLoaded", function(){
  var temp = document.querySelector(".recipe").clientHeight;
  // console.log(temp);
  document.querySelector(".photo").setAttribute("style","height:"+temp+"px");
});

function show_loader(){
  var loader = document.querySelector(".loader");
  loader.style.visibility = "visible";
}
