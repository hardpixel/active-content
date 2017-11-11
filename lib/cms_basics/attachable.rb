module CmsBasics
  module Attachable
    extend ActiveSupport::Concern

    class_methods do
      def has_attachment(name, field, options={})
        assoc_opts = { as: :attachable, class_name: 'Attachment', autosave: true, dependent: :destroy }
        assoc_proc = -> { where field: field }

        multiple = options.delete(:multiple)
        options  = options.reverse_merge(class_name: name.to_s.classify)
        options  = options.merge(through: :"#{field}_attachments", source: :upload)

        if multiple
          has_many :"#{field}_attachments", assoc_proc, assoc_opts
          has_many :"#{field}", options
        else
          has_one :"#{field}_attachment", assoc_proc, assoc_opts
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
