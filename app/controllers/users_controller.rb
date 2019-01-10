class UsersController < ApplicationController
  skip_before_action :authorize, only: [:create, :new]
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    unless @current_user = User.find(session[:user_id]) == nil
         @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      flash[:notice] = 'Unable to create user'
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_profile_update_params)
      flash[:success] = "Profile information saved."
    else
      flash[:alertt] = "There was an error. Please try again."
    end
    redirect_to @user
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def user_create_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_profile_update_params
    params.require(:user).permit(:first_name, :last_name, :username, :gender, :bio, :avatar_image )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
