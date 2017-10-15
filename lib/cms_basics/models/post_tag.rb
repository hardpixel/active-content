class PostTag < Tagging
  # Set default scope
  default_scope { where taggable_type: 'Post' }

  # Has associations
  has_many :taggings
  has_many :posts, through: :taggings, source: :taggable, source_type: 'Post'
end
