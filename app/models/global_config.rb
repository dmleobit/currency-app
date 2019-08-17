# == Schema Information
#
# Table name: global_configs
#
#  id          :bigint           not null, primary key
#  latest_rate :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# We can use this model for global variables that changed by admin or automatically
class GlobalConfig < ApplicationRecord
  def self.[](data)
    GlobalConfig.first[data]
  end

  def self.get_rates
    GlobalConfig.first&.latest_rate.dig("rates") || {}
  end
end
