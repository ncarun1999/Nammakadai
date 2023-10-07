# frozen_string_literal: true

class User < ApplicationRecord
  has_logidze
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable

  # association
  belongs_to :account

  # validation
  validates :first_name, presence: true

  # callback
  after_update_commit :complete_onboard, if: :saved_change_to_confirmed_at

  # method
  def super_admin?
    has_role?(:super_admin)
  end

  private

  def complete_onboard
    return if account.onboarded_on.present?

    # set onboarded_on
    account.update(onboarded_on: Time.now)
    WelcomeJob.perform_later(account.id)

    # set role
    add_role :admin, account
  end
end
