class ChangeDescriptionToCampaign2 < ActiveRecord::Migration[5.0]
  def change
    change_column_null :savings, :total_savings, true
  end
end
