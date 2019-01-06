class ActiveContent::Template < ActiveRecord::Base
  self.table_name = 'templates'

  belongs_to :templatable, polymorphic: true, optional: true

  def name
    ActiveSupport::StringInquirer.new(super || default_template || 'default')
  end

  private

  def default_template
    templatable.class.template.default_value if templatable.present?
  end
end
