module CmsBasics
  module Attachable
    extend ActiveSupport::Concern

    class_methods do
      def has_attachment(name, options={})
        assoc_opts = { as: :attachable, class_name: 'Attachment', autosave: true, dependent: :destroy }
        assoc_proc = -> { where name: name }

        multiple = options.delete(:multiple)
        options  = options.reverse_merge(through: :"#{name}_attachments", source: :upload)

        if multiple
          has_many :"#{name}_attachments", assoc_proc, assoc_opts
          has_many :"#{name}", options
        else
          has_one :"#{name}_attachment", assoc_proc, assoc_opts
          has_one :"#{name}", options

          define_method :"#{name}_id" do
            send(:"#{name}").try :id
          end

          define_method :"#{name}_id=" do |value|
            send :"#{name}=", Upload.find_by_id(value)
          end
        end
      end
    end
  end
end
