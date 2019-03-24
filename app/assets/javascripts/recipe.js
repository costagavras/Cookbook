
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

// document.addEventListener("DOMContentLoaded", function(){
//   // Added cookie logic to avoid losing hidden/unhidden status on refresh page
//   var comments = document.querySelector(".comment_section");
//   var show_link = document.querySelector(".comments_show");
//   comments.style.visibility = readCookie("comments");
//   show_link.innerText = comments.style.visibility == "hidden" ? "unhide" : "hide";
//
//   var images = document.querySelector(".photo");
//   var show_images_link = document.querySelector(".images_show");
//   var recipePhotos = document.querySelector(".recipe_photos")
//   images.style.visibility = readCookie("images");
//   show_images_link.innerText = images.style.visibility == "hidden" ? "unhide" : "hide";
//   if (images.style.visibility == "hidden") {
//     recipePhotos.setAttribute("style","grid-template-columns:"+"100% 0%");
//   }
//   else {
//     recipePhotos.setAttribute("style","grid-template-columns:"+"50% 50%");
//   }
// });

// function show_comments() {
//   var comments = document.querySelector(".comment_section");
//   var show_link = document.querySelector(".comments_show");
//   show_link.innerText = show_link.innerText == "hide" ? "unhide" : "hide";
//   if (show_link.innerText == "unhide") {
//     comments.style.visibility = "hidden";
//     // Added cookie logic to avoid losing hidden/unhidden status on refresh page
//     createCookie("comments", "hidden");
//   }
//   else {
//     comments.style.visibility = "visible";
//     createCookie("comments", "visible");
//   }
//   event.preventDefault();
//   adjustHeight();
// };

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
  images.style.visibility = readCookie("images");
  show_images_link.innerText = images.style.visibility == "hidden" ? "unhide" : "hide";
  if (images.style.visibility == "hidden") {
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
  show_images_link.innerText = show_images_link.innerText == "hide" ? "unhide" : "hide";
  if (show_images_link.innerText == "unhide") {
    var recipePhotos = document.querySelector(".recipe_photos")
    recipePhotos.setAttribute("style","grid-template-columns:"+"100% 0%");
    images.style.visibility = "hidden";
    // Added cookie logic to avoid losing hidden/unhidden status on refresh page
    createCookie("images", "hidden")
  }
  else {
    var recipePhotos = document.querySelector(".recipe_photos")
    recipePhotos.setAttribute("style","grid-template-columns:"+"50% 50%");
    images.style.visibility = "visible";
    createCookie("images", "visible");
  }
  event.preventDefault();
  adjustHeight();
};
