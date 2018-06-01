class ActiveContent::Profile < ActiveRecord::Base
  # Set table name
  self.table_name = 'profiles'

  # Belongs associations
  belongs_to :profileable, polymorphic: true, optional: true

  # Name composed by first and last name
  def name
    if first_name or last_name
      "#{first_name} #{last_name}".strip
    end
  end
end
