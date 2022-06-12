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
class Link < ApplicationRecord
  belongs_to :user

  validates :url, format: URI::regexp(%w[http https]), presence: true
  validates :shorten_code, uniqueness: true, length: { in: 6..9 }

  before_validation :set_shorten_code

  def shorten_url
    "#{base_url}/#{shorten_code}"
  end

  def set_shorten_code
    self.shorten_code ||= SecureRandom.alphanumeric(9)
  end

  def increment_clicks
    increment!(:clicks_count)
  end

  private

  def base_url
    Rails.env.production? ? 'https://shorten-url-app.herokuapp.com' : 'http://localhost:3000'
  end
end
