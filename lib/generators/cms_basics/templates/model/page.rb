class Page < ApplicationRecord
  # Add template support
  # has_templates :home, :blog

  # Set ancestry for tree organization
  # has_ancestry orphan_strategy: :adopt
end
