class CollectDataForShow
  include CountingsHelper
  attr_reader :counting,
              :rates,
              :latest_rate,
              :table_data,
              :chart_data,
              :data_is_loading

  def initialize(counting)
    @counting = counting
    @rates = get_rates
    @latest_rate = get_rate(GlobalConfig["latest_rate"]["rates"], @counting)
    @table_data = get_weeks_rates
    @chart_data = get_chart_data
    @data_is_loading = data_is_loading?
  end

  private

  def get_rates
    days = (Date.today - @counting.duration).upto(Date.today - 1).to_a
    RateHistory.where(date: days).order(date: :desc)
  end

  def get_weeks_rates
    res = {}
    @rates.each do |rate|
      key = {n_week: rate.date.cweek, year: rate.date.year}
      # key = "#{rate.date.cweek}:#{rate.date.year}"
      res[key] ||= []
      res[key] << get_rate(rate.value, @counting)
    end
    res.map do |key, value|
      [key, (value.inject(0.0){|v,sum| sum+v.to_f}/value.size).round(5)]
    end.to_h
  end

  def get_chart_data
    @table_data.map do |key, value|
      ["#{key[:year]} year. #{key[:n_week]} week", (value * @counting.amount).round(4)]
    end.reverse
  end

  def data_is_loading?    
    workers = Sidekiq::Workers.new
    workers.select do |process_id, thread_id, work|
      work.dig("payload", "class").eql?("SetHistoryRates")
    end.present?
  end
end
