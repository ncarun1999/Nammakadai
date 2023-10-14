class AdminMailer < ApplicationMailer
  def welcome_email(account)
    @account = account
    mail(to: ENV.fetch('ADMIN_EMAIL', 'ncarun1999@gmail.com'), subject: 'New user created')
  end
end