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
  has_many :countings, dependent: :destroy
end
