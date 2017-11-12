class ActiveContent::Metum < ApplicationRecord
  self.table_name = 'meta'

  # Belongs associations
  belongs_to :metable, polymorphic: true, optional: true
end
