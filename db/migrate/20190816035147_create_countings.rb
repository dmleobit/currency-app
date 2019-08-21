class CreateCountings < ActiveRecord::Migration[5.2]
  def change
    create_table :countings do |t|
      t.string :basic_currency
      t.string :target_currency
      t.float  :amount, default: 0

      t.belongs_to :user
      t.timestamps
    end
  end
end
