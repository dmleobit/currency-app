module CountingsHelper
  def get_rate(rates, counting)
    rates[counting.target_currency] / rates[counting.basic_currency]
  end
end
