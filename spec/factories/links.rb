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
FactoryBot.define do
  factory :link do
    url { Faker::Internet.url }
    shorten_code { SecureRandom.alphanumeric(9) }
    clicks_count { 3 }
    user
  end
end
