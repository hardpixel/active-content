require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module CmsBasics
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc 'Generates migrations to add CMS tables.'
    source_root File.expand_path('../templates', __FILE__)
    class_option :page, type: :boolean, default: true, desc: 'Add page table.'
    class_option :post, type: :boolean, default: true, desc: 'Add post table.'
    class_option :category, type: :boolean, default: true, desc: 'Add category table.'
    class_option :tag, type: :boolean, default: true, desc: 'Add tag table.'
    class_option :template, type: :boolean, default: true, desc: 'Add template table.'

    def create_migration_file
      if options.page?
        template 'model/page.rb', 'app/models/page.rb'
        migration_template 'migration/page.rb', 'db/migrate/create_pages.rb'
      end

      if options.post?
        template 'model/post.rb', 'app/models/post.rb'
        migration_template 'migration/post.rb', 'db/migrate/create_posts.rb'
      end

      if options.category?
        template 'model/category.rb', 'app/models/category.rb'
        migration_template 'migration/category.rb', 'db/migrate/create_categories.rb'
      end

      if options.tag?
        template 'model/tag.rb', 'app/models/tag.rb'
        migration_template 'migration/tag.rb', 'db/migrate/create_tags.rb'
      end

      if options.template?
        migration_template 'migration/template.rb', 'db/migrate/create_templates.rb'
      end
    end

    def self.next_migration_number(dirname)
      ::ActiveRecord::Generators::Base.next_migration_number(dirname)
    end
  end
end
