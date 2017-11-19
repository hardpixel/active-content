class ActiveContent::Attachment < ActiveRecord::Base
  # Set table name
  self.table_name = 'attachments'

  # Belongs associations
  belongs_to :upload
  belongs_to :attachable, polymorphic: true, optional: true
end
