module CmsBasics
  module Callbacks
    extend ActiveSupport::Concern

    included do
      before_save do
        if self.class.name == 'Medium' and file_identifier.present?
          content_type = MIME::Types[file.content_type].first

          self.name       = file_identifier.split('.').first.titleize unless name?
          self.media_type = content_type.media_type
          self.sub_type   = content_type.sub_type
        end
      end
    end
  end
end
