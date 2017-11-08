module Cms
  module Category
    extend ActiveSupport::Concern

    included do
      include Cms::Templatable

      # Has associations
      has_many :categorizations

      # Set ancestry for tree organization
      has_ancestry orphan_strategy: :adopt
    end
  end
end
