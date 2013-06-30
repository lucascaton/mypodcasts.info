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

require 'spec_helper'
require 'paperclip/matchers'

RSpec.configure { |config| config.include Paperclip::Shoulda::Matchers }

describe Podcast do
  it { should have_attached_file(:logo) }
  it { should validate_attachment_content_type(:logo).allowing('image/png', 'image/gif', 'image/jpg') } # TODO: .rejecting('text/plain', 'text/xml')
  it { should validate_attachment_size(:logo).less_than(2.megabytes) }

  describe 'validations' do
    context 'when urls are equals' do
      it 'is not valid' do
        podcast = build :podcast, feed_url: 'http://example.com/feed', itunes_url: 'http://example.com/feed'
        expect(podcast).to be_invalid
        expect(podcast.errors[:base]).to eq(['As URLs do feed e do iTunes não podem ser a mesma'])
      end
    end

    context 'when urls are differents' do
      it 'is valid' do
        podcast = build :podcast, feed_url: 'http://example.com/feed', itunes_url: 'http://example.com/feed2'
        expect(podcast).to be_valid
      end
    end
  end

  describe 'scopes' do
    let(:podcast_1) { create :podcast, active: true }
    let(:podcast_2) { create :podcast, active: false }
    let(:podcast_3) { create :podcast, active: true }
    let(:podcast_4) { create :podcast, active: false }

    describe '.actives' do
      it 'returns all actives podcasts' do
        expect(Podcast.actives).to eq([podcast_1, podcast_3])
      end
    end

    describe '.not_actives' do
      it 'returns all not actives podcasts' do
        expect(Podcast.not_actives).to eq([podcast_2, podcast_4])
      end
    end
  end

  context 'when save a podcast' do
    it 'sets active if it is blank' do
      podcast = build :podcast, active: nil
      podcast.save
      expect(podcast.active).to eq(false)
    end

    it 'creates a slug for name' do
      podcast = create :podcast, name: 'John Doe'
      expect(podcast.slug).to eq('john-doe')
    end
  end

  context 'when update a podcast' do
    it 'updates a slug for name' do
      podcast = create :podcast, name: 'John Doe'
      podcast.update_attributes name: 'John Doe 2'
      expect(podcast.slug).to eq('john-doe-2')
    end
  end

  describe '#score_average' do
    context 'when there is no subscriptions' do
      it 'returns zero' do
        podcast = create :podcast
        expect(podcast.score_average).to eq(0)
      end
    end

    context 'when there are many subscriptions' do
      it 'returns the score average' do
        podcast = create :podcast
        create :subscription, podcast: podcast, score: 3
        create :subscription, podcast: podcast, score: 5
        create :subscription, podcast: podcast, score: 6
        create :subscription, podcast: podcast, score: 7
        expect(podcast.score_average).to eq(5.25)
      end
    end
  end

  describe '.ordered' do
    it 'returns the ordered list' do
      podcast_1 = mock :podcast, score_average: 10
      podcast_1.stub_chain(:subscriptions, :count).and_return(50)

      podcast_2 = mock score_average: 10
      podcast_2.stub_chain(:subscriptions, :count).and_return(100)

      podcast_3 = mock score_average: 9
      podcast_3.stub_chain(:subscriptions, :count).and_return(10)

      podcast_4 = mock score_average: 9
      podcast_4.stub_chain(:subscriptions, :count).and_return(200)

      podcast_5 = mock score_average: 8
      podcast_5.stub_chain(:subscriptions, :count).and_return(5)

      podcast_6 = mock score_average: 8
      podcast_6.stub_chain(:subscriptions, :count).and_return(140)

      podcast_7 = mock score_average: 8
      podcast_7.stub_chain(:subscriptions, :count).and_return(600)

      Podcast.stub!(:all).and_return([podcast_1, podcast_2, podcast_3, podcast_4, podcast_5, podcast_6, podcast_7])
      expect(Podcast.ordered).to eq([podcast_2, podcast_1, podcast_4, podcast_3, podcast_7, podcast_6, podcast_5])
    end
  end
end
