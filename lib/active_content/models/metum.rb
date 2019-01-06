class ActiveContent::Metum < ActiveRecord::Base
  self.table_name = 'meta'

  belongs_to :metable, polymorphic: true, optional: true
end
