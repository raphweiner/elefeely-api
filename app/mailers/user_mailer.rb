class UserMailer < ActionMailer::Base
  default from: "elefeely@gmail.com"

  def welcome_email(user)
    @user = user
    mail to: user.email, subject: "Welcome to Elefeely"
  end

  def reset_password_email(user)
    @user = user
    @greeting = "Hi"

    mail to: user.email, subject: 'Elefeely Password Reset'
  end
end
