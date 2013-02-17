class UsersController < ApplicationController
  def show
    @user = User.where(name: params[:name]).first.decorate
    @subscriptions = @user.subscriptions.select { |subscription| subscription.score.present? }.sort_by{ |subscription| [subscription.score.to_i, subscription.podcast.subscriptions.count] }.reverse
  end
end
