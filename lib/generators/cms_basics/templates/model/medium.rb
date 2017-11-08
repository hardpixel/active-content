class Medium < ApplicationRecord
  # Has associations
  has_many :attachments

  # Mount uploaders
  mount_uploader :file
end
