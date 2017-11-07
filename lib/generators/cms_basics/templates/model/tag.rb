class Tag < ApplicationRecord
  # Has associations
  has_many :taggings
end
