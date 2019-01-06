class ActiveContent::Attachment < ActiveRecord::Base
  self.table_name = 'attachments'

  belongs_to :upload
  belongs_to :attachable, polymorphic: true, optional: true
end
