document.addEventListener("DOMContentLoaded", function(){
  //Prepopulating select_tags for filters
  if (document.querySelector(".db_header")) {
      getAreaList();
      getCategoryList();
      getIngredientList();

    //updates 10 most recent recipes
      updateRecentList(null);
    //delete localstorage items that make work category and area(cuisine) links
      deleteLocalStorCatArea();
    //attaching functions to filter buttons
    var areaBtn = document.getElementById("area_select_btn");
    areaBtn.addEventListener("click", filterArea);
    var categoryBtn = document.getElementById("category_select_btn");
    categoryBtn.addEventListener("click", filterCategory);
    var ingredientBtn = document.getElementById("ingredient_select_btn");
    ingredientBtn.addEventListener("click", filterIngredient);
    //hides go back button element
    document.querySelector(".db_go_back").hidden = true;

  }
})

 //setting up recipe blocks, one per recipe
function doRecipeBlock(meal,area,category,picture,mealId,ingredients,instructions){

  var dbSearchResultArea = document.querySelector(".db_search_result_area");
  var dbRecipeBlock = document.createElement("div");

  dbSearchResultArea.appendChild(dbRecipeBlock);
  dbRecipeBlock.id = mealId;

  if (instructions == null) { //reduced info passed (first run), sets dblclick to run full info on recipe
    dbRecipeBlock.classList.add("db_recipe_block");
    dbRecipeBlock.addEventListener("dblclick", function () {
      expandRecipeDetail(mealId);
    }, false);
  } else { //full info passed (second run), removes eventlistener above and adds a new one
    dbRecipeBlock.classList.add("db_recipe_block_detail");
    dbRecipeBlock.removeEventListener("dblclick", function () {
      expandRecipeDetail(mealId);
    }, false);

    if (!localStorage.recentRecipe) { //if localStorage.recentRecipe still exists (= recipe was clicked through <10 most recent>) don't create links to go back
      // dbRecipeBlock.addEventListener("dblclick", goBack); //eventlistener sets goBack() that runs previous API function taken from localStorage
      var goBackLink = document.querySelector(".db_go_back");
      goBackLink.hidden = false;
      goBackLink.addEventListener("click", goBack);
    }
  }

  //setting up DOM elements
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
    dbRecipeCategory.innerText = "Category: " + category;
    localStorage.setItem("recipeCategory", category);
  }
  if (area != null) {
    var dbRecipeArea = document.createElement("h4");
    dbRecipeArea.id = "db_recipe_area";
    dbRecipeBlock.appendChild(dbRecipeArea);
    dbRecipeArea.innerText = "Cuisine: " + area;
    localStorage.setItem("recipeArea", area);
  }
  if (ingredients != null) {
    var dbRecipeIngredients = document.createElement("p");
    dbRecipeIngredients.id = "db_hidden_element";
    dbRecipeBlock.appendChild(dbRecipeIngredients);
    dbRecipeIngredients.innerText = "Ingredients: \n" + ingredients;
    dbRecipeCategory.addEventListener("click", filterCategory);
    dbRecipeArea.addEventListener("click", filterArea);
  }
  if (instructions != null) {
    var dbRecipeInstructions = document.createElement("p");
    dbRecipeInstructions.id = "db_hidden_element";
    dbRecipeBlock.appendChild(dbRecipeInstructions);
    dbRecipeInstructions.innerText = "Instructions: \n" + instructions;
  }
  if (picture != null) {
    var dbRecipePic = document.createElement("img");
    dbRecipePic.id = "db_recipe_pic";
    dbRecipeBlock.appendChild(dbRecipePic);
    dbRecipePic.src = picture;
  }
}

  //toggle expanded recipe view
  // function toggleExpandRecipeView(mealId) {
  //
  //    var recipeBlock = document.getElementById(mealId);
  //    var hiddenElements = recipeBlock.querySelectorAll("#db_hidden_element");
  //      for (var item of hiddenElements) { //correct way of looping through DOM node
  //        item.hidden = !item.hidden;
  //      }
  // }

  //function to go to the previous view is taken from localStorage
function goBack() {

  var storedFunc = localStorage.getItem("lastFunction");
  // Convert string back to a function
  var myFunc = eval('(' + storedFunc + ')');
  myFunc();
  var goBackLink = document.querySelector(".db_go_back");
  goBackLink.hidden = true;
}

function deleteLocalStorCatArea () {
  if (localStorage.recipeArea) {
    delete localStorage.recipeArea
  }
  if (localStorage.recipeCategory) {
    delete localStorage.recipeCategory
  }
}

  //deleting recipe blocks to clean up the page before each new API call
function removeRecipeBlocks() {

  var dbSearchResultArea = document.querySelector(".db_search_result_area");
  while (dbSearchResultArea.firstChild) {
    dbSearchResultArea.removeChild(dbSearchResultArea.firstChild);
  }
}

//reset filters to nothing chosen
function resetFilter(filterId) {

  var filter = document.getElementById(filterId);
  filter.selectedIndex = 0;
  if (filterId === "db_recipe") {
    filter.value = "";
  }
}

