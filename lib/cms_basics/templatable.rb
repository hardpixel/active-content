require 'active_delegate'

module Cms
  module Templatable
    extend ActiveSupport::Concern

    included do
      include ActiveDelegate

      # Has associations
      has_one :template, as: :templatable, class_name: 'Template', autosave: true, dependent: :destroy

      # Delegations
      delegate_attributes :name, to: :template, prefix: true

      # Get records that have template (specific or not)
      scope :with_template, -> (names = nil) {
        if names.nil?
          where.not template: nil
        else
          where template: names
        end
      }

      # Get records that don't have template (specific or not)
      scope :without_template, -> (names = nil) {
        if names.nil?
          where template: nil
        else
          where.not template: names
        end
      }
    end

    class_methods do
      # Set available templates as enum
      def set_templates(names=[])
        enum template_name: [:default, *Array(names)], default: 0
      end
    end
  end
end
