class TopController < ApplicationController
  def top
    if user_signed_in?
      redirect_to result_path(current_user.id)
    end
  end
end
