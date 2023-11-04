class Option::Value < ApplicationRecord
  # associations
  belongs_to :account
  belongs_to :option_name, class_name: '::Option::Name', foreign_key: :option_name_id

  # validation
  # validates :name, presence: true, uniqueness: { scope: :option_name_id, case_sensitive: false }
  before_validation :set_account_id

  private

  def set_account_id
    self.account_id = Account.first.id
  end
end
