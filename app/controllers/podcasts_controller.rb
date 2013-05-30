# encoding: utf-8
class PodcastsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @podcast = Podcast.find params[:id]
    @subscribers = @podcast.subscriptions.map { |subscription| subscription.user.decorate }

    if current_user
      @subscription = current_user.subscriptions.where(podcast_id: @podcast.id).first || Subscription.new
    end
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new params[:podcast]
    @podcast.created_by = current_user

    if @podcast.save
      Subscription.create(podcast_id: @podcast.id, user_id: current_user.id)
      flash[:notice] = 'Podcast cadastrado. Aguarde a aprovação do mesmo.'
      redirect_to @podcast
    else
      flash.now[:error] = @podcast.errors.full_messages.join(', ')
      render :new
    end
  end
end
