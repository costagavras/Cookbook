class Recipe < ApplicationRecord

  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user

  #active_storage attachments
  has_many_attached :photos
  has_one_attached :screencapture

  attr_accessor :remove_photos, :remove_screencapture, :remove_screencapture_saved_locally, :screencapture_name #attributes for the form

  # after_save :purge_photos, if: :remove_photos
  # private def purge_photos
  # puts "Hello, I'm before aftersave purge!"
  #   photos.purge_later
  # puts "Hello, I'm after aftersave purge!"
  # end

  validates :name, :complexity, :category, :prep_time, :servings, presence: true
  validates :servings, inclusion: { in: (1..20)}
  validates :screencapture_name, format: {without: /\s/ }

  def self.difflevel_int_to_text
    case self.complexity
    when 1
      return "Easy"
    when 2
      return "Average"
    when 3
      return "Hard"
    end
  end
  #
  # def complexity_icons
  #   output = ""
  #   self.complexity.times { output += ActionController::Base.helpers.image_tag('assets/images/cookbook_no_bg.png', :class => "logo_img_diff", :width => "30", :length => "30") }
  #   output
  # end

  def self.most_viewed
    self.order(visits: :desc)
    # self.order(:visits).reverse_order
  end

end
