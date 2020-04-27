class TopController < ApplicationController
  def top
    if user_signed_in?
      user = Saving.find_by(user_id: current_user)
      if user != nil
        redirect_to result_path(current_user.id)
      else
        redirect_to "/#{current_user.id}/beginner"
      end
    else
      redirect_to new_user_registration_path
    end
  end
end
