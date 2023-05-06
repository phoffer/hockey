class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.string :external_id, index: {unique: true}, null: false
      t.date :regular_start_date
      t.date :regular_end_date
      t.date :end_date

      t.timestamps
    end
  end
end
