class Category < ApplicationRecord
  # CMS Category Model
  include Cms::Model::Category

  # Set ancestry for tree organization
  # has_ancestry orphan_strategy: :adopt
end
