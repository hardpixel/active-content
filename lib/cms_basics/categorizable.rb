module Cms
  module Categorizable
    extend ActiveSupport::Concern

    included do
      # Has associations
      has_many :categorizations, as: :categorizable
      has_many :categories, through: :categorizations

      # Custom scopes
      scope :categorized,   -> { joins(:categories).distinct }
      scope :with_category, -> ids { categorized.where categories: { id: ids } }
    end

    # Get categories list
    def categories_list
      self.categories
    end

    # Assign categories list
    def categories_list=(names)
      self.categories = Array(names).map do |name|
        Category.find_by_name(name) || Category.new(name: name)
      end
    end
  end
end
