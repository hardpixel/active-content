class Post < ApplicationRecord
  # Add categories support (needs STI model PostCategories < Categories)
  # has_categories :post_categories

  # Add tags support (needs STI model PostTags < Tags)
  # has_tags :post_tags
end
