module Cms
  module Attachable
    extend ActiveSupport::Concern

    included do
      # Has associations
      has_many :attachments, as: :attachable
      has_many :media, through: :attachments
      
      # Custom scopes
      scope :attached,   -> { joins(:media).distinct }
      scope :with_media, -> ids { attached.where media: { id: ids } }
    end

    # Get media list
    def media_list
      self.media
    end

    # Assign media list
    def media_list=(names)
      self.media = Array(names).map do |name|
        Medium.find_by_name(name) || Medium.new(name: name)
      end
    end
  end
end
