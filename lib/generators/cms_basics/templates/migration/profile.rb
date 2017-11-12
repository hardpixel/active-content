class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string     :first_name
      t.string     :last_name
      t.text       :bio
      t.string     :website
      t.string     :phone
      t.string     :mobile
      t.string     :fax
      t.string     :address
      t.string     :city
      t.string     :province
      t.string     :country
      t.string     :postal_code
      t.string     :image
      t.references :profileable, polymorphic: true, index: false

      t.timestamps
    end

    add_index :profiles, [:profileable_type, :profileable_id], unique: true, name: :index_profiles_on_profilable_attribute
  end
end
