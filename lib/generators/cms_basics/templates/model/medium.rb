class Medium < ApplicationRecord
  # Mount carrierwave uploader
  mount_uploader :file
end
