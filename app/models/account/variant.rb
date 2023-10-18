class Account::Variant < ApplicationRecord
  belongs_to :account
  belongs_to :product

  # monetize
  monetize :cost_cents
  monetize :price_cents
end
