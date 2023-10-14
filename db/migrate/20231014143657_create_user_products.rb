class CreateUserProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :created_by, polymorphic: true
      t.decimal :price
      t.boolean :is_active

      t.timestamps
    end
  end
end
