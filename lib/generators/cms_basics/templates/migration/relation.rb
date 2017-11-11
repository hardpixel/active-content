class CreateRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :relations do |t|
      t.string     :field, null: false
      t.references :item, null: false, polymorphic: true, index: false
      t.references :relatable, null: false, polymorphic: true, index: false

      t.timestamps
    end

    add_index :relations, [:relatable_id, :relatable_type, :item_id, :item_type, :field], unique: true, name: :index_relations_on_relatable_attribute
  end
end
