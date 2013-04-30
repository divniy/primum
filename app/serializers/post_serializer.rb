class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at
  has_many :tags

  def created_at
    object.created_at
  end
end
