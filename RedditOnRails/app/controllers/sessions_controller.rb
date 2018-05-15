class SessionsController < ApplicationController


  def new
    if current_user
      require_logout
      return
    end

    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid Username and Password combo."]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

end
