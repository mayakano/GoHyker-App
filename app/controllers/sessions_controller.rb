class SessionsController < ApplicationController
  skip_before_action :authorize, except: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"

      redirect_to root_path
      # , notice: 'Logged in!'
    else
      # flash.now.alert = 'Email or password is invalid'
      flash[:error] = "Email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
