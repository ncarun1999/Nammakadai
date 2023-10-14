class CreateAccountProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :account_products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :created_by, polymorphic: true
      t.monetize :price
      t.string :alias

      t.timestamps
    end
  end
end
