# frozen_string_literal: true

class Onboarding::WizardController < ApplicationController
  before_action :validate_shop_info, only: :update
  STEPS = %w[Basic Address].freeze
  TOTAL_STEPS = STEPS.count

  def prepare_step
    @account ||= Account.find_by(id: session[:account_id])
    @user ||= current_account&.users&.first || User.find_by(id: session[:user_id])

    @steps = (1..TOTAL_STEPS)
    @onboarding_step = @account&.current_onboard_step&.to_i || @steps.find { |x| x == params[:step].to_i } || 1

    @onboarding_step_name = STEPS[@onboarding_step - 1]
    @onboarding_step_key = @onboarding_step_name.parameterize(separator: '_')
  end

  def show
    redirect_to onboarding_step_path(step: 1) and return if params[:step] != '1' && @account.blank?

    prepare_step

    prepare_method_name = "prepare_#{@onboarding_step_key}".to_sym
    send(prepare_method_name) if respond_to? prepare_method_name

    render :show
  end

  def update
    process_shop_info if params[:step] == '1'

    redirect_to onboarding_step_path(params[:step].to_i + 1) if @user&.valid?
  end

  private

  def prepare_verification; end

  def process_shop_info
    process_account
    process_user
  end

  def process_account
    @account = Account.new account_params
    if @account.save
      @account.update(current_onboard_step: 2, user_agreement_accepted_on: Time.now)
      session[:account_id] = @account.id
      @account
    else
      flash[:alert] = @account.errors.full_messages.join(', ')
      redirect_to onboarding_path
    end
  end

  def process_user
    return if @account.nil?

    @user = @account.users.new user_params
    if @user.save
      session[:user_id] = @user.id
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      redirect_to onboarding_path
    end
  end

  def validate_shop_info
    return unless params[:step] == '1'

    user_params = params[:user]
    account_params = params[:account]

    @errors = {}
    @errors['name'] = 'Shop name must exist' if account_params[:name].blank?
    @errors['password'] = 'Password must exist' if user_params[:password].blank?
    @errors['terms'] = 'Please accept term before continue' unless params[:terms] == 'on'

    unless user_params[:password] == user_params[:confirm_password]
      @errors['password_not_eql'] =
        'Password and Confirmation password are not same'
    end

    @errors['email'] = 'Email already taken' if User.find_by(email: params[:user][:email]).present?
    return if @errors.blank?

    flash[:alert] = @errors.values.join(', ')
    redirect_to onboarding_path
  end

  def account_params
    params.require(:account).permit(:name).merge(account_type: params[:account_type].to_i, phone: params[:phone])
  end

  def user_params
    params.require(:user).permit(:email, :password).merge(
      first_name: params[:account][:name], phone: params[:phone]
    )
  end
end
