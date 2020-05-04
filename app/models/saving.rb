class Saving < ApplicationRecord
  validates :total_savings,
            presence: true,
            on: :create
  validates :daily_income, :daily_consumption,
            presence: true,
            on: :create, on: :update
end
