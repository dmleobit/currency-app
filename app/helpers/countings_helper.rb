module CountingsHelper
  def count_sum_by_rate(rate, amount)
    (rate * amount).round(2)    
  end

  # profit/loss in comparison with latest_rate
  def profit_sum(latest_rate, rate, amount)
    count_sum_by_rate(latest_rate - rate, amount)
  end
end
