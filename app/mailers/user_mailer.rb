class UserMailer < ApplicationMailer
  default from: 'hello@bookparking.dev'

  def welcome_email(account)
    @account = account
    mail(to: @account.email, subject: 'Welcome to Bookparking')
  end
end
