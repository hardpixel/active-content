class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.string :file, null: false
      t.string :name, null: false
      t.text   :description
      t.string :media_type
      t.string :sub_type

      t.timestamps
    end

    create_table :attachments do |t|
      t.string     :name
      t.references :medium
      t.references :attachable, null: false, polymorphic: true, index: false

      t.timestamps
    end

    add_index :attachments, [:attachable_id, :attachable_type, :medium_id, :name], unique: true, name: :index_attachments_on_attachable_attribute
  end
end
