class AddWeatherOnRaceResults < ActiveRecord::Migration[5.1]
  def change
    add_column :race_results, :weather, :string
  end
end
