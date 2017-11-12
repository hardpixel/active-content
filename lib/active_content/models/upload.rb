class ActiveContent::Upload < ApplicationRecord
  # Set table name
  self.table_name = 'uploads'

  # Mount media uploader
  has_uploader

  # Define validations
  validates :file, presence: true
end
