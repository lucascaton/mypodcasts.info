# encoding: utf-8
class UserDecorator < Draper::Decorator
  delegate_all

  # Values for size:
  # bigger - 73px by 73px
  # normal - 48px by 48px
  # mini - 24px by 24px
  # original - This will be the size the image was originally uploaded in.
  def twitter_photo(size='mini')
    h.image_tag "https://api.twitter.com/1/users/profile_image?screen_name=#{model.name}&size=#{size}"
  end
end
