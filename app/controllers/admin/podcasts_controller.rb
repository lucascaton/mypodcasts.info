class Admin::PodcastsController < Admin::ApplicationController
  before_filter :load_podcast, only: [:edit]
  before_filter :load_users,   only: [:edit]

  def index
    @podcasts = Podcast.all
  end

  def edit
  end

  def update
    @podcast = Podcast.find params[:id]

    if @podcast.update_attributes params[:podcast]
      flash[:notice] = 'Podcast atualizado.'
      redirect_to admin_podcasts_path
    else
      flash.now[:alert] = @podcast.errors.full_messages.join(', ')
      load_users
      render :edit
    end
  end

  private

  def load_podcast
    @podcast = Podcast.find params[:id]
  end

  def load_users
    @users = User.all
  end
end
