FactoryBot.define do
  factory :recipe do
    name {"Here we are"}
    prep_time 20
    user_id 1
    category_id 1
    complexity 1
    ingredients "a lot"
    directions "do this and that"
    servings 3
    visits 1
  end
end
