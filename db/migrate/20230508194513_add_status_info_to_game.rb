class AddStatusInfoToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :home_score, :integer, default: 0
    add_column :games, :away_score, :integer, default: 0
    add_column :games, :time_display, :string
  end
end
