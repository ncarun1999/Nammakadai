# frozen_string_literal: true

class Account < ApplicationRecord
  has_logidze

  # associations
  has_many :users

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
end
