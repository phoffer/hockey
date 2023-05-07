class AddStatTypeToStatline < ActiveRecord::Migration[7.0]
  def change
    add_column :statlines, :stat_type, :integer
  end
end
