module ActiveContent
  module Templatable
    extend ActiveSupport::Concern

    class_methods do
      def has_templates(*templates)
        extend Enumerize
        include ActiveDelegate

        enumerize :template, in: templates, predicates: { prefix: true }

        has_one :view_template, as: :templatable, class_name: 'ActiveContent::Template', autosave: true, dependent: :destroy
        delegate_attribute :name, :enumerize, to: :view_template, prefix: 'template', alias: :template, finder: true, scope: true, cast: false

        before_save do
          self.view_template = nil if template.blank?
        end
      end
    end
  end
end
