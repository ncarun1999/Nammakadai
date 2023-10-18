class Account::Product < ApplicationRecord
  # associations
  belongs_to :account
  belongs_to :created_by, polymorphic: true, optional: true

  has_many :variants, class_name: 'Account::Variant', foreign_key: :account_products_id, dependent: :destroy

  # validations
  validates :name, presence: true
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # monetize
  monetize :cost_cents
  monetize :price_cents

  accepts_nested_attributes_for :variants
end
