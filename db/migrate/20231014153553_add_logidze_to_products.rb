class AddLogidzeToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_products, on: :products
      end

      dir.down do
        execute <<~SQL
          DROP TRIGGER IF EXISTS "logidze_on_products" on "products";
        SQL
      end
    end
  end
end
