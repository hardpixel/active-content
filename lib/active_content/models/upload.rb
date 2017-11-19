class ActiveContent::Upload < ActiveRecord::Base
  # Set table name
  self.table_name = 'uploads'

  # Mount carrierwave uploader
  has_uploader

  # Define validations
  validates :file, presence: true
end
