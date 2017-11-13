class ActiveContent::Content < ApplicationRecord
  # Set table name
  self.table_name = 'contents'

  # Define validations
  validates :title, presence: true
end
