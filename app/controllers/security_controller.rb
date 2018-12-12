class SecurityController < ApplicationController
    def new
        @street_numbers = Person.valid_street_numbers()

        @hide_header = true
        @person = Person.new
    end

    def create
        @person = Person.new(person_params)
        @person.active = true

        # generate a new token
        @person.verification_token = ('a'..'z').to_a.shuffle[0,8].join

        if @person.save
            UserMailer.with(person: @person).welcome_email.deliver_now

            flash[:success] = 'Check your email to verify your account'
            redirect_to login_path
        else
            render 'new'
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

    private
        def person_params
            params.permit(:first_name, :last_name, :email, :phone, :street_number, :password, :password_confirmation)
        end
end