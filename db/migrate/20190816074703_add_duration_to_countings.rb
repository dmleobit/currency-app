class AddDurationToCountings < ActiveRecord::Migration[5.2]
  def change
    add_column :countings, :duration, :integer
  end
end
