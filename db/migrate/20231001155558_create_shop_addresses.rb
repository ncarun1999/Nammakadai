class CreateShopAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shop_addresses do |t|
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :is_default
      t.string :postal_code
      t.references :account, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
