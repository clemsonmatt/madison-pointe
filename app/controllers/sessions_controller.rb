class SessionsController < ApplicationController
    def index
        redirect_to login_path
    end

    def new
        @hide_header = true
    end

    def create
        @hide_header = true

        user = Person.find_by(email: params[:email])

        if user && user.is_active(true) && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to dashboard_index_path
        else
            if user && ! user.is_active(true)
                flash.now[:danger] = 'Account is not active'
            else
                flash.now[:danger] = 'Email or password is invalid'
            end

            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to dashboard_index_path
    end
end
