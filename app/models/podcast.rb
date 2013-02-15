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
#

class Podcast < ActiveRecord::Base
  attr_accessible :name, :feed_url, :itunes_url, :logo

  validates :name, :active, presence: true
  validates :name, :feed_url, :itunes_url, uniqueness: true

  has_many :subscription
end
