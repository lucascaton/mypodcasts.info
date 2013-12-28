# == Schema Information
#
# Table name: podcasts
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  feed_url          :string(255)
#  itunes_url        :string(255)
#  active            :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  created_by_id     :integer          not null
#  overview          :text
#  slug              :string(255)
#

class Podcast < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :name, :feed_url, :itunes_url, :logo, :created_by_id, :overview, :slug, :active

  validates :name, :created_by_id, :logo, :feed_url, :itunes_url, :overview, presence: true
  validates :name, :feed_url, :itunes_url, uniqueness: true
  validates :active, inclusion: { in: [true, false] }

  validate :different_urls_validation

  has_many :subscriptions
  belongs_to :created_by, class_name: 'User'

  before_validation :set_active

  has_attached_file :logo, styles: { logo: '300x300>', thumb: '24x24>' }
  validates_attachment :logo, size: { in: 0..2.megabytes }

  friendly_id :name, use: :slugged

  scope :actives, where(active: true)
  scope :not_actives, where(active: false)

  def score_average
    scores = self.subscriptions.pluck(:score).compact
    scores.blank? ? 0 : scores.inject{ |sum, el| sum + el }.to_f / scores.size
  end

  def self.ordered
   self.all.sort_by { |podcast| [podcast.score_average, podcast.subscriptions.count] }.reverse
  end

  private

  def set_active
    self.active = false if self.active.nil?
  end

  def different_urls_validation
    errors.add(:base, 'As URLs do feed e do iTunes não podem ser a mesma') if self.feed_url == self.itunes_url
  end
end
