# encoding: utf-8
require 'spec_helper'

describe 'Users', type: :feature do
  describe 'show page' do
    it 'has the correct information' do
      user = create :user, name: 'johndoe'
      podcast = create :podcast, :active, name: 'SotixCast'
      subscription = create :subscription, podcast: podcast, user: user

      visit user_path(user, name: user.name)
      expect(page).to have_selector("img[src$='https://api.twitter.com/1/users/profile_image?screen_name=johndoe&size=original']")
      expect(page).to have_content(user.name)
      expect(page).to have_content("Membro desde #{I18n.l(user.created_at.to_date)}")

      expect(page).to have_content('1 ouvinte')
      expect(page).to have_selector("img[src$='#{podcast.logo.url(:logo)}']")
      expect(page).to have_content(podcast.name)
    end
  end
end
