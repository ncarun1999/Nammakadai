# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_account

  include FlipperMethods

  helper_method :current_account
  attr_reader :current_account

  def set_current_account
    @current_account ||= current_user.try(:account)
  end

  def authenticate_account!
    return if current_account.present?

    flash[:alert] = 'Please sign-in before continue...'
    redirect_to user_session_path
  end
end
