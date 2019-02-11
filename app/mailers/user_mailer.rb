class UserMailer < ApplicationMailer
  def welcome_email
    @person = params[:person]
    @url = url_for controller: 'security', action: 'verify_email', verification_token: @person.verification_token

    mail(to: @person.email, subject: 'Welcome to Madison Pointe Homeowners Association')
  end

  def password_reset
    @person = params[:person]
    @url = url_for controller: 'security', action: 'password_reset', reset_password_token: @person.reset_password_token

    mail(to: @person.email, subject: '[Madison Pointe HOA] Password reset')
  end

  def admin_email
    @person = params[:person]
    @url = url_for controller: 'manage/people', action: 'show', id: @person.id

    mail(to: 'madisonpthoaweb@gmail.com', subject: 'New Madison Pointe Member')
  end
end
