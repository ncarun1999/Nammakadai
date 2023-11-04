class Variant < ApplicationRecord
  # associations
  belongs_to :account
  belongs_to :product

  # attachments
  has_many_attached :images

  # monetize
  monetize :cost_cents
  monetize :price_cents
end
