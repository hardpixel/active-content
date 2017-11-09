class Template < ActiveRecord::Base
  # Belongs associations
  belongs_to :templatable, polymorphic: true, optional: true

  # Redefine template reader
  def template
    super.nil? ? super : ActiveSupport::StringInquirer.new(super)
  end
end
