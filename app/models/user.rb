class User < ApplicationRecord
  has_secure_password

  has_many :recipes, dependent: :destroy #deletes dependencies when deleting a recipe
  has_many :comments, through: :recipes #when user has a recipe that has comments from different users
  has_many :comments #comments left by the user himself

end
