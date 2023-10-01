# frozen_string_literal: true

module ApplicationHelper
  def onboarding_step
    @onboarding_step ||= params[:onboarding_step]&.to_i
  end

  def onboarding_step_key
    Onboarding::WizardController::STEPS[onboarding_step - 1].parameterize(separator: '_')
  end

  def enum_to_values(resource_klass, type)
    resource_klass.send(type)&.map { |k, v| [k.tr('_', ' ').titleize, v] }
  end
end
