class CreateAccountVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :account_variants do |t|
      t.references :account, null: false, foreign_key: true
      t.references :account_products, null: false, foreign_key: true
      t.string :title
      t.string :sku
      t.string :barcode
      t.string :alias
      t.text :description
      t.text :short_description
      t.jsonb :images
      t.jsonb :additional_details, default: {}
      t.monetize :price
      t.monetize :cost
      t.boolean :is_active

      t.timestamps
    end
  end
end
