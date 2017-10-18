class SessionsController < ApplicationController
    def new
    end

    def create
        user = Person.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to dashboard_index_path
        else
            flash.now[:danger] = 'Email or password is invalid'
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to new_session_path
    end
end
