require 'active_delegate'

module Cms
  module Templatable
    extend ActiveSupport::Concern

    included do
      include ActiveDelegate
      extend Enumerize

      # Has associations
      has_one :view_template, as: :templatable, class_name: 'Template', autosave: true, dependent: :destroy

      # Delegations
      delegate_attributes :template, to: :view_template

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
      # Set available templates as enumerized attribute
      def templates(names=[])
        enumerize :template, in: Array(names)
      end
    end
  end
end
