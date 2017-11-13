class ActiveContent::Profile < ApplicationRecord
  # Set table name
  self.table_name = 'profiles'

  # Belongs associations
  belongs_to :profileable, polymorphic: true, optional: true

  # Mount carrierwave uploader
  mount_uploader :image
end
