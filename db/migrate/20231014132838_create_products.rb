class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.text :short_description
      t.jsonb :image, default: []
      t.jsonb :additional_details, default: {}
      t.jsonb :active_for, default: []
      t.boolean :is_active
      t.monetize :cost
      t.integer :category
      t.references :created_by, polymorphic: true

      t.timestamps
    end
  end
end
