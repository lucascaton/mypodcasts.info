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

class User < ActiveRecord::Base
  has_many :subscriptions

  attr_accessible :image_url

  validates :provider, :uid, :name, presence: true

  def self.from_omniauth(auth)
    user = where(auth.slice('provider', 'uid')).first

    if user
      user.update_attributes image_url: auth['info']['image'] unless user.image_url
      user
    else
      create_from_omniauth(auth)
    end
  end

  private

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider  = auth['provider']
      user.uid       = auth['uid']
      user.image_url = auth['image_url']
      user.name      = auth['info']['nickname']
    end
  end
end
