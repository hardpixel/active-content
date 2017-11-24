module ActiveContent
  module Taxonomizable
    extend ActiveSupport::Concern

    class_methods do
      def has_taxonomy(name, options={})
        options = options.reverse_merge(class_name: "#{name}".classify, source: :taxonomy)
        options = options.merge(through: :"#{name}_taxonomizations")
        setting = { as: :taxonomizable, class_name: 'ActiveContent::Taxonomization', autosave: true, dependent: :destroy }

        has_many options[:through], setting
        has_many name, options

        define_method :"#{name}_list" do
          self.send name
        end

        define_method :"#{name}_list=" do |names|
          model = options[:class_name].classify.constantize
          names = Array(names).map do |n|
            model.find_by_name(n) || model.new(name: n)
          end

          self.send :"#{name}=", names
        end

        scope :"with_#{name}", -> (*ids) do
          joins(name).where(taxonomies: { id: ids })
        end

        scope :"without_#{name}", -> (*ids) do
          joins(name).where.not(taxonomies: { id: ids })
        end
      end

      def has_taxonomized(name, options={})
        assoc_name = "#{name}".pluralize
        assoc_type = (options[:class_name] || "#{name}".classify).constantize.base_class.name

        has_many :"#{assoc_name}", through: :taxonomizations, source: :taxonomizable, source_type: "#{assoc_type}"
      end
    end
  end
end
