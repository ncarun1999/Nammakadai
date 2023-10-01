# frozen_string_literal: true

class Onboarding::WizardController < ApplicationController
  STEPS = %w[Basics Verification].freeze
  TOTAL_STEPS = STEPS.count

  def prepare_step
    @account = current_account
    @steps = (1..TOTAL_STEPS)
    @onboarding_step = @steps.find { |x| x == params[:step].to_i } || current_account&.onboard_step || 1
    @onboarding_step_name = STEPS[@onboarding_step - 1]
    @onboarding_step_key = @onboarding_step_name.parameterize(separator: '_')
  end

  def show
    prepare_step

    prepare_method_name = "prepare_#{@onboarding_step_key}".to_sym
    send(prepare_method_name) if respond_to? prepare_method_name

    render 'show'
  end

  def update; end

  private

  def prepare_verification; end
end
