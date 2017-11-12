class Template < ActiveRecord::Base
  # Belongs associations
  belongs_to :templatable, polymorphic: true, optional: true

  # Redefine name reader
  def name
    super.nil? ? super : ActiveSupport::StringInquirer.new(super)
  end
end
