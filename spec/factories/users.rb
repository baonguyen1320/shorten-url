# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  api_key            :string           not null
#  current_sign_in_at :datetime
#  current_sign_in_ip :string
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :string
#  name               :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end
end
