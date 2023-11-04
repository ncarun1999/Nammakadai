class Option::Name < ApplicationRecord
  # associations
  belongs_to :account
  belongs_to :product
  has_many :option_values, class_name: '::Option::Value', foreign_key: 'option_name_id', dependent: :destroy

  # validations
  # validates :name, presence: true, uniqueness: { scope: :product_id, case_sensitive: false }
  before_validation :set_account_id

  accepts_nested_attributes_for :option_values

  private

  def set_account_id
    self.account_id = product.account_id
  end
end
