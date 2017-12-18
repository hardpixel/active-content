module ActiveContent
  module Templatable
    extend ActiveSupport::Concern

    class_methods do
      def has_templates(*args)
        extend Enumerize
        include ActiveDelegate

        options   = args.extract_options!
        templates = args
        default   = options.fetch :default, templates.first

        enumerize :template, in: templates, predicates: { prefix: true }, default: default

        has_one :view_template, as: :templatable, class_name: 'ActiveContent::Template', autosave: true, dependent: :destroy
        delegate_attribute :name, :string, to: :view_template, prefix: 'template', alias: :template, finder: true, scope: true
      end
    end
  end
end
