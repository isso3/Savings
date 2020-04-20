class CreateSavings < ActiveRecord::Migration[5.0]
  def change
    create_table :savings do |t|
      t.integer :total_savings,      null: false, limit: 8
      t.integer :month_income,       null: false, limit: 8
      t.integer :daily_consumption,  limit: 8
      t.integer :daily_income,       limit: 8

      t.timestamps
    end
  end
end
