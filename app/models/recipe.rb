class Recipe < ApplicationRecord

  has_many :comments
  belongs_to :category
  belongs_to :user

  # has_many_attached :images

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
