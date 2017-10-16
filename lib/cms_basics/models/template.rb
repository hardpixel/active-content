class Template < ActiveRecord::Base
  # Belongs associations
  belongs_to :templatable, polymorphic: true, optional: true
end
