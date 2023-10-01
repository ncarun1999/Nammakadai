# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  STORE_ACCESSOR_FALSE_VALUE = ['false', '0', '', nil, false].freeze
end
