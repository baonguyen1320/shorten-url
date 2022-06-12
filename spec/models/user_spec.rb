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
require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to allow_value('test@gmail.com').for(:email) }
  it { is_expected.not_to allow_value('abc.com').for(:email) }

  it { is_expected.to allow_value('abcd$123').for(:password) }
  it { is_expected.not_to allow_value('12345').for(:password) }
end
