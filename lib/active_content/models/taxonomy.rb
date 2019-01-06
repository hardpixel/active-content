class ActiveContent::Taxonomy < ActiveRecord::Base
  self.table_name = 'taxonomies'

  validates :name, presence: true

  has_many :taxonomizations
end
