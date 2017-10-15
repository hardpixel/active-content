class Categorization < ActiveRecord::Base
  # Belongs associations
  belongs_to :category
  belongs_to :categorizable, polymorphic: true, optional: true
end
