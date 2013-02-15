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
#

class Podcast < ActiveRecord::Base
  attr_accessible :name, :feed_url, :itunes_url, :logo, :created_by_id, :overview

  validates :name, :created_by_id, presence: true
  validates :name, :feed_url, :itunes_url, uniqueness: true
  validates :active, inclusion: { in: [true, false] }

  has_many :subscription
  belongs_to :created_by, class_name: 'User'

  before_validation :set_active

  has_attached_file :logo, styles: { logo: '500x500>' }

  private

  def set_active
    self.active = false if self.active.nil?
  end
end
