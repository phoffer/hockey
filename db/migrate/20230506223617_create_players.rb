class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.integer :external_id
      t.references :team, null: false, foreign_key: true
      t.string :name
      t.integer :jersey
      t.string :position

      t.timestamps
    end
  end
end
