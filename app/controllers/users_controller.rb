class UsersController < ApplicationController
  def show
    @user = User.where(name: params[:name]).first.decorate
    @subscriptions = @user.subscriptions
  end
end
