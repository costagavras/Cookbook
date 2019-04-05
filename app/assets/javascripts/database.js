document.addEventListener("DOMContentLoaded", function(){
  if (document.querySelector(".db_header")) {
      getAreaList();
      getCategoryList();
      getIngredientList();
  }
})

 //setting up recipe blocks, one per recipe
function doRecipeBlock(meal,category,area,picture){
  var dbSearchResultArea = document.querySelector(".db_search_result_area");
  var dbRecipeBlock = document.createElement("div");
  dbRecipeBlock.classList.add("db_recipe_block");
  dbSearchResultArea.appendChild(dbRecipeBlock);

  if (meal != null) {
    var dbRecipeName = document.createElement("h3");
    dbRecipeName.id = "db_recipe_name";
    dbRecipeBlock.appendChild(dbRecipeName);
    dbRecipeName.innerText = meal;
  }
  if (category != null) {
    var dbRecipeCategory = document.createElement("h4");
    dbRecipeCategory.id = "db_recipe_category";
    dbRecipeBlock.appendChild(dbRecipeCategory);
    dbRecipeCategory.innerText = category;
  }
  if (area != null) {
    var dbRecipeArea = document.createElement("h4");
    dbRecipeArea.id = "db_recipe_area";
    dbRecipeBlock.appendChild(dbRecipeArea);
    dbRecipeArea.innerText = area;
  }
  if (picture != null) {
    var dbRecipePic = document.createElement("img");
    dbRecipePic.id = "db_recipe_pic";
    dbRecipeBlock.appendChild(dbRecipePic);
    dbRecipePic.src = picture;
  }
}

  //deleting recipe blocks to clean up the page
function removeRecipeBlocks() {
  var dbSearchResultArea = document.querySelector(".db_search_result_area");
  while (dbSearchResultArea.firstChild) {
    dbSearchResultArea.removeChild(dbSearchResultArea.firstChild);
  }
}

function getRandomRecipe(){

  removeRecipeBlocks();

  var dbRandomRecipeURL = "https://www.themealdb.com/api/json/v1/1/random.php"

  axios({
          url: dbRandomRecipeURL,
          method: 'get', //default
          data: '', //`data` is the data to be sent as the request body, only applicable for request methods 'PUT', 'POST', and 'PATCH'
          dataType: 'json', // default
        }).then(function(response){
          var meal = response.data["meals"][0]["strMeal"];
          var category = "Category: " + response.data["meals"][0]["strCategory"];
          var area = "Cuisine: " + response.data["meals"][0]["strArea"];
          var picture = response.data["meals"][0]["strMealThumb"];

          doRecipeBlock(meal, category, area, picture);
    })
}

function getSearchedRecipe(){

  removeRecipeBlocks();

  var dbSearchedValue = document.getElementById("db_recipe").value;
  var dbSearchedRecipeURL = "https://www.themealdb.com/api/json/v1/1/search.php?s=" + dbSearchedValue;

  axios.get(dbSearchedRecipeURL)
        .then(function(response){
          if (response.data["meals"] != null) {
            // console.log(response.data["meals"]);
            for (var recipe = 0; recipe < response.data["meals"].length; recipe++) {
              var meal = response.data["meals"][recipe]["strMeal"];
              var category = "Category: " + response.data["meals"][recipe]["strCategory"];
              var area = "Cuisine: " + response.data["meals"][recipe]["strArea"];
              var picture = response.data["meals"][recipe]["strMealThumb"];
              doRecipeBlock(meal, category, area, picture);
            }
          } else {
            var meal = "The database does not contain recipes with this keyword";
            doRecipeBlock(meal);
          }
        });
}


      function getAreaList(){
        var dbListURL = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        var dbSelectTag = document.getElementById("selector_area");

        axios.get(dbListURL)
                .then(function(response){
                  var listOption = document.createElement("option");
                    listOption.innerHTML = "Select cuisine...";
                    dbSelectTag.appendChild(listOption);
                  for(item in response.data["meals"]){
                    var listOption = document.createElement("option");
                      listOption.innerHTML = response.data["meals"][item]["strArea"];
                      dbSelectTag.appendChild(listOption);
                  }
          })
      }

      function getCategoryList(){
        var dbListURL = "https://www.themealdb.com/api/json/v1/1/list.php?c=list"
        var dbSelectTag = document.getElementById("selector_category");

        axios.get(dbListURL)
                .then(function(response){
                  var listOption = document.createElement("option");
                    listOption.innerHTML = "Select category...";
                    dbSelectTag.appendChild(listOption);
                  for(item in response.data["meals"]){
                    var listOption = document.createElement("option");
                      listOption.innerHTML = response.data["meals"][item]["strCategory"];
                      dbSelectTag.appendChild(listOption);
                  }
          })
      }

      function getIngredientList(){
        var dbListURL = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        var dbSelectTag = document.getElementById("selector_ingredient");

        axios.get(dbListURL)
                .then(function(response){
                  var listOption = document.createElement("option");
                    listOption.innerHTML = "Select ingredient...";
                    dbSelectTag.appendChild(listOption);
                  for(item in response.data["meals"]){
                    var listOption = document.createElement("option");
                      listOption.innerHTML = response.data["meals"][item]["strIngredient"];
                      dbSelectTag.appendChild(listOption);
                  }
          })
      }

      //   .catch(function (error) {
      //     if (error.response) {
      //       // The request was made and the server responded with a status code
      //       // that falls out of the range of 2xx
      //       console.log(error.response.data);
      //       console.log(error.response.status);
      //       console.log(error.response.headers);
      //     } else if (error.request) {
      //       // The request was made but no response was received
      //       // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
      //       // http.ClientRequest in node.js
      //       console.log(error.request);
      //     } else {
      //       // Something happened in setting up the request that triggered an Error
      //       console.log('Error', error.message);
      //     }
      //     console.log(error.config);
      // });
