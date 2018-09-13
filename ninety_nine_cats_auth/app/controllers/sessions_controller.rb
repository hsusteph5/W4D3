class SessionsController < ApplicationController
  # before_action redirect_to cats_url if current_user
  
  def new 
    @user = User.new 
    render :new
  end 
  
  def create
    @user = User.find_by_credentials(
      params[:user][:username], 
      params[:user][:password]
    )
    if @user 
      # session[:session_token] = @user.reset_session_token!
      login!(@user)
      redirect_to cats_url(@user)
    else 
      flash.now[:errors] << ['invalid login credentials! booooooo']
    end   
  end 
  
  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end 
  end   

end
