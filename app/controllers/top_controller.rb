class TopController < ApplicationController
  def top
    if user_signed_in?
      # user = Saving.find_by(user_id: current_user)
      # if user != nil
      redirect_to "/#{current_user.id}/beginner"
      # else
      
      # end
    else
      redirect_to "/result/#{current_user.id}"
    end
  end
end
