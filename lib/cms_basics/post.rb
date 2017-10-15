module CmsBasics
  module Post
    extend ActiveSupport::Concern

    included do
      include CmsBasics::Categorizable
      include CmsBasics::Taggable
    end
  end
end
