class WelcomeJob
  include Sidekiq::Job
  sidekiq_options queue: 'default'

  def perform(account_id)
    account = Account.find(account_id)
    user = account.users.first
    WelcomeMailer.welcome_email(user.email).deliver_now
    AdminMailer.welcome_email(account).deliver_now
  end
end
