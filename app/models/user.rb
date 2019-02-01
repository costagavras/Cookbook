class User < ApplicationRecord

  has_secure_password

  has_many :recipes, dependent: :destroy #deletes dependencies when deleting a recipe
  has_many :comments #comments left by the user himself

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

end
