module CmsBasics
  module Templatable
    extend ActiveSupport::Concern

    class_methods do
      def has_templates(*templates)
        extend Enumerize
        include ActiveDelegate

        enumerize :template, in: templates, predicates: { prefix: true }

        has_one :view_template, as: :templatable, class_name: 'Template', autosave: true, dependent: :destroy
        delegate_attribute :name, :string, to: :view_template, prefix: 'template', alias: :template

        before_save do
          self.view_template = nil if template.blank?
        end

        query = self.includes(:view_template)
        blank = { templates: { name: nil } }

        scope :with_template, -> (*names) do
          named = { templates: { name: names } }
          names.empty? ? query.where.not(blank) : query.where(named)
        end

        scope :without_template, -> (*names) do
          named = { templates: { name: names } }
          names.empty? ? query.where(blank) : query.where(blank).or(query.where.not(named))
        end
      end
    end
  end
end
