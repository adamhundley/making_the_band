class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      flash[:info] = "Welcome #{current_user.name}!"
    end
    redirect_to root_path
  end

  def destroy
    flash[:alert] = "Sad to see you go #{current_user.name}. Come back again soon. 👋"
    session.clear
    @current_user = nil
    redirect_to root_path
  end
end
