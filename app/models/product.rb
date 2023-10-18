class Product < ApplicationRecord
  has_logidze

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

  # monetize
  monetize :cost_cents

  # callbacks
  before_create :set_active_for

  private

  def set_active_for
    self.active_for = [created_by.account.account_type]
  end
end

