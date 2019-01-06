class ActiveContent::Relation < ActiveRecord::Base
  self.table_name = 'relations'

  belongs_to :item, polymorphic: true, optional: true
  belongs_to :relatable, polymorphic: true, optional: true
end
