document.addEventListener("DOMContentLoaded", function(){
  // if (document.getElementById("db_recipe_name")) {
  //   getRandomRecipe();
  // }
})


function getRandomRecipe(){
  const dbRandomRecipeURL = "https://www.themealdb.com/api/json/v1/1/random.php"
  const dbRecipeName = document.getElementById("db_recipe_name");
  const dbRecipeCategory = document.getElementById("db_recipe_category");
  const dbRecipeArea = document.getElementById("db_recipe_area");
  const dbRecipePic = document.getElementById("db_recipe_pic");

  axios({
          url: dbRandomRecipeURL,
          method: 'get', //default
          data: '', //`data` is the data to be sent as the request body, only applicable for request methods 'PUT', 'POST', and 'PATCH'
          dataType: 'json', // default
        }).then(function(response){
          dbRecipeName.innerText = response.data["meals"][0]["strMeal"],
          dbRecipeCategory.innerText = "Category: " + response.data["meals"][0]["strCategory"],
          dbRecipeArea.innerText = "Cuisine: " + response.data["meals"][0]["strArea"],
          dbRecipePic.src = response.data["meals"][0]["strMealThumb"]
    })
}

function getSearchedRecipe(){
  const dbSearchedValue = document.getElementById("db_recipe").value;
  const dbSearchedRecipeURL = "https://www.themealdb.com/api/json/v1/1/search.php?s=" + dbSearchedValue;
  const dbRecipeName = document.getElementById("db_recipe_name");
  const dbRecipeCategory = document.getElementById("db_recipe_category");
  const dbRecipeArea = document.getElementById("db_recipe_area");
  const dbRecipePic = document.getElementById("db_recipe_pic");

  axios.get(dbSearchedRecipeURL)
        .then(function(response){
          if (response.data["meals"] != null) {
            dbRecipeName.innerText = response.data["meals"][0]["strMeal"],
            dbRecipeCategory.innerText = "Category: " + response.data["meals"][0]["strCategory"],
            dbRecipeArea.innerText = "Cuisine: " + response.data["meals"][0]["strArea"],
            dbRecipePic.src = response.data["meals"][0]["strMealThumb"]
          } else {
            dbRecipeName.innerText = "The database does not contain recipes with this keyword"
          }
        });
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
