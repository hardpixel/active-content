class PostCategory < Categorization
  # Set default scope
  default_scope { where categorizable_type: 'Post' }

  # Has associations
  has_many :categorizations
  has_many :posts, through: :categorizations, source: :categorizable, source_type: 'Post'
end
