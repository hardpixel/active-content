class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.text   :description

      t.timestamps
    end

    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, null: false, polymorphic: true, index: false

      t.timestamps
    end

    add_index :taggings, [:taggable_id, :taggable_type, :tag_id], unique: true, name: :index_taggings_on_taggable_attribute
  end
end
