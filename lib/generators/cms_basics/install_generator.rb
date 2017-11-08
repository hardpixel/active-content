require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module CmsBasics
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    # Model names
    MODEL_NAMES  = ['page', 'post', 'category', 'tag', 'medium', 'template'].freeze
    MIGRATE_ONLY = ['template'].freeze

    desc 'Generates migrations to add CMS tables.'
    source_root File.expand_path('../templates', __FILE__)
    argument :models, type: :array, default: MODEL_NAMES, enum: MODEL_NAMES, desc: 'Add CMS models tables.'

    def create_migration_file
      models.each do |model|
        template "model/#{model}.rb", "app/models/#{model}.rb" unless model.in? MIGRATE_ONLY
        migration_template "migration/#{model}.rb", "db/migrate/create_#{model.pluralize}.rb"
      end
    end

    def self.next_migration_number(dirname)
      ::ActiveRecord::Generators::Base.next_migration_number(dirname)
    end
  end
end
