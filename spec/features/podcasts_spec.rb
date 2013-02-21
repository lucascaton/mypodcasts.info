# encoding: utf-8
require 'spec_helper'

describe 'Podcasts', type: :feature do
  let(:podcast) { create :podcast, :active, name: 'SotixCast' }

  describe 'show page' do
    context 'when podcast is active' do
      it 'has the correct information' do
        user = create :user, name: 'John Doe'
        subscription = create :subscription, podcast: podcast, user: user

        visit podcast_path(podcast)
        expect(page).to have_selector("img[src$='#{podcast.logo.url(:logo)}']")
        expect(page).to have_content(podcast.name)
        expect(page).to have_content(podcast.overview)
        expect(page).to have_content('1 ouvinte')
        expect(page).to have_content(user.name)
      end
    end

    context 'when podcast is NOT active' do
      it 'has the correct information' do
        podcast = create :podcast, name: 'InactiveCast'
        visit podcast_path(podcast)
        expect(page).to have_content(podcast.name)
        expect(page).to have_content('Ainda não aprovado.')
      end
    end

    context 'after authentication' do
      it 'has subscriptions buttons' do
        authenticate
        visit podcast_path(podcast)
        expect(page).to have_button('Incluir na minha lista')
        expect(page).to have_no_content('ouvintes')
        click_button 'Incluir na minha lista'
        expect(page).to have_content('1 ouvinte')
        expect(page).to have_link('Retirar da minha lista')
      end
    end
  end

  describe 'new page' do
    it 'allows to create a podcast' do
      authenticate
      click_link 'Incluir outros podcasts'
      expect(page).to have_content('Cadastrar podcast')
      fill_in 'Nome', with: 'Sotix Cast'
      fill_in 'Resumo', with: 'Lorem ipsum dolor sit amet'
      fill_in 'URL do feed', with: 'http://feed.url.com'
      fill_in 'URL do iTunes', with: 'http://itunes.url.com'
      attach_file 'Logo', "#{Rails.root}/spec/support/fixtures/sotix.jpg"
      expect { click_button 'Salvar' }.to change(Podcast, :count).by(1)

      expect(page).to have_content('Podcast cadastrado. Aguarde a aprovação do mesmo.')
      expect(page).to have_content('Sotix Cast')
      expect(page).to have_content('Ainda não aprovado.')
    end
  end
end
