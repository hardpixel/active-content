module ActiveContent
  module Profileable
    extend ActiveSupport::Concern

    class_methods do
      def has_profile
        include ActiveDelegate

        has_one :profile, as: :profileable, class_name: 'ActiveContent::Profile', autosave: true, dependent: :destroy
        delegate_attributes to: :profile, allow_nil: true

        before_save do
          prof_foreign = self.class.profiles_attribute_names.map(&:to_s)
          prof_current = prof_foreign.map { |n| send(n) }
          prof_default = self.class.column_defaults.select { |n, _d| prof_foreign.include?(n) }.values
          prof_changes = (prof_current - prof_default).reject(&:blank?)

          if prof_changes.empty?
            self.profile = nil
          end
        end

        define_method :name do
          if first_name or last_name
            "#{first_name} #{last_name}".strip
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
