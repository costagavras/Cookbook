
function getRandomRecipe(){
  const dbRandomURL = "https://www.themealdb.com/api/json/v1/1/random.php"
  const dbRecipeName = document.getElementById("db_recipe_name");
  const dbRecipeCategory = document.getElementById("db_recipe_category");
  const dbRecipeArea = document.getElementById("db_recipe_area");
  const dbRecipePic = document.getElementById("db_recipe_pic");

  axios({
          url: dbRandomURL,
          method: 'get',
          data: '',
          dataType: 'json',
        }).then(function(response){
          dbRecipeName.innerText = response.data["meals"][0]["strMeal"],
          dbRecipeCategory.innerText = response.data["meals"][0]["strCategory"],
          dbRecipeArea.innerText = response.data["meals"][0]["strArea"],
          dbRecipePic.src = response.data["meals"][0]["strMealThumb"]
    })
}
