require 'spec_helper'

describe UserDecorator do
  subject { build(:user, image_url: 'https://api_twitter.com/an_image_with_normal_size.png').decorate }

  describe '#twitter_photo' do
    context 'with no args' do
      it 'return the correct html' do
        expect(subject.twitter_photo).to eql("<img alt=\"An_image_with_mini_size\" src=\"https://api_twitter.com/an_image_with_mini_size.png\" />")
      end
    end

    context 'with a different size' do
      it 'return the correct html' do
        expect(subject.twitter_photo('bigger')).to eql("<img alt=\"An_image_with_bigger_size\" src=\"https://api_twitter.com/an_image_with_bigger_size.png\" />")
      end
    end
  end
end
