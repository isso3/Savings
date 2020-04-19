class TopController < ApplicationController
  def top
    if user_signed_in?
      redirect_to "/result"
    end
  end

  def home

  end
end
