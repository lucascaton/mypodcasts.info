class PodcastsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @podcast = Podcast.find params[:id]
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new params[:podcast]
    @podcast.created_by = current_user

    if @podcast.save
      flash[:notice] = 'Podcast cadastrado!'
      redirect_to @podcast
    else
      flash.now[:error] = @podcast.errors.full_messages.join(', ')
      render :new
    end
  end
end
