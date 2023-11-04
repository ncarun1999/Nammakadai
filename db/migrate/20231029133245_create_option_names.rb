class CreateOptionNames < ActiveRecord::Migration[7.0]
  def change
    create_table :option_names do |t|
      t.references :account, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
