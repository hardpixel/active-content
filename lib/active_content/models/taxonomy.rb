class ActiveContent::Taxonomy < ActiveRecord::Base
  # Set table name
  self.table_name = 'taxonomies'

  # Define validations
  validates :name, presence: true

  # Has associations
  has_many :taxonomizations
end
