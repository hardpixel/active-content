class ActiveContent::Taxonomization < ApplicationRecord
  self.table_name = 'taxonomizations'

  # Belongs associations
  belongs_to :taxonomy
  belongs_to :taxonomizable, polymorphic: true, optional: true
end
