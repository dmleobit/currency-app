class RetypeColumnInRateHistories < ActiveRecord::Migration[5.2]
  def change
    remove_column :rate_histories, :date
    add_column    :rate_histories, :date, :date
  end
end
