require 'active_delegate'

module Cms
  module Templatable
    extend ActiveSupport::Concern

    included do
      include ActiveDelegate
      extend Enumerize

      # Has associations
      has_one :view_template, as: :templatable, class_name: 'Template', autosave: true, dependent: :destroy

      # Delegate attributes
      delegate_attributes :template, to: :view_template

      # Get records that have template (specific or not)
      scope :with_template, -> (*names) do
        query = self.includes(:view_template)
        named = { templates: { template: names } }
        blank = { templates: { template: nil } }

        if names.empty?
          query.where.not blank
        else
          query.where named
        end
      end

      # Get records that don't have template (specific or not)
      scope :without_template, -> (*names) do
        query = self.includes(:view_template)
        named = { templates: { template: names } }
        blank = { templates: { template: nil } }

        if names.empty?
          query.where blank
        else
          query.where(blank).or(query.where.not(named))
        end
      end

      # Allow saving without template
      before_save { self.view_template = nil if template.nil? }
    end

    class_methods do
      # Set available templates as enumerized attribute
      def templates(*args)
        args.extract_options!
        enumerize :template, in: Array(args).flatten, predicates: { prefix: true }
      end
    end
  end
end
