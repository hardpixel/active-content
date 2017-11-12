module CmsBasics
  module Profileable
    extend ActiveSupport::Concern

    class_methods do
      def has_profile
        include ActiveDelegate

        has_one :profile, as: :profileable, autosave: true, dependent: :destroy
        delegate_attributes to: :profile, allow_nil: true

        define_method :name do
          "#{first_name} #{last_name}".strip
        end

        define_method :gravatar do |size=48, default='mm'|
          hash = Digest::MD5::hexdigest(try(:email))
          "https://www.gravatar.com/avatar/#{hash}?rating=PG&size=#{size}&default=#{default}"
        end
      end
    end
  end
end