//updates array of 10 most recent recipes
function updateRecentList(meal) {

  if (meal != null) {
    if (localStorage.recentList) {
      var retrievedRecentList = localStorage.getItem("recentList");
      var arRecentList = JSON.parse(retrievedRecentList);
      if (arRecentList.indexOf(meal) != -1) { //case meal is found inside
        arRecentList.splice(arRecentList.indexOf(meal),1);
        arRecentList.push(meal);
      } else {
        if (arRecentList.length < 10) {
          arRecentList.push(meal);
        } else {
          arRecentList.shift();
          arRecentList.push(meal)
        }
      }
    } else {
      var arRecentList = [meal];
    }
      localStorage.setItem("recentList", JSON.stringify(arRecentList));
  } else { //case mean == null happens on page refresh (see first DOMContentLoaded function)
    if (localStorage.recentList) {
      var retrievedRecentList = localStorage.getItem("recentList");
      var arRecentList = JSON.parse(retrievedRecentList);
    }
  }
    //deleting old most_viewed_blocks and setting up new ones
    var most_viewed_block = document.querySelector(".db_most_viewed_block");
    while (most_viewed_block.firstChild) {
      most_viewed_block.removeChild(most_viewed_block.firstChild);
    }
    for (var recipe = 0; recipe < arRecentList.length; recipe++) {
      var index_recipe = document.createElement("div");
      index_recipe.classList.add("index_recipe");
      most_viewed_block.appendChild(index_recipe);
      var recipe_name = document.createElement("h3");
      recipe_name.classList.add("db_recent_name");
      recipe_name.addEventListener("click", getRecipe); //add eventlistener to show detail
      index_recipe.appendChild(recipe_name);
      recipe_name.innerText = arRecentList[recipe];
    }
}

//show detail (bugs if name is similar to another recipe)
function getRecipe(event) {
  localStorage.setItem("recentRecipe", event.target.innerText)
  getSearchedRecipe();
}

//API call for random recipe
function getRandomRecipe(){

  removeRecipeBlocks();
  resetFilter("selector_ingredient");
  resetFilter("selector_category");
  resetFilter("selector_area");
  resetFilter("db_recipe");

  var dbRandomRecipeURL = "https://www.themealdb.com/api/json/v1/1/random.php"

  localStorage.setItem("lastFunction", "getRandomRecipe");

  axios({
          url: dbRandomRecipeURL,
          method: 'get', //default
          data: '', //`data` is the data to be sent as the request body, only applicable for request methods 'PUT', 'POST', and 'PATCH'
          dataType: 'json', // default
        }).then(function(response){
          if (response.data["meals"] != null) {

            var responsum = response.data["meals"][0];
            var mealId = responsum["idMeal"];
            var meal = responsum["strMeal"];
            var category = responsum["strCategory"];
            var area = responsum["strArea"];
            var picture = responsum["strMealThumb"];

            doRecipeBlock(meal, area, category, picture, mealId);

          } else {
            var meal = "The database did not return a random recipe";
            doRecipeBlock(meal);
        }
    });

}

//API call for search bar
function getSearchedRecipe(){

  removeRecipeBlocks();
  resetFilter("selector_ingredient");
  resetFilter("selector_category");
  resetFilter("selector_area");

  var dbSearchedValue = (localStorage.recentRecipe) ? localStorage.recentRecipe : document.getElementById("db_recipe").value;

  var dbSearchedRecipeURL = "https://www.themealdb.com/api/json/v1/1/search.php?s=" + dbSearchedValue;

  localStorage.setItem("lastFunction", "getSearchedRecipe");

  axios.get(dbSearchedRecipeURL)
        .then(function(response){
          if (response.data["meals"] != null) {
            // console.log(response.data["meals"]);
            var responsum = response.data["meals"];
            for (var recipe = 0; recipe < responsum.length; recipe++) {
              var mealId = responsum[recipe]["idMeal"];
              var meal = responsum[recipe]["strMeal"];
              var category = responsum[recipe]["strCategory"];
              var area = responsum[recipe]["strArea"];
              var picture = responsum[recipe]["strMealThumb"];
              doRecipeBlock(meal, area, category, picture, mealId);
            }
          } else {
            var meal = "The database does not contain recipes with this keyword";
            doRecipeBlock(meal);
          }
        });
        var goBackLink = document.querySelector(".db_go_back");
        goBackLink.hidden = true;
}

//API call to populate area select_tag
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

//API call to populate category select_tag
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

//API call to populate ingredient select_tag
function getIngredientList(){
  var dbListURL = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
  var dbSelectTag = document.getElementById("selector_ingredient");
  var arIngredientList = [];

  axios.get(dbListURL)
          .then(function(response){
            var listOption = document.createElement("option");
              listOption.innerHTML = "Select ingredient...";
              dbSelectTag.appendChild(listOption);
            for(item in response.data["meals"]){
              arIngredientList.push(response.data["meals"][item]["strIngredient"]);
            }
            arIngredientList.sort();
            for(item in arIngredientList){
              var listOption = document.createElement("option");
                listOption.innerHTML = arIngredientList[item];
                dbSelectTag.appendChild(listOption);
            }
    })
}

