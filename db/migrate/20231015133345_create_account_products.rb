class CreateAccountProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :account_products do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name
      t.string :alias
      t.string :sku
      t.string :barcode
      t.boolean :track_quantity
      t.text :description
      t.text :short_description
      t.text :product_type
      t.integer :status
      t.integer :published_scope
      t.jsonb :tags
      t.jsonb :additional_details, default: {}
      t.monetize :cost
      t.monetize :price
      t.references :created_by, polymorphic: true

      t.timestamps
    end
  end
end
