module Cms
  module Medium
    extend ActiveSupport::Concern

    included do
      # Has associations
      has_many :attachments

      # Mount uploaders
      mount_uploader :file
    end
  end
end
