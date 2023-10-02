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

  private

  def complete_onboard
    account.update(onboarded_on: Time.now) if account.onboarded_on.nil?
  end
end
