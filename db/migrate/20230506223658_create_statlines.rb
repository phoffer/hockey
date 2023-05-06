class CreateStatlines < ActiveRecord::Migration[7.0]
  def change
    create_table :statlines do |t|
      t.references :player, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.json :stats

      t.timestamps
    end
  end
end
