class TopController < ApplicationController
  def top
    if user_signed_in?
      user = Saving.find_by(user_id: current_user)
      if user != nil
        result_path(current_user.id)
      else
        redirect_to "/#{current_user.id}/beginner"
      end
    end
  end
end
