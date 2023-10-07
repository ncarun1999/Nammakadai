# NOTE: See lib/populator/flipper_populator.rb
module FlipperMethods
  extend ActiveSupport::Concern

  included do
    helper_method :feature_enabled?
    helper_method :feature_disabled?
  end

  private

  def feature_enabled?(feature)
    Features.flipper[feature].enabled?(current_account) || Features.flipper[feature].enabled?(current_user)
  end

  def feature_disabled?(feature)
    !(Features.flipper[feature].enabled?(current_account) || Features.flipper[feature].enabled?(current_user))
  end
end
