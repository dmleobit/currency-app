# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  name             :string
#  oauth_expires_at :datetime
#  oauth_token      :string
#  provider         :string
#  uid              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ApplicationRecord
  has_many :countings

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
