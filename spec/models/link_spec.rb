# == Schema Information
#
# Table name: links
#
#  id           :bigint           not null, primary key
#  clicks_count :integer          default(0)
#  shorten_code :string
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
require 'rails_helper'

RSpec.describe Link, type: :model do
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to allow_value('https://example.com/test123').for(:url) }
  it { is_expected.not_to allow_value('example.com/').for(:url) }

  it { is_expected.to allow_value('abcd1234').for(:shorten_code) }
  it { is_expected.not_to allow_value('abcd1234567').for(:shorten_code) }
  it { is_expected.not_to allow_value('ab12').for(:shorten_code) }

  describe '.shorten_url' do
    it 'should return shorten url' do
      link = create(:link, shorten_code: 'abcd1234')

      expect(link.shorten_url).to eq('http://localhost:3000/abcd1234')
    end
  end

  describe '.increment_clicks!' do
    it 'should increment number of click' do
      link = create(:link)
      link.increment_clicks!
      link.reload

      expect(link.clicks_count).to eq(4)
    end
  end
end
