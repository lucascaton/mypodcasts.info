# encoding: utf-8
require 'spec_helper'

describe UserDecorator do
  subject { build(:user).decorate }

  describe '#twitter_photo' do
    context 'with no args' do
      it 'return the correct html' do
        expect(subject.twitter_photo).to eq("<img alt=\"Profile_image?screen_name=#{subject.name}&amp;size=mini\" src=\"https://api.twitter.com/1/users/profile_image?screen_name=#{subject.name}&amp;size=mini\" />")
      end
    end

    context 'with a different size' do
      it 'return the correct html' do
        expect(subject.twitter_photo('bigger')).to eq("<img alt=\"Profile_image?screen_name=#{subject.name}&amp;size=bigger\" src=\"https://api.twitter.com/1/users/profile_image?screen_name=#{subject.name}&amp;size=bigger\" />")
      end
    end
  end
end
