document.addEventListener("DOMContentLoaded", function(){
  var temp = document.querySelector(".recipe").clientHeight;
  // console.log(temp);
  document.querySelector(".photo").setAttribute("style","height:"+temp+"px");
});

function show_loader(){
  var loader = document.querySelector(".loader");
  loader.style.visibility = "visible";
}

// When the user scrolls the photo window, execute myFunction
function horizontal_bar() {
  var photoScroll = document.querySelector(".photo");
  var photoScrollTop = photoScroll.scrollTop;
  var height = photoScroll.scrollHeight - photoScroll.clientHeight; //scrollHeight less scrolled distance, always decreasing
  var scrolled = (photoScrollTop / height) * 100;
  document.getElementById("myBar").style.width = scrolled + "%";
}
