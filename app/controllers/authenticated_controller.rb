# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_account!
  before_action :authenticate_user!
end
