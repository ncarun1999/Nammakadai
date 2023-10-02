class ShopAddress < ApplicationRecord
  belongs_to :account
  belongs_to :user, optional: true
end
