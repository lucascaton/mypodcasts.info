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

require 'spec_helper'

describe Subscription do
  subject { build :subscription }

  describe 'validations' do
    context 'when user_id is not present' do
      it 'is not valid' do
        subject.user_id = nil
        expect(subject).to be_invalid
      end
    end

    context 'when podcast_id is not present' do
      it 'is not valid' do
        subject.podcast_id = nil
        expect(subject).to be_invalid
      end
    end

    context 'when an user has a duplicated podcast' do
      it 'is not valid' do
        create :subscription, user_id: 11, podcast_id: 22
        subject.user_id, subject.podcast_id = 11, 22
        expect(subject).to be_invalid
      end
    end
  end
end
