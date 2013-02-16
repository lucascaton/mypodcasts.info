class PagesController < ApplicationController
  def index
    @podcasts = Podcast.actives
    @users = current_user ? (User.all - [current_user.model]).map(&:decorate) : User.decorate
    @subscription = Subscription.new
  end
end
