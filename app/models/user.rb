class User < ApplicationRecord

  has_secure_password

  has_many :recipes, dependent: :destroy #deletes dependencies when deleting a recipe
  has_many :comments #comments left by the user himself

  validates :name, presence: true
  validates :name, uniqueness: {message: "This username is already taken!"}, on: :create
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true


end
