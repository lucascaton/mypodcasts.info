class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]).decorate
    @subscriptions = @user.subscriptions
  end
end
