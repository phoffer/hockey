class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.integer :external_id, index: {unique: true}, null: false
      t.string :name

      t.timestamps
    end
  end
end
