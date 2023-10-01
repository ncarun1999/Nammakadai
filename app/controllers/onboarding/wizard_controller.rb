# frozen_string_literal: true

module Onboarding
  class WizardController < AuthenticatedController
    STEPS = %w[Basics Verification].freeze
    TOTAL_STEPS = STEPS.count

    def prepare_step
      @account = current_account
    end
  end
end
