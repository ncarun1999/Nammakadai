class AccountMailer < ApplicationMailer
  def welcome_email
    mail(to: 'ncarun1999@gmail.com', subject: 'Welcome to Namakadai')
  end
end
