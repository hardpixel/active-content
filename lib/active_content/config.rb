module ActiveContent
  class Config
    include ActiveSupport::Configurable

    # Options with default
    config_accessor(:metum_class_name)          { 'ActiveContent::Metum' }
    config_accessor(:profile_class_name)        { 'ActiveContent::Profile' }
    config_accessor(:template_class_name)       { 'ActiveContent::Template' }
    config_accessor(:relation_class_name)       { 'ActiveContent::Relation' }
    config_accessor(:attachment_class_name)     { 'ActiveContent::Attachment' }
    config_accessor(:taxonomization_class_name) { 'ActiveContent::Taxonomization' }

    # Options without defaults
    config_accessor(:profile_image_uploader)
    config_accessor(:profile_locale_accessors)
    config_accessor(:metum_locale_accessors)
  end
end