//API call to run area filter
function filterArea() {

    removeRecipeBlocks();
    resetFilter("selector_ingredient");
    resetFilter("selector_category");
    resetFilter("db_recipe");

    if (localStorage.recipeArea) {
      document.getElementById("selector_area").value = localStorage.recipeArea;
      deleteLocalStorCatArea();
    }

    var dbSearchedValue = document.getElementById("selector_area").value;
    var dbSearchedRecipeURL = "https://www.themealdb.com/api/json/v1/1/filter.php?a=" + dbSearchedValue;

    localStorage.setItem("lastFunction", "filterArea");


    axios.get(dbSearchedRecipeURL)
          .then(function(response){
            if (response.data["meals"] != null) {
              // console.log(response.data["meals"]);
              var responsum = response.data["meals"];
              for (var recipe = 0; recipe < responsum.length; recipe++) {
                var mealId = responsum[recipe]["idMeal"];
                var meal = responsum[recipe]["strMeal"];
                var area = dbSearchedValue;
                var category = null;
                var picture = responsum[recipe]["strMealThumb"];
                doRecipeBlock(meal, area, category, picture, mealId);
              }
            } else {
              var meal = "The database does not contain recipes with this keyword";
              doRecipeBlock(meal);
            }
          });
          var goBackLink = document.querySelector(".db_go_back");
          goBackLink.hidden = true;
}

//API call to run category filter
function filterCategory() {

    removeRecipeBlocks();
    resetFilter("selector_ingredient");
    resetFilter("selector_area");
    resetFilter("db_recipe");

    if (localStorage.recipeCategory) {
      document.getElementById("selector_category").value = localStorage.recipeCategory;
      deleteLocalStorCatArea();
    }

    var dbSearchedValue = document.getElementById("selector_category").value;
    var dbSearchedRecipeURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=" + dbSearchedValue;

    localStorage.setItem("lastFunction", "filterCategory");

    axios.get(dbSearchedRecipeURL)
          .then(function(response){
            if (response.data["meals"] != null) {
              // console.log(response.data["meals"]);
              var responsum = response.data["meals"];
              for (var recipe = 0; recipe < responsum.length; recipe++) {
                var mealId = responsum[recipe]["idMeal"];
                var meal = responsum[recipe]["strMeal"];
                var area = null;
                var category = dbSearchedValue;
                var picture = responsum[recipe]["strMealThumb"];
                doRecipeBlock(meal, area, category, picture, mealId);
              }
            } else {
              var meal = "The database does not contain recipes with this keyword";
              doRecipeBlock(meal);
            }
          });
          var goBackLink = document.querySelector(".db_go_back");
          goBackLink.hidden = true;
}

//API call to run ingredient filter
function filterIngredient() {

    removeRecipeBlocks();
    resetFilter("selector_category");
    resetFilter("selector_area");
    resetFilter("db_recipe");

    var dbSearchedValue = document.getElementById("selector_ingredient").value;
    var dbSearchedRecipeURL = "https://www.themealdb.com/api/json/v1/1/filter.php?i=" + dbSearchedValue;

    localStorage.setItem("lastFunction", "filterIngredient");

    axios.get(dbSearchedRecipeURL)
          .then(function(response){
            if (response.data["meals"] != null) {
              // console.log(response.data["meals"]);
              var responsum = response.data["meals"];
              for (var recipe = 0; recipe < responsum.length; recipe++) {
                var mealId = responsum[recipe]["idMeal"];
                var meal = responsum[recipe]["strMeal"];
                var area = null;
                var category = null;
                var picture = responsum[recipe]["strMealThumb"];
                doRecipeBlock(meal, area, category, picture, mealId);
              }
            } else {
              var meal = "The database does not contain recipes with this keyword";
              doRecipeBlock(meal);
            }
          });
          var goBackLink = document.querySelector(".db_go_back");
          goBackLink.hidden = true;
  }

//loads full detail about the recipe
function expandRecipeDetail(mealId) {

  removeRecipeBlocks();

  var dbRecipeDetailURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=" + mealId;
  var arIngredients = [];

    axios.get(dbRecipeDetailURL)
          .then(function(response){
            if (response.data["meals"] != null) {
              // console.log(response.data["meals"]);
              var responsum = response.data["meals"][0];
              var meal = responsum["strMeal"];
              var category = responsum["strCategory"];
              var area = responsum["strArea"];
              var picture = responsum["strMealThumb"];
              var instructions = responsum["strInstructions"];
              for (var item = 1; item < 21; item++) {
                if (responsum["strIngredient"+item] != "" && responsum["strIngredient"+item] != null) {
                  arIngredients[item-1] = " " + responsum["strIngredient"+item] + ": " + responsum["strMeasure"+item];
                }
              }
              updateRecentList(meal);
              doRecipeBlock(meal, area, category, picture, mealId, arIngredients, instructions);
              localStorage.removeItem("recentRecipe"); //deletes reference to recentRecipe so no back links check in doRecipeBlock is correctly performed
            } else {
              var meal = "Oops! Something went wrong!";
              doRecipeBlock(meal);
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
