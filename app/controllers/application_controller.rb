class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]).decorate if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    if current_user.blank?
      flash[:error] = 'Você precisa se logar antes de ver essa página!'
      redirect_to root_path
    end
  end
end
