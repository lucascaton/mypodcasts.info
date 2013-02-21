# encoding: utf-8
require 'factory_girl'
require 'forgery'

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    provider 'twitter'
    sequence(:uid) { |n| n }
    name { Forgery::Internet.user_name }
  end

  factory :podcast do
    name { Forgery::Name.full_name }
    created_by_id 1
    sequence(:feed_url) { |n| "feed#{n}.com/feed" }
    sequence(:itunes_url) { |n| "itunes#{n}.com" }
    overview 'Lorem ipsum dolor sit amet, consectetur adipisicing elit'
    logo { fixture_file_upload "#{Rails.root}/spec/support/fixtures/sotix.jpg" }

    trait :active do
      active true
    end
  end

  factory :subscription do
    user
    podcast
    score { rand(10) + 1 }
  end
end
