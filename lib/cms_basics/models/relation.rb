class Cms::Relation < ApplicationRecord
  self.table_name = 'relations'

  # Belongs associations
  belongs_to :item, polymorphic: true, optional: true
  belongs_to :relatable, polymorphic: true, optional: true
end
