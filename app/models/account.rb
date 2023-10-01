# frozen_string_literal: true

class Account < ApplicationRecord
  has_logidze

  # associations
  has_many :users

  # store_accessors
  store_accessor :additional_details, :onboarded_on
  store_accessor :additional_details, :onboard_step
  store_accessor :additional_details, :is_user_agreement_accepted

  # methods
  def onboarded?
    !STORE_ACCESSOR_FALSE_VALUE.include?(onboarded_on)
  end
end
