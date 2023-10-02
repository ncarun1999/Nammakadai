# frozen_string_literal: true

class Account < ApplicationRecord
  has_logidze

  # validation
  validates :name, presence: true

  # associations
  has_many :users, dependent: :destroy
  has_many :shop_addresses, dependent: :destroy

  accepts_nested_attributes_for :shop_addresses

  # enums
  enum account_type: {
    medical: 0,
    hotel: 1,
    grocery_store: 2,
    wholesale: 3,
    fancy_store: 4,
    others: 99
  }

  # store_accessors
  store_accessor :additional_details, :onboarded_on
  store_accessor :additional_details, :current_onboard_step
  store_accessor :additional_details, :user_agreement_accepted_on

  # methods
  def onboarded?
    !STORE_ACCESSOR_FALSE_VALUE.include?(onboarded_on)
  end

  def default_address
    shop_addresses.where(is_default: true)&.first
  end
end
