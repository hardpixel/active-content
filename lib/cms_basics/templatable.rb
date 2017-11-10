module CmsBasics
  module Templatable
    extend ActiveSupport::Concern

    class_methods do
      def has_templates(*names)
        extend Enumerize
        include ActiveDelegate

        enumerize :template, in: names, predicates: { prefix: true }

        has_one :view_template, as: :templatable, class_name: 'Template', autosave: true, dependent: :destroy
        delegate_attributes :template, to: :view_template

        _define_view_templates_callbacks
        _define_view_templates_scopes
      end

      private

        def _define_view_templates_callbacks
          before_save do
            self.view_template = nil if template.nil?
          end
        end

        def _define_view_templates_scopes
          query = self.includes(:view_template)
          blank = { templates: { template: nil } }

          scope :with_template, -> (*names) do
            named = { templates: { template: names } }
            names.empty? ? query.where.not(blank) : query.where(named)
          end

          scope :without_template, -> (*names) do
            named = { templates: { template: names } }
            names.empty? ? query.where(blank) : query.where(blank).or(query.where.not(named))
          end
        end
    end
  end
end
