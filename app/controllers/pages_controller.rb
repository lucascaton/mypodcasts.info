class PagesController < ApplicationController
  def index
    @podcasts = Podcast.actives.ordered
    @users = current_user ? (User.all - [current_user.model]).map(&:decorate) : User.decorate
  end
end
