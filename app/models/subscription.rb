# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  podcast_id :integer          not null
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :podcast_id, :score

  validates :user_id, :podcast_id, presence: true
  validates :user_id, uniqueness: { scope: :podcast_id }
end
