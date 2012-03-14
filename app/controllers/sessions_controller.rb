class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
   user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    remember = params[:session][:remember]
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_to user
  
      if (params[:remember]=="1")
      		flash[:success] = "Confirmed, Will remember login."	
      		perm_sign_in user
      else
    		flash[:success] = "Will not remember login." 	 	
        	temp_sign_in user
 	
    	end
 		
   	redirect_to user
    	end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end