# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Category.destroy_all
Recipe.destroy_all
Comment.destroy_all

["antipasti", "soups", "main course", "sides", "desserts"].each do |name|
  Category.create(name: name)
end

3.times do
User.create(
  name: Faker::Name.first_name,
  password: "123456",
  password_confirmation: "123456"

)
end

10.times do
  recipe = Recipe.create(
    name: Faker::Name.name,
    prep_time: rand(10-100),
    user: User.all.sample,
    category: Category.all.sample,
    complexity: rand(1..3),
    ingredients: "a lot",
    directions: "do this, then that",
    servings: rand(1..8),
    grabbed: false
  )
  puts recipe.inspect
  recipe.save!

    1.times do
    Comment.create(
      description: "good",
      user: User.all.sample, #created by any user
      recipe: recipe #comment to this specific recipe
    )
    end

end
