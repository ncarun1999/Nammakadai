class CreateVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :variants do |t|
      t.references :account, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :title
      t.string :sku
      t.string :barcode
      t.string :alias
      t.text :description
      t.text :short_description
      t.jsonb :additional_details, default: {}
      t.jsonb :option, default: {}
      t.integer :position
      t.monetize :price
      t.monetize :cost
      t.monetize :compare_at_price
      t.boolean :is_active

      t.timestamps
    end
  end
end
