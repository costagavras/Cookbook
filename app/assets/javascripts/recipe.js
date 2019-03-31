
$(document).ready(function() {
  adjustHeight();
  $(".recipe_photos").on("dblclick", adjustHeight);
});

function adjustHeight(){
  var recipeHeight = document.querySelector(".recipe").clientHeight;
  document.querySelector(".photo").setAttribute("style","height:"+recipeHeight+"px");
  // alert('adjustHeightfired2');
}

function show_loader(){
  // var loader = document.querySelector(".loader");
  // loader.style.visibility = "visible";
  $(".loader").show();
};

function reset_filter(){
  var filter_number_fields = $(".filter_number_field");
  for (var i = 0; i < filter_number_fields.length; i++){
    filter_number_fields[i].value = "";
  }
};

//Identical to DOMContentLoaded, puts filter section well in sight
$(document).ready(function() {
  var filter_section = document.querySelector(".filter_section");
  filter_section.scrollIntoView({behavior: "auto", block: "center", inline: "nearest"});
});

// When the user scrolls the photo window, execute myFunction
function horizontal_bar() {
  var photoScroll = document.querySelector(".photo");
  var photoScrollTop = photoScroll.scrollTop;
  var height = photoScroll.scrollHeight - photoScroll.clientHeight; //scrollHeight less scrolled distance, always decreasing
  var scrolled = (photoScrollTop / height) * 100;
  document.getElementById("myBar").style.width = scrolled + "%";
};

document.addEventListener("DOMContentLoaded", function(){
  // Added cookie logic to avoid losing hidden/unhidden status on refresh page
  //jQueried
  $(".comment_section").css("display", readCookie("comments"));
  if (readCookie("comments") == "none") {
      $(".comments_show").text("unhide");
      $(".comment_section").hide();
    }
    else {
      $(".comments_show").text("hide");
      $(".comment_section").show();
    }

  //regular JS
  var images = document.querySelector(".photo");
  var show_images_link = document.querySelector(".images_show");
  var recipePhotos = document.querySelector(".recipe_photos")
  images.style.display = readCookie("images");
  show_images_link.innerText = images.style.display == "none" ? "unhide" : "hide";
  if (images.style.display == "none") {
    recipePhotos.setAttribute("style","grid-template-columns:"+"100% 0%");
  }
  else {
    recipePhotos.setAttribute("style","grid-template-columns:"+"50% 50%");
  }
});

//jQueried
function show_comments() {
  var comments = $(".comment_section");
  var comments_visibility = $(".comment_section").css("display");
    if (comments_visibility == "block") {
      $(".comments_show").text("unhide");
      comments.hide();
      // Added cookie logic to avoid losing hidden/unhidden status on refresh page
      createCookie("comments", "none");
    }
    else {
      $(".comments_show").text("hide");
      comments.show();
      createCookie("comments", "block");
    }
  event.preventDefault();
  adjustHeight();
};

//regular JS
function show_images() {
  var images = document.querySelector(".photo");
  var show_images_link = document.querySelector(".images_show");
  var recipePhotos = document.querySelector(".recipe_photos")
  show_images_link.innerText = readCookie("images") == "block" ? "unhide" : "hide";
  if (show_images_link.innerText == "unhide") {
    recipePhotos.setAttribute("style","grid-template-columns:"+"100% 0%");
    images.style.display = "none";
    createCookie("images", "none")
  }
  else {
    recipePhotos.setAttribute("style","grid-template-columns:"+"50% 50%");
    images.style.display = "block";
    createCookie("images", "block");
    adjustHeight();
  }
  event.preventDefault();
};
