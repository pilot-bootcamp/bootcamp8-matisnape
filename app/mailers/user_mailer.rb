class UserMailer < ApplicationMailer
  default from: 'hello@bookparking.dev'

  def welcome_email(user)
    @user = user
    @url  = 'http://bootcamp8-matisnape.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to Bookparking')
  end
end
