class SavingFromApi::GetDates
  extend LightService::Action

  expects :from
  promises :dates

  executed do |context|
    all_dates = context.from.upto(Date.yesterday).to_a
    exists_dates = RateHistory.where(date: all_dates).pluck(:date)

    context.dates = all_dates - exists_dates
    context.skip_remaining!("Date is blank") if context.dates.blank?
  end
end
