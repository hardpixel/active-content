module CmsBasics
  module Relatable
    extend ActiveSupport::Concern

    class_methods do
      def has_related(name, field, options={})
        assoc_type = "#{name}".classify.constantize.base_class.to_s
        assoc_opts = { as: :relatable, class_name: 'Cms::Relation', autosave: true, dependent: :destroy }
        assoc_proc = -> { where field: field }

        multiple = options.delete(:multiple)
        defaults = options.reverse_merge(class_name: "#{name}".classify, source: :item, source_type: assoc_type)

        if multiple
          options = defaults.merge(through: :"#{field}_relations")

          has_many options[:through], assoc_proc, assoc_opts
          has_many :"#{field}", options
        else
          options = defaults.merge(through: :"#{field}_relation")

          has_one options[:through], assoc_proc, assoc_opts
          has_one :"#{field}", options

          define_method :"#{field}_id" do
            send(:"#{field}").try :id
          end

          define_method :"#{field}_id=" do |value|
            send :"#{field}=", "#{name}".classify.constantize.find_by_id(value)
          end
        end
      end
    end
  end
end
