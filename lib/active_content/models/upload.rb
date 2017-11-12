class ActiveContent::Upload < ApplicationRecord
  self.table_name = 'uploads'

  # Mount carrierwave uploader
  has_uploader
end
