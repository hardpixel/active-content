class Attachment < ActiveRecord::Base
  # Belongs associations
  belongs_to :medium
  belongs_to :attachable, polymorphic: true, optional: true
end
