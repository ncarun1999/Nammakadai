class Account::Product < ApplicationRecord
  has_logidze

  # association
  belongs_to :user
  belongs_to :product

  # monetize
  monetize :price_cents
end
