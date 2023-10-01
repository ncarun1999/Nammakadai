class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :sales_department_email
      t.string :reporting_email
      t.string :logo
      t.string :subdomain
      t.string :phone
      t.string :gst_number
      t.string :shop_id
      t.string :order_prefix
      t.integer :last_ordered_number
      t.text :description
      t.boolean :test_mode
      t.jsonb :additional_details, default: {}
      t.datetime :is_imported
      t.datetime :last_used

      t.timestamps
    end
  end
end
