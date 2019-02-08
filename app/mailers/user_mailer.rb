class UserMailer < ApplicationMailer
  def welcome_email
    @person = params[:person]
    @url = url_for controller: 'security', action: 'verify_email', verification_token: @person.verification_token

    mail(to: @person.email, subject: 'Welcome to Madison Pointe Homeowners Association')
  end
end
