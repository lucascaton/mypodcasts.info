# encoding: utf-8
class PodcastsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @podcast = Podcast.find(params[:id]).decorate
    @subscribers = @podcast.subscriptions.map { |subscription| subscription.user.decorate }
    @subscription = Subscription.new
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new params[:podcast]
    @podcast.created_by = current_user

    if @podcast.save
      flash[:notice] = 'Podcast cadastrado. Aguarde a aprovação do mesmo.'
      redirect_to @podcast
    else
      flash.now[:error] = @podcast.errors.full_messages.join(', ')
      render :new
    end
  end
end
