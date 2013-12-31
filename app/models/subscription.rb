class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :podcast_id, :score

  validates :user_id, :podcast_id, presence: true
  validates :user_id, uniqueness: { scope: :podcast_id }

  belongs_to :user
  belongs_to :podcast

  scope :actives, joins(:podcast).where(podcasts: {active: true}).includes(:podcast)
end
