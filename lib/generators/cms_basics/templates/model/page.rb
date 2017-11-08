class Page < ApplicationRecord
  # Add template support
  # include Cms::Templatable

  # Set ancestry for tree organization
  has_ancestry orphan_strategy: :adopt
end
