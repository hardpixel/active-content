class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :type
      t.string :title, null: false
      t.text   :content
      t.text   :excerpt
      t.string :ancestry

      t.timestamps
    end

    add_index :contents, :ancestry
  end
end
