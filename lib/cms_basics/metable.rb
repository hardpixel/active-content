module CmsBasics
  module Metable
    extend ActiveSupport::Concern

    class_methods do
      def has_meta(field, cast_type, options={})
        include ActiveDelegate

        assoc_opts = { as: :metable, class_name: 'Metum', autosave: true, dependent: :destroy }
        assoc_proc = -> { where field: field }

        has_one :"#{field}_metum", assoc_proc, assoc_opts
        delegate_attributes only: [:value], to: :"#{field}_metum", prefix: field

        attribute :"#{field}", cast_type, default: options[:default]
        alias_attribute :"#{field}", :"#{field}_value"
      end
    end
  end
end
