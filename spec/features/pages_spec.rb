require 'spec_helper'

describe 'Pages', type: :feature do
  context 'before authentication' do
    it 'has the correct information in initial page' do
      visit root_path
      expect(page).to have_selector("img[src$='logo_small.png']")
      expect(page).to have_no_link('Incluir outros podcasts')
      expect(page).to have_content('Cadastre os seus podcasts preferidos, crie um perfil público para compartilhar os que você mais gosta através de notas e descubra o que os seus amigos gostam de escutar!')
      expect(page).to have_content("Copyright © #{Date.today.year} Lucas Caton. Esse projeto é open source.")
    end

    it 'has users' do
      doe = create :user, name: 'John Doe'
      moe = create :user, name: 'John Moe'
      zoe = create :user, name: 'John Zoe'

      podcast_a = create :podcast, :active
      podcast_b = create :podcast, :active

      create :subscription, user: moe, podcast: podcast_a
      create :subscription, user: zoe, podcast: podcast_a
      create :subscription, user: zoe, podcast: podcast_b

      visit root_path
      expect(page).to have_content('John Doe (0 podcasts)')
      expect(page).to have_content('John Moe (1 podcast)')
      expect(page).to have_content('John Zoe (2 podcasts)')
    end

    it 'has podcasts' do
      podcast_a = create :podcast, :active, name: 'Podcast A'
      podcast_b = create :podcast, :active, name: 'Podcast B'
      podcast_c = create :podcast, :active, name: 'Podcast C'

      create :subscription, user_id: 1, podcast: podcast_b
      create :subscription, user_id: 1, podcast: podcast_c
      create :subscription, user_id: 2, podcast: podcast_c

      visit root_path
      expect(page).to have_content('Podcast A (0 ouvintes)')
      expect(page).to have_content('Podcast B (1 ouvinte)')
      expect(page).to have_content('Podcast C (2 ouvintes)')
    end

    it 'has no inactive podcasts' do
      podcast = create :podcast, name: 'SotixCast'

      visit root_path
      expect(page).to have_no_content('SotixCast')
    end
  end

  context 'after authentication' do
    before { authenticate }

    it 'has the correct flash message' do
      expect(page).to have_content('Logado com sucesso.')
    end

    it 'has some new links' do
      expect(page).to have_link('Incluir outros podcasts')
    end

    it 'has sign out link' do
      expect(page).to have_link('Sair')
    end
  end
end
