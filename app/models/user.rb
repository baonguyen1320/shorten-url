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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :links, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  before_create :set_api_key

  def set_api_key
    self.api_key = SecureRandom.hex
  end
end
