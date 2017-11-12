class CreateMeta < ActiveRecord::Migration[5.0]
  def change
    create_table :meta do |t|
      t.string     :field, null: false
      t.text       :value, null: false
      t.references :metable, null: false, polymorphic: true, index: false

      t.timestamps
    end

    add_index :meta, [:metable_id, :metable_type, :field, :value], unique: true, name: :index_meta_on_metable_attribute
  end
end
