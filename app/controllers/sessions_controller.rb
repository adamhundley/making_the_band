class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
    end
    redirect_to root_path
  end

  def destroy
    flash[:bye] = "Sad to see you go #{current_user.name}. Come back again soon. 👋"
    session.clear
    @current_user = nil
    redirect_to root_path
  end
end
