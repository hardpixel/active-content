class Tagging < ActiveRecord::Base
  # Belongs associations
  belongs_to :tag
  belongs_to :taggable, polymorphic: true, optional: true
end
