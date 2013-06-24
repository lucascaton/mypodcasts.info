# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_url  :string(255)
#

require 'spec_helper'

describe User do
  describe '.from_omniauth' do
    let :auth do
      {
        'provider' => 'twitter',
        'uid'      => '1234',
        'info'     => { 'nickname' => 'Tarantino' }
      }
    end

    context 'when the user already exists' do
      it 'returns the user' do
        user = create(:user, provider: auth['provider'], uid: auth['uid'])
        expect(User.from_omniauth(auth)).to eq(user)
      end
    end

    context 'when the user does not exist' do
      it 'creates a new user' do
        user = User.from_omniauth(auth)

        expect(user.attributes.slice('provider', 'uid', 'name')).to eq(
          { 'provider' => 'twitter', 'uid' => '1234', 'name' => 'Tarantino' }
        )
      end
    end
  end
end
