class ActiveContent::Profile < ApplicationRecord
  # Set table name
  self.table_name = 'profiles'

  # Belongs associations
  belongs_to :profileable, polymorphic: true, optional: true

  # Mount carrierwave uploader
  mount_uploader :image

  # Name composed by first and last name
  def name
    if first_name or last_name
      "#{first_name} #{last_name}".strip
    end
  end
end
