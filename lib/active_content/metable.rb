module ActiveContent
  module Metable
    extend ActiveSupport::Concern

    class_methods do
      def has_meta(field, cast_type, options={})
        include ActiveDelegate

        assoc_opts = { as: :metable, class_name: 'ActiveContent::Metum', autosave: true, dependent: :destroy }
        assoc_proc = -> { where field: field }
        value_opts = options.merge(to: :"#{field}_metum", prefix: field, alias: field, cast: true)

        has_one :"#{field}_metum", assoc_proc, assoc_opts
        delegate_attribute :value, cast_type, value_opts

        before_save do
          send(:"#{field}_metum=", nil) if send(field).blank?
        end
      end
    end
  end
end
