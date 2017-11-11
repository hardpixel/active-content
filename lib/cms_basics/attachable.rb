module CmsBasics
  module Attachable
    extend ActiveSupport::Concern

    class_methods do
      def has_attachment(name, field, options={})
        assoc_opts = { as: :attachable, class_name: 'Attachment', autosave: true, dependent: :destroy }
        assoc_proc = -> { where field: field }

        multiple = options.delete(:multiple)
        defaults = options.reverse_merge(class_name: name.to_s.classify, source: :upload)

        if multiple
          options = defaults.merge(through: :"#{field}_attachments")

          has_many options[:through], assoc_proc, assoc_opts
          has_many :"#{field}", options
        else
          options = defaults.merge(through: :"#{field}_attachment")

          has_one options[:through], assoc_proc, assoc_opts
          has_one :"#{field}", options

          define_method :"#{field}_id" do
            send(:"#{field}").try :id
          end

          define_method :"#{field}_id=" do |value|
            send :"#{field}=", Upload.find_by_id(value)
          end
        end
      end
    end
  end
end
