module ActiveContent
  module Profileable
    extend ActiveSupport::Concern

    class_methods do
      def has_profile(options={})
        include ActiveDelegate

        assoc_class    = options.delete(:class_name) || ActiveContent.config.profile_class_name
        image_uploader = options.delete(:uploader) || ActiveContent.config.profile_image_uploader

        has_one :profile, as: :profileable, class_name: assoc_class, autosave: true, dependent: :destroy
        delegate_attributes options.except(:to).merge(to: :profile, allow_nil: true, localized: ActiveContent.config.profile_locale_accessors)

        ActiveContent::Profile.add_image_uploader name, image_uploader

        before_save do
          prof_foreign = self.class.profiles_attribute_names.map(&:to_s)
          prof_current = prof_foreign.map { |n| send(n) }
          prof_default = self.class.column_defaults.select { |n, _d| prof_foreign.include?(n) }.values
          prof_changes = (prof_current - prof_default).reject(&:blank?)

          if prof_changes.empty?
            self.profile = nil
          end
        end

        define_method :gravatar do |size=48, default='mm'|
          mail = try(:email)
          hash = Digest::MD5::hexdigest(mail) unless mail.nil?

          "https://www.gravatar.com/avatar/#{hash}?rating=PG&size=#{size}&default=#{default}"
        end
      end
    end
  end
end
