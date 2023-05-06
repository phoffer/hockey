class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :external_id, index: {unique: true}, null: false
      t.references :season, null: false, foreign_key: true
      t.integer :status, index: true
      t.date :date, index: true
      t.datetime :start_time
      t.references :away_team, null: false, foreign_key: { to_table: :teams }
      t.references :home_team, null: false, foreign_key: { to_table: :teams }

      t.timestamps
    end
  end
end
