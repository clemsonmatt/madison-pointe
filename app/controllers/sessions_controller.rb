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

      return redirect_to profile_index_path unless user.verified_at

      redirect_to dashboard_index_path
    else
      flash.now[:danger] = user && !user.is_active(true) ? 'Account is not active' : 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to dashboard_index_path
  end
end
