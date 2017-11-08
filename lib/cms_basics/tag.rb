module Cms
  module Tag
    extend ActiveSupport::Concern

    included do
      include Cms::Templatable

      # Has associations
      has_many :taggings
    end
  end
end
