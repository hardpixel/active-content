class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text   :content
      t.text   :excerpt
      t.string :template

      t.timestamps
    end
  end
end
