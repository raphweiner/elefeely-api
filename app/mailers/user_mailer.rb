class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def reset_password_email
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
