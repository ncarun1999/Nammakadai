class UserProduct < ApplicationRecord

  # associations
  belongs_to :user
  belongs_to :product
  belongs_to :created_by, polymorphic: true, optional: true
end
