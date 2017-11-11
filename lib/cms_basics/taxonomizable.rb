module CmsBasics
  module Taxonomizable
    extend ActiveSupport::Concern

    class_methods do
      def has_taxonomy(name, options={})
        options = options.reverse_merge(class_name: name.to_s.classify, source: :taxonomy)
        options = options.merge(through: :"#{name}_taxonomizations")
        setting = { as: :taxonomizable, class_name: 'Taxonomization', autosave: true, dependent: :destroy }

        has_many options[:through], setting
        has_many name, options

        _define_taxonomy_list_methods(name, options)
      end

      private

        def _define_taxonomy_list_methods(name, options)
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
        end
    end
  end
end
