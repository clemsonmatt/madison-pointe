class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    protected
        def logged_in?
            @user ||= Person.find(session[:user_id]) if session[:user_id]

            if ! @user
                redirect_to login_path
            end
        end
end
