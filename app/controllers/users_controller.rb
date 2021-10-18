class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :requere_user, only: [:edit, :update]
  before_action :requere_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}, you have succesfully sign up!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User was updated succesfuly."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:success] = "Account successfuly deleted"
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def requere_same_user
    if current_user != @user && !current_user.admin?
      flash[:error] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end

end
