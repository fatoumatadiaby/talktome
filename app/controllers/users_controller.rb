class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end
   
    def create
      @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user_id
            redirect_to user_path
        else
            render :new
        end
    end



    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
    end
end
