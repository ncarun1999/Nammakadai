class CreateIntegrationWhatsapps < ActiveRecord::Migration[7.0]
  def change
    create_table :integration_whatsapps do |t|
      t.references :account, null: false, foreign_key: true
      t.string :business_id
      t.string :access_token
      t.string :api_key
      t.string :phone_number_id

      t.timestamps
    end
  end
end
