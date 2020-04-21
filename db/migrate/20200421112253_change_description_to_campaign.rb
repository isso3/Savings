class ChangeDescriptionToCampaign < ActiveRecord::Migration[5.0]
  def change
    change_column_null :savings, :month_income, true
  end
end
