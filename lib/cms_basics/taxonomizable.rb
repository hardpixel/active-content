module CmsBasics
  module Taxonomizable
    extend ActiveSupport::Concern

    class_methods do
      def has_categories(name, options={})
        options = options.reverse_merge(class_name: name.to_s.classify)
        options = options.merge(through: :categorizations, source: :category)

        has_many :categorizations, as: :categorizable
        has_many name, options

        scope :categorized,   -> { joins(name).distinct }
        scope :with_category, -> ids { categorized.where name => { id: ids } }

        _define_taxonomy_list_methods(name)
      end

      def has_tags(name, options={})
        options = options.reverse_merge(class_name: name.to_s.classify)
        options = options.merge(through: :taggings, source: :tag)

        has_many :taggings, as: :taggable
        has_many name, options

        scope :tagged,   -> { joins(name).distinct }
        scope :with_tag, -> ids { tagged.where name => { id: ids } }

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
