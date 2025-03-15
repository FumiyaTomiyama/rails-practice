class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.references :board, null: false, foreign_key: true
      t.string :name
      t.text :comment, null: false

      t.timestamps
    end
  end
end
