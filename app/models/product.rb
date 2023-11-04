class Product < ApplicationRecord
  has_logidze

  # associations
  belongs_to :account
  belongs_to :created_by, polymorphic: true, optional: true

  has_many :variants, dependent: :destroy
  has_many :option_names, class_name: 'Option::Name', dependent: :destroy
  has_many :option_values, through: :option_names

  # nested attributes
  accepts_nested_attributes_for :option_names
  accepts_nested_attributes_for :variants

  # attribute accessor
  attr_accessor :remove_images
  attr_accessor :value

  # attachments
  has_many_attached :images

  # validations
  validates :name, presence: true
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # monetize
  monetize :cost_cents
  monetize :price_cents

  # enums
  enum status: {
    active: 0,
    archived: 1,
    inactive: 2,
    draft: 3
  }
end

