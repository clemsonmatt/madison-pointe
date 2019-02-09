class SecurityController < ApplicationController
  def new
    @houses = House.all
    @hide_header = true
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.active = true

    # generate a new token
    @person.verification_token = ('a'..'z').to_a.sample(8).join

    if verify_recaptcha(model: @person) && @person.save
      UserMailer.with(person: @person).welcome_email.deliver_now

      flash[:success] = 'Check your email to verify your account'
      redirect_to login_path
    else
      flash[:danger] = 'Missing required fields'
      redirect_to new_security_path
    end
  end

  def verify_email
    @person = Person.find_by(verification_token: params[:verification_token], email_verified_at: nil)

    if @person
      @person.email_verified_at = DateTime.now
      @person.verification_token = nil

      @person.save

      flash[:success] = 'Your account is verified. Login to continue'
    else
      flash[:danger] = 'Account not found'
    end

    redirect_to login_path
  end

  def password_forgot
    @hide_header = true
  end

  def password_forgot_reset
    if params[:email].blank?
      flash[:danger] = 'No email provided'
      return redirect_to security_forgot_password_path
    end

    person = Person.find_by email: params[:email]

    if person.blank?
      flash[:danger] = "Account not found for #{params[:email]}"
      return redirect_to security_forgot_password_path
    end

    unless verify_recaptcha(model: person)
      flash[:danger] = 'Invalid recaptcha'
      return redirect_to security_forgot_password_path
    end

    person.generate_password_token!

    UserMailer.with(person: person).password_reset.deliver_now

    flash[:info] = 'Check your email for a password reset link'

    redirect_to login_path
  end

  def password_reset
    token = params[:reset_password_token].to_s

    @person = Person.find_by reset_password_token: token

    if @person.nil? || @person.password_token_valid? == false
      flash[:danger] = 'Invalid token. Cannot reset password.'
      return redirect_to login_path
    end

    @hide_header = true
  end

  def update_password
    token = params[:reset_password_token].to_s

    @person = Person.find_by reset_password_token: token

    if @person && @person.password_token_valid?
      if params[:password] != params[:password_confirm]
        flash[:danger] = 'Passwords must match'
        return redirect_to security_reset_password_path @person.reset_password_token
      end

      if @person.reset_password! params[:password]
        @person.authenticate(params[:password])
        session[:user_id] = @person.id

        flash[:success] = 'Password updated'
        return redirect_to profile_index_path
      end
    end

    flash[:danger] = 'Invalid token. Cannot reset password.'
    redirect_to login_path
  end

  private

  def person_params
    params.permit(:first_name, :last_name, :email, :phone, :house_id, :password, :password_confirmation)
  end
end
