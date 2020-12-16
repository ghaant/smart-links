class SessionsController < ApplicationController
  def new
    redirect_to current_user if logged_in?
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user&.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to @user
    else
      redirect_to login_path, alert: 'Invalid email/password combination'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
