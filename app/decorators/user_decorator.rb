# encoding: utf-8
class UserDecorator < Draper::Decorator
  delegate_all

  def twitter_photo(size='mini')
    h.image_tag "https://api.twitter.com/1/users/profile_image?screen_name=#{model.name}&size=#{size}"
  end
end
