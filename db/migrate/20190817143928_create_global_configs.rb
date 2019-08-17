class CreateGlobalConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :global_configs do |t|
      t.json :latest_rate

      t.timestamps
    end
  end
end
