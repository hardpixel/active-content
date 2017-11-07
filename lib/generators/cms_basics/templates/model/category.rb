class Category < ApplicationRecord
  # Has associations
  has_many :categorizations
  # Set ancestry for tree organization
  has_ancestry
end
