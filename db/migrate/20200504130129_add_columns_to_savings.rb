class AddColumnsToSavings < ActiveRecord::Migration[5.0]
  def change
    add_column :savings, :evacuation, :integer, limit: 8
  end
end
