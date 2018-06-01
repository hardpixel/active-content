class ActiveContent::Profile < ActiveRecord::Base
  # Define class attributes
  class_attribute :image_uploaders

  # Set table name
  self.table_name = 'profiles'

  # Belongs associations
  belongs_to :profileable, polymorphic: true, optional: true

  # Pick correct uploader after initialize for profileable class
  after_initialize do
    class_name = :"#{profileable.class.name.underscore}_image"
    base_class = :"#{profileable.class.base_class.name.underscore}_image"

    self.class.uploaders[:image] = begin
      self.class.image_uploaders[class_name] ||
      self.class.image_uploaders[base_class]
    end
  end

  # Build new image uploader class
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

  # Add uploader for a profilable class
  def self.add_image_uploader(assoc_name, uploader)
    self.image_uploaders ||= {}
    self.mount_uploader :image, build_image_uploader(assoc_name, uploader)

    class_name = :"#{assoc_name.underscore}_image"
    self.image_uploaders[class_name] = self.uploaders[:image]
  end

  # Name composed by first and last name
  def name
    if first_name or last_name
      "#{first_name} #{last_name}".strip
    end
  end
end
