class ResultController < ApplicationController
  require "date"  
  def show
    saving = Saving.order(id: :desc).find_by(user_id: current_user.id)
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
    user = Saving.order(id: :desc).find_by(user_id: current_user)
    @saving.total_savings = user.total_savings
    @total_saving = user.total_savings
    unless @saving.save
      flash[:alert] = "登録に失敗しました"
      render action: :new and return
    end
    if @saving.daily_income == nil
        @saving.daily_income = 0
    end
    if @saving.daily_consumption == nil
      @saving.daily_consumption = 0
    end
    if @saving.month_income
      @saving.total_savings = @total_saving + @saving.month_income + @saving.daily_income - @saving.daily_consumption
    else
      @saving.total_savings = @total_saving + @saving.daily_income - @saving.daily_consumption
    end
    if @saving.update(saving_params)
      redirect_to result_path(current_user.id)
    else
      flash[:alert] = "登録に失敗しました"
      redirect_to new_result_path
    end
  end

  def edit
    @saving = Saving.where(user_id: current_user).last
  end

  def update
    i = 1
    ok = false
    @saving = Saving.order(id: :desc).find_by(user_id: current_user)
    @saving.update(saving_params)
    if @saving.user_id == current_user.id
      now = Date.today
      while ok == false
        yesterday = now.ago(i.days)
        y_saving = Saving.where(user_id: current_user).find_by(updated_at: yesterday..now)
        if y_saving != nil
          ok = true
        else
          if i > 1460
            y_saving = @saving
            break
          elsif y_saving == nil
            i += 1
          elsif y_saving != nil
            ok = true
          end
        end
      end
      if @saving.month_income == nil && @saving.daily_income == nil && @saving.daily_consumption == nil
        @saving.month_income = 0
        @saving.daily_income = 0
        @saving.daily_consumption = 0
      end
      one = Saving.where(user_id: current_user.id).count
      if one != 1
        if @saving.month_income
          if @saving.evacuation == nil
            saving = @saving
            saving.evacuation = saving.total_savings
            @saving.evacuation = saving.evacuation
            @saving.update(saving_params)
            @saving.total_savings = y_saving.total_savings + @saving.month_income + @saving.daily_income - @saving.daily_consumption
          elsif @saving.evacuation != nil
            evacuation = Saving.order(id: :desc).where(user_id: current_user).limit(2).offset(1).first
            @saving.total_savings = evacuation.total_savings + @saving.month_income + @saving.daily_income - @saving.daily_consumption
          end
        else
          if @saving.evacuation == nil
            saving = @saving
            saving.evacuation = saving.total_savings
            saving.evacuation.freeze
            @saving.total_savings = @saving.total_savings + @saving.daily_income - @saving.daily_consumption
          elsif @saving.evacuation != nil
            evacuation = Saving.order(id: :desc).where(user_id: current_user).limit(2).offset(1).first
            @saving.total_savings = evacuation.total_savings + @saving.daily_income - @saving.daily_consumption
          end
        end
      else
        if @saving.month_income
          if @saving.evacuation == nil
            saving = @saving
            saving.evacuation = saving.total_savings
            @saving.evacuation = saving.evacuation
            @saving.update(saving_params)
            @saving.total_savings = @saving.total_savings + @saving.month_income + @saving.daily_income - @saving.daily_consumption
          elsif @saving.evacuation != nil
            evacuation = Saving.find_by(user_id: current_user)
            @saving.total_savings = evacuation.total_savings + @saving.month_income + @saving.daily_income - @saving.daily_consumption
          end
        else
          if @saving.evacuation == nil
            saving = @saving
            saving.evacuation = saving.total_savings
            saving.evacuation.freeze
            @saving.total_savings = @saving.total_savings + @saving.daily_income - @saving.daily_consumption
          elsif @saving.evacuation != nil
            evacuation = Saving.find_by(user_id: current_user)
            @saving.total_savings = evacuation.evacuation + @saving.daily_income - @saving.daily_consumption
          end
        end
      end
      unless @saving.update(saving_params)
        flash[:alert] = "更新に失敗しました"
        render action: :edit and return
      end
    end
    redirect_to result_path(current_user.id)
  end

  def create_beginner
    @saving = Saving.new(saving_beginner_params)
    @saving.user_id = current_user.id
    @saving.valid?
    if @saving.save
      flash[:notice] = "登録しました"
      redirect_to result_path(current_user.id)
    else
      flash[:alert] = "登録に失敗しました"
      redirect_to "/:id/beginner"
    end
  end

  def beginner
    @saving = Saving.create(total_savings: params[:total_savings])
  end

  private
  def saving_params
    params.require(:saving).permit(:total_savings, :month_income, :daily_income, :daily_consumption)
  end

  def saving_beginner_params
    params.require(:saving).permit(:total_savings)
  end
end
