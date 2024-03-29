class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def logged_in?
    @user ||= Person.find(session[:user_id]) if session[:user_id]

    redirect_to login_path unless @user
  end

  def permission?(permission)
    @user = current_user

    redirect_to login_path unless @user && @user.permission?(permission)
  end

  def current_user
    @user ||= Person.find(session[:user_id]) if session[:user_id]
  end
end
