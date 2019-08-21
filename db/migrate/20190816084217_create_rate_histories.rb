class CreateRateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :rate_histories do |t|
      t.string :date
      t.json :value

      t.timestamps
    end
  end
end
