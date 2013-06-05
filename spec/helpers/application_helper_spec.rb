require 'spec_helper'

describe ApplicationHelper do

  describe '#title' do
    before { helper.title 'test' }
    it 'should set title instance variable' do
      expect(helper.instance_variable_get('@title')).to eq('test')
    end
  end

  describe '#show_title' do
    context 'with no title' do
      it 'returns title tag with default value' do
        expect(helper.show_title).to eq('<title>My Podcasts</title>')
      end
    end

    context 'with args' do
      before { helper.instance_variable_set('@title', 'test') }
      it 'returns title tag' do
        expect(helper.show_title).to eq('<title>test - My Podcasts</title>')
      end
    end
  end

  describe '#description' do
    before { helper.description 'test' }
    it 'should set description intance variable' do
      expect(helper.instance_variable_get('@description')).to eq('test')
    end
  end

  describe '#show_description' do
    context 'when description is empty' do
      it 'returns empty string' do
        expect(helper.show_description).to be_blank
      end
    end

    context 'with args' do
      before { helper.instance_variable_set('@description', 'test') }
      it 'returns description tag' do
        expect(helper.show_description).to eq('<meta content="test" name="description" />')
      end
    end
  end

end
