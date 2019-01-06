class ActiveContent::Profile < ActiveRecord::Base
  class_attribute :image_uploaders

  self.table_name = 'profiles'

  belongs_to :profileable, polymorphic: true, optional: true

  after_initialize do
    unless profileable.nil?
      class_name = :"#{profileable.class.name.underscore}_image"
      base_class = :"#{profileable.class.base_class.name.underscore}_image"

      self.class.uploaders[:image] = begin
        self.class.image_uploaders[class_name] ||
        self.class.image_uploaders[base_class] ||
        self.class.image_uploaders[:image]
      end
    end
  end

  def self.build_image_uploader(assoc_name, uploader_class)
    if uploader_class
      uploader = Class.new(uploader_class)
      const_set("#{assoc_name}#{uploader_class}", uploader)

      uploader.class_eval do
        alias :original_model :model

        def model
          original_model.profileable
        end
      end

      uploader
    end
  end

  def self.add_image_uploader(assoc_name, uploader)
    self.image_uploaders ||= {}
    self.mount_uploader :image, build_image_uploader(assoc_name, uploader)

    class_name = uploader ? :"#{assoc_name.underscore}_image" : :image
    self.image_uploaders[class_name] = self.uploaders[:image]
  end

  def name
    if first_name or last_name
      "#{first_name} #{last_name}".strip
    end
  end
end
