class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @subscription = Subscription.new params[:subscription]
    @subscription.user = current_user

    @subscription.save
    redirect_to @subscription.podcast
  end

  def update
    @subscription = current_user.subscriptions.where(podcast_id: params[:subscription][:podcast_id]).first

    @subscription.update_attributes score: params[:subscription][:score]
    redirect_to @subscription.podcast
  end

  def destroy
    @subscription = Subscription.find params[:id]

    if @subscription.user == current_user
      @subscription.destroy
      redirect_to root_path
    else
      flash[:error] = 'Você não tem autorização para isso.'
      redirect_to @subscription.podcast
    end
  end
end
