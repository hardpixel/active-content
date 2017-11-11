class Attachment < ActiveRecord::Base
  # Belongs associations
  belongs_to :upload
  belongs_to :attachable, polymorphic: true, optional: true
end
