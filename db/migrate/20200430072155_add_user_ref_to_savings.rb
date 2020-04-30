class AddUserRefToSavings < ActiveRecord::Migration[5.0]
  def change
    add_reference :savings, :user, foreign_key: true
  end
end
