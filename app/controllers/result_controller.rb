class ResultController < ApplicationController
  def show
    
  end

  def new
    @saving = Saving.new
  end

  def create
    @saving = Saving.new(saving_params)
    @saving.save
    redirect_to "/result/:id"
  end

  def create_beginner
    @saving = Saving.new(saving_beginner_params)
    @saving.save
    redirect_to result_path
  end

  def beginner
    @saving = Saving.new(total_savings: params[:total_savings])
  end

  private
  def saving_params
    params.require(:saving).permit(:total_savings, :month_income, :daily_income, :daily_consumption)
  end

  def saving_beginner_params
    params.require(:saving).permit(:total_savings)
  end
end
