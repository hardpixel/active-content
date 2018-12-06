class ActiveContent::Template < ActiveRecord::Base
  # Set table name
  self.table_name = 'templates'

  # Belongs associations
  belongs_to :templatable, polymorphic: true, optional: true

  # Redefine name reader
  def name
    ActiveSupport::StringInquirer.new(
      super || self.class.template.default_value
    )
  end
end
