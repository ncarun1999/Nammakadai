class Product < ApplicationRecord
  # associations
  belongs_to :created_by, polymorphic: true, optional: true

  # validations
  validates :name, presence: true
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # enums
  enum :category, {
    medical: 0,
    hotel: 1,
    grocery_store: 2,
    wholesale: 3,
    fancy_store: 4,
    others: 99
  }
end
