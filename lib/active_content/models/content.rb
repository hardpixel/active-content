class ActiveContent::Content < ActiveRecord::Base
  # Set table name
  self.table_name = 'contents'

  # Define validations
  validates :title, presence: true
end
