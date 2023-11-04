class CreateOptionValues < ActiveRecord::Migration[7.0]
  def change
    create_table :option_values do |t|
      t.references :account, null: false, foreign_key: true
      t.references :option_name, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
