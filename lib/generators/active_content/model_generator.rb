require 'rails/generators'

module ActiveContent
  class ModelGenerator < Rails::Generators::Base

    desc 'Generates a new ActiveContent class in models folder.'
    source_root File.expand_path('../templates', __FILE__)

    argument :type, type: :string, required: true
    argument :name, type: :string, required: true

    def create_migration_file
      template 'model.rb', "app/models/#{model_file}.rb"
    end

    private

    def model_class
      name.camelize
    end

    def type_class
      type.camelize
    end

    def model_file
      "#{name.downcase.underscore}"
    end

    def model_meta
      args.map do |arg|
        field, cast_type, default = arg.split(':')

        items  = [":#{field.to_sym}", ":#{cast_type.to_sym}"]
        items << ["default: #{value_type_cast(cast_type.to_sym, default)}"] if default.present?

        items.join(', ')
      end
    end

    def value_type_cast(cast_type, value)
      strings = [:string, :date, :datetime, :time]
      cast_type.in?(strings) ? "'#{value}'" : value
    end
  end
end
