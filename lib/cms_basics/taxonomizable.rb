module CmsBasics
  module Taxonomizable
    extend ActiveSupport::Concern

    class_methods do
      def has_taxonomy(name, options={})
        options = options.reverse_merge(class_name: name.to_s.classify)
        options = options.merge(through: :taxonomizations, source: :taxonomy)

        has_many :taxonomizations, as: :taxonomizable
        has_many name, options

        scope :taxonomized,   -> { joins(name).distinct }
        scope :with_taxonomy, -> ids { taxonomized.where name => { id: ids } }

        _define_taxonomy_list_methods(name)
      end

      private

        def _define_taxonomy_list_methods(name)
          define_method :"#{name}_list" do
            self.send name
          end

          define_method :"#{name}_list=" do |names|
            model = name.to_s.classify.constantize
            names = Array(names).map do |n|
              model.find_by_name(n) || model.new(name: n)
            end

            self.send :"#{name}=", names
          end
        end
    end
  end
end
