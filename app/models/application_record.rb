# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  STORE_ACCESSOR_FALSE_VALUE = ['false', '0', '', nil, false].freeze

  def self.ransackable_attributes(auth_object = nil)
    super
  end

  def self.ransackable_associations(auth_object = nil)
    super
  end
end
