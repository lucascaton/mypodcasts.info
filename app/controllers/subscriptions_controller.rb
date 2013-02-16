# encoding: utf-8
class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def create
  end

  def create
    @subscription = Subscription.new params[:subscription]
    @subscription.user = current_user

    if @subscription.save
      redirect_to @subscription.podcast
    else
      flash.now[:error] = @subscription.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    @subscription = Subscription.find params[:id]

    if @subscription.user == current_user
      @subscription.destroy
      redirect_to @subscription.podcast
    else
      flash[:error] = 'Você não tem autorização para isso.'
      redirect_to @subscription.podcast
    end
  end
end
