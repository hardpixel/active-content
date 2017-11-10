module CmsBasics
  module Mediable
    extend ActiveSupport::Concern

    class_methods do
      def has_uploader(name=nil)
        mount_uploader :file, name
        _define_media_uploader_callbacks
      end

      private

        def _define_media_uploader_callbacks
          before_save do
            if file_identifier.present?
              content_type = MIME::Types[file.content_type].first

              self.name       = file_identifier.split('.').first.titleize unless name?
              self.media_type = content_type.media_type
              self.sub_type   = content_type.sub_type
            end
          end
        end
    end
  end
end
