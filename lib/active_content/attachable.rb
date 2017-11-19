module ActiveContent
  module Attachable
    extend ActiveSupport::Concern

    class_methods do
      def has_attachment(name, field, options={})
        assoc_opts = { as: :attachable, class_name: 'ActiveContent::Attachment', autosave: true, dependent: :destroy }
        assoc_proc = -> { where field: field }

        multiple = options.delete(:multiple)
        defaults = options.reverse_merge(class_name: "#{name}".classify, source: :upload)

        if multiple
          options = defaults.merge(through: :"#{field}_attachments")

          has_many options[:through], assoc_proc, assoc_opts
          has_many :"#{field}", options

          define_method :"#{field}_urls" do |size=nil|
            iv_name = "@#{field}_#{size}_urls"

            instance_variable_get(iv_name) ||
            instance_variable_set(iv_name, send(:"#{field}").map { |i| i.try(:file_url, size) })
          end
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

          define_method :"#{field}_url" do |size=nil|
            iv_name = "@#{field}_#{size}_url"

            instance_variable_get(iv_name) ||
            instance_variable_set(iv_name, send(:"#{field}").try(:file_url, size))
          end
        end
      end
    end
  end
end
