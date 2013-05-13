class TagCategory < ActiveRecord::Base
  validates :title, presence: true

  scope :published, -> { order('position ASC') }
end
