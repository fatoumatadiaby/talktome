class SessionsController < ApplicationController
  #login
  def welcome
   
    if logged_in?
    current_user.posts
    end  
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
      @user = User.find_by(username: params[:user][:username])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
            redirect_to home_path
      else
        @error = "please fill in all of the information reuired"
        redirect_to login_path
      end
    end
  end

  def destroy
    session.clear
    redirect_to home_path
  end

 
  private
  def user_params
    params.require(:user).permit(:email, :password, :name, :username)
  end
 
  def auth
    request.env['omniauth.auth']
  end
end