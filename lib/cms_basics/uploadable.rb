module CmsBasics
  module Uploadable
    extend ActiveSupport::Concern

    class_methods do
      def has_uploader(name=nil)
        mount_uploader :file, name

        _define_media_record_attributes
        _define_media_uploader_callbacks
      end

      private

        def _define_media_record_attributes
          define_method :mime_type do
            @mime_type ||= MIME::Types[file.content_type].first
          end
        end

        def _define_media_uploader_callbacks
          before_save do
            if file_identifier.present?
              self.name       = file_identifier.split('.').first.titleize unless name?
              self.media_type = mime_type.media_type
              self.sub_type   = mime_type.sub_type
            end
          end
        end
    end
  end
end
