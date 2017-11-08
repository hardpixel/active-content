module Cms
  module Page
    extend ActiveSupport::Concern

    included do
      include Cms::Templatable
      
      # Set ancestry for tree organization
      has_ancestry orphan_strategy: :adopt
    end
  end
end
