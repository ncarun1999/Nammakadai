# frozen_string_literal: true

class User < ApplicationRecord
  has_logidze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable

  belongs_to :account

  rolify
end