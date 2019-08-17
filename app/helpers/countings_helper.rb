module CountingsHelper
  def get_rate(rate, counting, total_sum = false)
    rate = (rate.value[counting.target_currency] / rate.value[counting.basic_currency])
    (total_sum ? rate * counting.amount : rate).round(5)
  end

  def get_change_course(first_rate, second_rate, counting)
    (get_rate(first_rate, counting) - get_rate(second_rate, counting)).round(4)
  end
end
