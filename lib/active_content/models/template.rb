class ActiveContent::Template < ActiveRecord::Base
  # Set table name
  self.table_name = 'templates'

  # Belongs associations
  belongs_to :templatable, polymorphic: true, optional: true

  # Redefine name reader
  def name
    ActiveSupport::StringInquirer.new(
      super || default_template || 'default'
    )
  end

  private

  # Get default template name
  def default_template
    templatable.class.template.default_value if templatable.present?
  end
end
