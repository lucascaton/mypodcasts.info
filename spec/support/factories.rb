# encoding: utf-8
require 'factory_girl'
require 'forgery'

FactoryGirl.define do
  sequence(:uid) { |n| n }

  factory :user do
    provider 'twitter'
    uid
    name { Forgery::Internet.user_name }
  end
end
