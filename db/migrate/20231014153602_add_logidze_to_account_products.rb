class AddLogidzeToAccountProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :account_products, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_account_products, on: :account_products
      end

      dir.down do
        execute <<~SQL
          DROP TRIGGER IF EXISTS "logidze_on_account_products" on "account_products";
        SQL
      end
    end
  end
end
