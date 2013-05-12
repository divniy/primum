class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :tag_list, :created_at
  #has_many :tags

  def created_at
    object.decorate.created_at
  end
end
