module ActiveContent
  module Relatable
    extend ActiveSupport::Concern

    class_methods do
      def has_related(name, field, options={})
        assoc_type = "#{name}".classify.constantize.base_class.to_s
        assoc_opts = { as: :relatable, class_name: ActiveContent.config.relation_class_name, autosave: true, dependent: :destroy }
        assoc_proc = -> { where field: field }

        default  = options.delete(:default)
        multiple = options.delete(:multiple)
        options  = options.reverse_merge(class_name: "#{name}".classify, source: :item, source_type: assoc_type)

        if multiple
          options = options.merge(through: :"#{field}_relations")

          has_many options[:through], assoc_proc, assoc_opts
          has_many :"#{field}", options
        else
          options = options.merge(through: :"#{field}_relation")

          has_one options[:through], assoc_proc, assoc_opts
          has_one :"#{field}", options

          define_method :"#{field}_id" do
            send(:"#{field}").try :id
          end

          define_method :"#{field}_id=" do |value|
            send :"#{field}=", "#{name}".classify.constantize.find_by_id(value)
          end
        end

        if default
          relation_method  = :"_relation_#{field}_default"
          relation_default = default

          define_singleton_method relation_method do
            relation_default
          end

          after_initialize do |record|
            if record.try(:"#{field}").blank?
              record.send(:"#{field}=", self.class.try(relation_method))
            end
          end
        end
      end
    end
  end
end
