document.addEventListener("DOMContentLoaded", function(){
  var recipeHeight = document.querySelector(".recipe").clientHeight;
  document.querySelector(".photo").setAttribute("style","height:"+recipeHeight+"px");
});

function show_loader(){
  var loader = document.querySelector(".loader");
  loader.style.visibility = "visible";
};

function reset_filter(){
  var filter_number_fields = document.querySelectorAll(".filter_number_field");
  for (var i = 0; i < filter_number_fields.length; i++){
    filter_number_fields[i].value = "";
  }
};

document.addEventListener("DOMContentLoaded", function return_to_filter(){
  var filter_button = document.querySelector(".filter_button");
  filter_button.scrollIntoView({behavior: "auto", block: "center", inline: "nearest"});
});

// When the user scrolls the photo window, execute myFunction
function horizontal_bar() {
  var photoScroll = document.querySelector(".photo");
  var photoScrollTop = photoScroll.scrollTop;
  var height = photoScroll.scrollHeight - photoScroll.clientHeight; //scrollHeight less scrolled distance, always decreasing
  var scrolled = (photoScrollTop / height) * 100;
  document.getElementById("myBar").style.width = scrolled + "%";
};

function show_comments() {
  var comments = document.querySelector(".comment_section");
  var show_link = document.querySelector(".comments_show");
  show_link.innerText = show_link.innerText == "hide" ? "unhide" : "hide";
  if (show_link.innerText == "unhide") {
    comments.style.visibility = "hidden";
  }
  else {
    comments.style.visibility = "visible";
  }
  event.preventDefault();
  var recipeHeight = document.querySelector(".recipe").clientHeight;
  document.querySelector(".photo").setAttribute("style","height:"+recipeHeight+"px");
};

function show_images() {
  var images = document.querySelector(".photo");
  var show_images_link = document.querySelector(".images_show");
  show_images_link.innerText = show_images_link.innerText == "hide" ? "unhide" : "hide";
  if (show_images_link.innerText == "unhide") {
    var recipePhotos = document.querySelector(".recipe_photos")
    recipePhotos.setAttribute("style","grid-template-columns:"+"100% 0%");
    images.style.visibility = "hidden";
  }
  else {
    var recipePhotos = document.querySelector(".recipe_photos")
    recipePhotos.setAttribute("style","grid-template-columns:"+"50% 50%");
    images.style.visibility = "visible";
  }
  event.preventDefault();
  var recipeHeight = document.querySelector(".recipe").clientHeight;
  images.setAttribute("style","height:"+recipeHeight+"px");
};
