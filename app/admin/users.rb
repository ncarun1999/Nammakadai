# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params(
    :account_id, :first_name, :last_name, :phone, :additional_details,
    :invitation_token, :invitation_created_at, :invitation_sent_at, :invitation_accepted_at,
    :invitation_limit, :invited_by_id, :invited_by_type, :invitations_count, :force_sign_in_at,
    :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at,
    :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip,
    :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts,
    :unlock_token, :locked_at, :log_data
  )

  filter :account
  filter :first_name
  filter :last_name
  filter :email
  filter :current_sign_in_at
  filter :last_sign_in_at
  filter :created_at

  index do
    column :id
    column :first_name
    column :last_name
    column :phone
    column :email
    column :account do |user|
      account = Account.find(user.account_id)
      link_to account.name, admin_account_path(id: account)
    end
    column :created_at
    column :sign_in_count
    column :current_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_at
    column :last_sign_in_ip

    actions
  end

  show do
    panel 'User Details' do
      attributes_table_for(user) do
        row :id
        row :email
        row :first_name
        row :last_name
        row :account
        row :roles do |user|
          user.roles.map(&:name).join(', ')
        end
        row :created_at
        row :updated_at
      end
    end

    panel 'Sign in Details' do
      attributes_table_for(user) do
        row :id
        row :reset_password_token
        row :reset_password_sent
        row :remember_created_at
        row :sign_in_count
        row :signed_in_at
        row :last_signed_in_at
        row :current_sign_in_ip
        row :last_sign_in_ip
      end
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)

    f.inputs 'Details' do
      f.input :account
      f.input :first_name
      f.input :last_name
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end

    f.inputs 'Roles' do
      f.input :roles
    end
    f.actions
  end
end
