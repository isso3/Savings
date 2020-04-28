class ResultController < ApplicationController
  require "date"  
  def show
    saving = Saving.order(id: :desc).find_by(user_id: current_user)
    now = Date.today
    past = saving.updated_at
    @time = (now - Date.parse(past.to_s)).to_i
  end

  def new
    @saving = Saving.new
  end

  def create
    @saving = Saving.new(saving_params)
    @saving.user_id = current_user.id
    user = Saving.where(user_id: current_user)
    @total_saving = user.last.total_savings
    @saving.save
    if @saving.month_income
      @saving.total_savings = @total_saving + @saving.month_income + @saving.daily_income - @saving.daily_consumption
    else
      @saving.total_savings = @total_saving + @saving.daily_income - @saving.daily_consumption
    end
    @saving.update(saving_params)
    redirect_to result_path(current_user.id)
  end

  def edit
    @saving = Saving.where(user_id: current_user).last
  end

  def update
    @saving = Saving.order(id: :desc).find_by(user_id: current_user)
    if @saving.user_id == current_user.id
      now = Date.today
      yesterday = now.yesterday
      y_saving = Saving.where(user_id: current_user).find_by(updated_at: yesterday..now)
      @saving.total_savings = y_saving.total_savings
      @saving.update(saving_params)
      if @saving.month_income
        @saving.total_savings = @saving.total_savings + @saving.month_income + @saving.daily_income - @saving.daily_consumption
      else
        @saving.total_savings = @saving.total_savings + @saving.daily_income - @saving.daily_consumption
      end
      @saving.update(saving_params)
    end
    redirect_to result_path(current_user.id)
  end

  def create_beginner
    @saving = Saving.new(saving_beginner_params)
    @saving.user_id = current_user.id
    @saving.save
    redirect_to result_path(current_user.id)
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
