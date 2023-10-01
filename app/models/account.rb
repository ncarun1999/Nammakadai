# frozen_string_literal: true

class Account < ApplicationRecord
  has_logidze

  # associations
  has_many :users

  # store_accessors
  store_accessor :additional_details, :is_onboarded
  store_accessor :additional_details, :last_filled_form
  store_accessor :additional_details, :is_agreement_accepted

  # methods
  def onboarded?
    falsy_values = ['false', '0', '', nil, false]
    !falsy_values.include?(is_onboarded)
  end
end
