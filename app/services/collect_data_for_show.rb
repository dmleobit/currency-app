class CollectDataForShow
  attr_reader :counting,
              :rates,
              :table_data,
              :chart_data,
              :weeks_rates,
              :data_is_loading

  def initialize(counting)
    @counting = counting
    @rates = rates_from_db
    @weeks_rates = build_weeks_rates
    @table_data = highlight_points
    @chart_data = build_chart_data
    @data_is_loading = data_is_loading?
  end

  def latest_rate
    @latest_rate ||= count_rate(GlobalConfig["latest_rate"]["rates"])
  end

  private

  def rates_from_db
    days = (counting.duration_in_days.days.ago.to_date..Date.yesterday).to_a
    RateHistory.where(date: days).order(date: :desc)
  end

  def build_weeks_rates
    hash = Hash.new { |new_hash, key| new_hash[key] = [] }
    rates.each do |rate|
      key = { n_week: rate.date.strftime("%W").to_i, year: rate.date.year }
      hash[key] << count_rate(rate.value)
    end

    hash.map { |key, value| [key, value.average] }.to_h
  end

  def highlight_points
    weeks_rates.max_by { |_k, rate| rate }[0][:color] = "0f0"
    weeks_rates.min_by { |_k, rate| rate }[0][:color] = "f00"

    weeks_rates
  end

  def build_chart_data
    table_data.map do |key, value|
      ["#{key[:year]} year. #{key[:n_week]} week", (value * counting.amount).round(4)]
    end.reverse
  end

  def data_is_loading?
    workers = Sidekiq::Workers.new
    workers.select do |_process_id, _thread_id, work|
      work.dig("payload", "class").eql?("SetHistoryRates")
    end.present?
  end

  def count_rate(rate)
    rate[counting.target_currency] / rate[counting.basic_currency]
  end
end
