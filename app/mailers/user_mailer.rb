class UserMailer < ApplicationMailer
  default from: 'no-reply@desafioacid.com'

  def login_success_email(email, ua)
    @email = email
    @user_agent = ua
    mail(to: email, subject: 'Login success!')
  end

  def login_failed_email(email, ua)
    @email = email
    @user_agent = ua
    mail(to: email, subject: 'Login failed!')
  end
end
