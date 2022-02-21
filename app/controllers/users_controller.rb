class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your Account was Created Successfully!"
      redirect_to root_url
    else
      flash[:warning] = @user.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all.order(updated_at: :desc)
  end

  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to users_url
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
  end
end