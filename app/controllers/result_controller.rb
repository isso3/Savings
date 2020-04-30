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
    @saving = Saving.create(saving_params)
    @saving.user_id = current_user.id
    user = Saving.order(id: :desc).find_by(user_id: current_user)
    @total_saving = user.total_savings
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
    i = 1
    ok = false
    @saving = Saving.order(id: :desc).find_by(user_id: current_user)
    if @saving.user_id == current_user.id
      now = Date.today
      while ok == false
        yesterday = now.ago(i.days)
        y_saving = Saving.where(user_id: current_user).find_by(updated_at: yesterday..now)
        if y_saving != nil
          ok = false
          break
        else
          if i > 1461
            y_saving = @saving
            y_saving.total_savings = @saving.total_savings
            break
          elsif y_saving == nil
            i += 1
          elsif y_saving != nil
            ok = true
          end
        end
      end
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
    @saving = Saving.create(saving_beginner_params)
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
