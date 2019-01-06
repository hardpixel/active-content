class ActiveContent::Taxonomization < ActiveRecord::Base
  self.table_name = 'taxonomizations'

  belongs_to :taxonomy
  belongs_to :taxonomizable, polymorphic: true, optional: true
end
