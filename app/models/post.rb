class Post < ActiveRecord::Base
  scope :by_creation, -> { order('created_at DESC') }

  acts_as_taggable

  #after_create :notify_post_create
  def notify_post_create
    PostFeed.create(self)
  end
end
