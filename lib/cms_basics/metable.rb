module CmsBasics
  module Metable
    extend ActiveSupport::Concern

    class_methods do
      def has_meta(field, cast_type, options={})
        include ActiveDelegate

        assoc_opts = { as: :metable, class_name: 'Metum', autosave: true, dependent: :destroy }
        assoc_proc = -> { where field: field }
        value_opts = { to: :"#{field}_metum", prefix: field, alias: field, default: options[:default] }

        has_one :"#{field}_metum", assoc_proc, assoc_opts
        delegate_attribute :value, cast_type, value_opts
      end
    end
  end
end
