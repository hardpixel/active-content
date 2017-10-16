module Cms
  module Post
    extend ActiveSupport::Concern

    included do
      include Cms::Categorizable
      include Cms::Taggable
      include Cms::Templatable
    end
  end
end
