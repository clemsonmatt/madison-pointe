class SecurityController < ApplicationController
    def new
        @street_numbers = Person.valid_street_numbers()

        @hide_header = true
        @person = Person.new
    end

    def create
        @person = Person.new(person_params)
        @person.active = true

        if @person.save
            flash[:success] = 'Check your email to verify your account'
            redirect_to login_path
        else
            render 'new'
        end
    end

    private
        def person_params
            params.permit(:first_name, :last_name, :email, :phone, :street_number, :password, :password_confirmation)
        end
end