# encoding: utf-8
class UserDecorator < Draper::Decorator
  delegate_all

  # Values for size:
  # bigger - 73px by 73px
  # normal - 48px by 48px
  # mini - 24px by 24px
  # original - This will be the size the image was originally uploaded in.
  def twitter_photo(size='mini')
    if model.image_url
      h.image_tag model.image_url.gsub(/normal/, size)
    else
      ''
    end
  end
end
