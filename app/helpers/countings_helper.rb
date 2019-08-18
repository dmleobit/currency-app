module CountingsHelper
  def get_rate(rates, counting, total_sum = false)
    rate = (rates[counting.target_currency] / rates[counting.basic_currency])
    (total_sum ? rate * counting.amount : rate).round(5)
  end
end
