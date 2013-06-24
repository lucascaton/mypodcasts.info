class PagesController < ApplicationController
  def index
    if current_user.nil? || current_user.image_url.nil?
      flash.now[:notice] = 'O Twitter atualizou sua API e será necessário se autenticar novamente para exibir a imagem do seu usuário.'
    end

    @podcasts = Podcast.actives.ordered
    @users = current_user ? (User.order('RANDOM()') - [current_user.model]).map(&:decorate) : User.decorate
  end
end
