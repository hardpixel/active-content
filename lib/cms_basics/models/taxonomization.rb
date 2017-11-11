class Taxonomization < ActiveRecord::Base
  # Belongs associations
  belongs_to :taxonomy
  belongs_to :taxonomizable, polymorphic: true, optional: true
end
