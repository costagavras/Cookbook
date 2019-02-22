FactoryBot.define do
  factory :comment do
    description {"awesome"}
    user_id {1}
    recipe_id {1}
  end
end
