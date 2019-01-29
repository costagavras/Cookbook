class Recipe < ApplicationRecord

  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user

  #active_storage attachments
  has_many_attached :photos

  attr_accessor :remove_photos #for the form

  # after_save :purge_photos, if: :remove_photos
  # private def purge_photos
  # puts "Hello, I'm before aftersave purge!"
  #   photos.purge_later
  # puts "Hello, I'm after aftersave purge!"
  # end



  validates :name, :complexity, :category, :prep_time,:servings, :grabbed, presence: true
  # validates :hunt_date, inclusion:{ in: (Date.today-6.months..Date.today+6.months)}
  # validates :hunt_time, inclusion:{ in: (8.hours..20.hours)}
  validates :servings, inclusion: { in: (1..20)}

  def difflevel_int_to_text
    case self.complexity
    when 1
      return "Easy"
    when 2
      return "Average"
    when 3
      return "Hard"
    end
  end

end
