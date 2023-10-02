# frozen_string_literal: true

class Onboarding::WizardController < ApplicationController
  before_action :set_account
  before_action :require_completed_account_setup!
  before_action :require_incompleted_account_setup!
  before_action :validate_user_agreement, only: :update

  STEPS = %w[Basic User Complete].freeze
  TOTAL_STEPS = STEPS.count

  def prepare_step
    @steps = (1..TOTAL_STEPS)
    @onboarding_step = @account&.current_onboard_step&.to_i || @steps.find { |x| x == params[:step].to_i } || 1

    @onboarding_step_name = STEPS[@onboarding_step - 1]
    @onboarding_step_key = @onboarding_step_name.parameterize(separator: '_')
  end

  def show
    prepare_step

    prepare_method_name = "prepare_#{@onboarding_step_key}".to_sym
    send(prepare_method_name) # if respond_to? prepare_method_name
    render :show
  end

  def update
    case params[:step]
    when '1'
      process_account
    when '2'
      process_user
    end

    redirect_to onboarding_path(step: params[:step].to_i + 1) if flash[:alert].nil?
  end

  private

  def prepare_basic
    @account ||= Account.new
    @account.shop_addresses.build
  end

  def prepare_user
    @user = @account.users.build
  end

  def prepare_complete
    @user = @account.users.find_by(id: session[:user_id])
  end

  def process_account
    @account = Account.new account_params
    if @account.save
      @account.update(current_onboard_step: 2, user_agreement_accepted_on: Time.now)
      session[:account_id] = @account.id
    else
      flash[:alert] = @account.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  def process_user
    @user = @account.users.new user_params
    if @user.save
      @account.update(current_onboard_step: 3)
      session[:user_id] = @user.id
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  def require_completed_account_setup!
    return unless params[:step] != '1' && @account.blank?

    redirect_to onboarding_path(step: 1)
  end

  def require_incompleted_account_setup!
    redirect_to root_path if current_account.present? && current_account.onboarded?
  end

  def validate_user_agreement
    return unless params[:step] == '1' && !params[:terms] == 'on'

    flash[:alert] = 'Please accept user agreement before continue.'
    redirect_to onboarding_path
  end

  def set_account
    @account ||= Account.find_by(id: session[:account_id])
  end

  def account_params
    params.require(:account).permit(
      :name, :account_type, :phone, shop_addresses_attributes: %i[street_1 street_2 city postal_code state is_default]
    )
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password)
  end
end
