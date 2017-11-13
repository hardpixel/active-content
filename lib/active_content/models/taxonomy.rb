class ActiveContent::Taxonomy < ApplicationRecord
  # Set table name
  self.table_name = 'taxonomies'

  # Define validations
  validates :name, presence: true
end
