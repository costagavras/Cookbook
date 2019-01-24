class User < ApplicationRecord

  has_secure_password

  has_many :recipes, dependent: :destroy #deletes dependencies when deleting a recipe
  # has_many :user_recipes, through: :recipes, source: :category
  # has_many :comments, through: :recipes #when user has a recipe that has comments from different users
  has_many :comments #comments left by the user himself

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

end
