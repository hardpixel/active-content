class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text   :content
      t.text   :excerpt
      t.string :ancestry

      t.timestamps
    end

    add_index :pages, :ancestry
  end
end
