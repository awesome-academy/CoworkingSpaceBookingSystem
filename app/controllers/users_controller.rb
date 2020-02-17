class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:alert] = t ".user_notexist"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_mail"
      redirect_to root_path
    else
      flash[:success] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to user_path @user
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:alert] = t ".user_notexist"
    redirect_to root_path
  end

  def correct_user
    @user = User.find(params[:id])
    return if @user == current_user

    flash[:alert] = t ".cant_update"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :phone, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".alert_login"
      redirect_to login_url
    end
  end
end
