class SessionsController < ApplicationController
  #login
  def welcome
    current_user
  end
 
  def new
    @user = User.new

  end

 
  def create
    if auth
      user = User.create_with_omniauth(auth)
      session[:user_id] = user.id    
      redirect_to home_path
    else
      @user = User.find_by(email: params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
            redirect_to home_path
      else
        render :new
      end
    end
  end

  def destroy
    session.clear
    redirect_to logout_path
  end

 
  private
  def user_params
    params.require(:user).permit(:email, :password, :name, :username)
  end
 
  def auth
    request.env['omniauth.auth']
  end
end