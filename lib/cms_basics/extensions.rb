module Cms
  module Extensions
    # Category
    module Category
      extend ActiveSupport::Concern

      included do
        has_many :categorizations
      end
    end

    # Tag
    module Tag
      extend ActiveSupport::Concern

      included do
        has_many :taggings
      end
    end

    # Medium
    module Medium
      extend ActiveSupport::Concern

      included do
        has_many :attachments
        mount_uploader :file

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

# if defined? Category
#   ::Category.send :include, Cms::Extensions::Category
# end
#
# if defined? Tag
#   ::Tag.send :include, Cms::Extensions::Tag
# end
#
# if defined? Medium
#   ::Medium.send :include, Cms::Extensions::Medium
# end
