class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :type
      t.string :name, null: false
      t.text   :description
      t.string :ancestry

      t.timestamps
    end

    add_index :categories, :type
    add_index :categories, :ancestry

    create_table :categorizations do |t|
      t.references :category
      t.references :categorizable, null: false, polymorphic: true, index: false

      t.timestamps
    end

    add_index :categorizations, [:categorizable_id, :categorizable_type, :category_id], unique: true, name: :index_categorizations_on_categorizable_attribute
  end
end
