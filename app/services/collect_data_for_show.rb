class CollectDataForShow
  include CountingsHelper
  attr_reader :counting,
              :rates,
              :table_data,
              :chart_data,
              :weeks_rates,
              :data_is_loading

  def initialize(counting)
    @counting = counting
    @rates = get_rates
    @weeks_rates = get_weeks_rates
    @table_data = highlight_points
    @chart_data = get_chart_data
    @data_is_loading = data_is_loading?
  end

  def latest_rate
    @latest_rate ||= get_rate(GlobalConfig["latest_rate"]["rates"], counting)
  end

  private

  def get_rates
    days = (counting.duration_in_days.days.ago.to_date..Date.yesterday).to_a
    RateHistory.where(date: days).order(date: :desc)
  end

  def get_weeks_rates
    hash = Hash.new {|hash, key| hash[key] = []}
    rates.each do |rate|
      key = { n_week: rate.date.strftime("%W").to_i, year: rate.date.year }
      hash[key] << get_rate(rate.value, counting)
    end

    hash.map { |key, value| [key, value.average]}.to_h
  end

  def highlight_points
    weeks_rates.max_by { |k, rate| rate }[0][:color] = "0f0"
    weeks_rates.min_by { |k, rate| rate }[0][:color] = "f00"

    weeks_rates    
  end

  def get_chart_data
    table_data.map do |key, value|
      ["#{key[:year]} year. #{key[:n_week]} week", (value * counting.amount).round(4)]
    end.reverse
  end

  def data_is_loading?    
    workers = Sidekiq::Workers.new
    workers.select do |process_id, thread_id, work|
      work.dig("payload", "class").eql?("SetHistoryRates")
    end.present?
  end
end
