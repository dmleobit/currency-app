class SaveDataFromApi
  extend LightService::Organizer

  def self.call(from)
    with(from: from).reduce(
        # We can move this class in separate files if need 
        SavingFromApi::GenerateMainUrl,
        SavingFromApi::GetDates,
        SavingFromApi::GetRatesFromApi,
        SavingFromApi::SaveRates
      )
  end
end
