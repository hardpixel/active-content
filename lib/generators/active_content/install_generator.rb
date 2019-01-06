require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module ActiveContent
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    MODEL_NAMES  = ['content', 'taxonomy', 'upload', 'template', 'relation', 'metum', 'profile'].freeze

    desc 'Generates migrations to add CMS tables.'
    source_root File.expand_path('../templates', __FILE__)
    argument :models, type: :array, default: MODEL_NAMES, enum: MODEL_NAMES, desc: 'Add CMS models tables.'

    def create_migration_file
      models.each do |model|
        migration_template "#{model}.rb", "db/migrate/create_#{model.pluralize}.rb"
      end
    end

    def self.next_migration_number(dirname)
      ::ActiveRecord::Generators::Base.next_migration_number(dirname)
    end
  end
end
