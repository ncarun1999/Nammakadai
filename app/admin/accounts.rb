# frozen_string_literal: true

ActiveAdmin.register Account do
  permit_params(
    :name, :sales_department_email, :reporting_email, :logo, :subdomain,
    :phone, :gst_number, :shop_id, :order_prefix, :account_type, :last_ordered_number,
    :description, :test_mode, :additional_details, :is_imported, :last_used
  )

  filter :name

  index do
    column :id
    column :name
    column :sales_department_email
    column :reporting_email
    column :users do |account|
      account.users.map(&:email).join(', ')
    end
    column :logo
    column :subdomain
    column :phone
    column :gst_number
    column :shop_id
    column :order_prefix
    column :account_type
    column :last_ordered_number
    column :description
    column :test_mode
    column :additional_details
    column :is_imported
    column :last_used
    column :created_at

    actions do |account|
      link_to 'Login As', root_path
    end
  end
end
