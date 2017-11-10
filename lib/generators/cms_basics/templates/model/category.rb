class Category < ApplicationRecord
  # Set ancestry for tree organization
  # has_ancestry orphan_strategy: :adopt
end
