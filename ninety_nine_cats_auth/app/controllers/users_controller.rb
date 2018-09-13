class UsersController < ApplicationController
  # before_action redirect_to cats_url if current_user
  # before_action :require_logged_in
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  # def show 
  #   @user = User.find_by(id: params[:id])
  # end 
  # 
  
  private
  
  def user_params
    # debugger
    params.require(:user).permit(:username, :password)
  end 
  
end 