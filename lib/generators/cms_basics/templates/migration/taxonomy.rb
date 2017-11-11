class CreateTaxonomies < ActiveRecord::Migration[5.0]
  def change
    create_table :taxonomies do |t|
      t.string :type
      t.string :name, null: false
      t.text   :description
      t.string :ancestry

      t.timestamps
    end

    add_index :taxonomies, :type
    add_index :taxonomies, :ancestry

    create_table :taxonomizations do |t|
      t.references :taxonomy
      t.references :taxonomizable, null: false, polymorphic: true, index: false

      t.timestamps
    end

    add_index :taxonomizations, [:taxonomizable_id, :taxonomizable_type, :taxonomy_id], unique: true, name: :index_taxonomizations_on_taxonomizable_attribute
  end
end
