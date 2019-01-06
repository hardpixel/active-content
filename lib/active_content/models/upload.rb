class ActiveContent::Upload < ActiveRecord::Base
  self.table_name = 'uploads'

  has_uploader

  validates :file, presence: true
end
