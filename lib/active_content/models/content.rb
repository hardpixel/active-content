class ActiveContent::Content < ActiveRecord::Base
  self.table_name = 'contents'

  validates :title, presence: true
end
