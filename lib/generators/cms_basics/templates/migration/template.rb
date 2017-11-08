class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string     :template, null: false
      t.references :templatable, null: false, polymorphic: true, index: false

      t.timestamps
    end

    add_index :templates, [:templatable_id, :templatable_type, :template], unique: true, name: :index_templates_on_templatable_attribute
  end
end
