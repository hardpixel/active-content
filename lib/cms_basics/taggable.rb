module Cms
  module Taggable
    extend ActiveSupport::Concern

    included do
      # Has associations
      has_many :taggings, as: :taggable
      has_many :tags, through: :taggings

      # Custom scopes
      scope :tagged,   -> { joins(:tags).distinct }
      scope :with_tag, -> ids { tagged.where tags: { id: ids } }
    end

    # Get tags list
    def tags_list
      self.tags
    end

    # Assign tags list
    def tags_list=(names)
      self.tags = Array(names).map do |name|
        Tag.find_by_name(name) || Tag.new(name: name)
      end
    end
  end
end
